//
//  JJShieldCFuncs.m
//  JJCrashGuard
//
//  Created by Jerod on 2022/2/10.
//

#import "JJShieldCFuncs.h"
#import <objc/runtime.h>
#import "JJCrashGuard.h"


@interface JJCrashGuard (handleError)
- (void)handleInfoWith:(BOOL)condition log:(NSString*)log;
@end

@implementation JJCrashGuard (handleError)

//- (void)assert:(BOOL)condition format:(NSString*)format, ... NS_REQUIRES_NIL_TERMINATION {
//    [self assert:condition format:format, 1, 2, 3];
//}

//- (void)report:(id)firstArg, ... NS_REQUIRES_NIL_TERMINATION {
//    NSLog(@"firstArg : %@", firstArg);
//
//    va_list args; // 定义一个指向个数可变的参数列表指针；
//    va_start(args, firstArg);
//
//
//    while (1) {
//        void* arg = va_arg(args, void*);
//        if (arg == nil) break;
//        NSLog(@"arg : %d", arg);
//    }
//
//    va_end(args);
//}

- (void)handleInfoWith:(BOOL)condition log:(NSString*)log {
    NSString * rl = [@"[JJCrashGuard] error : " stringByAppendingString:log];
    NSLog(@"%@", rl);
    if([JJCrashGuard shared].debugger) {
        NSAssert(condition, @"[JJCrashGuard] error : %@", log);
    }
    [[JJCrashGuard shared] reportLog:rl stackInfo:nil];
}

@end



#pragma mark - C Functions


void CPLog(NSString *format, ...) {
    NSString *cpFormat = [@"[CrashGuard] " stringByAppendingString:format];
    va_list args;
    va_start(args, format);
    NSString *log = [[NSString alloc] initWithFormat:cpFormat arguments:args];
    va_end(args);
    NSLog(@"%@", log);
}


void CPAssert(BOOL condition, NSString* format, ...)
{
    va_list argsPtr;
    va_start(argsPtr, format);
    NSString *log = [[NSString alloc] initWithFormat:format arguments:argsPtr];
    va_end(argsPtr);
    [[JJCrashGuard shared] handleInfoWith:condition log:log];
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

