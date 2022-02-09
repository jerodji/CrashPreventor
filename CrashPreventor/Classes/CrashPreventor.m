//
//  CrashPreventor.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "CrashPreventor.h"
#import <objc/runtime.h>
#import "NSArray+JJCrashShield.h"
#import "NSMutableArray+JJCrashShield.h"
#import "NSDictionary+JJCrashShield.h"
#import "NSMutableDictionary+JJCrashShield.h"


@implementation CrashPreventor

@synthesize isOpen = _isOpen;
@synthesize debugger = _debugger;


+ (instancetype)shared {
    static CrashPreventor * ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[super allocWithZone:nil] init];
    });
    return ins;
}
+(id)allocWithZone:(NSZone *)zone {
    return [self shared];
}
-(id)copyWithZone:(NSZone *)zone {
    return [[self class] shared];
}
-(id)mutableCopyWithZone:(NSZone *)zone {
    return [[self class] shared];
}



- (void)openPreventor {
    _isOpen = YES;
    if (_isOpen) {
        [NSArray openCrashPreventor];
        [NSMutableArray openCrashPreventor];
        [NSDictionary openCrashPreventor];
        [NSMutableDictionary openCrashPreventor];
    }
}

- (void)openDebuggerAssert:(BOOL)debugger {
#ifdef DEBUG
    _debugger = debugger;
#else
    _debugger = NO;
#endif
}

@end






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
