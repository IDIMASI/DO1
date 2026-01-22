#!/bin/bash

start_time=$(date +%s.%N)

if [[ $# != 1 ]]
then
	echo "Invalid number of arguments (expected 1, input $#)"
	exit 1
fi

if [[ !(-d $1) ]]
then
	echo "it is not a directory"
	exit 1
fi

if [[ $1 != */ ]]
then
	echo "incorrect input"
	exit 1
fi

directoria_sum=$(ls -lR $1 | grep "^d" | wc -l)
total_files="$(find $1 -type f | wc -l)"
big_folders=$(du -h  $1* | sort -rh | head -5 | cat -n | awk '{print $1" - "$3", "$2}')

echo "Total number of folders (including all nested ones) = $directoria_sum"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):
$big_folders"
echo "etc up to 5"
echo "Total number of files = $total_files"
echo "Number of:  
Configuration files (with the .conf extension) = $(find $1 -name "*.conf" | wc -l)
Text files = $(find $1 -name "*.txt" | wc -l)
Executable files = $(find $1 -type f -perm /a=x | wc -l)
Log files (with the extension .log) = $(find $1 -name "*.log" | wc -l)
Archive files = $(find /etc/ -name "*.zip" -name "*.tar" -name "*.rar"|wc -l)
Symbolic links = $(find $1 -type l |wc -l)"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
	for i in {1..10}
	do
		file_path=$(find $1 -type f -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d") 
		if ! [[ -z $file_path ]]
		then
			echo -n "$i - "
			echo -n "$(echo $file_path | awk '{print $2}'), " # path
			echo -n "$(echo $file_path | awk '{print $1}'), " # size
			echo "$(echo $file_path | grep -o -E "\.[^/.]+$" | awk -F . '{print $2}')" # extension
		fi
	done

	echo "etc up to 10"

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
	for i in {1..10}
	do
		file_path=$(find $1 -type f -name "*.exe" -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d") 
		if ! [[ -z $file_path ]]
		then
			echo -n "$i - "
			echo -n "$(echo $file_path | awk '{print $2}'), " # path
			echo -n "$(echo $file_path | awk '{print $1}'), " # size
			md5_hash=$(echo "$file_path" | awk '{print $2}' | xargs md5sum | awk '{print $1}')
        	echo "$(echo "$file_path" | awk '{print $2}' | xargs md5sum | awk '{print $1}')"
		fi
	done
echo "etc up to 10"

end_time=$(date +%s.%N)
echo "Script execution time (in seconds) = " `echo "$end_time $start_time" | awk '{printf "%.1lf", $1-$2}'`