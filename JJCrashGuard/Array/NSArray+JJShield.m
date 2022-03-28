//
//  NSArray+preventor.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "NSArray+JJShield.h"
//#import "JJCrashGuard.h"
#import "JJShieldCFuncs.h"


@implementation NSArray (JJCrashShield)

+ (void)openShield {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //__NSPlaceholderArray
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");
        swizzling_instance_method(__NSPlaceholderArray, @selector(initWithObjects:count:), @selector(__NSPlaceholderArray_safe_initWithObjects:count:));
        swizzling_instance_method(__NSPlaceholderArray,
                                  @selector(objectAtIndex:),
                                  @selector(__NSPlaceholderArray_safe_objectAtIndex:));
        swizzling_instance_method(__NSPlaceholderArray,
                                  @selector(objectAtIndexedSubscript:),
                                  @selector(__NSPlaceholderArray_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSPlaceholderArray,
                                  @selector(objectsAtIndexes:),
                                  @selector(__NSPlaceholderArray_safe_objectsAtIndexes:));
        swizzling_instance_method(__NSPlaceholderArray,
              @selector(enumerateObjectsUsingBlock:),
              @selector(__NSPlaceholderArray_safe_enumerateObjectsUsingBlock:));
        swizzling_instance_method(__NSPlaceholderArray,
              @selector(enumerateObjectsWithOptions:usingBlock:),
              @selector(__NSPlaceholderArray_safe_enumerateObjectsWithOptions:usingBlock:));
        swizzling_instance_method(__NSPlaceholderArray,
          @selector(enumerateObjectsAtIndexes:options:usingBlock:),
          @selector(__NSPlaceholderArray_safe_enumerateObjectsAtIndexes:options:usingBlock:));
        
        
        // NSArray 的类簇
        // __NSArray0: 空数组
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        swizzling_instance_method(__NSArray0, @selector(objectAtIndex:), @selector(__NSArray0_safe_objectAtIndex:));
        swizzling_instance_method(__NSArray0, @selector(objectAtIndexedSubscript:), @selector(__NSArray0_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArray0, @selector(subarrayWithRange:), @selector(__NSArray0_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArray0, @selector(arrayByAddingObject:), @selector(__NSArray0_safe_arrayByAddingObject:));
        swizzling_instance_method(__NSArray0,
                                  @selector(objectsAtIndexes:),
                                  @selector(__NSArray0_safe_objectsAtIndexes:));
        
        // __NSSingleObjectArrayI: iOS10 以上单个内容
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(objectAtIndex:), @selector(__NSSingleObjectArrayI_safe_objectAtIndex:));
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(objectAtIndexedSubscript:), @selector(__NSSingleObjectArrayI_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(subarrayWithRange:), @selector(__NSSingleObjectArrayI_safe_subarrayWithRange:));
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(arrayByAddingObject:), @selector(__NSSingleObjectArrayI_safe_arrayByAddingObject:));
        
        // __NSArrayI: 内容obj类型, 多个元素
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        swizzling_instance_method(__NSArrayI,
                                  @selector(objectAtIndex:),
                                  @selector(__NSArrayI_safe_objectAtIndex:));
        swizzling_instance_method(__NSArrayI,
                                  @selector(objectAtIndexedSubscript:),
                                  @selector(__NSArrayI_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArrayI,
                                  @selector(subarrayWithRange:),
                                  @selector(__NSArrayI_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArrayI,
                                  @selector(arrayByAddingObject:),
                                  @selector(__NSArrayI_safe_arrayByAddingObject:));
        swizzling_instance_method(__NSArrayI,
                                  @selector(objectsAtIndexes:),
                                  @selector(__NSArrayI_safe_objectsAtIndexes:));
        
        
        // __NSArrayI_Transfer : 内容obj类型
        Class __NSArrayI_Transfer = NSClassFromString(@"__NSArrayI_Transfer");
        swizzling_instance_method(__NSArrayI_Transfer, @selector(objectAtIndex:), @selector(__NSArrayI_Transfer_safe_objectAtIndex:));
        swizzling_instance_method(__NSArrayI_Transfer, @selector(objectAtIndexedSubscript:), @selector(__NSArrayI_Transfer_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArrayI_Transfer, @selector(subarrayWithRange:), @selector(__NSArrayI_Transfer_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArrayI_Transfer, @selector(arrayByAddingObject:), @selector(__NSArrayI_Transfer_safe_arrayByAddingObject:));
        
        // __NSFrozenArrayM
        Class __NSFrozenArrayM = NSClassFromString(@"__NSFrozenArrayM");
        swizzling_instance_method(__NSFrozenArrayM, @selector(objectAtIndex:), @selector(__NSFrozenArrayM_safe_objectAtIndex:));
        swizzling_instance_method(__NSFrozenArrayM, @selector(objectAtIndexedSubscript:), @selector(__NSFrozenArrayM_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSFrozenArrayM, @selector(subarrayWithRange:), @selector(__NSFrozenArrayM_safe_subarrayWithRange:));
        swizzling_instance_method(__NSFrozenArrayM, @selector(arrayByAddingObject:), @selector(__NSFrozenArrayM_safe_arrayByAddingObject:));
        
        // __NSArrayReversed
        Class __NSArrayReversed = NSClassFromString(@"__NSArrayReversed");
        swizzling_instance_method(__NSArrayReversed, @selector(objectAtIndex:), @selector(__NSArrayReversed_safe_objectAtIndex:));
        swizzling_instance_method(__NSArrayReversed, @selector(objectAtIndexedSubscript:), @selector(__NSArrayReversed_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArrayReversed, @selector(subarrayWithRange:), @selector(__NSArrayReversed_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArrayReversed, @selector(arrayByAddingObject:), @selector(__NSArrayReversed_safe_arrayByAddingObject:));
        
    });
}

// MARK: __NSArray0
- (id)__NSArray0_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSArray0_safe_objectAtIndex:index];
    } else {
        CPError(@"-[__NSArray0 objectAtIndex:], index %d beyond empty array.", (int)index);
        return nil;
    }
}
- (NSArray *)__NSArray0_safe_objectsAtIndexes:(NSIndexSet *)indexes {
    if (!indexes) {
        CPError(@"-[__NSArray0 objectsAtIndexes:], index set cannot be nil.");
        return @[];
    }
    NSUInteger firstIndex = indexes.firstIndex;
    NSUInteger lastIndex = indexes.lastIndex;
    if (firstIndex >= 0 && lastIndex < self.count) {
        return [self __NSArray0_safe_objectsAtIndexes:indexes];
    } else {
        if (firstIndex == lastIndex) {
            CPError(@"-[__NSArray0 objectsAtIndexes:], index %lu beyond empty array.", firstIndex);
        } else {
            CPError(@"-[__NSArray0 objectsAtIndexes:], indexes [%lu...%lu] beyond empty array.", (unsigned long)firstIndex, (unsigned long)lastIndex);
        }
        return @[];
    }
}
- (id)__NSArray0_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArray0_safe_objectAtIndexedSubscript:index];
    } else {
        CPError(@"-[__NSArray0 objectAtIndexedSubscript:], index %d beyond empty array.", (int)index);
        return nil;
    }
}
- (NSArray*)__NSArray0_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPError(@"-[__NSArray0 subarrayWithRange:], range NSNotFound", nil);
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArray0_safe_subarrayWithRange:range];
    } else {
        CPWarning(@"-[__NSArray0 subarrayWithRange:], range location %d + length %d beyond empty array.", (int)range.location, (int)range.length);
        return [self __NSArray0_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArray0_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArray0_safe_arrayByAddingObject:anObject];
    } else {
        //return [self __NSArray0_safe_arrayByAddingObject:[NSNull null]];
        CPError(@"-[__NSArray0 arrayByAddingObject:], object can not be nil", nil);
        return self;
    }
}

