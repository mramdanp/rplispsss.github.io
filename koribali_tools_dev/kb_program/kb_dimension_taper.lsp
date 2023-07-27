;------------------------------------------------------------------------------
;  Copyright (c) 2022 - M. Ramdan Purnama
;  Program Information 
;   File Name     : kb_dimension_taper.lsp
;   Author        : M. Ramdan purnama
;   Email         : m.ramdan.p@gmail.com
;   Website       : -
;   Date Created  : 2023/07/07, 15:15 haurjaya, Bogor 
;   Description   : 
;------------------------------------------------------------------------------ 
;
; PROGRAM MANAGEMENT ----------------------------------------------------------
;------------------------------------------------------------------------------
(defun kb_dimension_taper (/
  ; local variables
    dti_etp dti_stp dti_getsc dti_loc
    dpo_ent dpo_entget dpo_assoc dpo_subst dpo_entmode
    oldosmode oldorthomode olddimscale olddimdec oldclayer  
  )
  
  (load "C:\\AutoLISP\\koribali_tools_dev\\kb_function\\kb_function.lsp")

  ; settings 
  (setq *error* *koribali_error*)
  (kb_setting_save); from kb_function.lsp
  
  ; input 
  (kb_dim_tpr_input)
  
  ; ouput
  (kb_dim_tpr_output)
  
  ; ressetings
  (kb_setting_restore); from kb_function.lsp
  (setq *error* nil)

  
); end defun
;
; INPUT -----------------------------------------------------------------------
;------------------------------------------------------------------------------
(defun kb_dim_tpr_input ()
  
  ; settings
  (setvar "OSMODE" 33)
  (setvar "ORTHOMODE" 1)
  
  ; start point and end point
  (setq dti_etp (getpoint "\nEnter End Point :"
    (setq dti_stp (getpoint "\nEnter Start Point :"))
    )
  )
  
  ; dimension scale 
  ; drawing scale
  (initget 1 "1 2")
  (princ "\nEnter Scale [1 = Select Dimension/2 = Input value]")
  (setq dti_getsc (getkword))
  
  ; dimension scale value
  (setq dti_sc 
    (if (eq  dti_getsc "1")
	  ; then
	  (get_dimscale)
	  ; else
	  (getreal "\nEnter Scale of Leader :")
	); end if
  );setq
  
  ; dimension line location
  (setq dti_loc (polar dti_stp (* pi 0.5) (* dti_sc 10.)))
  
); end defun
;
; OUTPUT ----------------------------------------------------------------------
;------------------------------------------------------------------------------
(defun kb_dim_tpr_output ()
  
  ; set variables
  (setvar "OSMODE" 0)
  (setvar "DIMSCALE" dti_sc)
  (setvar "DIMDEC" 1)
  
  ;  layer setting
   (if (= (TBLSEARCH "LAYER" "AM_5"))
    (setvar "CLAYER" "AM_5")
    (command "_.Layer" "_M" "AM_5" "_C" "Bylayer" "" "_L" "Bylayer" "" "")
  )
  
  ; dimension line
  (command "DIMLINEAR" dti_stp dti_etp "H" dti_loc)
  
  ; add diameter symbol to the dimension line
  (setq 
    dpo_ent (entlast)
	dpo_entget (entget dpo_ent)
	dpo_assoc (assoc 1 dpo_entget)
	dpo_subst (subst (cons 1 "%%c<>") dpo_assoc dpo_entget)
	dpo_entmode (entmod dpo_subst)); end setq
	
  ; dimension edit
  (command "DIMEDIT" "O" dpo_ent "" 45.0)
  
); end defun
;
; Error Handling
(defun *koribali_error* (msg)

  (setq *error* nil)
  (kb_setting_restore)
  (princ "\nTaper Dimension is Cancelled")
  
);