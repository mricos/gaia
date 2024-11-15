<script>
  import { onMount } from 'svelte';

  onMount(() => {

  });

  import { scrollToId } from '../store.js';  

  function handleButtonClick(id) {
    const element = document.getElementById(id);
    if (element) {
      window.scrollTo({
        top: element.offsetTop -
                document.querySelector('header').offsetHeight
                - 20,
        behavior: 'smooth'
      });
    }
  }
</script>

<style>
header {

    color: var(--h1-color);

    background-color: var(--nav-bar-bg);

    padding: 10px;
    text-align: center;
    position: sticky;  /* This will make the header sticky */
    top: 0;  /* This will ensure the header sticks to the top of the page */
    z-index: 1000;  /* Optional: This will ensure the header stays on top of other content */
    position: fixed;  /* This will fix the header at the top */
    width: 100%;  /* Ensure the header spans the full width of the viewport */

}

nav button {
    background-color: var(--nav-bar-bg);
    color: var(--h1-color);
    font-family: var(--main-font-family);
    border: none; /* Remove default border */
    padding: 10px 10px; /* Add some padding */
    margin: 0 1px; /* Add some margin between buttons */
    cursor: pointer; /* Change cursor to pointer on hover */
    border-radius: 5px; /* Optional: Round the corners */
    transition: background-color 0.3s; /* Optional: Add transition for hover effect */
}

nav button:hover {
    background-color: #444; /* Darker background color on hover */
}

</style>

<header>
<nav>
  <button on:click={() => handleButtonClick('chapter1')}>C1</button>
  <button on:click={() => handleButtonClick('chapter2')}>C2</button>
  <button on:click={() => handleButtonClick('chapter3')}>C3</button>
  <button on:click={() => handleButtonClick('chapter4')}>C4</button>
  <button on:click={() => handleButtonClick('chapter5')}>C5</button>
  <button on:click={() => handleButtonClick('chapter6')}>C6</button>
  <button on:click={() => handleButtonClick('chapter7')}>C7</button>
  <button on:click={() => handleButtonClick('chapter8')}>C8</button>
  <button on:click={() => handleButtonClick('chapter9')}>C9</button>
  <button on:click={() => handleButtonClick('chapter10')}>C10</button>
  <button on:click={() => handleButtonClick('chapter11')}>C11</button>
</nav>

</header>
