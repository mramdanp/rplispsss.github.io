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
(defun kb_layer (a)

  (if (= (TBLSEARCH "LAYER" a))
    (setvar "CLAYER" a)
    (command "_.Layer" "_M" a "_C" "Bylayer" "" "_L" "Bylayer" "" "")
  )
  
)