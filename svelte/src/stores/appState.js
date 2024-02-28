// src/stores/appState.js
import { writable } from 'svelte/store';
import { createSessionStore } from './createSessionStore.js';

export const appState = createSessionStore('appState', 
  { isModalOpen: false });