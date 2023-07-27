;------------------------------------------------------------------------------
;  Copyright (c) 2023 - M. Ramdan Purnama
;  Program Information 
;   File Name     : kb_scale.lsp
;   Author        : M. Ramdan purnama
;   Email         : m.ramdan.p@gmail.com
;   Website       : -
;   Date Created  : 2023/07/07, 16:44 haurjaya, Bogor 
;   Description   : 
;------------------------------------------------------------------------------ 
(defun get_dimscale (/ e ent data xdata dimscale)

  (setq e 1)
    (while e
      (setq ent (car (entsel "\nSelect dimension line: "))) ;select
      (if (or (null ent) ;if missed pick
        (/= (cdr (assoc 0 (entget ent))) "DIMENSION")) ;
        (prompt "\nNot an valid \Dimension line") ;
        (setq e nil) ;
    ) ;end if
  ) ;end while
  
  (setq data (entget ent '("acad")))
  (setq xdata (cdadr (assoc -3 data)))
  (setq dimscale (cdr (assoc 1040 xdata)))
  
);end defun
;