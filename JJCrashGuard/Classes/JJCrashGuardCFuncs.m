//
//  JJCrashGuardCFuncs.m
//  JJCrashGuard
//
//  Created by CN210208396 on 2022/2/10.
//

#import "JJCrashGuardCFuncs.h"
#import <objc/runtime.h>


@implementation JJCrashGuardCFuncs

@end



//void CPAssert(BOOL condition, NSString* desc, ...)
//{
//    
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

