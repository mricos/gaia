<script>
  import "../app.css";
  import Navbar from '../components/Navbar.svelte';
  import Log from "../components/Log.svelte";
  import Joystick from '../components/Joystick.svelte';
</script>

<main class="flex flex-col min-h-screen">
    <header class="bg-blue-500 text-white p-4">
        <Navbar></Navbar>
          <!-- Additional navigation links could go here -->
        <!-- Any other header content (like a logo or da search form) could go here -->
      </header>
  <article class="flex-1 overflow-auto p-4">

    <slot />
  </article>
  <footer class="p-5 text-xs flex justify-between">
    <div><Joystick/></div>
    <Log></Log>
  <style>
    .footer-text {
      align-self: flex-end;
    }
  </style>
  </footer>
 
<hidden class="hidden">
</hidden>
</main>

