#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -x|--x)
    x="$2"
    shift # past argument
    shift # past value
    ;;
    -y|--y)
    y="$2"
    shift # past argument
    shift # past value
    ;;
    -if|--inputfile)
    inputfile="$2"
    shift # past argument
    shift # past value
    ;;
    -of|--outputfile)
    outputfile="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# copy first x row as they were
sed -n "1,$x p" "$inputfile" > "$outputfile"

# cycle every other row from 2nd to the last but one
# mirror 2nd, copy 3rd, mirror 4th ...
# generally: mirror i, copy i+1
#
# about the double brackets: $((i+x)) gives i+x
# pipe into tac reverses whatever was before 
for i in $(seq 2 2 $((y-1))); do
 sed -n "$((i*x+1)),$((i*x+x)) p" "$inputfile" | tac >> "$outputfile"
 sed -n "$(((i+1)*x+1)),$(((i+1)*x+x)) p" "$inputfile" >> "$outputfile"
done

sed -n ",$x p" "$inputfile" > "$outputfile"
