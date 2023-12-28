    class NavbarComponent {
        constructor(elementId, app) {
            this.element = document.getElementById(elementId);
            this.app = app;
            this.element.querySelector('.hamburger').addEventListener('click', this.toggleMenu.bind(this));
            this.element.querySelectorAll('ul li a').forEach(item => {
                item.addEventListener('click', this.changeMode.bind(this));
            });
        }

        toggleMenu() {
            console.log('Toggling menu');
            this.element.querySelector('ul').classList.toggle('visible');
        }
        changeMode(event) {
            const mode = event.target.getAttribute('data-mode');
            console.log('Changing mode to:', mode);
            this.app.setState({ ...this.app.state, mode: mode });
            event.preventDefault();
        }
        update(state) {
            console.log('Updating NavbarComponent with state:', state);
            const mode = state.mode;
            this.element.querySelectorAll('ul li a').forEach(item => {
                item.classList.remove('selected');
                if (item.getAttribute('data-mode') === mode) {
                    item.classList.add('selected');
                }
            });
        }
    }


    class TextComponent {
        constructor(elementId, app) {
            this.element = document.getElementById(elementId);
            this.app = app;
        }

        update(state) {
            console.log('Updating TextComponent with state:', state);
            const mode = state.mode;
            if (mode) {
                this.element.textContent = 'Current mode: ' + mode;
            } else {
                this.element.textContent = 'No mode selected';
            }
        }
    }

    class FooterComponent {
        constructor(elementId, app) {
            this.element = document.getElementById(elementId);
            this.app = app;
        }

        update(state) {
            console.log("FooterComponent::update(message)", state);
            this.element.textContent = state.mode;
            this.element.style.textAlign = 'center';
        }
    }

    class InputComponent {
        constructor(elementId, app) {
            this.element = document.getElementById(elementId);
            if (!this.element) {
                throw new Error(`Element with id "${elementId}" does not exist`);
            }
            this.app = app;
        }

        update(state) {
            console.log("InputComponent::update(state)", state);
            this.element.textContent = state.mode;
            this.element.style.textAlign = 'center';        }
    }

    class OutputComponent {
        constructor(elementId, app) {
            this.element = document.getElementById(elementId);
            this.app = app;
        }

        update(state) {
            console.log("OutputComponent::update(state)", state);
            this.element.textContent = state.mode;
            this.element.style.textAlign = 'center';
        }
    }

    class SettingsComponent {
        constructor(elementId, app) {
            this.element = document.getElementById(elementId);
            this.app = app;
        }

        update(state) {
            console.log("SettingsComponent::update(state)", state);
            this.element.textContent ='Settings';
            this.element.style.textAlign = 'center';
    }    }

    class MainComponent {
        constructor(elementId, app) {
            this.element = document.getElementById(elementId);
            this.app = app;
            this.inputComponent = new InputComponent('input', app);
            this.outputComponent = new OutputComponent('output', app);
            this.settingsComponent = new SettingsComponent('settings', app);
            this.defaultElement = document.getElementById('default');
            this.activeComponent = 'default';
            console.log('MainComponent constructor finished.');

        }

        switchTo(component) {
            console.log('switchTo ', component);
            this.activeComponent = component;
            this.inputComponent.element.style.display = (component === 'input') ? 'block' : 'none';
            this.outputComponent.element.style.display = (component === 'output') ? 'block' : 'none';
            this.settingsComponent.element.style.display = (component === 'settings') ? 'block' : 'none';
            this.defaultElement.style.display = (component === 'default') ? 'block' : 'none';
        }

        update(state) {
            console.log("MainComponent.update ", state);
            this.switchTo(state.mode);
            switch (state.mode) {
                case 'input':
                    this.inputComponent.update(state);
                    break;
                case 'output':
                    this.outputComponent.update(state);
                    break;
                case 'settings':
                    this.settingsComponent.update(state);
                    break;
                default:
                    // Handle the default case
                    break;
            }
        }
    }