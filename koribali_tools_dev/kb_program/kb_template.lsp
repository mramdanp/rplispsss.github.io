;------------------------------------------------------------------------------
;  Copyright (c) 2023 - M. Ramdan Purnama									   
;  Program Information 												           
;   File Name     : XXXX.lsp		
;   Author        : M. Ramdan purnama
;   Email         : m.ramdan.p@gmail.com
;   Website       : -
;   Date Created  : 2023/XX/XX Haurjaya, Bogor 
;   Description   : 
;------------------------------------------------------------------------------ 
; PROGRAM MANAGEMENT ----------------------------------------------------------
(defun nama_program
  (/
    ; local variables
	---
	---
	---
	---
  )
  
  ; load function
  (load "C:\\AutoLISP\\koribali_tools_dev\\kb_function\\kb_function.lsp")
  
  ; setting 
  (setq *error* *koribali_error*)
  (kb_setting_save); from kb_function\\kb_settings.lsp
  
    ; call input function
	()
	
	; call calc function
	()
	
	; call point function
	()
	
	; call output function
	()
  
  ; setting
  (kb_setting_restore); from kb_function.lsp
  (setq *error* nil)
  (princ "\n*** Koribali Tools, XXXX is Successful ***")
  
); end defun
;  
; ERROR HANDLING --------------------------------------------------------------
(defun *koribali_error* (msg)

  (setq *error* nil)
  (kb_setting_restore); from kb_function\\kb_settings.lsp
  (princ "\n*** Koribali Tools, XXXX is Cancelled ***")

); end defun
; INPUT -----------------------------------------------------------------------
(defun ()

  ;

); end defun 
;
; CALC ------------------------------------------------------------------------
(defun ()

  ;

); end defun 
;
; POINT -----------------------------------------------------------------------
(defun ()

  ;

); end defun 
;
; OUTPUT ----------------------------------------------------------------------
(defun ()

  ;

); end defun 