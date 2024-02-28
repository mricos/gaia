<script>
  import { onMount } from 'svelte';
  import { writable } from 'svelte/store';
  import { browser } from '$app/environment';
  import { sliderValue } from '../stores/sliderStore.js'; // Import the store

  // Function to save current chapter to sessionStorage
  function saveToSessionStorage(chapter) {
    if (browser) {
      sessionStorage.setItem('currentChapter', chapter);
    }
  }

  // Function to load current chapter from sessionStorage
  function loadFromSessionStorage() {
    if (browser) {
      return sessionStorage.getItem('currentChapter');
    }
    return null;
  }

  // Chapters array
  const chapters = [
    "Introduction",
    "Taking a leap into the deeply personal",
    "First Impressions",
    "Seeing the prompts in one word",
    "Using words to step away from words",
    "What do we want?",
    "Investigating personal identity",
    "Being and doing",
    "Natural limits",
    "Self-regulating systems and individual choice",
    "Contemplation"
  ];

  let currentChapter = writable(chapters[0]); // Default to first chapter

  // Subscribe to sliderValue changes
  $: $sliderValue, setCurrentChapter($sliderValue);

  function setCurrentChapter(xValue) {
    // Ensure xValue is within the chapters array bounds
    if (xValue >= 1 && xValue <= chapters.length) {
      const chapterIndex = xValue - 1; // Adjust for array indexing
      currentChapter.set(chapters[chapterIndex]);
      if (browser) {
        sessionStorage.setItem('currentChapter', chapters[chapterIndex]);
      }
    }
  }

  onMount(() => {
    // Initialize with value from session storage if available
    const storedChapter = sessionStorage.getItem('currentChapter');
    if (storedChapter) {
      currentChapter.set(storedChapter);
    }
  });
</script>

<div>
  <h1>{$currentChapter}</h1>
  
  <!-- Display chapter content here -->
</div>