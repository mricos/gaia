//appState.js
import { createSessionStore } from './sessionStore.js';

export const appState = {
  isModalOpen: createSessionStore('isModalOpen', false),
  joystickData: {
      x: createSessionStore('joystickDataX', 0),
      y: createSessionStore('joystickDataY', 0)
  },
  // Add more nested appState variables here as needed
};