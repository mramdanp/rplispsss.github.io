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
(defun kb_scale (x)

  (cond 
    ((<= x 800.0) 5)
    ((and (> x 800.0)(<= x 1000.0)) 6) 
    ((and (> x 1000.0)(<= x 1400.0)) 8) 
    ((and (> x 1400.0)(<= x 1800.0)) 10) 
    ((and (> x 1800.0)(<= x 2850.0)) 15) 
    ((and (> x 2850.0)(<= x 3850.0)) 20) 
    ((and (> x 3850.0)(<= x 4950.0)) 25) 
    ((and (> x 4950.0)(<= x 5950.0)) 30) 
    ((and (> x 5950.0)(<= x 7950.0)) 40) 
    ((and (> x 7950.0)(<= x 10150.0)) 50) 
    ((and (> x 10150.0)(<= x 12150.0)) 60) 
    ((> x 12150.0) 75) 
  )
  
); end defun