//
//  CrashPreventor.h
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, JShieldType) {
    JShieldTypeAll = 0,
    JShieldTypeArray        = 1 << 0,
    JShieldTypeDictionary   = 1 << 1,
    JShieldTypeString       = 1 << 2,
    JShieldTypeKVC          = 1 << 3
    
};



@interface JJCrashGuard : NSObject

+ (instancetype)shared;

/// 是否开启了防护
@property (nonatomic, assign, readonly, getter=isOpen) BOOL open;

/// 是否开启了断言调试
@property (nonatomic, assign, readonly, getter=isDebugger) BOOL debugger;

/// 保护列表
@property (nonatomic, strong, readonly) NSArray<NSNumber*>*shieldTypes;


/// 开启所有防护
- (void)beginGuard;

/// 开启防护
/// @param type 需要保护的类型
- (void)beginGuardTypes:(JShieldType)type;

/// 是否开启断言, 只在debug模式有效; Release不会断言;
/// @param debugger YES 开启断言; NO 不开断言;
- (void)openDebuggerAssert:(BOOL)debugger;


/// 使用扩展实现重写次方法,实现自己的上报日志逻辑.
/// @param log 日志信息
/// @param info 堆栈信息,可能为 nil.
- (void)reportLog:(NSString*)log stackInfo:(NSString*)info;


@end

