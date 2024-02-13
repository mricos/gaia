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
export const sliderValue = writable(getSessionValue('sliderX', 8));
export const verticalSliderValue = writable(getSessionValue('sliderY', 4));

// Subscribe to changes and update sessionStorage
sliderValue.subscribe(value => {
  if (typeof window !== 'undefined') {
    sessionStorage.setItem('sliderX', JSON.stringify(value));
  }
});
verticalSliderValue.subscribe(value => {
  if (typeof window !== 'undefined') {
    sessionStorage.setItem('sliderY', JSON.stringify(value));
  }
});