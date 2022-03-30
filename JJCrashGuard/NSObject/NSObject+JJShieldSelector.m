//
//  NSObject+JJShieldSelector.m
//  JJCrashGuard
//
//  Created by Jerod on 2022/3/29.
//

#import "NSObject+JJShieldSelector.h"
#import <objc/runtime.h>
#import "JJCrashGuard.h"
#import "JJShieldCFuncs.h"

@interface _JJSelctorPreventor : NSObject {
//    @public
//    IMP classDogIMP;
//    IMP instanceDogIMP;
//    id  errorTarget;
//    SEL errorSelector;
}
@end
@implementation _JJSelctorPreventor
//+ (instancetype)shared {
//    static _JJSelctorPreventor * ins = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        ins = [[_JJSelctorPreventor alloc] init];
//    });
//    return ins;
//}
//+ (void)initialize {
//    if (self == [_JJSelctorPreventor class]) {
//        [_JJSelctorPreventor shared]->classDogIMP = class_getMethodImplementation([_JJSelctorPreventor class], @selector(_class_method_dog));
//        //[_JJSelctorPreventor shared]->instanceDogIMP = class_getMethodImplementation([_JJSelctorPreventor class], @selector(_instance_method_dog));
//    }
//}
// v@:
//- (void)_class_method_dog {
//    CPError(@"+[%@ %@]: unrecognized selector sent to class %p", self->errorTarget, NSStringFromSelector(_cmd), self->errorTarget);
//    self->errorTarget = nil;
//    self->errorSelector = nil;
//}
//- (void)_instance_method_dog {
//    CPError(@"-[%@ %@]: unrecognized selector sent to instance %p", self->errorTarget, NSStringFromSelector(_cmd), self->errorTarget);
//    self->errorTarget = nil;
//    self->errorSelector = nil;
//}
+ (void)_guardInstanceMethodForTarget:(id)target selector:(SEL)aSelector {
    if (!target) {
        CPWarning(@"target is nil.");
        return;
    }
    if (!aSelector) {
        CPWarning(@"selector is nil.");
        return;
    }
    CPError(@"-[%@ %@]: unrecognized selector sent to instance %p", target, NSStringFromSelector(aSelector), target);
}
+ (void)_guardClassMethodForTarget:(id)target selector:(SEL)aSelector {
    if (!target) {
        CPWarning(@"target is nil.");
        return;
    }
    if (!aSelector) {
        CPWarning(@"selector is nil.");
        return;
    }
    CPError(@"+[%@ %@]: unrecognized selector sent to class %p", target, NSStringFromSelector(aSelector), target);
}
@end



@implementation NSObject (JJShieldSelector)
+ (void)openShieldSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        swizzling_class_method([NSObject class], @selector(forwardingTargetForSelector:), @selector(_cp_class_forwardingTargetForSelector:));
//        swizzling_instance_method([NSObject class], @selector(forwardingTargetForSelector:), @selector(_cp_instance_forwardingTargetForSelector:));
        
        swizzling_instance_method([NSObject class], @selector(methodSignatureForSelector:), @selector(_cp_instance_methodSignatureForSelector:));
        swizzling_instance_method([NSObject class], @selector(forwardInvocation:), @selector(_cp_instance_forwardInvocation:));
        swizzling_class_method([NSObject class], @selector(methodSignatureForSelector:), @selector(_cp_class_methodSignatureForSelector:));
        swizzling_class_method([NSObject class], @selector(forwardInvocation:), @selector(_cp_class_forwardInvocation:));
    });
}

// MARK: 慢速转发
//Type Encodings
//https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100

- (NSMethodSignature *)_cp_instance_methodSignatureForSelector:(SEL)aSelector {
    SEL selctor = @selector(methodSignatureForSelector:);
    Method oriMethod = class_getInstanceMethod([NSObject class], selctor);
    IMP oriIMP = method_getImplementation(oriMethod);
    Method curMethod = class_getInstanceMethod([self class], selctor);
    IMP curIMP = method_getImplementation(curMethod);
    BOOL overrided = oriIMP != curIMP;
    if (overrided) {
        return [self _cp_instance_methodSignatureForSelector:aSelector];
    } else {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@:"];;
    }
}
- (void)_cp_instance_forwardInvocation:(NSInvocation *)anInvocation {
    SEL selctor = @selector(forwardInvocation:);
    Method oriMethod = class_getInstanceMethod([NSObject class], selctor);
    IMP oriIMP = method_getImplementation(oriMethod);
    Method curMethod = class_getInstanceMethod([self class], selctor);
    IMP curIMP = method_getImplementation(curMethod);
    BOOL overrided = oriIMP != curIMP;
    if (overrided) {
        [self _cp_instance_forwardInvocation:anInvocation];
    } else {
        [_JJSelctorPreventor _guardInstanceMethodForTarget:anInvocation.target selector:anInvocation.selector];
    }
}


