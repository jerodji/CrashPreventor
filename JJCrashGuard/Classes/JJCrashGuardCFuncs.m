//
//  JJCrashGuardCFuncs.m
//  JJCrashGuard
//
//  Created by CN210208396 on 2022/2/10.
//

#import "JJCrashGuardCFuncs.h"
#import <objc/runtime.h>


void CPAssert(BOOL condition, NSString* desc, ...)
{
    va_list argptr;
    va_start(argptr, desc);
    int idx = 0;
    int params[16] = {0};
    
    while (1) {
        int tmp = va_arg(argptr, int);
        if (tmp == 0 || tmp == -2041954144 || tmp == INT_MAX || tmp == INT_MIN) {
            break;
        }
        params[idx] = (int)tmp;
        idx++;
    }
    
//void *a0, *a1, *a2, *a3, *a4, *a5, *a6, *a7, *a8, *a9, *a10, *a11, *a12, *a13, *a14, *a15 = nil;
    int a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15 = 0;
    a0 = params[0];
    a1 = params[1];
    a2 = params[2];
    a3 = params[3];
    a4 = params[4];
    a5 = params[5];
    a6 = params[6];
    a7 = params[7];
    a8 = params[8];
    a9 = params[9];
    a10 = params[10];
    a11 = params[11];
    a12 = params[12];
    a13 = params[13];
    a14 = params[14];
    a15 = params[15];
    
    NSString * info = [NSString stringWithFormat:desc, a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15];

    if([JJCrashGuard shared].debugger){
        //NSAssert(condition, [@"[JJCrashGuard] error : " stringByAppendingString:desc], ##__VA_ARGS__);
//        NSAssert(condition, info);
//        assert(<#e#>)
        
    } else {
        NSLog(@"[JJCrashGuard] error : %@", info);
    }
    
    [[JJCrashGuard shared] report:info];
    
}



/**
 exchange instance method
 */
void swizzling_instance_method(Class cls, SEL originSEL, SEL swizzleSEL)
{
    if (!cls) return;

    Method originMethod = class_getInstanceMethod(cls, originSEL);
    Method swizzleMethod = class_getInstanceMethod(cls, swizzleSEL);

    if (!originMethod || !swizzleMethod) return;
    
    BOOL didAddMethod = class_addMethod(cls, originSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzleSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

/**
 exchange class method
 */
void swizzling_class_method(Class cls, SEL originSEL, SEL swizzleSEL)
{
    if (!cls) return;
    
    Method originMethod = class_getClassMethod(cls, originSEL);
    Method swizzleMethod = class_getClassMethod(cls, swizzleSEL);
    
    if (!originMethod || !swizzleMethod) return;
    
    const char * metaName = NSStringFromClass(cls).UTF8String;
    Class metaClass = objc_getMetaClass(metaName);
    
    BOOL didAddMethod = class_addMethod(metaClass, originSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(metaClass, swizzleSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

