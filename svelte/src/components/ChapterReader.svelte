<script>
  import { onMount } from 'svelte';
  import { writable } from 'svelte/store';
  import { browser } from '$app/environment';
  import { xaxis, yaxis } from '../stores/joystickStore.js'; // Import the store
	import { showChapterMenu } from '../stores/chapterStore.js';

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
  $: $xaxis, setCurrentChapter($xaxis);

  function setCurrentChapter(xValue) {
    // Ensure xValue is within the chapters array bounds
    if (xValue >= 1 && xValue <= chapters.length) {
      const chapterIndex = xValue - 1; // Adjust for array indexing
      currentChapter.set(chapters[chapterIndex]);
      if (browser) {
        sessionStorage.setItem('currentChapter', chapters[chapterIndex]);
        showChapterMenu.set(false);
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

<div class="h-1/2 ml-20 mr-20 overflow-hidden" >
  <p class="text-2xl">
  After many years of Buddhist study and practice, and being influenced by less traditional non-duality speakers, I was inspired to develop a contemplation practice called “Knowing Gaia”. I’ve combined my experience of meditation and a Buddhist world view with a more contemporary approach which is not based on any spiritual authority. In “Knowing Gaia” a scientific world view is bent a little bit in the direction of intuition, poetry and mysticism without making up any stories which contradict our modern common sense. The text is more of an invitation than a guide, and readers are expected to make their own discoveries which may well be radically different from my own.
  </p>

Gaia, from Greek mythology, can be thought of as ‘Mother Earth’. The mythology includes stories of creation, primordial conflict and shifting rulers. Here, I’m using a contemporary concept of Gaia. James Lovelock, an English scientist and inventor, started it. He was working for NASA investigating planetary atmospheres when he started thinking about how very odd Earth’s atmosphere is, how unstable and unlikely. Of course this is a result of life processes exchanging gases, impossible for a non-living planet. He realized that not only does life adapt to changing conditions, but also changes conditions itself in a dynamic, self-regulating system.

There was nothing anthropomorphic in his idea, but his friend, novelist William Golding, found it poetic and suggested calling it ‘Gaia’ rather than a more prosaic ‘Earth systems science’.

Some people have been enchanted by the poetry into thinking that our Earth will take care of us. Unfortunately, we don’t know that. Evidence so far suggests that Gaia is heartless. We are only as special as we make ourselves to be. Gaia is mother to all her children - frog and fly, Neanderthal and Homo Sapiens. Life forms thrive, or not, in an ever-changing web. Everyone needs something to eat. Animals eat plants which were thriving on the carbon dioxide exhaled by those very animals. The animals are thriving on the oxygen produced by the plants they are killing. Yet the whole complex system not only continues, but continues to develop more complexity. It almost seems alive, and so, following Lovelock, I’m calling it Gaia.

I’m setting aside the fact that traditional ideas of ‘mother’ imply the existence of ‘father’. Let’s just say the Sun is our father, and go ahead with Gaia as our subject. Think of the earth and everything on it. The oceans are home to phytoplankton cells in the billions, each separately working away at photosynthesis, releasing trace amounts of oxygen. Diatoms not only give us oxygen, but lock carbon in their miniscule shells.The shells drop down through the water when the diatom dies, taking that bit of carbon with them, cooling the planet, to the benefit of the living diatoms and everyone else who likes the temperature the way it is. Having discovered the amazing convenience of fossil fuels, we humans are about to defeat their efforts. Certain species of jellyfish think that’s a great idea! They are already showing up in unprecedented numbers. So, who is choosing the future?

At the time of the asteroid impact that killed the dinosaurs, small mammals were living in burrows, out of danger from the huge beasts who had ruled the planet for 175 million years. These small rat-like mammals would not be our first choice of an ancestor, but hiding in their burrows they survived the fires and extreme conditions following the impact, and became our ancestors. From a combination of chance, time and natural selection in a complex, self-regulating system, we merged.


  <!-- Display chapter content here -->
</div>

