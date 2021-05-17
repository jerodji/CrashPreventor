//
//  NSMutableDictionary+preventor.m
//  CrashPreventor
//
//  Created by Jerod on 2021/5/17.
//

#import "NSMutableDictionary+preventor.h"
#import "CrashPreventor.h"

@implementation NSMutableDictionary (preventor)

+ (void)openCrashPreventor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //__NSDictionaryM
        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        swizzling_instance_method(__NSDictionaryM, @selector(setObject:forKey:), @selector(__NSDictionaryM_safe_setObject:forKey:));
        swizzling_instance_method(__NSDictionaryM, @selector(setObject:forKeyedSubscript:), @selector(__NSDictionaryM_safe_setObject:forKeyedSubscript:));
        swizzling_instance_method(__NSDictionaryM, @selector(removeObjectForKey:), @selector(__NSDictionaryM_safe_removeObjectForKey:));
    });
}

- (void)__NSDictionaryM_safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self __NSDictionaryM_safe_setObject:anObject forKey:aKey];
    } else {
        CPAssert(NO, @"*** [CrashPreventor], -[__NSDictionaryM setObject:forKey:], object or key cannot be nil.");
    }
}

- (void)__NSDictionaryM_safe_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (key) {
        [self __NSDictionaryM_safe_setObject:obj forKeyedSubscript:key];
    } else {
        CPAssert(NO, @"*** [CrashPreventor], -[__NSDictionaryM setObject:forKeyedSubscript:], key cannot be nil.");
    }
}

- (void)__NSDictionaryM_safe_removeObjectForKey:(id)aKey {
    if (aKey) {
        [self __NSDictionaryM_safe_removeObjectForKey:aKey];
    } else {
        CPAssert(NO, @"*** [CrashPreventor], -[__NSDictionaryM removeObjectForKey:]: key cannot be nil");
    }
}



@end
