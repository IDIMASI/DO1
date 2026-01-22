#!/bin/bash

number='^[+-]?[0-9]+([.][0-9]+)?$' 
if [[ $# != 1 ]] || !([[ $1 =~ $number ]]);
then 
	echo "Wrong argument"
else
	echo $1
fi