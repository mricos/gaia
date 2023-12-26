createGlobalCss() {
    mkdir css
    cat > "css/global.css" <<'EOF'
/* Styles for layout */
html, body {
    margin: 0;
    padding: 0;
    height: 100%;
    display: flex;
    flex-direction: column;
}

/* Header is intentionally left blank for consistency */
body > header {
    display: block;
    height: 10vh; /* Adjust the height as needed */
}

/* Main content area where the counter is centered */
body > main {
    flex-grow: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
}

/* Footer with buttons */
body > footer {
    display: flex;
    justify-content: space-around;
    align-items: center;
    height: 20vh;
}

/* Button styles */
button {
    width: 25%;
    font-size: 1rem;
    padding: 1rem;
}
EOF
}

createHeaderComponentJs() {
    cat > "js/pico/components/headerComponent.js" <<'EOF'
class HeaderComponent {
    render(container) {
        container.innerHTML += '<header></header>';
    }
}
EOF
}

createMainComponentJs() {
    cat > "js/pico/components/mainComponent.js" <<'EOF'
class MainComponent {
    constructor(model) {
        this.model = model;
        this.model.subscribe('counter', this.updateCounter.bind(this));
    }
    updateCounter(counterValue) {
        document.getElementById('counter-value').textContent = 'Count: ' + counterValue;
    }
    render(container) {
        container.innerHTML += '<main><div id="counter-value">Count: 0</div></main>';
        this.updateCounter(this.model.data.counter);
    }
}
EOF
}

createFooterComponentJs() {
    cat > "js/pico/components/footerComponent.js" <<'EOF'
class FooterComponent {
    constructor(controller) {
        this.controller = controller;
    }
    render(container) {
        container.innerHTML += `
            <footer>
                <button id="decrement"
                 hx-post="/decrement"
                 hx-swap="outerHTML">Decrement</button>
                <button id="increment" 
                 hx-post="/increment"
                 hx-swap="outerHTML">Increment</button>
            </footer>
        `;
    }
}
EOF
}

createAppJs() {
    cat > "js/app.js" <<'EOF'
document.addEventListener('DOMContentLoaded', () => {
    window.model = new PicoModel();
    window.controller = new PicoController(window.model);
    new HeaderComponent().render(document.body);
    new MainComponent(window.model).render(document.body);
    new FooterComponent(window.controller).render(document.body);

    document.body.addEventListener('htmx:beforeRequest', (event) => {
        console.log('HTMX Request being sent:', event.detail);
    });

    document.body.addEventListener('htmx:afterRequest', (event) => {
        console.log('HTMX Request completed:', event.detail);
    });
  htmx.process(document.getElementById('decrement'));
  htmx.process(document.getElementById('increment'));

});
EOF
}

createModelJs() {
    cat > "js/pico/model.js" <<'EOF'
class PicoModel {
    constructor() {
        this.data = { counter: 0 };
        this.listeners = { counter: [] };
    }
    subscribe(property, listener) {
        this.listeners[property].push(listener);
    }
    notify(property) {
        this.listeners[property].forEach(listener => listener(this.data[property]));
    }
    updateCounter(value) {
        this.data.counter = value;
        this.notify('counter');
    }
}
EOF
}

createControllerJs() {
    cat > "js/pico/controller.js" <<'EOF'
class PicoController {
    constructor(model) {
        this.model = model;
        this.registerRoutes();
    }
registerRoutes() {
    console.log("PicoController:registerRoutes()");
    document.body.addEventListener('htmx:beforeRequest', (event) => {
        console.log('HTMX Request received:', event.detail);

        // Using target attribute to determine the request path
        const targetElement = event.detail.target;
        const requestPath = targetElement.getAttribute('hx-post');
        console.log('Request Path:', requestPath);

        if (requestPath === '/increment') {
            console.log("Handling increment client-side");
            this.handleIncrement();
            event.preventDefault();
        } else if (requestPath === '/decrement') {
            console.log("Handling decrement client-side");
            this.handleDecrement();
            event.preventDefault();
        }
    });
}


    handleIncrement() {
        this.model.updateCounter(this.model.data.counter + 1);
    }

    handleDecrement() {
        this.model.updateCounter(this.model.data.counter - 1);
    }
}
EOF
}

createIndexHtml() {
    cat > "./index.html" <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pico UI Counter</title>
    <link rel="stylesheet" href="css/global.css">
</head>
<body>
    <header></header>
    <main id="app"></main>
    <footer></footer>
    <script src="https://unpkg.com/htmx.org@1.9.10"
      integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC"
        crossorigin="anonymous"></script>

    <script src="js/pico/model.js"></script>
    <script src="js/pico/controller.js"></script>
    <script src="js/pico/components/headerComponent.js"></script>
    <script src="js/pico/components/mainComponent.js"></script>
    <script src="js/pico/components/footerComponent.js"></script>
    <script src="js/app.js"></script>
</body>
</html>
EOF
}

# This function must be called to set up the initial project structure and files.
createPico() {
    mkdir -p js
    mkdir -p js/pico
    mkdir -p js/pico/components

    createGlobalCss
    createModelJs
    createControllerJs
    createHeaderComponentJs
    createMainComponentJs
    createFooterComponentJs
    createAppJs
    createIndexHtml
}
