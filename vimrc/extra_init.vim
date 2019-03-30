" this file defines something that must done after .vimrc loaded and before plugins load

let s:plugin_path = expand('<sfile>:p:h')

python3 << PYTHON_EOF
exec(open(vim.eval("s:plugin_path") + "/extra_init.py", "r", encoding="utf-8").read(), globals())
PYTHON_EOF

