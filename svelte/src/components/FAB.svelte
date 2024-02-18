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
      bottom: 10vh;
      right: 10vw;
      border-color: var(--orange-12);
      border-width: 4px;
      border-radius:100%;
      padding: 1em;
      background: var(--orange-10);
      color: var(--brown-10);
      /* Add more styles for your FAB here */
    }
  </style>