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
    [self openShieldWith:@[[NSArray class]]];
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
            
        } else if ([obj isEqual:[NSDictionary class]]) {
            
        } else if ([obj isEqual:[NSMutableDictionary class]]) {
            
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

- (void)report:(NSString*)info {
    //请扩展实现自己的上报方法
}

//- (void)report:(id)firstArg, ... NS_REQUIRES_NIL_TERMINATION {
//    NSLog(@"firstArg : %@", firstArg);
//    
//    va_list args; // 定义一个指向个数可变的参数列表指针；
//    va_start(args, firstArg);
//    
//    
//    while (1) {
//        void* arg = va_arg(args, void*);
//        if (arg == nil) break;
//        NSLog(@"arg : %d", arg);
//    }
//    
//    va_end(args);
//}

@end

