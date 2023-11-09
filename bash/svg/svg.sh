gaia_svg_help(){
  cat <<EOF
  Collection of Bash scripts for manipulating SVG text.
EOF
}

gaia_svg_path_nofill(){

awk '/<path/ { gsub(/fill="[^"]*"/, ""); } { print }' $1

}

