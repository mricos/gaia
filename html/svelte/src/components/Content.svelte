<script>

  import { scrollToId } from '../store.js';

  function handleScrollToId(id) {
    const element = document.getElementById(id);
    if (element) {
      window.scrollTo({
        top: element.offsetTop,
        behavior: 'smooth'
      });
    }
  }

  scrollToId.subscribe(value => {
    if (value !== null) {
      handleScrollToId(value);
      scrollToId.set(null);  // Reset the store value after handling
    }
  });

    import { onMount } from 'svelte';
    let bookContent = '';
    let chapters = [];

    onMount(async () => {
        console.log("Content onMount");
        try {
            const response = await fetch('./book.html');
            if (!response.ok) {
                // Handle HTTP errors
                console.error('Failed to fetch book.html:',
                    response.statusText);
                return;
            }
            bookContent = await response.text();
        } catch (error) {
            // Handle network errors
            console.error('Network error:', error);
        }

        chapters = Array.from(document.querySelectorAll('.chapter'));

    });




</script>

{#if bookContent}
    <div class="book-content">
        {@html bookContent}
    </div>
{:else}
    <div class="book-content">Loading...</div>
{/if}

