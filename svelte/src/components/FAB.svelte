<script>
    import { writable } from 'svelte/store';
    export let settingsVisible = writable(false);
  
    function toggleSettings() {
      settingsVisible.update(v => !v);
    }
  </script>
  
  <button on:click={toggleSettings} class="fab">+</button>
  
  <style>
    .fab {
      position: fixed;
      bottom: 20px;
      right: 20px;
      /* Add more styles for your FAB here */
    }
  </style>