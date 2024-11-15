<script>
  import { isModalOpen, isButtonAToggled,
     isButtonBToggled, isButtonCToggled } from '../stores/storeFab.js';
  
  function toggleButtonA() {
    isButtonAToggled.update(value => !value);
  }
  
  function toggleButtonB() {
    isButtonBToggled.update(value => !value);
  }
  
  function toggleButtonC() {
    isButtonCToggled.update(value => !value);
  }
  
  function openModal() {
    isModalOpen.set(true);
  }
  </script>


<style>
  .fab-grid {
    z-index: 999; /* Bring the FAB grid to the top */

    position: fixed;
    bottom: 5vh;
    right: 5vw;
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: 1fr 1fr;
    gap: 1rem;
    width-max: 30%; /* Adjust the total width of the grid */
  }

  .fab-a, .fab-b, .fab-c, .fab-plus {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50px; /* Adjust the size as needed */
    height: 50px; /* Adjust the size as needed */
    border: 2px solid var(--orange-12);
    border-radius: 50%;
    background: var(--orange-10);
    color: var(--brown-10);
    cursor: pointer;
  }

  .fab-plus {
    grid-column: 2 / span 1;
    grid-row: 2 / span 1;
    width: 50px; /* Adjust the size as needed */
    height: 50px; /* Adjust the size as needed */
    border-radius: 100%;
  }
</style>

<div class="fab-grid">
  <div on:click={toggleButtonA} class="fab-a">A</div>
  <div on:click={toggleButtonB} class="fab-b">B</div>
  <div on:click={toggleButtonC} class="fab-c">C</div>
  <button on:click={openModal} class="fab-plus">
    <svg class="w-6 h-6 text-orange-700" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
    </svg>
  </button>
</div>