#!/bin/bash


_pico_generate_css() {
    cat <<EOF
/* CSS variables for colors */
:root {
    --background-color: #f0f0f0;
    --foreground-color: #333;
    --accent-color: #007bff;
}

/* Body styling using CSS variables */
body {
    position: fixed;
    overflow: hidden;
    width: 100%;
    height: 100%;
    background: var(--background-color);
    color: var(--foreground-color);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
}

/* Button styling using CSS variables */
button {
    background: var(--foreground-color);
    color: var(--background-color);
    padding: 10px 20px;
    margin-top: 20px;
}

/* Dark mode styling */
body.dark-mode {
    background: var(--foreground-color);
    color: var(--background-color);
}

/* Dark mode button styling */
body.dark-mode button {
    background: var(--background-color);
    color: var(--foreground-color);
}

/* Top, middle and bottom section styling */
.top-section, .middle-section, .bottom-section {
    display: flex;
    justify-content: center;
    align-items: center;
    flex: 1;
}
EOF
}

# Function to generate JS
_pico_generate_js() {
    cat <<'EOF'
function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', document.body.classList.contains('dark-mode'));
}

// Check the user's preference on page load
document.addEventListener('DOMContentLoaded', (event) => {
    if (localStorage.getItem('darkMode') === 'true') {
        document.body.classList.add('dark-mode');
    }
});
EOF
}

[ ! -d "./css" ] && (
  echo "css missing, hit return to create, ctrl-c to cancel"
  read
)

# Generate according to pico-mvc file name conventions
[ ! -d "./css" ] && mkdir ./css
[ ! -d "./js" ] && mkdir ./js

_pico_generate_js > ./js/script.js
_pico_generate_css > ./css/global.css

cat <<EOF

 ./js/script.js created
 ./css/global.css created
 ./css/pico.min.css  <-- MUST PROVIDE THIS

EOF

cp $HOME/src/vendor/pico-1.5.10/css/pico.min.css ./css/
