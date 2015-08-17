W=($(wc -l SNPsites))

x=1
while [ $x -le $W ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p SNPsites" # These were filtered based on sites that appear diploid in Tablet.

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)

num=($(awk -v var=${c1} '$2==var' *bam.vcf | wc -l))

if [ "$num" -gt "10" ] ; then
        echo "${c1}" >> retained.txt
else
        echo "${c1}" >> ommitted.txt
fi

x=$(( $x + 1 ))
done

