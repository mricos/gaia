# Knowing Gaia

This repo contains tools for exploring the Gaia hypothesis
and the nature of self as suggested in
[Knowing Gaia](https://knowing-gaia.net/) by Pat Adducci.
The raw text is found in the [./assets](./assets) directory.

## Pipeline
This data path starts with a Google Doc document and is 
either retrieved via API or cut-and-paste into [raw.txt](./assets/raw.txt).

On a Linux or Mac commandline, the gaia_ functions are used
to cleanup and produced a file with one paragraph per 
line in clean.txt. The clean.index identifies chapter
and section markers for for section-level look up.

The bash commands 'gaia_build_{webpage,stats}' create
a meaningful representation of clean.txt.

If webpage is used, custom made components are built
using Bash environment variables for passing properites 
between gaia components found, see html.

## Goals of the project
- Stay in touch with the Linux operation system
- Review typical dimensionality compression schemes
- Create **thought embeddings** of knowldge graph triples (subject, predicate, object)
- Create **concept embeddings** of thought embeddings (topic analysis)
- Build Android mobile app with [SvelteKit](https://kit.svelte.dev/) + [Capacitor](https://capacitorjs.com/solution/svelte)
- Think about the tactile nature of UI and natural language
 
## Directories in the repo

- **./assets**: raw text and some images for docs
- **./bash**: linux tools used to parse raw.txt
- **./js**: creates vanilla JS components for simple UI
- **./svelte**: vanilla npm package using svlete and rollup
- **./notebooks**: native app used to view one chapter+prompt
- **./capacitor**: svelte-capacitor mobile app to view by chapter+prompt

# Embeddings

Custom **thought-emebeddings** and **concept-embeddings** are
presented in the notebooks. The basic idea is fine-tune 
a distance measure of a limited number of thoughts and concepts.

## Background that is useful

- [PCA](https://en.wikipedia.org/wiki/Principal_component_analysis)
- [SVD](https://en.wikipedia.org/wiki/Singular_value_decomposition)
- [LDA](https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation)
- [word2vec](https://en.wikipedia.org/wiki/Word2vec)
- [BERT](https://en.wikipedia.org/wiki/BERT_(language_model))
- [sBERT](https://www.sbert.net/)

## Future

The next step is to record and create EEG embeddings of Muse 2
data that are correlated in time with the user reading passages of text.
This creates a system of creating 'labled' EEG signals resulting 
from complex thought.
