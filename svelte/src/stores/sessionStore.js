   // sessionStore.js
   import { writable } from 'svelte/store';

   function getSessionValue(key, defaultValue) {
       if (typeof window !== 'undefined') {
           const storedValue = sessionStorage.getItem(key);
           return storedValue ? JSON.parse(storedValue) : defaultValue;
       }
       return defaultValue;
   }

   export function createSessionStore(key, defaultValue) {
       const store = writable(getSessionValue(key, defaultValue));

       store.subscribe(value => {
           if (typeof window !== 'undefined') {
               sessionStorage.setItem(key, JSON.stringify(value));
           }
       });

       return store;
   }
