"������ĸ��д�ķ�����Ϊ��
syn match cMacro display "\<\(wx\)\?[A-Z_][A-Z0-9_]*\>"
hi def link cMacro Macro

"highlight functions
syn match cFunction display "\(#\s*define\s\+\)\@<!\(#\s*pragma\s\+\)\@<!\(\<defined\>\)\@!\<[a-zA-Z_]\w*\>\s*\(\n\s*\)*("ms=s,me=e-1
hi def link cFunction Function

"������_t��β�ķ�����Ϊ����
syn match cMoreTypes display "\<\w*_t\>"
hi def link cMoreTypes Type

so <sfile>:p:h/operators_hi.vim
