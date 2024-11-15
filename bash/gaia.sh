source ./docs.sh
gaia_reset(){
  rm clean.txt
  rm clean.index
}

gaia_cleaner(){
  ./cleaner raw.txt  > clean.txt
}

gaia_indexer(){
   cat clean.txt | ./indexer > clean.index
}


# consider rewriting with single awk cal
gaia_get_between(){
  local start=$1;  # start line
  local end=$2;    # end line
  local file=${3:-clean.txt};
  < "$file" tail -n +"$1" | head -n "$(($2 - $1))"
}

# Convert from two dim (chapter,prompt) to one dim (unitID).
# Examples: (1,2) => 15; (2,2) => 26.
gaia_get_unit_id(){
  local chapter=$1
  local prompt=$2
  echo $(( 2 + chapter*11 + prompt))
}

gaia_get_offset(){
  local tokens=($(sed "$1q;d" clean.index))
  echo "${tokens[0]}" # quotes not necessary since its a token
}

gaia_get_unit_text(){
  local id=$1
  local idNext=$((id + 1))
  local offset=$(gaia_get_offset $id)
  local offsetNext=$(gaia_get_offset $idNext)
  gaia_get_between $((offset+1)) $offsetNext
}

gaia_get_chapter_offset(){
  local line=($(awk /"chapterStart C$1"/ clean.index))
  echo ${line[0]}
}

gaia_get_author_offset(){
  local line=($(awk /"authorStart"/ clean.index))
  echo ${line[0]}
}

gaia_get_document_end(){
  local line=($(awk /"documentEnd"/ clean.index))
  echo ${line[0]}
}

gaia_get_prompt(){
  local indexLine=($(awk /"promptStart P$1"/ clean.index))
  local promptIndex=${indexLine[0]}
  gaia_get_line $promptIndex
}

gaia_get_line(){
  sed "$1q;d" clean.txt
}

# Normally want to "" $variables. But when the variable
# is known to be single token, do not quote (ignore SC2046 warning) 
# shellcheck disable=SC2046,SC2086
gaia_display(){
  local chapter=$1 # single token number 
  local prompt=$2  # single token number
  local width=${3:-60}
  local unitId=$(gaia_get_unit_id $chapter $prompt)
  local chapterText="$(gaia_get_line $(gaia_get_chapter_offset $chapter))"
  local promptText="$(gaia_get_prompt $prompt)"
  local text=$(gaia_get_unit_text $unitId)
  local textFmt=$(echo -e "$chapterText\n\n$promptText\n\n$text" | 
                   fmt -$width | sed -e 's/^/         /')
  local len=$(echo -e "$textFmt" | wc -l );
  local margin=$(( (24-len)/2 ))
  clear;
  if (( len < 23 ))
  then 
    printf '\n%.0s' $(seq 1 $margin) 
    echo "$textFmt" 
    printf '\n%.0s' $(seq 1 $margin) 
  else
    echo "$textFmt" | less
    echo "$textFmt" 
  fi 
}

# Multiple sentences per line.
# Think 'one paragraph per line'.
gaia_str_to_sentences(){
  local str="$1"
  local lines=$(echo $str | sed 's/\. /\.\n/g')  # adds newlines
  echo "$lines"  # Glob to retain \n
}

gaia_get_chapter_lines(){
  local authorOffset=$(gaia_get_author_offset)
  local docEnd=$(gaia_get_document_end)
  local chapter=$1;
  local chapterPlus1=$((chapter + 1))
  local start=$(gaia_get_chapter_offset $chapter)
  local end=$(gaia_get_chapter_offset $chapterPlus1)
  [[ -z $end ]] && end=$authorOffset
  local chapterLines=$(gaia_get_between $start $end); # keeps new lines
  echo "$chapterLines" #Quote to preserve newlines
}
