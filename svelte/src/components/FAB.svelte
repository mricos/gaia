// FAB.svelte
<script>

import { appState } from '../stores/appState.js'; // Import the appState store


function toggleModal() {
  $appState.isModalOpen = !$appState.isModalOpen;
}

function closeModal() {
  appState.update(state => ({ ...state, isModalOpen: false }));
}

function openModal() {
  appState.update(state => ({ ...state, isModalOpen: open }));
}

</script>
  
<button on:click={openModal} class="fab">FAB</button>
  
<button on:click={toggleModal} class="fixed bottom-4 
    right-4 p-4 bg-orange-400 rounded-full text-white">
    <svg class="w-6 h-6 text-orange-700" 
      fill="none" stroke="currentColor" viewBox="0 0 24 24"
      xmlns="http://www.w3.org/2000/svg">
      <path stroke-linecap="round" stroke-linejoin="round" 
        stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
    </svg>
</button>

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