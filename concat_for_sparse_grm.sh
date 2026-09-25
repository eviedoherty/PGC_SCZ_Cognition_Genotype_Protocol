#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=1
#SBATCH --job-name=grm_concat
#SBATCH --output=grm_concat.out
#SBATCH --error=grm_concat.err

cd /home/edoherty/gcta-1.95.3-linux-x86_64

N=20
PREFIX=grm_fastgwa_test

# safety check before touching anything
for i in $(seq -w 1 $N); do
  for ext in grm.id grm.bin grm.N.bin; do
    if [ ! -f "${PREFIX}.part_${N}_${i}.${ext}" ]; then
      echo "ERROR: missing ${PREFIX}.part_${N}_${i}.${ext}" >&2
      exit 1
    fi
  done
done

rm -f ${PREFIX}.grm.id ${PREFIX}.grm.bin ${PREFIX}.grm.N.bin
for i in $(seq -w 1 $N); do
  cat ${PREFIX}.part_${N}_${i}.grm.id    >> ${PREFIX}.grm.id
  cat ${PREFIX}.part_${N}_${i}.grm.bin   >> ${PREFIX}.grm.bin
  cat ${PREFIX}.part_${N}_${i}.grm.N.bin >> ${PREFIX}.grm.N.bin
done

rm ${PREFIX}.part_${N}_*.grm.id
rm ${PREFIX}.part_${N}_*.grm.bin
rm ${PREFIX}.part_${N}_*.grm.N.bin
