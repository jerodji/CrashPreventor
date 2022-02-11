//
//  CrashPreventor.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "JJCrashGuard.h"
#import "NSArray+JJCrashShield.h"
#import "NSMutableArray+JJCrashShield.h"
#import "NSDictionary+JJCrashShield.h"
#import "NSMutableDictionary+JJCrashShield.h"


@implementation JJCrashGuard

@synthesize isOpen = _isOpen;
@synthesize debugger = _debugger;
@synthesize shieldList = _shieldList;

+ (instancetype)shared {
    static JJCrashGuard * ins = nil;
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



- (void)openShield {
    [self openShieldWith:@[
        [NSArray class], [NSMutableArray class],
        [NSDictionary class], [NSMutableDictionary class]]
    ];
}

- (void)openShieldWith:(NSArray<Class>*)list {
    if (!list) return;
    if (list.count == 0) return;
    
    _isOpen = YES;
    _shieldList = list;
    
    [list enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqual:[NSArray class]]) {
            [NSArray openShield];
        } else if ([obj isEqual:[NSMutableArray class]]) {
            [NSMutableArray openShield];
        } else if ([obj isEqual:[NSDictionary class]]) {
            [NSDictionary openShield];
        } else if ([obj isEqual:[NSMutableDictionary class]]) {
            [NSMutableDictionary openShield];
        }
        
        
    }];
}

- (void)openDebuggerAssert:(BOOL)debugger {
#ifdef DEBUG
    _debugger = debugger;
#else
    _debugger = NO;
#endif
}

- (void)reportLog:(NSString*)log stackInfo:(NSString*)info {
    //请扩展实现自己的上报方法
}

@end

