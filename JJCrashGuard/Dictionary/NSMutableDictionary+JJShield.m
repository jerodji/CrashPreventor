//
//  NSMutableDictionary+preventor.m
//  JJCrashGuard
//
//  Created by Jerod on 2021/5/17.
//

#import "NSMutableDictionary+JJShield.h"
//#import "JJCrashGuard.h"
#import "JJShieldCFuncs.h"


@implementation NSMutableDictionary (JJCrashShield)

+ (void)openShield
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //__NSDictionaryM
        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        swizzling_instance_method(__NSDictionaryM,
                                  @selector(setObject:forKey:),
                                  @selector(__NSDictionaryM_safe_setObject:forKey:));
        swizzling_instance_method(__NSDictionaryM,
                                  @selector(setObject:forKeyedSubscript:),
                                  @selector(__NSDictionaryM_safe_setObject:forKeyedSubscript:));
        swizzling_instance_method(__NSDictionaryM,
                                  @selector(removeObjectForKey:),
                                  @selector(__NSDictionaryM_safe_removeObjectForKey:));
    });
}

- (void)__NSDictionaryM_safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self __NSDictionaryM_safe_setObject:anObject forKey:aKey];
    } else {
        CPError(@"-[__NSDictionaryM setObject:forKey:], object or key cannot be nil.");
    }
}

- (void)__NSDictionaryM_safe_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (key) {
        [self __NSDictionaryM_safe_setObject:obj forKeyedSubscript:key];
    } else {
        CPError(@"-[__NSDictionaryM setObject:forKeyedSubscript:], key cannot be nil.");
    }
}

- (void)__NSDictionaryM_safe_removeObjectForKey:(id)aKey {
    if (aKey) {
        [self __NSDictionaryM_safe_removeObjectForKey:aKey];
    } else {
        CPError(@"-[__NSDictionaryM removeObjectForKey:]: key cannot be nil");
    }
}



@end
