x=1
while [ $x -le 36 ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p bam.filelist" # These were filtered based on sites that appear diploid in Tablet.

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)

samtools index ${c1}

x=$(( $x + 1 ))
done

