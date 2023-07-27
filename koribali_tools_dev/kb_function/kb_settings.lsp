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
(defun kb_setting_save ()

  (setq
    oldosmode    (getvar "OSMODE")
	oldorthomode (getvar "ORTHOMODE")
	olddimscale  (getvar "DIMSCALE")
	olddimdec    (getvar "DIMDEC")
	oldclayer    (getvar "CLAYER")
	oldceltype   (getvar "CELTYPE")
	oldcelweight (getvar "CELWEIGHT")
	oldcecolor   (getvar "CECOLOR")
 ); end setq
 
); end defun
;
(defun kb_setting_restore ()

  (setvar "OSMODE" oldosmode)
  (setvar "ORTHOMODE" oldorthomode)
  (setvar "DIMSCALE" olddimscale)
  (setvar "DIMDEC" olddimdec)
  (setvar "CLAYER" oldclayer)
  (setvar "CELTYPE" oldceltype)
  (setvar "CELWEIGHT" oldcelweight)
  (setvar "CECOLOR" oldcecolor)
 
); end defun
;
;(defun *koribali_error* (msg)

  ;(setq *error* nil)
  ;(kb_setting_restore)
  ;(princ "\nKoribali Tools is Cancelled")
  
;)
;(defun C:garis ()

  ;(setq *error* *koribali_error*)
  ;(kb_setting_save)
   
  ;(setvar "OSMODE" 0)
  ;(command "LINE" (getpoint)(getpoint) "")
  ;(kb_setting_restore)
  ;(;setq *error* nil)
  
;)
