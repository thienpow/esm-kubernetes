#!/bin/sh

pattern=$1
folder=$2
search=$3
replace=$4

input_file="$(find ${folder} -type f -iname ${pattern})"
echo "checking ${input_file} and edit ${search} to ${replace}"
sed -i.bak "s/${search}/${replace}/g" "${input_file}"
#read -p "wait and check"
rm "${input_file}.bak";