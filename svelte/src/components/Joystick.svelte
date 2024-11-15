<script>
  import { onMount, onDestroy } from 'svelte';
 
    import { xaxis, yaxis, xAxisMax, xAxisMin, yAxisMax, yAxisMin 
    } from 
    '../stores/joystickStore.js';


  let joystickContainer;
  let isDragging = false;
  export let minValue=1;
  export let maxValue=16;

  export let initX = 0;
  export let initY = 0;

  onMount(() => {
    initX = $xaxis;
    initY = $yaxis;
    setHandlePositionQuantized(initX, initY);
    setHandlePositionQuantized(4,5);
    updateJoystickSize();
    window.addEventListener('resize', updateJoystickSize);

  });

  onDestroy(() => {
    // Remove the resize event listener when the component is destroyed
    window.removeEventListener('resize', updateJoystickSize);
  });

  function updateJoystickSize() {
    // Get the current joystick size
    const rect = joystickContainer.getBoundingClientRect();

    // Update the min and max values in the joystick store
    xAxisMax.set(rect.width / 2);
    xAxisMin.set(-rect.width / 2);
    yAxisMax.set(rect.height / 2);
    yAxisMin.set(-rect.height / 2);
  }



  function handleTouchStart(event) {
    isDragging = true;
    // Prevent the default touch action
    event.preventDefault();
    // Add touch event listeners
    joystickContainer.addEventListener('touchmove', handleTouchMove);
    joystickContainer.addEventListener('touchend', handleTouchEnd);
  }


  export function handleTouchMove(event) {
    if (joystickState.isDragging) {
      // Get the touch position relative to the joystick
      const rect = joystickContainer.getBoundingClientRect();
      const touch = event.touches[0];
      const x = touch.clientX - rect.left;
      const y = touch.clientY - rect.top;
      joystickState.position = { x, y };
    }
  }

  export function handleMouseDown(event) {
    joystickState.isDragging = true;
    // Prevent the default mouse action
    event.preventDefault();
  }

  // Add touch event listeners
  onMount(() => {
    joystickContainer.addEventListener('touchmove', handleTouchMove);
    joystickContainer.addEventListener('touchend', handleTouchEnd);
    joystickContainer.addEventListener('touchcancel', handleTouchEnd);
  });

  // Add mouse event listeners
  onMount(() => {
    joystickContainer.addEventListener('mousemove', handleMouseMove);
    joystickContainer.addEventListener('mouseup', handleMouseUp);
  });

  // Remove touch event listeners when the component is destroyed
  onDestroy(() => {
    joystickContainer.removeEventListener('touchmove', handleTouchMove);
    joystickContainer.removeEventListener('touchend', handleTouchEnd);
    joystickContainer.removeEventListener('touchcancel', handleTouchEnd);
  });

  // Remove mouse event listeners when the component is destroyed
  onDestroy(() => {
    joystickContainer.removeEventListener('mousemove', handleMouseMove);
    joystickContainer.removeEventListener('mouseup', handleMouseUp);
  });





  export const joystickState = {
    position: { x: 0, y: 0 },
    isDragging: false,
    n: 16 // Default quantization value
  };
  
  export function setHandlePositionQuantized(x, y) {
    const { x: quantizedX, y: quantizedY } = quantizePosition(x, y);
    joystickState.position = { x: quantizedX, y: quantizedY };
  }


  
  export function handleTouchEnd() {
    joystickState.isDragging = false;
    centerJoystick();
  }
  
  
  function setHandlePosition(x, y) {
    const handle = joystickContainer.firstChild;
    handle.style.left = `${x}px`;
    handle.style.top = `${y}px`;

  }
  
  export function handleMouseMove( event) {
    if (joystickState.isDragging) {
      // Get the mouse position relative to the joystick
      const rect = joystickContainer.getBoundingClientRect();
      const x = parseFloat(event.clientX - rect.left).toFixed(2);
      const y = parseFloat(event.clientY - rect.top).toFixed(2);
      joystickState.position = { x, y };
      xaxis.set(x);
      yaxis.set(y);
      setHandlePosition(x,y);
    }
  }
  
  export function handleMouseUp() {
    joystickState.isDragging = false;
    //centerJoystick()
  }
  
  export function quantizePosition(x, y) {
    const n = joystickState.n;
    const quantizedX = Math.floor((x / n) * 100);
    const quantizedY = Math.floor((y / n) * 100);
    return { x: quantizedX, y: quantizedY };
  }

  


</script>


<div 
  class="joystick border"
  bind:this={joystickContainer}
  on:mousedown={handleMouseDown}
  on:touchstart={handleTouchStart}
  on:touchmove={handleTouchMove}
  on:touchend={handleTouchEnd}
  on:touchcancel={handleTouchEnd}

  role="slider" 
  aria-valuemin={minValue} 
  aria-valuemax={maxValue} 
  aria-valuenow={$xaxis} 
  aria-orientation="horizontal" 
  tabindex="0">

  <div 
    class="joystick-handle border border-blue-500" 
    role="slider" 
    aria-valuemin={minValue} 
    aria-valuemax={maxValue} 
    aria-valuenow={$yaxis} 
    aria-orientation="vertical" 
    tabindex="0">
    <!-- Display the slider values -->
  </div>
  <p>x: {$xaxis}</p>
  <p>y: {$yaxis}</p>

</div>


<style>
    .joystick {
        position: absolute;
        bottom: 9vh; /* Positioned at the bottom */
        left: 50%; /* Center horizontally */
        transform: translateX(-50%); /* Adjust for centering */
        width: 25vmin; /* 1/4 of the screen's smaller dimension */
        height: 25vmin; /* Make it a square */
        background-color: #eee; /* Just for visibility */
        font-size: .75em;
        color: #333;
        opacity: 10%;
        display: flex;
        user-select: none;
        flex-direction: row;
        justify-content:center;
        align-items: flex-end;
        border-radius: 10%;
        rotate: 0deg;
        border: 2px solid #333; /* Styling the border */
        z-index: 1000;
    }

    .joystick-handle {
        width: 12.5%; /* Smaller than the joystick area */
        height: 12.5%; /* Make it a square */
        background-color: #666; /* Just for visibility */
        position: absolute;
        border-radius: 10%;
        border: 2px solid #4b4141; /* Styling the border */
    }
</style>