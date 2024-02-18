<script>
    import { writable } from 'svelte/store';
    export let settingsVisible = writable(true);
  
    function toggleSettings() {
      settingsVisible.update(v => !v);
    }
  </script>
  
  <button on:click={toggleSettings} class="fab">FAB</button>
  
  <style>
    .fab {
      position: absolute;
      bottom: 20px;
      right: 20px;
      /* Add more styles for your FAB here */
    }
  </style>