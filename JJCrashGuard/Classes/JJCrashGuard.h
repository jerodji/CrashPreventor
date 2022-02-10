//
//  CrashPreventor.h
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import <Foundation/Foundation.h>

@interface JJCrashGuard : NSObject

+ (instancetype)shared;

/// 是否开启了防护
@property (nonatomic, assign, readonly) BOOL isOpen;

/// 是否开启了断言调试
@property (nonatomic, assign, readonly) BOOL debugger;

/// 保护列表
@property (nonatomic, strong, readonly) NSArray *shieldList;


/// 开启所有防护
- (void)openShield;

/// 开启防护
/// @param list 需要保护的类型
- (void)openShieldWith:(NSArray<Class>*)list;


/// 是否开启断言, 只在debug模式有效; Release不会断言;
/// @param debugger YES 开启断言; NO 不开断言;
- (void)openDebuggerAssert:(BOOL)debugger;


- (void)report:(NSString*)info;


@end

