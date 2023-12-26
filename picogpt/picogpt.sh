createGlobalCss() {
    mkdir -p "css"
    cat > "css/global.css" <<'EOF'
html, body {
    margin: 0;
    padding: 0;
    height: 100%;
    display: flex;
    flex-direction: column;
}
body > header {
    /* Intentionally left blank; added to ensure consistent structure */
}
body > main {
    flex-grow: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
}
body > footer {
    display: flex;
    justify-content: space-around;
    align-items: center;
    height: 20vh; /* Adjust the height of the footer as needed */
}
button {
    width: 25%; /* Adjust button width as needed */
    font-size: 1rem;
    padding: 1rem;
}
EOF
}

createHeaderComponentJs() {
    mkdir -p "js/pico/components"
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
        container.innerHTML += '<main><div id="counter-value"></div></main>';
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
                <button id="decrement" onclick="window.controller.decrementCounter()">Decrement</button>
                <button id="increment" onclick="window.controller.incrementCounter()">Increment</button>
            </footer>
        `;
    }
}
EOF
}

createAppJs() {
    mkdir -p "js"
    cat > "js/app.js" <<'EOF'
document.addEventListener('DOMContentLoaded', () => {
    window.model = new PicoModel();
    window.controller = new Controller(window.model);
    new HeaderComponent().render(document.body);
    new MainComponent(window.model).render(document.body);
    new FooterComponent(window.controller).render(document.body);
});
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
setupPicoUIComponents() {
    createGlobalCss
    createModelJs
    createControllerJs
    createHeaderComponentJs
    createMainComponentJs
    createFooterComponentJs
    createAppJs
    createIndexHtml
}
