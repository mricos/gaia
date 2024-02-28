<!-- Navbar.svelte -->
<script>
  // No script needed for basic navigation
</script>

<nav class="navbar bg-base-100">
  <div class="navbar-start">
    <a class="btn btn-ghost normal-case text-xl" href="/">MyApp</a>
  </div>
  <div class="navbar-center hidden lg:flex">
    <ul class="menu menu-horizontal p-0">
      <li><a href="/">Home</a></li>
      <li><a href="/about">About</a></li>
      <li><a href="/contact">Contact</a></li>
    </ul>
  </div>
  <div class="navbar-end">
    <a class="btn" href="/login">Login</a>
  </div>
</nav>