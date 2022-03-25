//
//  JJShieldCFuncs.h
//  JJCrashGuard
//
//  Created by Jerod on 2022/2/10.
//

#import <Foundation/Foundation.h>


void CPLog(NSString *format, ...);

void CPAssert(BOOL condition, NSString* desc, ...);


/** exchange instance method */
void swizzling_instance_method(Class cls, SEL originSEL, SEL swizzleSEL);

/** exchange class method */
void swizzling_class_method(Class cls, SEL originSEL, SEL swizzleSEL);
