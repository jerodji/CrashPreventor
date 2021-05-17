//
//  CrashPreventor.h
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import <Foundation/Foundation.h>



#define CPAssert(condition, desc, ...) if([CrashPreventor shared].debugger){NSAssert((condition), (desc), ##__VA_ARGS__);}


/**
 exchange instance method
 */
void swizzling_instance_method(Class cls, SEL originSEL, SEL swizzleSEL);

/**
 exchange class method
 */
void swizzling_class_method(Class cls, SEL originSEL, SEL swizzleSEL);




@interface CrashPreventor : NSObject

+ (instancetype)shared;

@property (nonatomic, assign, readonly) BOOL isOpen;

@property (nonatomic, assign, readonly) BOOL debugger;

/// 开启防护
- (void)openPreventor;

/// 是否开启断言, 只在debug模式有效; Release不会断言;
/// @param debugger YES 开启断言; NO 不开断言;
- (void)openDebuggerAssert:(BOOL)debugger;

@end



