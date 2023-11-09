# Gaia Documentation System - Bash

The Gaia Documentation System is a Bash-based framework designed to transform structured text documents into HTML format. This system parses text using indexing clues and assembles HTML pages by incorporating various content components and styles.

## System Overview

The system is composed of two main scripts: `gaia.sh` and `html.sh`, each with dedicated functions for processing text and generating HTML content.

### [gaia.sh](http://gaia.sh/) Functions

- `gaia_reset()`: Cleans the workspace by removing `clean.txt` and `clean.index` files.
- `gaia_cleaner()`: Processes the raw text input and generates a cleaned version.
- `gaia_indexer()`: Creates an index mapping from the cleaned text.
- `gaia_get_between()`: Retrieves text between specified line numbers from a file.
- `gaia_get_unit_id()`: Converts chapter and prompt numbers to a unique unit ID.
- `gaia_get_offset()`, `gaia_get_unit_text()`, `gaia_get_chapter_offset()`, `gaia_get_author_offset()`, `gaia_get_document_end()`: These functions fetch specific offsets from the `clean.index` to locate different sections within the text.
- `gaia_get_prompt()`, `gaia_get_line()`: Extracts prompts and specific lines from the text.
- `gaia_display()`: Formats and displays a specified unit of text to the terminal.
- `gaia_str_to_sentences()`: Converts a string into individual sentences.
- `gaia_get_chapter_lines()`: Retrieves all lines associated with a given chapter.

### [html.sh](http://html.sh/) Functions

- `gaia-html-check-env()`: Checks the environment for required variables.
- `gaia-html-make-all()`: Orchestrates the construction of the entire HTML document.
- `gaia-html-cat-all()`: Concatenates individual HTML component files into one document.
- `gaia-html-make-chapter()`: Generates HTML content for a specific chapter from text lines.
- `gaia-html-get-color()`, `gaia-html-get-alternating-sentence-class()`: Helper functions to style content.
- `gaia-html-make-prompt()`, `gaia-html-make-sentence()`, `gaia-html-make-span()`: Functions to generate HTML markup for prompts, sentences, and span elements.
- `gaia-html-make-head()`, `gaia-html-make-header()`, `gaia-html-make-body()`, `gaia-html-make-footer()`: Functions to generate specific sections of the HTML document.
- `gaia-html-make-components()`: Processes `.env` files and substitutes variables to create HTML components.
- `gaia-html-about()`: Provides documentation for using the Gaia Documentation System.

## Component Files

- `components/*.env`: Template files that contain HTML structures for different sections of the final HTML page, including placeholders for variables that are substituted during the build process.

## Building the HTML Document

To generate the HTML document, execute the `gaia-html-make-all` function. This function will sequentially invoke other functions to create individual components and assemble them into a single HTML file named `${GAIA_VERSION}pre$pre.html`.

### Example Usage

```bash
export GAIA_VERSION="1.0"
export GAIA_HTML="./html"
export GAIA_COMPONENTS="./components"
gaia-html-make-all

```

This will produce an HTML file with the specified version number and pre-numbering. The `GAIA_HTML` and `GAIA_COMPONENTS` environment variables should be set to point to the directories containing the HTML output and component templates, respectively.

## Final Note

The generated HTML document will be styled and structured according to the content of the `.env` component files and the index provided by `clean.index`. Customization can be achieved by modifying these components and the associated CSS and JavaScript files.
