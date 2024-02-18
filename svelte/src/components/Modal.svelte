<!-- Modal.svelte -->
<script>
    import { createEventDispatcher } from 'svelte';
  
    // Event dispatcher to communicate with parent components
    const dispatch = createEventDispatcher();
  

    // Prop to control the visibility of the modal
    export let isOpen = false;
  
    // Function to close the modal
    function closeModal() {
      isOpen = false;
      dispatch('close', { isOpen });
    }
  </script>
  
  <style>
    /* Basic styling */
    .modal {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
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
  
  {#if isOpen}
    <div class=" modal open ">
      <div class=" modal-content">
        <span class="close-button" on:click={closeModal}>&times;</span>
        <slot></slot>
      </div>
    </div>
  {/if}