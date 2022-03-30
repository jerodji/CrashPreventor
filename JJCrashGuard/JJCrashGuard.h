//
//  CrashPreventor.h
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import <Foundation/Foundation.h>

/// 保护的类型
typedef NS_OPTIONS(NSUInteger, JShieldType) {
    JShieldTypeAll = 0,
    JShieldTypeArray        = 1 << 1,
    JShieldTypeDictionary   = 1 << 2,
    JShieldTypeSet          = 1 << 3,
    JShieldTypeString       = 1 << 4,
    JShieldTypeNSURL        = 1 << 5,
    JShieldTypeKVC          = 1 << 6,
    JShieldTypeKVO          = 1 << 7,
    JShieldTypeUnrecognizedSelector = 1 << 8
};

/// 日志级别
typedef NS_ENUM(NSUInteger, JShieldLogLevel) {
    JShieldLogLevelError = 1,
    JShieldLogLevelWarning = 2, // waning 和 error
    JShieldLogLevelInfo = 3, // info, waning 和 error
};

/// 使用代理方法,实现自己的上报日志逻辑.
/// msg 日志信息
/// info 堆栈信息,可能为 nil.
@protocol JShieldLogDelegate <NSObject>
@optional
- (void)errorMsg:(NSString*)msg stackInfo:(NSString*)info;
- (void)warningMsg:(NSString*)msg stackInfo:(NSString*)info;
- (void)infoMsg:(NSString*)msg stackInfo:(NSString*)info;
@end




@interface JJCrashGuard : NSObject

+ (instancetype)shared;

/// 日志级别
@property (nonatomic, assign) JShieldLogLevel logLevel;

/// 日志回调
@property (nonatomic, weak) id<JShieldLogDelegate> delegate;

/// 是否开启断言调试
@property (nonatomic, assign) BOOL debugger;

/// 是否开启了防护
@property (nonatomic, assign, readonly, getter=isOpen) BOOL open;

/// 保护列表
@property (nonatomic, strong, readonly) NSArray<NSNumber*>*shieldTypes;


/// 开启所有防护
- (void)beginGuard;

/// 开启防护
/// @param type 需要保护的类型
- (void)beginGuardTypes:(JShieldType)type;


@end

