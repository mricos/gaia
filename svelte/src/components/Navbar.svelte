<script>
  import ChapterMenu from './ChapterMenu.svelte'; // Changed this line
  import { onMount } from 'svelte';
  import { currentChapterName } from '../stores/chapterStore.js';
  import { showChapterMenu } from '../stores/chapterStore.js';

  let chapterName = "Chapter";
  $: chapterName = $currentChapterName;

  onMount(() => {
    currentChapterName.subscribe(value => {
      chapterName = value || "Chapter";
    });
  });
</script>

<nav class="bg-lime-900 rounded-lg flex justify-between items-center m-4">
  <div>
    <a class="btn btn-ghost text-xl"
     on:click={() => showChapterMenu.set(true)}>{chapterName}
    </a>
  </div>

  {#if $showChapterMenu}
    <div class="fixed inset-0 flex items-center justify-center">
      <ChapterMenu 
      show={$showChapterMenu}
      on:close={() => showChapterMenu.set(false)} />
    </div>
  {/if}
</nav>