<script>
  import "../app.css";
  import Navbar from '../components/Navbar.svelte';
  import Joystick from '../components/Joystick.svelte';
  import { appState } from '../stores/appState.js';
  import Footer from '../components/Footer.svelte';
	import Modal from "../components/Modal.svelte";
	import FAB from "../components/FAB.svelte";

  $: appState.set({ isModalOpen: false });

</script>
<main class="overflow-hidden flex flex-col min-h-screen">
<Navbar/>
<slot />
<Modal isOpen={appState.isModalOpen===false}>
  <pre>{JSON.stringify($appState, null, 2)}</pre>
</Modal >

<Joystick/>
<FAB />
<Footer />
</main>