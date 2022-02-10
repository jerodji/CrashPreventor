/*!
 ValidObjc.h
 DoctorPlatform
 Created by Jerod on 2018/7/26.
 Copyright © 2018年 PAG. All rights reserved.
 */

#import <Foundation/Foundation.h>


#pragma mark - def

#define IS_NULL(o)      [JJValidObjc isNull:(o)]
#define IS_EMPTY(o)     [JJValidObjc isEmpty:(o)]
#define Is_FULL_SPACE(o) [JJValidObjc isFullSpace:(o)]

#define NOT_NULL(o)      [JJValidObjc notNull:(o)]
#define NOT_EMPTY(o)     [JJValidObjc notEmpty:(o)]
#define NOT_FULL_SPACE(o) [JJValidObjc notFullSpace:(o)]

#define NOT_NULL_EMPTY(o) [JJValidObjc notNullNotEmpty:(o)]

#define VALID_STRING(a)     [JJValidObjc validString:(a)]
#define VALID_ARRAY(a)      [JJValidObjc validArray:(a)]
#define VALID_DICTIONARY(a) [JJValidObjc validDictionary:(a)]
#define VALID_OBJECT(a)     [JJValidObjc validObject:(a)]

#define SAFE_STRING(a) [JJValidObjc safeStr:(a)]

#define SPACE_STRING(obj) [JJValidObjc constraintStr:(obj)]

@interface JJValidObjc : NSObject

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



@interface NSArray<T> (jjsafe)
- (T)safeObjectAtIndex:(NSUInteger)index;
@end


@interface NSMutableArray<T> (jjsafe)
- (void)safeInsertObject:(T)anObject atIndex:(NSUInteger)index;
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(T)anObject;
@end


@interface NSDictionary<K, T> (jjsafe)
- (T)safeObjectForKey:(K)aKey;
@end


@interface NSMutableDictionary<K, T> (jjsafe)
- (void)safeSetObject:(T)anObject forKey:(K <NSCopying>)aKey;
- (void)safeRemoveObjectForKey:(K)aKey;
@end
