import { writable, derived } from 'svelte/store';

//export const currentChapterName = writable("Chapter");
export const currentChapterId = writable(null);
export const showChapterMenu = writable(false);
// Initial state can be null or the first chapter's identifier
export const chapters = [
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

export const currentChapterName = derived(
    currentChapterId,
    ($currentChapterId, set) => {
        if ($currentChapterId !== null) {
            set(chapters[$currentChapterId]);
        }
    }
);
