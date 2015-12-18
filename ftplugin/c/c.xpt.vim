XPTemplate priority=personal

let s:f = g:XPTfuncs()

fun! s:f.myHeaderSymbol(...) "{{{
  let h = expand('%:t')
  let h = substitute(h, '\.', '_', 'g') " replace . with _
  let h = substitute(h, '.', '\U\0', 'g') " make all characters upper case
  let t = strftime("%Y%m%d%H%M%S")

  return '__'.h.'_'.t.'__'
endfunction "}}}


XPTvar $CDL     /**
XPTvar $CDM     *
XPTvar $CDR     */
XPTvar $CL      //

XPT main hint=main\ (argc,\ argv)
int main`$SPfun^(`$SParg^int argc,`$SPop^char** argv`$SParg^)`$BRfun^{
    `cursor^
    return 0;
}

XPT fun wrap=curosr	hint=func..\ (\ ..\ )\ {...
`int` `name^`$SPfun^(`$SParg`param?`$SParg^)`$BRfun^{
    `cursor^
}

XPT ifcpp
#ifdef __cplusplus
extern "C" {
#endif

`cursor^

#ifdef __cplusplus
}
#endif

XPT once wrap	" #ifndef .. #define ..
XSET symbol=myHeaderSymbol()
#ifndef `symbol^
#define `symbol^

`cursor^

#endif `$CL^ `symbol^

