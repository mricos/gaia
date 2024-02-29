<!-- Modal.svelte -->
<script>
  import { appState } from '../stores/appState.js'; // Import the appState store

  //export let isOpen = false;
  //$: isOpen = $appState.isModalOpen;
  // Initialize isOpen with the value from appState.isModalOpen
  let isOpen = appState.isModalOpen;
  // Subscribe to changes in appState.isModalOpen and update isOpen
  $: isOpen = appState.$isModalOpen;
  function closeModal() {
    appState.isModalOpen.set(false); // Update isModalOpen in appState to close the modal
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
      top: 5%;
      left: 5%;
      width: 90%;
      height: 90%;
      display: flex;
      align-items: center;
      justify-content: center;
      @apply bg-palette-orange-10;
      @apply text-palette-orange-1;
      z-index: 999;
      visibility: hidden;
      transition: all 1.5s ease;

    }
    .modal-content {
      padding: 20px;
      border-radius: 5px;
      border-width: 1.5px;
      border-color: var(--orange-16); 
      border-style: solid;
      width: 95%;
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
    background: rgba(0, 0, 0, 0.8); /* Dim the background */
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
        font-size:.75rem;
        width: 90%;
      }
    }
  </style>
