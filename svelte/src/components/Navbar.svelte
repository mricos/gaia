<script>
    import { page } from '$app/stores'; // Import the page store
  
    // Reactive statement to derive the current path
    $: currentPath = $page.url.pathname;
  </script>
<style>
  /* Styling for the navbar */
  nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.5rem 1rem;
    background-color: #007bff;
    color: white;
  }

  .navbar-brand {
    font-size: 1.5rem;
    font-weight: bold;
  }

  .nav-item {
    margin-left: 1rem;
  }

  .nav-link {
    color: white;
    text-decoration: none;
  }

  .nav-link:hover {
    text-decoration: underline;
  }
</style>

<nav>
  <div class="navbar-brand">KGKG</div>
  <div>
    <a href="/" class="nav-link nav-item">Home</a>
    <a href="/about" class="nav-link nav-item">About</a>
    <a href="/contact" class="nav-link nav-item">Contact</a>
  </div>
  <span>Current Chapter</span>
  <button class="p-2">☰</button> <!-- Hamburger Icon -->

</nav>


<nav>
    {#if currentPath === '/'}
      <!-- Content for the home page navbar -->
      <a href="/another-page">Go to Another Page</a>
    {:else if currentPath === '/another-page'}
      <!-- Content for the another page navbar -->
      <a href="/">Go to Home</a>
    {/if}
  </nav>