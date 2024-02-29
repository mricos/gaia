<script>
  import ChapterReader from '../components/ChapterReader.svelte';
  // These are client-side environment variables and should be accessed directly in the script
  const currentVersion = import.meta.env.VITE_APP_VERSION;
  const apiFromEnvFile = import.meta.env.VITE_API_KEY;


 </script>
<ChapterReader />
