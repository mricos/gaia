newPico(){
  rm -rf css
  rm -rf js
  rm index.html
  source picogpt.sh
  createPico
  python -m http.server
}
