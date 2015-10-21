#!/bin/bash

#/home/zlounsbe/bin/stacks-1.31/process_radtags \
#-P -p /home/zlounsbe/ArcticFox/raw_data/ \
#-i gzfastq -E phred33 \
#-o /home/zlounsbe/ArcticFox/Stacks/data/ \
#-b /home/zlounsbe/ArcticFox/Stacks/barcodes.txt \
#--inline_null -e sbfI -c -q -r

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-1031.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-1031.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-8013.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-8013.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-0218.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-0218.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-1034.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-1034.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-1061.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-1061.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-0601.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-0601.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-0602.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-0602.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-0796.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-0796.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-1071.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-1071.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-0598.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-0598.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-1079.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-1079.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#/home/zlounsbe/bin/stacks-1.31/clone_filter \
#-1 /home/zlounsbe/ArcticFox/Stacks/data/AF-1122.1.fq.gz -2 /home/zlounsbe/ArcticFox/Stacks/data/AF-1122.2.fq.gz -i gzfastq -o /home/zlounsbe/ArcticFox/Stacks/NoClones

#Use a larger --mem value for this step because it will kill at the default (during the population step)
#perl /home/zlounsbe/bin/stacks-1.31/scripts/denovo_map.pl -m 7 \
#-S -t -b 1 \
#-D "example_radtags" \
#-o /home/zlounsbe/ArcticFox/Stacks/map \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-1031.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-8013.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-0218.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-1034.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-1061.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-0601.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-0602.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-0796.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-1071.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-0598.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-1079.1.fq.fil.fq_1 \
#-s /home/zlounsbe/ArcticFox/Stacks/NoClones/AF-1122.1.fq.fil.fq_1

#For this next bit, I renamed all of the AF-*.2.fq.fil.fq_2 files to AF-*.1.fq.fil.fq_2 because Stacks told me it could not find the files as they were named... (In the NoClones folder)
perl /home/zlounsbe/bin/stacks-1.31/scripts/sort_read_pairs.pl \
-p /home/zlounsbe/ArcticFox/Stacks/map \
-s /home/zlounsbe/ArcticFox/Stacks/NoClones/ \
-o /home/zlounsbe/ArcticFox/Stacks/pairs

perl /home/zlounsbe/bin/stacks-1.31/exec_velvet.pl \
-c \
-P -p /home/zlounsbe/ArcticFox/Stacks/pairs/ \
-o /home/zlounsbe/ArcticFox/Stacks/assembled/ \
-M 200
