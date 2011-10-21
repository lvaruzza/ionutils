#!/bin/bash

TMAP=/share/apps/tmap/bin/tmap
ref=$1
in=$2
out=`basename $in .fastq`

if [ ! -f $ref.tmap.anno ]; then
 echo Creating index for $ref
 $TMAP index $ref
fi

echo Mapping and converting to BAM...
$TMAP mapall -f $ref -r $in -A 5 -M 3 -O 3-E 1 -n 8 -v map1 map2 map3 | samtools view -S -b - | samtools sort - $out
echo sorting BAM...
samtools index $out.bam
