<script>
    import { onMount, onDestroy } from 'svelte';
    let thumbstickContainer;
    let thumbstickPosition = { x: 0, y: 0 };
    let thumbSize = 20; // Size of the thumb
    let isDragging = false;
  
    // Function to center the thumbstick
    function centerThumbstick() {
      const containerRect = thumbstickContainer.getBoundingClientRect();
      const thumbCenter = thumbSize / 2;
      thumbstickPosition = {
        x: (containerRect.width / 2) - thumbCenter,
        y: (containerRect.height / 2) - thumbCenter
      };
    }
  
    // Function to handle touchmove events
    function handleTouchMove(event) {
      if (isDragging) {
        // Get the touch position relative to the thumbstick
        const rect = thumbstickContainer.getBoundingClientRect();
        const touch = event.touches[0];
        const x = touch.clientX - rect.left;
        const y = touch.clientY - rect.top;
        thumbstickPosition = {
          x: x - rect.width / 2, // Center the thumbstick at the touch position
          y: y - rect.height / 2
        };
      }
    }
    function handleTouchStart(event) {
    isDragging = true;
    // Prevent the default touch action
    event.preventDefault();
  }

    // Function to reset thumbstick position when touch ends
    function handleTouchEnd() {
      isDragging = false;
      centerThumbstick();
    }
  
    function handleMouseMove(event) {
  if (isDragging) {
    // Get the mouse position relative to the thumbstick
    const rect = thumbstickContainer.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;
    thumbstickPosition = {
      x: x - thumbSize / 2, // Center the thumbstick at the mouse position
      y: y - thumbSize / 2
    };
  }
}
    // Function to handle mouseup events
    function handleMouseUp() {
      isDragging = false;
      centerThumbstick();
    }
  
    // Function to handle mousedown events
    function handleMouseDown(event) {
      isDragging = true;
      // Prevent the default mouse action
      event.preventDefault();
    }
  
    // ... existing code ...
  
    // Add touch event listeners
    onMount(() => {
      thumbstickContainer.addEventListener('touchmove', handleTouchMove);
      thumbstickContainer.addEventListener('touchend', handleTouchEnd);
      thumbstickContainer.addEventListener('touchcancel', handleTouchEnd);
    });
  
    // Add mouse event listeners
    onMount(() => {
      thumbstickContainer.addEventListener('mousemove', handleMouseMove);
      thumbstickContainer.addEventListener('mouseup', handleMouseUp);
      centerThumbstick();

    });
  
    // Remove touch event listeners when the component is destroyed
    onDestroy(() => {
      thumbstickContainer.removeEventListener('touchmove', handleTouchMove);
      thumbstickContainer.removeEventListener('touchend', handleTouchEnd);
      thumbstickContainer.removeEventListener('touchcancel', handleTouchEnd);
    });
  
    // Remove mouse event listeners when the component is destroyed
    onDestroy(() => {
      thumbstickContainer.removeEventListener('mousemove', handleMouseMove);
      thumbstickContainer.removeEventListener('mouseup', handleMouseUp);
    });
  </script>
  
  <div
    class="thumbstick"
    bind:this={thumbstickContainer}
    on:mousedown={handleMouseDown}
    on:touchstart={handleTouchStart}
    on:touchmove={handleTouchMove}
    on:touchend={handleTouchEnd}
    on:touchcancel={handleTouchEnd}
  >
    <div class="thumb" style="transform: translate({thumbstickPosition.x}px, 
    {thumbstickPosition.y}px)"></div>
  </div>
  
  <style>
    .thumbstick {
      position: relative;
      width: 100px;
      height: 100px;
      background-color: #ccc;
      border-radius: 50%;
    }
  
    .thumb {
      position: absolute;
      width: 20px;
      height: 20px;
      background-color: #333;
      border-radius: 50%;
      transition: transform .02s ease-out; /* Changed from 0.1s to 1s */
    }
  </style>