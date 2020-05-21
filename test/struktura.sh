#!/bin/bash

if [[ "$#" != 0 ]]; then
	echo "Pozvali ste skriptu sa parametrima!"
	exit 1
fi

if [[ -d "struktura" ]]; then
	echo "Folder struktura vec postoji!"
	exit 1
fi

mkdir struktura

regioni=$(cut --delimiter ":" --fields 3 regioni | sort -u)

IFS=$'\n'
for region in $regioni; do
	mkdir "struktura/$region"
	gradovi=$(grep ":$region:" regioni | cut --delimiter ":" --fields 2,4)
	for grad in $gradovi; do
		ime=$(cut --delimiter ":" --fields 1 <<< "$grad")
		broj=$(cut --delimiter ":" --fields 2 <<< "$grad")
		echo "$broj" > "struktura/$region/$ime"
	done
done
unset IFS
