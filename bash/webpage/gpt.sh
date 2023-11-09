cat <<EOF
I am building a documentation system using Bash. It coverts clean.txt to HTML using indexing clues found in clean.index. The HTML is composed by assigning variables in bash and using envsub on component files ending in.env. Here are the current components

EOF

for file in ./components/*.env;
  do printf '%s\n' "$file";
  cat "$file";
  echo
done

echo 'and here are bash functions used to make $GAIA_VERSIONpre$1.html'

echo gaia.sh:
cat ../gaia.sh

echo html.sh:
cat ./html.sh
