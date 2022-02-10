/*!
 ValidObjc.h
 DoctorPlatform
 Created by Jerod on 2018/7/26.
 Copyright © 2018年 PAG. All rights reserved.
 */

#import <Foundation/Foundation.h>


#pragma mark - def

#define IS_NULL(o)      [ValidObjc isNull:(o)]
#define IS_EMPTY(o)     [ValidObjc isEmpty:(o)]
#define Is_FULL_SPACE(o) [ValidObjc isFullSpace:(o)]

#define NOT_NULL(o)      [ValidObjc notNull:(o)]
#define NOT_EMPTY(o)     [ValidObjc notEmpty:(o)]
#define NOT_FULL_SPACE(o) [ValidObjc notFullSpace:(o)]

#define NOT_NULL_EMPTY(o) [ValidObjc notNullNotEmpty:(o)]

#define VALID_STRING(a)     [ValidObjc validString:(a)]
#define VALID_ARRAY(a)      [ValidObjc validArray:(a)]
#define VALID_DICTIONARY(a) [ValidObjc validDictionary:(a)]
#define VALID_OBJECT(a)     [ValidObjc validObject:(a)]

#define SAFE_STRING(a) [ValidObjc safeStr:(a)]

#define SPACE_STRING(obj) [ValidObjc constraintStr:(obj)]

@interface ValidObjc : NSObject

#pragma mark - function

NSString* SafeString(id a);

BOOL ValidString(id a);
BOOL ValidArray(id a);
BOOL ValidDictionary(id a);
BOOL ValidObject(id a);


BOOL IsNull(id o);
BOOL IsEmpty(id o);
BOOL IsFullSpace(id o);

BOOL NotNull(id o);
BOOL NotEmpty(id o);
BOOL NotFullSpace(id o);
BOOL NotNullNotEmpty(id o);

//NSString* ConstraintString(id a);

#pragma mark - Method

+ (BOOL)validString:(id)obj;
+ (BOOL)validArray:(id)obj;
+ (BOOL)validDictionary:(id)obj;
+ (BOOL)validObject:(id)obj;

+ (NSString*)safeStr:(id)obj;
+ (NSString*)constraintStr:(id)obj;

+ (BOOL)isNull:(id)objc;
+ (BOOL)notNull:(id)objc;
+ (BOOL)isEmpty:(id)objc;
+ (BOOL)notEmpty:(id)objc;
+ (BOOL)isFullSpace:(NSString *)str;
+ (BOOL)notFullSpace:(NSString*)str;
+ (BOOL)notNullNotEmpty:(id)obj;

@end



@interface NSArray<T> (safe)
- (T)safeObjectAtIndex:(NSUInteger)index;
@end


@interface NSMutableArray<T> (safe)
- (void)safeInsertObject:(T)anObject atIndex:(NSUInteger)index;
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(T)anObject;
@end


@interface NSDictionary<K, T> (safe)
- (T)safeObjectForKey:(K)aKey;
@end


@interface NSMutableDictionary<K, T> (safe)
- (void)safeSetObject:(T)anObject forKey:(K <NSCopying>)aKey;
- (void)safeRemoveObjectForKey:(K)aKey;
@end
