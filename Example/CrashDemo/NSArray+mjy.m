////
////  NSArray+mjy.m
////  CrashDemo
////
////  Created by CN210208396 on 2022/2/11.
////
//
//#import "NSArray+mjy.h"
//#import <objc/runtime.h>
//
//@implementation NSArray (mjy)
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originalMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
//        Method newMethod = class_getInstanceMethod(self, @selector(mjy_objectAtIndexedSubscript:));
//        
//        BOOL didAddMethod = class_addMethod(self, @selector(objectAtIndexedSubscript:), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
//        if (didAddMethod) {
//            class_replaceMethod(self, @selector(mjy_objectAtIndexedSubscript:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, newMethod);
//        }
//    });
//}
//
//
//- (id)mjy_objectAtIndexedSubscript:(NSInteger)idx{
//    if (idx < self.count) {
//        return [self mjy_objectAtIndexedSubscript:idx];
//    }
//    NSLog(@"越界了");
//    return nil;
//}
//
//
//@end
