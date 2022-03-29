//
//  JJShieldCFuncs.m
//  JJCrashGuard
//
//  Created by Jerod on 2022/2/10.
//

#import "JJShieldCFuncs.h"
#import <objc/runtime.h>
#import "JJCrashGuard+handleError.h"


void CPLog(NSString *format, ...) {
    if ([JJCrashGuard shared].logLevel >= JShieldLogLevelInfo) {
        NSString *cpFormat = [@"[CrashGuard][info] " stringByAppendingString:format];
        va_list args;
        va_start(args, format);
        NSString *log = [[NSString alloc] initWithFormat:cpFormat arguments:args];
        va_end(args);
        [[JJCrashGuard shared] handleInfoMsg:log];
    }
}

void CPWarning(NSString *format, ...) {
    if ([JJCrashGuard shared].logLevel >= JShieldLogLevelWarning) {
        NSString *cpFormat = [@"[CrashGuard][warning] " stringByAppendingString:format];
        va_list args;
        va_start(args, format);
        NSString *log = [[NSString alloc] initWithFormat:cpFormat arguments:args];
        va_end(args);
        [[JJCrashGuard shared] handleWarningMsg:log];
    }
}

void CPError(NSString *format, ...) {
    if ([JJCrashGuard shared].logLevel >= JShieldLogLevelError) {
        NSString *cpFormat = [@"[CrashGuard][error] " stringByAppendingString:format];
        va_list args;
        va_start(args, format);
        NSString *log = [[NSString alloc] initWithFormat:cpFormat arguments:args];
        va_end(args);
        [[JJCrashGuard shared] handleErrorMsg:log];
    }
}


//void CPAssert(BOOL condition, NSString* format, ...)
//{
//    va_list argsPtr;
//    va_start(argsPtr, format);
//    NSString *log = [[NSString alloc] initWithFormat:format arguments:argsPtr];
//    va_end(argsPtr);
//    [[JJCrashGuard shared] handleInfoWith:condition log:log];
//}



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

