<script>
  import WebSocketComponent from './WebSocketComponent.svelte';
  import { isButtonAToggled, isButtonBToggled, isButtonCToggled } from '../stores/storeFab.js';
  import { derived } from 'svelte/store';
  import { normalizedXaxis, normalizedYaxis } from '../stores/joystickStore.js';


  let hudAPosition = { top: '10vh', left: '10vw', right: '5vw'  };
  let hudBPosition = { top: '20vh', left: 'inherit', right: '5vw' };
  let hudCPosition = { top: '40vh', left: '10vw', right: '5vw'  };

  const hudAVisible = derived(isButtonAToggled, ($isButtonAToggled) => $isButtonAToggled);
  const hudBVisible = derived(isButtonBToggled, ($isButtonBToggled) => $isButtonBToggled);
  const hudCVisible = derived(isButtonCToggled, ($isButtonCToggled) => $isButtonCToggled);

//    top: `calc(50% - 50px + ${$normalizedYaxis * 100}vh)`,

$: {
  hudBPosition = {

    top: `30vh`,
    left: `20vw`,
  };
}

</script>

{#if $isButtonAToggled}
  <div class="hud" style="top: {hudAPosition.top}; left: {hudAPosition.left};">HUD A</div>
{/if}

{#if $isButtonBToggled}
  <div class="hud" style="top: {hudBPosition.top}; 
  top: {hudBPosition.top};
  left: {hudBPosition.left};
  right: {hudBPosition.right};

  width:50%; transform: translate(0%)">
  HUD B</div>
{/if}


{#if $isButtonCToggled}
  <div class="hud" style="top: {hudCPosition.top}; left: {hudCPosition.left};">HUD C</div>
  <WebSocketComponent />
{/if}


  <style>
  .hud {
    position: absolute;
    background-color: rgba(0, 0, 0, 0.8); /* Transparent black background */
    color: white; /* Text color */
    padding: 10px; /* Padding around the content */
    border: 2px solid white; /* White border */
    border-radius: 5px; /* Rounded corners */
    margin: 2rem; /* Margin around each HUD */
  }
</style>

