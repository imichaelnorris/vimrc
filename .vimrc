set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
"set number
set nofoldenable

python << EOL
import vim

def EvaluateCurrentLine(*args):
    cur_str = vim.current.line
    action, symb = None, None
    for i in args:
        if i in ["r", "p", "x"]: action = i
        else: symb = i
    try:
        start = cur_str.rindex(symb)+len(symb)
    except:
        start = 0
    
    if action == "x":
        exec cur_str
    else:
        result = eval(cur_str[start:], globals())
        if action == "r":
            vim.current.line = cur_str[:start]+str(result)
        else:
            print(result)
    
    for i in locals():
        globals()[i] = locals()[i]

EOL
command -narg=* PyEv python EvaluateCurrentLine(<f-args>)

:map pr :PyEv r<CR>
:map pe :PyEv p<CR>
:map px :PyEv x<CR>
:map == :set number<CR>
:map -- :set nonumber<CR>
