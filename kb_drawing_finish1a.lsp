(defun KB_drawing_finish ()

  (if (/= (getvar "TILEMODE") 1) 
    (setvar "TILEMODE" 1))
	
  (if (/= (tblnext "LAYER" "MD") nil)
    (command-s "-layer" "off" "MD" ""))
	
  (command "PURGE" "A" "*" "N")
  
  (command "ZOOM" "E")

  (setvar "TILEMODE" 0)
  (if (/= (tblnext "LAYER" "AM_VIEWS") nil)
    (command "VPLAYER" "F" "AM_VIEWS" "" ""))
	
  (command "ZOOM" "E")
  
  (command "QSAVE")
  
);

; percobaan 1
