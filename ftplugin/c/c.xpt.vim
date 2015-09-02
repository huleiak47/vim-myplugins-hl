XPTemplate priority=personal

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
int `name^`$SPfun^(`$SParg`param?`$SParg^)`$BRfun^{
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
