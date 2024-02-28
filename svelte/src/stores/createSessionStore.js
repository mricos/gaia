import { writable } from 'svelte/store';

// Function to get a value from sessionStorage or return a default value
function getSessionValue(key, defaultValue) {
  if (typeof window !== 'undefined') {
    const storedValue = sessionStorage.getItem(key);
    return storedValue ? JSON.parse(storedValue) : defaultValue;
  }
  return defaultValue;
}

// Initialize the slider values with session data or default values
export const createSessionStore = (key, startValue) => {
  const value = getSessionValue(key, startValue);
  const store = writable(value);

  // Subscribe to changes and update sessionStorage
  store.subscribe(currentValue => {
    if (typeof window !== 'undefined') {
      sessionStorage.setItem(key, JSON.stringify(currentValue));
    }
  });

  return store;
};