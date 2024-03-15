<script>
  import { onMount } from 'svelte';

  let messages = [];
  let socket = new WebSocket('ws://localhost:8080'); // Replace with your WebSocket server URL

  socket.onopen = () => {
    console.log('WebSocket Client Connected');
};

  client.onmessage = (message) => {
    const now = new Date();
    messages = [...messages, `${now.toISOString()} - ${message.data}`];
  };

  onMount(() => {
    client.onmessage = (message) => {
      const now = new Date();
      messages = [...messages, `${now.toISOString()} - ${message.data}`];
    };
  });
</script>

<pre style="font-family: monospace;">
  {#each messages as message}
    <p>{message}</p>
  {/each}
</pre>
