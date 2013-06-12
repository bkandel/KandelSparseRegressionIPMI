#!/bin/bash
ROOTDIR=/home/ben/Data/KandelSparseRegressionIPMI/data
DATADIR=image_data
DEMOGDIR=demog
TEMPLATEDIR=template
VOI=age
SPARSITY=05
FOLD=5
CLUSTER=500
NEIGVECS=6
OUTDIR=/home/ben/Data/KandelSparseRegressionIPMI/data/out

cmd="sccan --svd network[${ROOTDIR}/${DATADIR}/${VOI}_train.mha,${ROOTDIR}/${TEMPLATEDIR}/GM_mask_lores_trimmed.nii.gz,-0.${SPARSITY},${ROOTDIR}/${DEMOGDIR}/wolk_regression_train_age.csv] \
      -i 5 \
      --PClusterThresh $CLUSTER \
      -n $NEIGVECS \
      -o $OUTDIR/agevec.nii.gz \
      -r 0 \
      -p 0"
echo $cmd
$cmd
