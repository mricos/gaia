<style>
    .joystick {
        position: absolute;
        bottom: 20%; /* Positioned 20% from the bottom */
        left: 50%; /* Center horizontally */
        transform: translateX(-50%); /* Adjust for centering */
        width: 25vmin; /* 1/4 of the screen's smaller dimension */
        height: 25vmin; /* Make it a square */
        background-color: #eee; /* Just for visibility */
        opacity: 10%;
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 10%;
        rotate: 0deg;
        border: 2px solid #333; /* Styling the border */
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

<script>
    import { sliderValue, verticalSliderValue } from '../stores/sliderStore.js';
    let joystickHandle;
    let isDragging = false;
    export let minValue=1;
    export let maxValue=16;
    function handleMouseDown(event) {
        isDragging = true;
        // Add global event listeners
        window.addEventListener('mousemove', handleMouseMove);
        window.addEventListener('mouseup', handleMouseUp);
    }
    function handleMouseMove(event) {
    if (isDragging) {
        const rect = joystickHandle.getBoundingClientRect();
        const joystickRect = joystickHandle.parentNode.getBoundingClientRect();
        const handleHalfWidth = rect.width / 2;
        const handleHalfHeight = rect.height / 2;

        let x = event.clientX - joystickRect.left - handleHalfWidth;
        let y = event.clientY - joystickRect.top - handleHalfHeight;

        // Ensure the handle stays within the joystick bounds
        x = Math.max(0, Math.min(x, joystickRect.width - rect.width));
        y = Math.max(0, Math.min(y, joystickRect.height - rect.height));

        // Quantize the position
        const quantizedX = Math.floor((x / (joystickRect.width - rect.width)) * 16);
        const quantizedY = Math.floor((y / (joystickRect.height - rect.height)) * 16);

        sliderValue.set(quantizedX);
        verticalSliderValue.set(quantizedY);

        // Update the joystick handle's style to reflect the quantized position
        joystickHandle.style.left = `${(x / joystickRect.width) * 100}%`;
        joystickHandle.style.top = `${(y / joystickRect.height) * 100}%`;
    }
}

    function handleMouseUp(event) {
        isDragging = false;
        // Remove global event listeners
        window.removeEventListener('mousemove', handleMouseMove);
        window.removeEventListener('mouseup', handleMouseUp);
    }

    // Cleanup on component destruction
    import { onDestroy } from 'svelte';
    onDestroy(() => {
        if (isDragging) {
            window.removeEventListener('mousemove', handleMouseMove);
            window.removeEventListener('mouseup', handleMouseUp);
        }
    });
</script>



<div 
  class="joystick border" 
  on:mousedown={handleMouseDown} 
  role="slider" 
  aria-valuemin={minValue} 
  aria-valuemax={maxValue} 
  aria-valuenow={$sliderValue} 
  aria-orientation="horizontal" 
  tabindex="0">

  <div 
    class="joystick-handle border border-blue-500" 
    bind:this={joystickHandle} 
    on:mousemove={handleMouseMove} 
    role="slider" 
    aria-valuemin={minValue} 
    aria-valuemax={maxValue} 
    aria-valuenow={$verticalSliderValue} 
    aria-orientation="vertical" 
    tabindex="0">
    <!-- Display the slider values -->
  </div>
  <div class="border-2 border-red-400 ">
</div>
</div>

<p>Slider Value: {$sliderValue}</p>
<p>Vertical Slider Value: {$verticalSliderValue}</p>