// MARK: __NSArrayI
- (id)__NSArrayI_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSArrayI_safe_objectAtIndex:index];
    } else {
        CPError(@"-[__NSArrayI objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}

//*** -[NSArray objectsAtIndexes:]: index 3 in index set beyond bounds [0 .. 1]
- (NSArray *)__NSArrayI_safe_objectsAtIndexes:(NSIndexSet *)indexes {
    if (!indexes) {
        CPError(@"-[__NSArrayI objectsAtIndexes:], indexes is nil.");
        return @[];
    }
    NSUInteger firstIndex = indexes.firstIndex;
    NSUInteger lastIndex = indexes.lastIndex;
    if (firstIndex >= 0 && lastIndex < self.count) {
        return [self __NSArrayI_safe_objectsAtIndexes:indexes];
    } else {
        if (firstIndex == lastIndex) {
            CPError(@"-[__NSArrayI objectsAtIndexes:], index %lu beyond bounds [0...%lu]", firstIndex, (unsigned long)(self.count-1));
        } else {
            CPError(@"-[__NSArrayI objectsAtIndexes:], indexes [%lu...%lu] beyond bounds [0...%lu]", (unsigned long)firstIndex, (unsigned long)lastIndex, (unsigned long)(self.count-1));
        }
        return @[];
    }
}

- (id)__NSArrayI_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArrayI_safe_objectAtIndexedSubscript:index];
    } else {
        CPError(@"-[__NSArrayI objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSArrayI_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPError(@"-[__NSArrayI subarrayWithRange:], range NSNotFound", nil);
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArrayI_safe_subarrayWithRange:range];
    } else {
        CPWarning(@"-[__NSArrayI subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArrayI_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArrayI_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArrayI_safe_arrayByAddingObject:anObject];
    } else {
        CPError(@"-[__NSArrayI arrayByAddingObject:], object cannot be nil", nil);
        //return [self __NSArrayI_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}

// MARK: __NSPlaceholderArray
- (instancetype)__NSPlaceholderArray_safe_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt
{
    if (objects) {
        id newObjs[cnt];
        NSUInteger newCnt = 0;
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjs[newCnt] = objects[i];
                newCnt++;
            } else {
                CPWarning(@"-[__NSPlaceholderArray initWithObjects:count:], object cannot be nil at %d", i);
            }
        }
        return [self __NSPlaceholderArray_safe_initWithObjects:newObjs count:newCnt];
    } else {
        return [self __NSPlaceholderArray_safe_initWithObjects:NULL count:0];
    }
}
- (id)__NSPlaceholderArray_safe_objectAtIndex:(NSUInteger)index {
//    if (0 <= index && index < self.count) {
//        return [self __NSPlaceholderArray_safe_objectAtIndex:index];
//    } else {
        CPError(@"-[__NSPlaceholderArray objectAtIndex:], index %d beyond placeholder array.", (int)index);
        return nil;
//    }
}
- (id)__NSPlaceholderArray_safe_objectAtIndexedSubscript:(NSUInteger)index {
//    if (0 <= index && index < self.count) {
//        return [self __NSPlaceholderArray_safe_objectAtIndexedSubscript:index];
//    } else {
        CPError(@"-[__NSArrayI objectAtIndexedSubscript:], index %d beyond placeholder array.", (int)index);
        return nil;
//    }
}
- (NSArray *)__NSPlaceholderArray_safe_objectsAtIndexes:(NSIndexSet *)indexes {
    if (!indexes) {
        CPError(@"-[__NSPlaceholderArray objectsAtIndexes:], indexes is nil for placeholder array.");
        return @[];
    }
    NSUInteger firstIndex = indexes.firstIndex;
    NSUInteger lastIndex = indexes.lastIndex;
//    if (firstIndex >= 0 && lastIndex < self.count) {
//        return [self __NSPlaceholderArray_safe_objectsAtIndexes:indexes];
//    } else {
        if (firstIndex == lastIndex) {
            CPError(@"-[__NSPlaceholderArray objectsAtIndexes:], index %lu beyond placeholder array.", firstIndex);
        } else {
            CPError(@"-[__NSPlaceholderArray objectsAtIndexes:], indexes [%lu...%lu] beyond placeholder array.", (unsigned long)firstIndex, (unsigned long)lastIndex);
        }
        return @[];
//    }
}
- (void)__NSPlaceholderArray_safe_enumerateObjectsUsingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    CPError(@"-[__NSPlaceholderArray enumerateObjectsUsingBlock:], placeholder array can not call this method.");
}
- (void)__NSPlaceholderArray_safe_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    CPError(@"-[__NSPlaceholderArray enumerateObjectsWithOptions:usingBlock:], placeholder array can not call this method.");
}
- (void)__NSPlaceholderArray_safe_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    CPError(@"-[__NSPlaceholderArray enumerateObjectsAtIndexes:options:usingBlock:], placeholder array can not call this method.");
}

