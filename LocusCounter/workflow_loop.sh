#!/bin/bash
x=1
while [ $x -le 43 ] # "-le " refers to your sample size for the "while loop"
do

      string="sed -n ${x}p files2"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1
	c2=$2

	./change_workflow_file.sh ${c1}
	./workflow2.sh
	./change_workflow_file_back.sh ${c1}

x=$(( $x + 1 ))

done
