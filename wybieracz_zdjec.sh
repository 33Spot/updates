

folder=katalog_ze_zdjeciami_1
mkdir $folder

for file in *.jpg
do
	for x in {}
	do
		a=${file%????}
		b=$(echo -n $a | tail -c 4)

		if [ "$b" == "$x" ]; then
			echo kopiujemy "$file"
			cp "$file" "$folder"
		fi;

	done;
	
done;


#6813,6777,6790,6793,6798,6801,6811,6817,6818,4334,4335,6162,8595,8602,8610,2613,2020,2618,2626,2638,2639,2645,2646,2651,2655,2664,2678,9890,9892,3807,6188,0794,0967,6002,0774,1448


