gaia_help(){
  cat <<EOF

    This is a collection of Bash functions for Extraction,
    Transformation and Loading of the Google document Knowing Gaia.
    
    https://docs.google.com/document/d/1QCWu6BMxVjcee9mf7tEMx8Z048ciYwlmx-EkoVSyzVI
    
    It is also a command line interface for reading the book.
    PWD must be where gaia.sh is located.
    
    1. copy or ln -s ../assets/raw.txt raw.txt
    2. gaia_cleaner         # makes clean.txt
    3. gaia_indexer         # makes clean.index
    4. gaia_display 2 3     # display Chapter 2, Prompt 3

EOF
}


gaia_docs(){
  cat <<'EOF'

# Gaia Documentation System - CLI

## Overview

gaia.sh translates a raw text into HTML with id tags:

- Sentence: c2-s3-p2-s2 (chapter 2, section 3, paragraph 2, sentence 2)
- Paragraph: c2-s3-p2  
- Section: c2-s3
- Chapter: c2

Prompt sections are a special type of section.

### Server build code

Copy your text into raw.txt, see example of tags Gaia discovers in
the inital text asset.

```bash
source gaia.sh
gaia-clean  # transform raw.txt -> clean.txt 
gaia-index  # creates clean.index mapping elements to lines
gaia-display 2 3 # displays Ch. 2, Sec. 3 formated for terminal
```

See html.sh for code that generates HTML From parsed data.

EOF

}