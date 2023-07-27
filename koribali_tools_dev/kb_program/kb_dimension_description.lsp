;------------------------------------------------------------------------------
;  Copyright (c) 2022 - M. Ramdan Purnama
;  Program Information 
;   File Name     : kb_dimension_description.lsp
;   Author        : M. Ramdan purnama
;   Email         : m.ramdan.p@gmail.com
;   Website       : -
;   Date Created  : 2023/07/07, 16:04 haurjaya, Bogor 
;   Description   : 
;------------------------------------------------------------------------------ 
;
; PROGRAM MANAGEMENT ----------------------------------------------------------
;
; INPUT -----------------------------------------------------------------------
;------------------------------------------------------------------------------
(defun kb_dimension_description ()

  (setq *error* *koribali_error*)
  
  ; Description
  (initget 1 "1 2 3 4 5")
  (princ "\nEnter description [1 : Opening/2 : Straight/3 : Taper/4 : Insertion/5 : G.L.より]")
  (setq ddi_getdesc (getkword))
  
  (cond 
    ((eq ddi_getdesc "1")
	  (princ "\nEnter cut width of opening <mm>:")
	  (setq ddi_cwo (getreal))
	)
  ); end cond
  
  (setq ddi_desc 
    (cond
      ((eq ddi_getdesc "1") (cons 1 (strcat "開口<>*" (rtos ddi_cwo))))
      ((eq ddi_getdesc "2") (cons 1 "<>\\X(ストレート部)"))
      ((eq ddi_getdesc "3") (cons 1 "<>\\X(テーパー部)"))
      ((eq ddi_getdesc "4") (cons 1 "<>\\X(灯具挿入寸法)"))
      ((eq ddi_getdesc "5") (cons 1 "G.L.より<>"))
    ); end cond
  ); end setq
 
  ; dimension line
  (setq 
    ddi_dL (entsel "\nSelect the dimension line")
	ddi_entget (entget (car ddi_dL))
	ddi_assoc  (assoc 1 ddi_entget)
	ddi_subst  (subst ddi_desc ddi_assoc ddi_entget)
  )
  
  ; modify the dimention line
  (entmod ddi_subst)
  
  (setq *error* nil)
  
); end defun
;
; Error Handling
(defun *koribali_error* (msg)

  (setq *error* nil)
  (kb_setting_restore); from kb_function.lsp
  (princ "\nDescription Dimension is Cancelled")
  
);
