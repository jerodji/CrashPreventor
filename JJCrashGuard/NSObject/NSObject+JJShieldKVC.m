//
//  NSObject+JJShieldKVC.m
//  JJCrashGuard
//
//  Created by Jerod on 2022/3/25.
//

#import "NSObject+JJShieldKVC.h"
#import "JJShieldCFuncs.h"
#import "JJCrashGuard.h"
#import <objc/runtime.h>

@implementation NSObject (JJShieldKVC)

+ (void)openShieldKVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_instance_method([NSObject class], @selector(setValue:forKey:), @selector(__safe_setValue:forKey:));
        swizzling_instance_method([NSObject class], @selector(setNilValueForKey:), @selector(__safe_setNilValueForKey:));
        swizzling_instance_method([NSObject class], @selector(setValue:forUndefinedKey:), @selector(__safe_setValue:forUndefinedKey:));
        swizzling_instance_method([NSObject class], @selector(valueForUndefinedKey:), @selector(__safe_valueForUndefinedKey:));
    });
}

// 4 种崩溃

// 1. key = nil 的崩溃
- (void)__safe_setValue:(id)value forKey:(NSString *)key {
    if (key == nil) {
        CPError(@"*** -[%@ setValue:forKey:]: attempt to set a value for a nil key", NSStringFromClass([self class]));
        return;
    }
//    if (value == nil) {
//        CPError(@"[%@ setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key %@.", self, key);
//        return;
//    }
    [self __safe_setValue:value forKey:key];
}

// 2. setNilValueForKey 的崩溃
- (void)__safe_setNilValueForKey:(NSString *)key {
    CPError(@"[%@ setNilValueForKey]: could not set nil as the value for the key oop.", self);
}

// 3. key 不存在的崩溃
// 4. keyPath 错误的崩溃
- (void)__safe_setValue:(id)value forUndefinedKey:(NSString *)key {
//    BOOL open = [[JJCrashGuard shared].shieldTypes containsObject:@(JShieldTypeKVC)];
//    if (open) {
        CPError(@"-[%@ setValue:forUndefinedKey:], key:%@, value:%@", self.class, key, value);
//    } else {

//        NSString *reason = [NSString stringWithFormat:@"[<%@ %p> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key %@.", self.class, self, key];
//        NSException *exception = [NSException exceptionWithName:@"NSUnknownKeyException" reason:reason userInfo:nil];
//        @throw exception;
//    }
}

- (id)__safe_valueForUndefinedKey:(NSString *)key {
//    BOOL open = [[JJCrashGuard shared].shieldTypes containsObject:@(JShieldTypeKVC)];
//    if (open) {
        CPError(@"-[%@ valueForUndefinedKey:], key:%@", self.class, key);
        return nil;
//    } else {
//        //    Thread 1: "[<NSObject 0x6000002ec160> valueForUndefinedKey:]: this class is not key value coding-compliant for the key uu."
//        NSString *reason = [NSString stringWithFormat:@"[<%@ %p> valueForUndefinedKey:]: this class is not key value coding-compliant for the key %@.", self.class, self, key];
//        NSException *exception = [NSException exceptionWithName:@"NSUnknownKeyException" reason:reason userInfo:nil];
//        @throw exception;
//
//        return nil;
//    }
}


@end
