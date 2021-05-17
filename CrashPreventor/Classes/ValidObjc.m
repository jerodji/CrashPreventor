/*!
 ValidObjc.m
 DoctorPlatform
 Created by Jerod on 2018/7/26.
 Copyright © 2018年 PAG. All rights reserved.
 */

#import "ValidObjc.h"

@implementation ValidObjc

#pragma mark - function

BOOL IsNull(id o) {
    return [ValidObjc isNull:o];
}
BOOL IsEmpty(id o) {
    return [ValidObjc isEmpty:o];
}
BOOL IsFullSpace(id o) {
    return [ValidObjc isFullSpace:o];
}

BOOL NotNull(id o) {
    return [ValidObjc notNull:o];
}
BOOL NotEmpty(id o) {
    return [ValidObjc notEmpty:o];
}
BOOL NotFullSpace(id o) {
    return [ValidObjc notFullSpace:o];
}

BOOL NotNullNotEmpty(id o) {
    return [ValidObjc notNullNotEmpty:o];
}

/* length > 0, 不全是空格 */
BOOL ValidString(id a) {
    return [ValidObjc validString:a];
}

/* count > 0 */
BOOL ValidArray(id a) {
    return [ValidObjc validArray:a];
}

/* 有Keys */
BOOL ValidDictionary(id a) {
    return [ValidObjc validDictionary:a];
}

BOOL ValidObject(id a) {
    return [ValidObjc validObject:a];
}

NSString* SafeString(id a) {
    return [ValidObjc safeStr:a];
}
//NSString* ConstraintString(id a) {
//    return [ValidObjc constraintStr:a];
//}

#pragma mark - Method

+ (NSString*)safeStr:(id)obj {
    if ([ValidObjc validString:obj]) {
        return (NSString*)obj;
    } else {
        return @"";
    }
}


+ (NSString*)constraintStr:(id)obj {
    if ([ValidObjc validString:obj]) {
        return (NSString*)obj;
    } else {
        return @" ";
    }
}

+ (BOOL)validString:(id)obj {
    if ([ValidObjc isNull:obj]) {
        return NO;
    }
    if (![obj isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    NSString *str = (NSString*)obj;
    if (str.length>0 && ![ValidObjc isFullSpace:str]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)validArray:(id)obj {
    if ([ValidObjc isNull:obj]) {
        return NO;
    }
    if (![obj isKindOfClass:[NSArray class]]) {
        return NO;
    }
    NSArray *array = (NSArray*)obj;
    if (array.count>0) {
        return YES;
    }
    return NO;
}

+ (BOOL)validDictionary:(id)obj {
    if ([ValidObjc isNull:obj]) {
        return NO;
    }
    if (![obj isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    NSDictionary *dict = (NSDictionary*)obj;
    if (dict.allKeys.count>0) {
        return YES;
    }
    return NO;
}

+ (BOOL)validObject:(id)obj {
    if ([ValidObjc isNull:obj]) {
        return NO;
    }
    if ([ValidObjc isEmpty:obj]) {
        return NO;
    }
    if ([obj isKindOfClass:[NSString class]] && [ValidObjc isFullSpace:(NSString*)obj]) {
        return NO;
    }
    return YES;
}

///MARK: - ---
+ (BOOL)isNull:(id)objc
{
    if (nil==objc || [objc isEqual:[NSNull null]] || [objc isEqual:@"<null>"] || [objc isEqual:@"null"] || [objc isEqual:@"(null)"] ||  objc==Nil || objc==NULL || [objc isEqual:@"<nil>"] || [objc isEqual:@"nil"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)notNull:(id)objc {
    return ![self isNull:objc];
}

+ (BOOL)isEmpty:(id)objc
{
    if ([objc isKindOfClass:[NSString class]]) {
        NSString* str = (NSString*)objc;
        if (str.length == 0) {
            return YES;
        }
    }
    
    if ([objc isKindOfClass:[NSArray class]]) {
        NSArray* array = (NSArray*)objc;
        if (array.count == 0) {
            return YES;
        }
    }
    
    if ([objc isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dic = (NSDictionary*)objc;
        if (dic.count == 0) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)notEmpty:(id)objc {
    return ![self isEmpty:objc];
}


+ (BOOL)notFullSpace:(NSString*)str {
    return ![self isFullSpace:str];
}
+ (BOOL)isFullSpace:(NSString *)str {
    
    if(!str) {
        return YES;
    }
    else {
        
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if([trimedString length] == 0) {
            return YES;
        }else {
            return NO;
        }
    }
}

+ (BOOL)notNullNotEmpty:(id)obj {
    if ([ValidObjc notNull:obj] && [ValidObjc notEmpty:obj]) {
        return YES;
    }
    return NO;
}


@end

