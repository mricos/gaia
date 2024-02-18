<script>
  import "../app.css";
  import Navbar from '../components/Navbar.svelte';
  import Joystick from '../components/Joystick.svelte';
  import { appState } from '../stores/appState.js';
  import Footer from '../components/Footer.svelte';
	import Modal from "../components/Modal.svelte";
  import Woodcut from "../components/Woodcut.svelte";
  export let data;

$: appState.set(data);
</script>
<main class="overflow-hidden flex flex-col min-h-screen">
<Navbar/>
<slot />
<Modal isOpen=true>
  <pre>{JSON.stringify($appState, null, 2)}</pre>
</Modal >
<Joystick/>
<Footer />
</main>