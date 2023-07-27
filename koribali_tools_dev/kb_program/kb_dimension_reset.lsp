;------------------------------------------------------------------------------
;  Copyright (c) 2022 - M. Ramdan Purnama
;  Program Information 
;   File Name     : kb_dimension_reset.lsp
;   Author        : M. Ramdan purnama
;   Email         : m.ramdan.p@gmail.com
;   Website       : -
;   Date Created  : 2023/07/07, 15:59 haurjaya, Bogor 
;   Description   : 
;------------------------------------------------------------------------------ 
;
; PROGRAM MANAGEMENT ----------------------------------------------------------
(defun kb_dimension_reset (/
  ; local variables
    ss eLst eLst
  )

  (setq *error* *koribali_error*)
  
  (princ "\nSelect dimensions: ")
  (setq ss (ssget '((0 . "DIMENSION"))))
  (if ss
    (foreach forVar 
	  (vl-remove nil (mapcar '(lambda (x) (if (= (type (cadr x)) 'ENAME) (cadr x) '())) (ssnamex ss)))
      (setq eLst (entget forVar))
      (setq eLst (subst '(70 . 32) (assoc 70 eLst) eLst))
      (entmod eLst)
      (entupd forVar)
    )
  )
  
  (setq *error* nil)
  
); end defun
;
; Error Handling
(defun *koribali_error* (msg)

  (setq *error* nil)
  (princ "\nReset Text Positon is Cancelled")

)
  