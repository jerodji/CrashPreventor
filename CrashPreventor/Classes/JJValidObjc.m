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





@implementation NSArray (safe)

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index < 0) {
        NSString *msg = [NSString stringWithFormat:@"*** %@ index 不能小于 0", [self class]];
//        NSAssert(NO, msg);
        NSLog(@"%@", msg);
        return nil;
    }
    if (index >= self.count) {
        NSString *msg = [NSString stringWithFormat:@"*** %@ 越界, 无效的 index:%lu", [self class], (unsigned long)index];
//        NSAssert(NO, msg);
        NSLog(@"%@", msg);
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end


@implementation NSMutableArray (safe)

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index < 0) {
        NSString *msg = [NSString stringWithFormat:@"%@ index 不能小于 0", [self class]];
        NSAssert(NO, msg);
        return;
    }
    if (index >= self.count) {
        NSString *msg = [NSString stringWithFormat:@"%@ 越界, 无效的 index:%lu", [self class], (unsigned long)index];
        NSAssert(NO, msg);
        return;
    }
    if (anObject == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ index:%lu, 不能插入空值", [self class], (unsigned long)index];
        NSAssert(NO, msg);
        return;
    }
    
    [self insertObject:anObject atIndex:index];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index < 0) {
        NSString *msg = [NSString stringWithFormat:@"%@ index 不能小于 0", [self class]];
        NSAssert(NO, msg);
        return;
    }
    if (index >= self.count) {
        NSString *msg = [NSString stringWithFormat:@"%@ 越界, 无效的 index: %lu", [self class], (unsigned long)index];
        NSAssert(NO, msg);
        return;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < 0) {
        NSString *msg = [NSString stringWithFormat:@"%@ index 不能小于 0", [self class]];
        NSAssert(NO, msg);
        return;
    }
    if (index >= self.count) {
        NSString *msg = [NSString stringWithFormat:@"%@ 越界, 无效的 index:%lu", [self class], (unsigned long)index];
        NSAssert(NO, msg);
        return;
    }
    if (anObject == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ index:%lu, 不能插入空值", [self class], (unsigned long)index];
        NSAssert(NO, msg);
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end



@implementation NSDictionary (safe)

- (id)safeObjectForKey:(id)aKey {
    NSArray * keys = self.allKeys;
    if ([keys containsObject:aKey]) {
        return [self objectForKey:aKey];
    }
    NSString *msg = [NSString stringWithFormat:@"%@ 不包含 key: %@", [self class], aKey];
//    NSAssert(NO, msg);
    NSLog(@"%@", msg);
    return nil;
}

@end



@implementation NSMutableDictionary (safe)

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ key 不能为 nil", [self class]];
        NSAssert(NO, msg);
        return;
    }
    if (anObject == nil) {
        //[self setObject:[NSNull null] forKey:aKey];
        NSString *msg = [NSString stringWithFormat:@"%@ key:%@, 不能插入空值", [self class], aKey];
        NSAssert(NO, msg);
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

- (void)safeRemoveObjectForKey:(id)aKey {
    if (aKey == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ key 不能为 nil", [self class]];
        NSAssert(NO, msg);
        return;
    }
    
    [self removeObjectForKey:aKey];
}


@end
