

(defun kb_top_screw_cap ()

  ; load functions
  (load "C:\\AutoLISP\\koribali_tools_dev\\kb_function\\kb_function.lsp")
  
  (setq oldosmode (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  
  (kb_tsc_input)
  (kb_tsc_calc)
  (kb_tsc_point)
  (setvar "OSMODE" 0)
  (kb_tsc_output)
  
  (setvar "OSMODE" oldosmode)
  

); end defun



(defun kb_tsc_calc ()
  
  ; diameter of pipe
  (setq scc_dp (rtos (distance sci_stp sci_etp)))

  ; screw cap database
  (setq scc_db
    (cond
      ((eq scc_dp "60.5") (list 76.3	4.2	3.2	50	25	"COM-MPK-059-2"))
      ((eq scc_dp "76.3") (list 89.1	3.2	3.2	50	25	"COM-MPK-134"))
      ((eq scc_dp "83.6") (list 101.6	7	3.2	50	25	"COM-MPK-113"))
      ((eq scc_dp "89.1") (list 101.6	4.2	3.2	50	25	"COM-MPK-145"))
      ((eq scc_dp "90")   (list 101.6	3.2	3.2	50	25	"COM-MPK-098"))
      ((eq scc_dp "75")   (list 89.1	4.2	3.2	40	20	"NB7003"))
      ((eq scc_dp "85")   (list 101.6	4.2	3.2	40	20	"NB7003"))	
      ((eq scc_dp "95")   (list 105.4	3.2	3.2	50	25	"COM-MPK-030"))
      ((eq scc_dp "100")  (list 111.4	3.2	3.2	50	25	"COM-MPK-103"))
      ((eq scc_dp "101.6")(list 114.3	4.5	3.2	50	25	"COM-MPK-112"))
      ((eq scc_dp "120")  (list 131.4	3.2	3.2	50	25	"COM-MPK-102"))
      ((eq scc_dp "110")  (list 121.4	3.2	3.2	50	25	"COM-MPK-124"))
      ((eq scc_dp "114.3")(list 124.4	3.2	3.2	50	25	"COM-MPK-022"))
      ((eq scc_dp "125")  (list 136.4	3.2	3.2	50	25	"COM-MPK-058"))
      ((eq scc_dp "116")  (list 141.4	3.2	3.2	50	25	"COM-MPK-116"))
      ((eq scc_dp "139.8")(list 153.4	3.2	3.2	50	25	"COM-MPK-143"))
      ((eq scc_dp "146")  (list 157.4	3.2	3.2	50	25	"COM-MPK-082"))
      ((eq scc_dp "150")  (list 160.4	3.2	3.2	50	25	"COM-MPK-028"))
      ((eq scc_dp "160")  (list 170.4	3.2	3.2	50	25	"COM-MPK-119"))
      ((eq scc_dp "165.2")(list 176.4	3.2	3.2	50	25	"COM-MPK-047"))
      ((eq scc_dp "170")  (list 180.4	3.2	3.2	50	25	"COM-MPK-020"))
      ((eq scc_dp "172")  (list 182.4	3.2	3.2	50	25	"COM-MPK-033"))
      ((eq scc_dp "190.7")(list 201.4	3.2	3.2	50	25	"COM-MPK-034"))
      ((eq scc_dp "192")  (list 203.4	3.2	3.2	50	25	"COM-MPK-130"))
      ((eq scc_dp "210")  (list 221.4	3.2	3.2	50	25	"COM-MPK-040"))
      ((eq scc_dp "216.3")(list 227.4	3.2	3.2	50	25	"COM-MPK-010"))
      ((eq scc_dp "267.4")(list 278.4	3.2	3.2	50	25	"COM-MPK-018"))
      ((eq scc_dp "318.5")(list 329.9	3.2	3.2	50	25	"COM-MPK-029"))
      ((eq scc_dp "355.6")(list 366.4	3.2	3.2	50	25	"COM-MPK-054"))
      ((eq scc_dp "406.4")(list 417.4	3.2	3.2	50	25	"COM-MPK-061"))
      ((eq scc_dp "457.2")(list 468.4	3.2	3.2	50	25	"COM-MPK-069"))
      ((eq scc_dp "508")  (list 518.4	3.2	3.2	50	25	"COM-MPK-084"))
	  (T (list (+ scc_dp 15.0) 3.2 3.2 50 25 "KB-MPK-XXX"))
    ); end cond
  ); end setq
  
  (setq 
    scc_dc  (nth 0 scc_db); diameter of cap
	scc_tc  (nth 1 scc_db); thickness of cap
	scc_tcp (nth 2 scc_db); thickness of cap (top)
	scc_L   (nth 3 scc_db); length of cap
    scc_pb  (nth 4 scc_db); position of bolt	
    scc_id  (nth 5 scc_db); position of bolt	
  )
); end defun
;

(defun kb_tsc_point ()
  (setq 
    xbp (+ (car sci_stp)(/ (atoi scc_dp) 2.0))
	xL1 (- xbp (- (/ scc_dc 2.0) scc_tc))
	xL2 (- xbp (/ scc_dc 2.0))
	xr1 (+ xbp (- (/ scc_dc 2.0) scc_tc))
	xr2 (+ xbp (/ scc_dc 2.0))

    ybp (cadr sci_stp)
	yu  (+ ybp scc_tcp)
	yL1 (- ybp (- scc_L scc_tcp scc_pb))
	yL2 (- ybp (- scc_L scc_tcp))
  )
  (setq 
    pL1a (list xL1 ybp 0.0)
    pL1b (list xL1 yL2 0.0)
	pL2a (list xL2 yu  0.0)
	pL2b (list xL2 yL1 0.0)
	pL2c (list xL2 yL2 0.0)
	pc   (list xbp yL1 0.0)
	pr1a (list xr1 ybp 0.0)
    pr1b (list xr1 yL2 0.0)
	pr2a (list xr2 yu  0.0)
	pr2b (list xr2 yL1 0.0)
	pr2c (list xr2 yL2 0.0) 
  )
)
(defun kb_tsc_output ()

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
  
)
  ; if Leader
  (setq blockname "C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_screw_cap_leader.dwg")
  (kb_insert_block blockname pL2a sci_sc)
  
  ; if balloon
  (setq blockname "C:\\AutoLISP\\koribali_tools_dev\\kb_block\\kb_top_screw_cap_balloon.dwg")
  (kb_insert_block blockname pL2a sci_sc)




  (setq a (ssget "_A" '((0 . "TEXT"))) i 0)
  
  (repeat (sslength a)
    (setq b (ssname a i))
    (setq c (entget b))
    (setq d (assoc 1 c))
    (setq e (substr (cdr d) 1))
    (if (= e "ï ê}:COM-MPK-XXX")(setq desc b))
	(setq i (1+ i))
  )
  (setq g (cons 1 scc_id))
  (setq h (entget desc))
  (setq j (assoc 1 h))
  (setq m (subst g j h))
  (entmod m)

