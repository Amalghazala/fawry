#!/bin/bash

show_help() {
  echo "Usage: $0 [-n] [-v] search_string filename"
  echo "Options:"
  echo "  -n    Show line numbers"
  echo "  -v    Invert match"
  echo "  --help Show help message"
}

show_line_numbers=false
invert_match=false

while getopts ":nv-:" opt; do
  case $opt in
    n) show_line_numbers=true ;;
    v) invert_match=true ;;
    -)
      case "$OPTARG" in
        help)
          show_help
          exit 0
          ;;
        *)
          echo "Invalid option --$OPTARG"
          show_help
          exit 1
          ;;
      esac
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      show_help
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

if [[ $# -lt 2 ]]; then
  echo "Error: Missing search string or filename."
  show_help
  exit 1
fi

search_string="$1"
file="$2"

if [[ ! -f "$file" ]]; then
  echo "Error: File '$file' not found."
  exit 1
fi

line_number=0
while IFS= read -r line; do
  ((line_number++))
  match=$(echo "$line" | grep -i "$search_string")

  if $invert_match; then
    if [[ -z "$match" ]]; then
      if $show_line_numbers; then
        echo "$line_number:$line"
      else
        echo "$line"
      fi
    fi
  else
    if [[ -n "$match" ]]; then
      if $show_line_numbers; then
        echo "$line_number:$line"
      else
        echo "$line"
      fi
    fi
  fi
done < "$file"
