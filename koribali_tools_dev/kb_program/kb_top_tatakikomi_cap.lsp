;------------------------------------------------------------------------------
;  Copyright (c) 2023 - M. Ramdan Purnama									   
;  Program Information 												           
;   File Name     : kb_top_tatakikomi_cap.lsp		
;   Author        : M. Ramdan purnama
;   Email         : m.ramdan.p@gmail.com
;   Website       : -
;   Date Created  : 2023/07/27 Haurjaya, Bogor 
;   Description   : 
;------------------------------------------------------------------------------ 
; PROGRAM MANAGEMENT ----------------------------------------------------------
(defun kb_top_tatakikomi_cap
  (/
    ; local variables
	  ;sci_stp sci_etp scc_dp sci_bp sci_desc sci_getsc sci_sc
	  ;scc_temp 
	  ;xc xleader xmlist xL1 xL2 xL3 xr1 xr2 xr3 yc yu yL1 yL2
      ;pL1a pL1b135 pL2a pL2b pL3a pL3b pr1a pr1b pr1b45 pr2a pr2b pr3a pr3b
	  ;pleader pMaterial
  )
  
  ; load function
  (load "C:\\AutoLISP\\koribali_tools_dev\\kb_function\\kb_function.lsp")
  
  ; setting 
  (setq *error* *koribali_error*)
  (kb_setting_save); from kb_function\\kb_settings.lsp
  
    ; call input1 function
	(kb_ttp_input1)

	(setq scc_temp (rtos scc_dp))
	(cond 
      ((or 
	    (eq scc_temp "76.3")
	    (eq scc_temp "89.1")
	    (eq scc_temp "101.6")
	    (eq scc_temp "114.3")
	    (eq scc_temp "139.8")
	    (eq scc_temp "165.2")
	    (eq scc_temp "190.7")
	    (eq scc_temp "216.3")
	   )
	   
	    ; call input2 function
	    (kb_ttp_input2)
		
        ; call point function
        (kb_ttp_point)
	
        ; call output function
        (kb_ttp_output)
		
      );
      (t (alert "\nDiameter pipe is not Standard!"))
    ); end cond

  ; setting
  (kb_setting_restore); from kb_function.lsp
  (setq *error* nil)
  
); end defun
;  
; ERROR HANDLING --------------------------------------------------------------
(defun *koribali_error* (msg)

  (setq *error* nil)
  (kb_setting_restore); from kb_function\\kb_settings.lsp
  (princ "\n*** Koribali Tools, Steel Cap (Tatakikomi) is Cancelled ***")

); end defun
;
; INPUT 1 ---------------------------------------------------------------------
(defun kb_ttp_input1 ()

  ; settings
  (setvar "OSMODE" 1)
  
  ; start point and end point
  (setq sci_etp (getpoint "\nEnter End Point :"
    (setq sci_stp (getpoint "\nEnter Start Point :"))
    )
  )
  
  ; diameter pole 
  (setq scc_dp (distance sci_stp sci_etp))
  
  ; condition
  (if (< (car sci_stp)(car sci_etp)) 
    ; then
	(progn
	  (setq sci_stp sci_stp)
	  (setq sci_etp sci_etp)
	); end progn
    ; else
	(progn
	  (setq sci_stp sci_etp)
	  (setq sci_etp sci_stp)
	); end progn
  ); end if
  
); end defun
;
(defun kb_ttp_input2 ()

  ; basepoint 
  (setq sci_bp (polar sci_stp (* pi 0) (/ scc_dp 2.0)))
  
  ; description
  (initget 1 "1 2")
  (princ "\nEnter Description type [1 : Leader/2 : Balloon]")
  (setq sci_desc (getkword))
	  
  ; dimension scale 
  ; drawing scale
  (initget 1 "1 2")
  (princ "\nEnter Scale [1 : Select Dimension/2 : Input value]")
  (setq sci_getsc (getkword))
  
  ; dimension scale value
  (setq sci_sc 
    (if (eq  sci_getsc "1")
	  ; then
	  (get_dimscale)
	  ; else
	  (getreal "\nEnter Scale of Leader :")
	); end if
  );setq

); end defun 
;
; POINT -----------------------------------------------------------------------
(defun kb_ttp_point()

  ; coordinates
  ; x coordinates
  (setq 
    xc (car sci_bp)
	xleader (- xc (/ scc_dp 4.0))
	xmlist (+ xc (+ (/ scc_dp 2.0) (* sci_sc 5.0)))
	xL1 (- xc (- (/ scc_dp 2.0) 0.4))
    xL2 (- xc (/ scc_dp 2.0))
    xL3 (- xc (+ (/ scc_dp 2.0) 2.6))	
	xr1 (+ xc (- (/ scc_dp 2.0) 0.4))
    xr2 (+ xc (/ scc_dp 2.0))
    xr3 (+ xc (+ (/ scc_dp 2.0) 2.6))
  )
  
  ; y coordinates
  (setq 
    yc (cadr sci_bp)
	yu (+ yc 1.0)
	yL1 (- yc 2.0)
	yL2 (- yc 35.0)
  )
  
  ; points 
  (setq
    pL1a (list xL1 yu 0.0)
    pL1b (list xL1 yL1 0.0)
	pL1b135 (polar pL1b (* pi 0.75) 3.0)
	pL2a (list xL2 yc 0.0)
	pL2b (list xL2 yL2 0.0)
	pL3a (list xL3 yL1 0.0)
	pL3b (list xL3 yL2 0.0)
	
	pr1a (list xr1 yu 0.0)
    pr1b (list xr1 yL1 0.0)
	pr1b45 (polar pr1b (* pi 0.25) 3.0)
	pr2a (list xr2 yc 0.0)
	pr2b (list xr2 yL2 0.0)
	pr3a (list xr3 yL1 0.0)
	pr3b (list xr3 yL2 0.0)
	
	pleader (list xleader yu 0.0)
	pMaterial (list xmlist yL2 0.0)
  )

); end defun 
;
; OUTPUT ----------------------------------------------------------------------
(defun kb_ttp_output ()

  (setvar "OSMODE" 0)
  
  (kb_layer "AM_0"); from kb_function\\kb_layer.lsp
  (command "pline" pL1a pr1a "A" "S" pr1a pr1b45 pr3a "L" pr3a pr3b pL3b pL3a "A" "S" pL3a pL1b135 pL1a "")
  
  (kb_layer "AM_3"); from kb_function\\kb_layer.lsp
  (command "pline" pL2b pL2a pr2a pr2b "")
  
  ; if Leader
  (setq blockname
    (cond
      ((eq sci_desc "1")"C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_tatakikomi_cap_leader.dwg")
      ((eq sci_desc "2")"C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_tatakikomi_cap_balloon.dwg")
	); end cond
  ); end setq 
  
  (insert_block blockname pleader sci_sc)
  
); end defun 