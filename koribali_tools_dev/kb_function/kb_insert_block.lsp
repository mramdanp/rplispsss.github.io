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
(defun kb_insert_block (a b c)

  ;a = block name
  ;b = block basepoint
  ;c =scale
  (command "INSERT" a b "" "" "")
  (command "SCALE" (entlast) "" b c)
  (command "EXPLODE" (entlast))
  
); end defun