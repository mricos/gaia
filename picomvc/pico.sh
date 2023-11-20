#!/bin/bash

pico_build(){
local file=${1:-"./index.html"}
pico_generate_header > $file
pico_generate_content >> $file
pico_generate_footer >> $file 
}

pico_generate_header() {
    cat <<EOF
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PicoMVC</title>
<link rel="stylesheet" href="./css/pico.min.css">
<link rel="stylesheet" href="./css/global.css">
<script src="./js/script.js"></script>
</head>
EOF
}

# Function to generate content
pico_generate_content() {
    local main="$(pico_generate_main)"
    cat <<EOF
    <main class="container">
    $main
    </main>
EOF
}
pico_generate_main(){
    cat <<EOF
        <div class="top-section">
            <h4>Configure, run and monitor jobs at scale from AI assisted
            Jupyter notebooks. See<a href="https://notes.nodeholder.com">
            Nodeholder Notes</a> to learn more.</h4>
        </div>
        <div class="middle-section">
            <button
                class="button-primary"
                onclick="toggleDarkMode()"
            >
                Toggle Dark Mode
            </button>
        </div>

        <div class="bottom-section">
            <p>Bottom</p>
        </div>
EOF
}

pico_generate_components(){
   for component in $(ls -1 components/*.env)                                   
   do                                                                           
      local basename=$(basename $component)                                     
      cat $component | envsubst
   done                                                                         
}

# Function to generate footer
pico_generate_footer() {
    cat <<EOF
<footer>
    <!-- You can place your footer content here -->
</footer>
</html>
EOF
}

# Function to generate full page
pico_generate_page() {
    pico_generate_header
    pico_generate_content
    pico_generate_footer
}

