#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CrashPreventor.h"
#import "NSArray+preventor.h"
#import "NSDictionary+preventor.h"
#import "NSMutableArray+preventor.h"
#import "NSMutableDictionary+preventor.h"
#import "ValidObjc.h"

FOUNDATION_EXPORT double CrashPreventorVersionNumber;
FOUNDATION_EXPORT const unsigned char CrashPreventorVersionString[];