// MARK: __NSArrayI_Transfer
- (id)__NSArrayI_Transfer_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSArrayI_Transfer_safe_objectAtIndex:index];
    } else {
        CPError(@"-[__NSArrayI_Transfer objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSArrayI_Transfer_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArrayI_Transfer_safe_objectAtIndexedSubscript:index];
    } else {
        CPError(@"-[__NSArrayI_Transfer objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSArrayI_Transfer_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPError(@"-[__NSArrayI_Transfer subarrayWithRange:], range NSNotFound", nil);
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArrayI_Transfer_safe_subarrayWithRange:range];
    } else {
        CPWarning(@"-[__NSArrayI_Transfer subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArrayI_Transfer_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArrayI_Transfer_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArrayI_Transfer_safe_arrayByAddingObject:anObject];
    } else {
        CPError(@"-[__NSArrayI_Transfer arrayByAddingObject:], object cannot be nil", nil);
        //return [self __NSArrayI_Transfer_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}

// MARK: __NSSingleObjectArrayI
- (id)__NSSingleObjectArrayI_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSSingleObjectArrayI_safe_objectAtIndex:index];
    } else {
        CPError(@"-[__NSSingleObjectArrayI objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSSingleObjectArrayI_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSSingleObjectArrayI_safe_objectAtIndexedSubscript:index];
    } else {
        CPError(@"-[__NSSingleObjectArrayI objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSSingleObjectArrayI_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPError(@"-[__NSSingleObjectArrayI subarrayWithRange:], range NSNotFound", nil);
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSSingleObjectArrayI_safe_subarrayWithRange:range];
    } else {
        CPWarning(@"-[__NSSingleObjectArrayI subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSSingleObjectArrayI_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSSingleObjectArrayI_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSSingleObjectArrayI_safe_arrayByAddingObject:anObject];
    } else {
        CPError(@"-[__NSSingleObjectArrayI arrayByAddingObject:], object cannot be nil", nil);
        //return [self __NSSingleObjectArrayI_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}

// MARK: __NSFrozenArrayM
- (id)__NSFrozenArrayM_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSFrozenArrayM_safe_objectAtIndex:index];
    } else {
        CPError(@"-[__NSFrozenArrayM objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSFrozenArrayM_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSFrozenArrayM_safe_objectAtIndexedSubscript:index];
    } else {
        CPError(@"-[__NSFrozenArrayM objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSFrozenArrayM_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPError(@"-[__NSFrozenArrayM subarrayWithRange:], range NSNotFound", nil);
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSFrozenArrayM_safe_subarrayWithRange:range];
    } else {
        CPWarning(@"-[__NSFrozenArrayM subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSFrozenArrayM_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSFrozenArrayM_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSFrozenArrayM_safe_arrayByAddingObject:anObject];
    } else {
        CPError(@"-[__NSFrozenArrayM arrayByAddingObject:], object cannot be nil", nil);
        //return [self __NSFrozenArrayM_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}


// MARK: __NSArrayReversed
- (id)__NSArrayReversed_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSArrayReversed_safe_objectAtIndex:index];
    } else {
        CPError(@"-[__NSArrayReversed objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSArrayReversed_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArrayReversed_safe_objectAtIndexedSubscript:index];
    } else {
        CPError(@"-[__NSArrayReversed objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSArrayReversed_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPError(@"-[__NSArrayReversed subarrayWithRange:], range NSNotFound", nil);
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArrayReversed_safe_subarrayWithRange:range];
    } else {
        CPWarning(@"-[__NSArrayReversed subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArrayReversed_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArrayReversed_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArrayReversed_safe_arrayByAddingObject:anObject];
    } else {
        CPError(@"-[__NSArrayReversed arrayByAddingObject:], object cannot be nil", nil);
        //return [self __NSArrayReversed_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}


@end
