<script>
    export let show;
    export let close;
    import { chapters, showChapterMenu } from '../stores/chapterStore.js';
    import {  currentChapterId } from '../stores/chapterStore.js';
            

    function closeChapterMenu() {
        showChapterMenu.set(false);
    }

    function setCurrentChapter(id) {
      currentChapterId.set(id);
      closeChapterMenu();
    }
    function handleClose() {
        closeChapterMenu();
    }
  </script>
  <div class="flex items-center justify-center">
      <ul class="menu p-2 w-96 bg-lime-900 rounded-t-none">
        {#each chapters as title,  id}
          <li><a on:click={() => setCurrentChapter(id)}>{title}</a></li>
        {/each}
      </ul>
</div>