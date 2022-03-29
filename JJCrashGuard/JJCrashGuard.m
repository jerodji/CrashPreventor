//
//  CrashPreventor.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "JJCrashGuard.h"
#import "NSArray+JJShield.h"
#import "NSMutableArray+JJShield.h"
#import "NSDictionary+JJShield.h"
#import "NSMutableDictionary+JJShield.h"

@interface JJCrashGuard ()

@end


@implementation JJCrashGuard {
    NSMutableArray *shieldList;
}

@synthesize open = _open;
//@synthesize debugger = _debugger;
//@synthesize shieldList = _shieldList;

+ (instancetype)shared {
    static JJCrashGuard * ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[super allocWithZone:nil] init];
        ins->shieldList = [NSMutableArray array];
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

// MARK: - Methods

- (void)beginGuard {
    [self beginGuardTypes:JShieldTypeAll];
}

- (void)beginGuardTypes:(JShieldType)type {
    _open = YES;
    if (type == JShieldTypeAll) {
        if (![self->shieldList containsObject:@(JShieldTypeAll)]) {
            [self _guardTypes:JShieldTypeArray | JShieldTypeDictionary | JShieldTypeString | JShieldTypeKVC];
        }
    } else {
        [self _guardTypes:type];
    }
}

- (void)_guardTypes:(JShieldType)type {
    if (type & JShieldTypeArray) {
        if (![self->shieldList containsObject:@(JShieldTypeArray)]) {
            NSLog(@"begin guard array");
            [NSArray openShield];
            [NSMutableArray openShield];
            [self->shieldList addObject:@(JShieldTypeArray)];
        }
    }
    if (type & JShieldTypeDictionary) {
        if (![self->shieldList containsObject:@(JShieldTypeDictionary)]) {
            NSLog(@"begin guard dictionary");
            [NSDictionary openShield];
            [NSMutableDictionary openShield];
            [self->shieldList addObject:@(JShieldTypeDictionary)];
        }
    }
    if (type & JShieldTypeString) {
        if (![self->shieldList containsObject:@(JShieldTypeString)]) {
            NSLog(@"begin guard string");
        }
    }
    if (type & JShieldTypeKVC) {
        if (![self->shieldList containsObject:@(JShieldTypeKVC)]) {
            NSLog(@"begin guard kvc");
            [self->shieldList addObject:@(JShieldTypeKVC)];
        }
    }
    
    
    
}


- (void)setDebugger:(BOOL)debugger {
    #ifdef DEBUG
        _debugger = debugger;
    #else
        _debugger = NO;
    #endif
}

//- (void)openDebuggerAssert:(BOOL)debugger {
//#ifdef DEBUG
//    _debugger = debugger;
//#else
//    _debugger = NO;
//#endif
//}

//- (void)errorMessage:(NSString*)msg stackInfo:(NSString*)info {
//    //请扩展实现自己的上报方法
//}


// MARK: - getter

- (NSArray *)shieldTypes {
    return (NSArray*)self->shieldList;
}


@end

