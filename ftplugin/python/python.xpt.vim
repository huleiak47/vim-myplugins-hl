XPTemplate priority=personal

XPT docf    hint=docuemnt\ file
XSET author=$author
XSET date=date()
#!/usr/bin/env python
# -*- coding:`Echo(&fenc)^ -*-
ur'''
`^
@file `file()^
@author `author^
@version 1.0
@date `date^
@copyright (C) `strftime("%Y")^ `Feitian Technologies Co., Ltd^. All rights reserved.
'''

..XPT

XPT ""
"""
`cursor^
"""

XPT ''
'''
`cursor^
'''


XPT #!
#!/usr/bin/env python
# -*- coding:`Echo(&fenc)^ -*-

`cursor^

XPT funicode
from __future__ import unicode_literals
`cursor^

XPT try
try:
    `job^
except `Exception^ as `e^:
    `pass^

XPT open
open(`filename^, "`r^")

XPT withopen
with open(`filename^, "`r^") as `f^:
    `pass^

XPT forxrange
for `i^ in xrange(`0^, `end^):
    `pass^
