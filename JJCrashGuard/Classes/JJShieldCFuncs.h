//
//  JJShieldCFuncs.h
//  JJCrashGuard
//
//  Created by CN210208396 on 2022/2/10.
//

#import <Foundation/Foundation.h>
#import "JJCrashGuard.h"



//#define CPAssert(condition, desc, ...) \
//if([JJCrashGuard shared].debugger){\
//    NSAssert(condition, [@"[JJCrashGuard] error : " stringByAppendingString:desc], ##__VA_ARGS__);\
//}else{\
//    NSString * format = [@"[JJCrashGuard] error : " stringByAppendingString:desc];\
//    NSLog(format, ##__VA_ARGS__);\
//}


void CPAssert(BOOL condition, NSString* desc, ...);


/** exchange instance method */
void swizzling_instance_method(Class cls, SEL originSEL, SEL swizzleSEL);

/** exchange class method */
void swizzling_class_method(Class cls, SEL originSEL, SEL swizzleSEL);
