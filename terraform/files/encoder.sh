#!/bin/bash

#read -p "Filename to encode: " INPUT
#echo ""
INPUT=$1

echo "Encoded file will be placed in the same location."
#read -p "Output filename: " OUTPUT
#echo ""

bash -c "cat ${INPUT} | base64 | awk '{print}' ORS='' && echo"  >   ${INPUT}.b64
