class PicoX {
    constructor(debug = false) {
        this.debug = debug;
        this.currentReaction = null;
        this.reactions = new Map();
    }

    observable(obj) {
        const picox = this;
        return new Proxy(obj, {
            get(target, key) {
                picox.debug && console.log(`Getting property ${key}`);
                if (picox.currentReaction) {
                    if (!picox.reactions.has(key)) {
                        picox.reactions.set(key, new Set());
                    }
                    picox.reactions.get(key).add(picox.currentReaction);
                }
                return target[key];
            },
            set(target, key, value) {
                if (target[key] === value) {
                    return true; // No value change, no need to trigger reactions
                }
                picox.debug && console.log(`Setting property ${key} to ${value}`);
                target[key] = value;
                if (picox.reactions.has(key)) {
                    picox.reactions.get(key).forEach(reaction => reaction());
                }
                return true;
            }
        });
    }

    reaction(observableFn, reactionFn) {
        this.currentReaction = reactionFn; // Set current reaction to the reaction function
        observableFn(); // Run observable function to register the reaction
        this.currentReaction = null; // Clear current reaction
    }
}


class App {
    constructor() {
        this.debug = true; // Set this to false to disable debugging
        this.picox = new PicoX(this.debug);
        this.state = this.picox.observable({mode:'default'});
        this.initializeComponents();
        this.state.mode=this.loadState().mode;
        console.log('Observable state:', this.state);

    }

    initializeComponents() {
        this.registerComponent(new NavbarComponent('navbar', this));
        this.registerComponent(new MainComponent('main', this));
        this.registerComponent(new FooterComponent('footer', this));
    }

    loadState() {
        const defaultState = { mode: 'input' };
        const stateKey = 'appState'; // Use a consistent key for saving/loading state

        try {
            console.log('Lookingfor localStorage key:',stateKey);

            const savedState = localStorage.getItem(stateKey);
            console.log('Found state:',savedState);

            if (savedState) {
                const parsedState = JSON.parse(savedState);
                console.log('parsedState:',parsedState);
                return parsedState;
            }
        } catch (error) {
            // It might be beneficial to handle specific types of errors differently
            // For example, a SyntaxError indicates invalid JSON.
            if (error instanceof SyntaxError) {
                console.error('Error parsing state:', error);
            } else {
                console.error('Error loading state:', error);
            }
        }

        // If we reach here, it means there was no saved state or an error occurred
        // Log a message if debugging is enabled
        this.debug && console.warn('No saved state found or error occurred. Using default state.');
        return defaultState;
    }

    saveState() {
        const stateKey = 'appState'; // Consistent key for localStorage
        try {
            // Create a clean object from the state's own properties
            const stateToSave = Object.keys(this.state).reduce((obj, key) => {
                obj[key] = this.state[key];
                return obj;
            }, {});

            if (this.debug) {
                console.log('Saving state:', stateToSave);
            }
            console.log("attempting to saveState",stateToSave)

            localStorage.setItem(stateKey, JSON.stringify(stateToSave));
        } catch (error) {
            // Detailed error logging
            if (this.debug) {
                console.error('Error saving state to localStorage:', error.message);
                console.error('Failed state:', this.state);
            }
        }
    }


    setState(newState) {
        this.debug && console.log('Setting state, old new:', this.state, newState);
        Object.assign(this.state, newState);
        this.saveState();
    }

    registerComponent(component) {
        this.debug && console.log('Registering component:', component);
       // this.components.push(component);
        this.picox.reaction(
            () => this.state.mode,
            () => component.update(this.state)
        );
    }
}

window.addEventListener('DOMContentLoaded', () => {
    const app = new App();
});