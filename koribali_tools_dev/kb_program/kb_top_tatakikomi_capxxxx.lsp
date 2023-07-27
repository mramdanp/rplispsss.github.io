;------------------------------------------------------------------------------
;  Copyright (c) 2023 - M. Ramdan Purnama									   
;  Program Information 												           
;   File Name     : kb_top_screwcap.lsp		
;   Author        : M. Ramdan purnama
;   Email         : m.ramdan.p@gmail.com
;   Website       : -
;   Date Created  : 2023/07/25, 16:38 Haurjaya, Bogor 
;   Description   : 
;------------------------------------------------------------------------------ 
; PROGRAM MANAGEMENT ----------------------------------------------------------
(defun kb_top_screw_cap 
  (/
    ; local variables
	sci_etp sci_stp sci_desc sci_getsc sci_sc
    scc_dp scc_db scc_dc scc_tc scc_tcp scc_L scc_pb scc_id
    xbp xL1 xL1 xr1 xr2 ybp yu yL1 yL2
    pL1a pL1b pL2a pL2b pL2c pc pr1a pr1b pr2a pr2b pr2c
    blockname
    a b c d e f g h i j k l m
  )
  ; load function
  (load "C:\\AutoLISP\\koribali_tools_dev\\kb_function\\kb_function.lsp")
  
  ; settings 
  (setq *error* *koribali_error*)
  (kb_setting_save); from kb_function.lsp
    
	; input 
	(kb_tsc_input)
	
	; calc 
	(kb_tsc_calc)
	
	; point
	(kb_tsc_point)
	
	; output 
	(kb_tsc_output)
	
  ; ressetings
  (kb_setting_restore); from kb_function.lsp
  (setq *error* nil)
  
); end defun
;























; INPUT -----------------------------------------------------------------------
(defun kb_ttc_input ()

  ; settings
  (setvar "OSMODE" 1)
  
  ; start point and end point
  (setq sci_etp (getpoint "\nEnter End Point :"
    (setq sci_stp (getpoint "\nEnter Start Point :"))
    )
  )
  
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
  
  ; diameter pole 
  (setq scc_dp (distance sci_stp sci_etp))
  
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
; CALC ------------------------------------------------------------------------
(defun kb_ttc_calc ()
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
	 (kb_tsc_point)
	 (kb_tsc_output)
    )
	(t (alert "\nDiameter pipe is not Standard!"))
  ); end cond

); end defun
;
; POINT -----------------------------------------------------------------------
(defun kb_tsc_point ()

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
  
)
; OUTPUT ----------------------------------------------------------------------
(defun kb_tsc_output ()
  (setvar "OSMODE" 0)
  
  (if (= (TBLSEARCH "LAYER" "AM_0"))
    (setvar "CLAYER" "AM_0")
    (command "_.Layer" "_M" "AM_0" "_C" "Bylayer" "" "_L" "Bylayer" "" "")
  )
  (command "PLINE" pL2a pL2c pr2c pr2a "C")
  
  (if (= (TBLSEARCH "LAYER" "AM_3"))
    (setvar "CLAYER" "AM_3")
    (command "_.Layer" "_M" "AM_3" "_C" "Bylayer" "" "_L" "ACJISTGL" "" "")
  )
  
  (command "PLINE" pL1b pL1a pr1a pr1b "")

  (setq blockname "C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_screw_cap_m8_FS.dwg")
  (kb_insert_block blockname pc 1)
  
  (setq blockname "C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_screw_cap_m8_LS.dwg")
  (kb_insert_block blockname pL2b 1)
  
  (setq blockname "C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_screw_cap_m8_RS.dwg")
  (kb_insert_block blockname pr2b 1)
  
  ; if Leader
  (setq blockname
    (cond
      ((eq sci_desc "1")"C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_screw_cap_leader.dwg")
      ((eq sci_desc "2")"C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_screw_cap_balloon.dwg")
	); end cond
  ); end setq 
  
  (kb_insert_block blockname pL2a sci_sc)
  
  (if (= sci_desc "2")
    (progn
      (setq a (ssget "_A" '((0 . "TEXT"))) i 0)
      (repeat (sslength a)
        (setq b (ssname a i))
        (setq c (entget b))
        (setq d (assoc 1 c))
        (setq e (substr (cdr d) 1))
        (if (= e "•Ê}:COM-MPK-XXX")(setq desc b))
	    (setq i (1+ i))
      ); end repeat
      (setq g (cons 1 scc_id))
      (setq h (entget desc))
      (setq j (assoc 1 h))
      (setq m (subst g j h))
      (entmod m)
	); end progn
  ); end if

)
; ERROR HANDLING --------------------------------------------------------------
(defun *koribali_error* (msg)

  (setq *error* nil)
  (kb_setting_restore)
  (princ "\n*** Koribali Tools, Screw cap is Cancelled ***")

)