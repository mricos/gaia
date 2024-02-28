<!-- Modal.svelte -->
<script>
  import { appState } from '../stores/appState.js'; // Import the appState store

  export let isOpen = false;
  $: isOpen = $appState.isModalOpen;

  function closeModal() {
    //appState.set({ isModalOpen: false });
    appState.update(currentState => {
  return { ...currentState, isModalOpen: false };
});
  }
</script>


{#if isOpen}
  <div class="modal open" role="dialog">
    <div class="modal-content">
      <span class="close-button" role="button" tabindex="0" on:click={closeModal}
       on:keydown={e => e.key === 'Enter' && closeModal()}>&times;</span>
      <slot></slot>
    </div>
  </div>
  <div class="modal-overlay" role="button" on:click={closeModal} tabindex="0" 
  on:keydown={e => e.key === 'Enter' && closeModal()}></div>
{/if}
  
  <style>
    /* Basic styling */
    .modal {
      position: fixed;
      top: 10%;
      left: 10%;
      width: 80%;
      height: 80%;
      display: flex;
      align-items: center;
      justify-content: center;
      @apply bg-palette-orange-10;
      @apply text-palette-orange-1;
      z-index: 999;
      visibility: hidden;
      transition: all 0.3s ease;

    }
    .modal-content {
      padding: 20px;
      border-radius: 5px;
      border-width: 1.5px;
      border-color: var(--orange-16);
      border-style: solid;
      max-width: 500px;
      width: 90%;
    }
    .close-button {
    @apply text-palette-orange-16;
      float: right;
      cursor: pointer;
    }
  
    .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.9); /* Dim the background */
    z-index: 998; /* Place it below the modal */
  }

    /* Visibility control */
    .modal.open {
      opacity: 1;
      visibility: visible;
    }
  
    /* Responsive adjustments */
    @media (max-width: 768px) {
      .modal-content {
        width: 80%;
      }
    }
  </style>
