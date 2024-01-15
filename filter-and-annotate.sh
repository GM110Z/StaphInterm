
#!/bin/bash
echo "Getting rid of small contigs..."


#drop any contig smaller than 20kbk

VAR1=$(echo *.fna | xargs ls)
for y in ${VAR1}
   do
      reformat.sh ${y} out=${y}.fasta minlength=20000
   done

echo "Changing the header"
VAR2=$(echo *.fasta | xargs ls)

for x in ${VAR2}
   do
      awk 'BEGIN{FS="|"}{if(/^>/){print ">"$3}else{print $0}}'  ${x} >  ${x}
   done


echo "Annotating.."
VAR3=$(echo *.fasta | xargs ls)

for z in ${VAR3}
   do
      prokka --outdir ${z}_res --prefix ${z}_reannotated --locustag ${z}_locustag --cpus 8  ${z}
   done

