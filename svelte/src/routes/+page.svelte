<script>
  import { onMount } from 'svelte';
  import ChapterReader from '../components/ChapterReader.svelte';
  // These are client-side environment variables and should be accessed directly in the script
  const currentVersion = import.meta.env.VITE_APP_VERSION;
  const apiFromEnvFile = import.meta.env.VITE_API_KEY;
  import { appState } from '../stores/appState.js';

  export let data;

  let apiKey=data.props.apiKeyapiKey;
  let commitHash=data.props.commitHash;
  $: appState.set(data);

  onMount(() => {
    // Initialize the clientCache store with data passed from the server
    //clientCache.set(data);

  });

 </script>
<ChapterReader />

<pre>{JSON.stringify(data)}</pre>

