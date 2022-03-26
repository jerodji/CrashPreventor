//
//  NSObject+JJShieldKVC.m
//  JJCrashGuard
//
//  Created by Jerod on 2022/3/25.
//

#import "NSObject+JJShieldKVC.h"
#import "JJShieldCFuncs.h"
#import "JJCrashGuard.h"

@implementation NSObject (JJShieldKVC)


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    BOOL open = [[JJCrashGuard shared].shieldTypes containsObject:@(JShieldTypeKVC)];
    if (open) {
        CPLog(@"KVC error, -[%@ setValue:forUndefinedKey:], key:%@, value:%@", self.class, key, value);
    } else {
        
        NSString *reason = [NSString stringWithFormat:@"[<%@ %p> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key %@.", self.class, self, key];
        NSException *exception = [NSException exceptionWithName:@"NSUnknownKeyException" reason:reason userInfo:nil];
        @throw exception;
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    BOOL open = [[JJCrashGuard shared].shieldTypes containsObject:@(JShieldTypeKVC)];
    if (open) {
        CPLog(@"KVC error, -[%@ valueForUndefinedKey:], key:%@", self.class, key);
        return nil;
    } else {
        //    Thread 1: "[<NSObject 0x6000002ec160> valueForUndefinedKey:]: this class is not key value coding-compliant for the key uu."
        NSString *reason = [NSString stringWithFormat:@"[<%@ %p> valueForUndefinedKey:]: this class is not key value coding-compliant for the key %@.", self.class, self, key];
        NSException *exception = [NSException exceptionWithName:@"NSUnknownKeyException" reason:reason userInfo:nil];
        @throw exception;
        
        return nil;
    }
}


@end