+ (NSMethodSignature *)_cp_class_methodSignatureForSelector:(SEL)aSelector {
    SEL selctor = @selector(methodSignatureForSelector:);
    Method oriMethod = class_getClassMethod([NSObject class], selctor);
    IMP oriIMP = method_getImplementation(oriMethod);
    Method curMethod = class_getClassMethod([self class], selctor);
    IMP curIMP = method_getImplementation(curMethod);
    BOOL overrided = oriIMP != curIMP;
    if (overrided) {
        return [self _cp_class_methodSignatureForSelector:aSelector];
    } else {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@:"];;
    }
}
+ (void)_cp_class_forwardInvocation:(NSInvocation *)anInvocation {
    SEL selctor = @selector(forwardInvocation:);
    Method oriMethod = class_getClassMethod([NSObject class], selctor);
    IMP oriIMP = method_getImplementation(oriMethod);
    Method curMethod = class_getClassMethod([self class], selctor);
    IMP curIMP = method_getImplementation(curMethod);
    BOOL overrided = oriIMP != curIMP;
    if (overrided) {
        [self _cp_class_forwardInvocation:anInvocation];
    } else {
        [_JJSelctorPreventor _guardClassMethodForTarget:anInvocation.target selector:anInvocation.selector];
    }
}


/*
// MARK: 快速转发
+ (id)_cp_class_forwardingTargetForSelector:(SEL)aSelector {
    SEL sel2 = @selector(forwardingTargetForSelector:);
    // 获取 NSObject 的消息转发方法
    Method rootMethod2 = class_getClassMethod([NSObject class], sel2);
    // 获取 当前类 的消息转发方法
    Method currentMethod2 = class_getClassMethod([self class], sel2);

    // 判断当前类本身是否实现第二步:消息接受者重定向
    BOOL noOverrided2 = method_getImplementation(currentMethod2) == method_getImplementation(rootMethod2);
    if (noOverrided2) {
        // 判断有没有自定义第三步:消息重定向
        SEL sel3 = @selector(methodSignatureForSelector:);
        Method rootMethod3 = class_getClassMethod([NSObject class], sel3);
        Method curMethod3 = class_getClassMethod([self class], sel3);
        BOOL noOverrided3 = method_getImplementation(rootMethod3) == method_getImplementation(curMethod3);
        
        if (noOverrided3) {
            [_JJSelctorPreventor shared]->errorTarget = self;
            [_JJSelctorPreventor shared]->errorSelector = aSelector;
            Class cls = [_JJSelctorPreventor class];
            IMP dogIMP = [_JJSelctorPreventor shared]->classDogIMP;
            BOOL succ = class_addMethod(cls, aSelector, dogIMP, "v@:");//???: 参数们需要保存抓取吗?
            if (!succ) {
                //Method m = class_getInstanceMethod([_JJSelctorPreventor class], aSelector);
                //method_setImplementation(m, [_JJSelctorPreventor shared]->classDogIMP);
            }
            return [_JJSelctorPreventor shared];
        }
    }
    
    return [self _cp_class_forwardingTargetForSelector:aSelector];
}

- (id)_cp_instance_forwardingTargetForSelector:(SEL)aSelector {
    SEL forwardingSel = @selector(forwardingTargetForSelector:);
    Method rootForwardingMethod = class_getInstanceMethod([NSObject class], forwardingSel);
    Method currentForwardingMethod = class_getInstanceMethod([self class], forwardingSel);
    BOOL norealize = method_getImplementation(rootForwardingMethod) == method_getImplementation(currentForwardingMethod);
    if (norealize) {
        SEL sel3 = @selector(methodSignatureForSelector:);
        Method rootMethod3 = class_getInstanceMethod([NSObject class], sel3);
        Method curMethod3 = class_getInstanceMethod([self class], sel3);
        BOOL noOverrided3 = method_getImplementation(rootMethod3) == method_getImplementation(curMethod3);
        if (noOverrided3) {
            [_JJSelctorPreventor shared]->errorTarget = self;
            [_JJSelctorPreventor shared]->errorSelector = aSelector;
            Class cls = [_JJSelctorPreventor class];
            IMP dogIMP = [_JJSelctorPreventor shared]->instanceDogIMP;
            class_addMethod(cls, aSelector, dogIMP, "v@:");
            return [_JJSelctorPreventor shared];
        }
    }

    return [self _cp_instance_forwardingTargetForSelector:aSelector];
}
*/


// MARK: 动态决议
// @@:
//id _CrashPreventorSelector(id self, SEL _cmd) {
//    CPError(@"%@ not exist.", NSStringFromSelector(_cmd));
//    return [NSNull null];
//}
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    class_addMethod([self class], sel, (IMP)_CrashPreventorSelector, "@@:");
//    return YES;
//}


@end
