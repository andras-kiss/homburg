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

#old version done with sed, not complete
#cp /dev/null $outputfile
#for i in $(seq 0 2 $y); do
# sed -n "$((i*x+1)),$((i*x+x)) p" "$inputfile" >> "$outputfile"
# sed -n "$(((i+1)*x+1)),$(((i+1)*x+x)) p" "$inputfile" | tac >> "$outputfile"
#done

#with awk
cp /dev/null $outputfile
for i in $(seq 0 2 $y); do
 awk -v line="$i" "NR>=$((i*x+1)) && NR<=$((i*x+x))"'{print $1, $2, $3}' $inputfile >> $outputfile
 awk -v line="$i" "NR>=$(((i+1)*x+1)) && NR<=$(((i+1)*x+x))"'{print $1, $2, $3}' "$inputfile" | tac >> "$outputfile"
done
