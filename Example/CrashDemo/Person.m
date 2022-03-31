//
//  Person.m
//  CrashDemo
//
//  Created by CN210208396 on 2022/3/30.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Dong : NSObject
@end
@implementation Dong
- (void)noExistInstanceMethod:(NSString*)str {
    NSLog(@"%s, %@", __func__, str);
}
@end


@implementation Person

//- (void)setNilValueForKey:(NSString *)key {
//    NSLog(@"111");
//}

+ (void)existClassMethod:(NSString *)str {
    NSLog(@"%s, %@", __func__, str);
}

- (void)existInstanceMethod:(NSString *)str {
    NSLog(@"%s, %@", __func__, str);
}


// MARK: 三步转发流程, 如果这里写了, 用这里的实现, 那么防护框架的拦截代码就不执行.
//id _tmpImpl(id self, SEL _cmd) {
//    NSLog(@"%s, %@, %@", __func__, self, NSStringFromSelector(_cmd));
//    return [NSNull null];
//}
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    class_addMethod([self class], sel, (IMP)_tmpImpl, "@@:");
//    return YES;
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [Dong new];
//}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//}
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    NSLog(@"-- %@", anInvocation.target);
//    NSLog(@"-- %@", NSStringFromSelector(anInvocation.selector));
//    NSLog(@"-- end");
//}

@end
