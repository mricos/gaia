<script>
  import "../app.css";
  import {onMount} from 'svelte';
  import Navbar from '../components/Navbar.svelte';
  import Joystick from '../components/Joystick.svelte';
  import Thumbstick from '../components/Thumbstick.svelte';
  import { appState } from '../stores/appState.js';
  import Footer from '../components/Footer.svelte';
	import Modal from "../components/Modal.svelte";
	import FAB from "../components/FAB.svelte";
	import Hud from "../components/Hud.svelte";
  import { xaxis, yaxis } from '../stores/joystickStore.js';
  let initialSliderX = null;
  let initialSliderY = null;

  if (typeof sessionStorage !== 'undefined') {
    initialSliderX = parseInt(sessionStorage.getItem('sliderX')) || 0;
    initialSliderY = parseInt(sessionStorage.getItem('sliderY')) || 0;
  }

  onMount(() => {
    if (initialSliderX !== null && initialSliderY !== null) {
      xaxis.set(initialSliderX);
      yaxis.set(initialSliderY);
    }
  });
</script>

<main class="w-full">
<Navbar>
</Navbar>
{#if initialSliderX !== null && initialSliderY !== null}
<slot/>
<Modal>
  <pre>{JSON.stringify(appState, null, 2)}</pre>
</Modal >
<Thumbstick  />
<Joystick  />
{/if}
<Hud />
<FAB />
<Footer />
</main>

<style>
  @media only screen and (max-width: 600px) {
    html {
      height: 100vh;
      overflow: hidden;
    }
  }
</style>