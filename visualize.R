require(ANTsR)

glass <- antsImageRead('data/template/glassbrain.nii.gz', 3)
wm <- antsImageRead('data/template/WM.nii.gz', 3)
leftright <- antsImageRead('data/template/leftright.nii.gz', 3)
lateralLeft <- rotationMatrix(pi/2, 0, -1, 0) %*% rotationMatrix(pi/2, -1, 0, 0)
sagittalLeft <- rotationMatrix(-pi/2, 0, -1, 0) %*% rotationMatrix(pi/2, -1, 0, 0)
lateralRight <- rotationMatrix(-pi/2, 0, -1, 0) %*% rotationMatrix(pi/2, -1, 0, 0)
sagittalRight <- rotationMatrix(pi/2, 0, -1, 0) %*% rotationMatrix(pi/2, -1, 0, 0)
wm.left <- maskImage(wm, leftright, 1)
wm.right <- maskImage(wm, leftright, 2)
glass.left <- maskImage(glass, leftright, 1)
glass.right <- maskImage(glass, leftright, 2)

for (VOI in c("bnt", "wordlisttotal", "age")){
  for (sparsity in c(01, 03, 05, 07, 10)){
    eigenvectors.left <- list()
    eigenvectors.right <- list()
    for (eigvec.number in 5:0) {
      i = eigvec.number + 1 # R lists start at 1, not 0
      eigvec <- antsImageRead(paste('data/precomputed/', VOI, 'Sparse', 
                                    sprintf('%.2i', sparsity), 
        'Cluster200TrainView1vec', sprintf('%.3i', eigvec.number), '.nii.gz', sep=''), 3)
      eigenvectors.left[[i]] <- maskImage(eigvec, leftright, 1)
      eigenvectors.right[[i]] <- maskImage(eigvec, leftright, 2)
      if(length(eigenvectors.left[[i]][eigenvectors.left[[i]] > 0]) == 0){
        eigenvectors.left[[i]] <- NULL # delete eigenvectors with only zeros
      }
      if(length(eigenvectors.right[[i]][eigenvectors.right[[i]] > 0]) == 0){
        eigenvectors.right[[i]] <- NULL
      }
    }
    vis.left <- renderSurfaceFunction( list( wm.left, glass.left ), 
         eigenvectors.left, surfval=0.5, alphasurf=c(1, 0.2), 
                                           basefval = 1.5, alphafunc=1)
    par3d(userMatrix=lateralLeft, windowRect=c(25,25,325,325), zoom=0.8 ) 
    rgl.snapshot(paste('fig/precomputed/', VOI, 'Sparse', sparsity, 
                 'Cluster200', '_lateral_left.png', sep='') )
    par3d(userMatrix=sagittalLeft, windowRect=c(25,25,325,325), zoom=0.9)
    rgl.snapshot(paste('fig/precomputed/', VOI, 'Sparse', sparsity, 
                       'Cluster200', '_sagittal_left.png', sep='') ) 
    if(length(eigenvectors.right  ) > 0 ) {
      vis.right <- renderSurfaceFunction(list(wm.right, glass.right), 
                                         eigenvectors.right, surfval=0.5, alphasurf=c(1, 0.2), 
                                         basefval=1.5, alphafunc=1)
      par3d(userMatrix=lateralRight, windowRect=c(25,25,325,325), zoom=0.8 ) 
      rgl.snapshot(paste('fig/precomputed/', VOI, 'Sparse', sparsity, 
                         'Cluster200', '_lateral_right.png', sep='') )  
      par3d(userMatrix=sagittalRight, windowRect=c(25,25,325,325), zoom=0.9)
      rgl.snapshot(paste('fig/precomputed/', VOI, 'Sparse', sparsity, 
                         'Cluster200', '_sagittal_right.png', sep='') )     
    }
  }
}