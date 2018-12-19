XPTemplate priority=personal

XPT docf    hint=docuemnt\ file
XSET author=$author
XSET date=date()
#!/usr/bin/env python
# -*- coding:`Echo(&fenc)^ -*-
ur'''
@brief `^
@file `file()^
@copyright (c) `strftime("%Y")^, `Nations Technologies Inc^. All rights reserved.
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

XPT fprint
from __future__ import print_function
`cursor^

XPT fdivision
from __future__ import division
`cursor^

XPT future
from __future__ import unicode_literals
from __future__ import print_function
from __future__ import division
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
