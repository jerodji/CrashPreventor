//
//  NSArray+preventor.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "NSArray+preventor.h"
#import "CrashPreventor.h"


@implementation NSArray (preventor)

+ (void)openCrashPreventor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // NSArray 的类簇
        // __NSArray0: 没内容
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        swizzling_instance_method(__NSArray0, @selector(objectAtIndex:), @selector(__NSArray0_safe_objectAtIndex:));
        swizzling_instance_method(__NSArray0, @selector(objectAtIndexedSubscript:), @selector(__NSArray0_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArray0, @selector(subarrayWithRange:), @selector(__NSArray0_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArray0, @selector(arrayByAddingObject:), @selector(__NSArray0_safe_arrayByAddingObject:));
        
        // __NSArrayI: 内容obj类型
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        swizzling_instance_method(__NSArrayI, @selector(objectAtIndex:), @selector(__NSArrayI_safe_objectAtIndex:));
        swizzling_instance_method(__NSArrayI, @selector(objectAtIndexedSubscript:), @selector(__NSArrayI_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArrayI, @selector(subarrayWithRange:), @selector(__NSArrayI_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArrayI, @selector(arrayByAddingObject:), @selector(__NSArrayI_safe_arrayByAddingObject:));
        
        //__NSPlaceholderArray
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");
        swizzling_instance_method(__NSPlaceholderArray, @selector(initWithObjects:count:), @selector(__NSPlaceholderArray_safe_initWithObjects:count:));
        
        
        // __NSArrayI_Transfer : 内容obj类型
        Class __NSArrayI_Transfer = NSClassFromString(@"__NSArrayI_Transfer");
        swizzling_instance_method(__NSArrayI_Transfer, @selector(objectAtIndex:), @selector(__NSArrayI_Transfer_safe_objectAtIndex:));
        swizzling_instance_method(__NSArrayI_Transfer, @selector(objectAtIndexedSubscript:), @selector(__NSArrayI_Transfer_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArrayI_Transfer, @selector(subarrayWithRange:), @selector(__NSArrayI_Transfer_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArrayI_Transfer, @selector(arrayByAddingObject:), @selector(__NSArrayI_Transfer_safe_arrayByAddingObject:));
        
        // __NSSingleObjectArrayI: iOS10 以上单个内容
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(objectAtIndex:), @selector(__NSSingleObjectArrayI_safe_objectAtIndex:));
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(objectAtIndexedSubscript:), @selector(__NSSingleObjectArrayI_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(subarrayWithRange:), @selector(__NSSingleObjectArrayI_safe_subarrayWithRange:));
        swizzling_instance_method(__NSSingleObjectArrayI, @selector(arrayByAddingObject:), @selector(__NSSingleObjectArrayI_safe_arrayByAddingObject:));
        
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
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArray0 objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSArray0_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArray0_safe_objectAtIndexedSubscript:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArray0 objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSArray0_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArray0 subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArray0_safe_subarrayWithRange:range];
    } else {
        NSLog(@"*** [CrashPreventor]: warning: -[__NSArray0 subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArray0_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArray0_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArray0_safe_arrayByAddingObject:anObject];
    } else {
        //return [self __NSArray0_safe_arrayByAddingObject:[NSNull null]];
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArray0 arrayByAddingObject:], object can not be nil");
        return self;
    }
}

// MARK: __NSArrayI
- (id)__NSArrayI_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSArrayI_safe_objectAtIndex:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSArrayI_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArrayI_safe_objectAtIndexedSubscript:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSArrayI_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArrayI_safe_subarrayWithRange:range];
    } else {
        NSLog(@"*** [CrashPreventor]: warning: -[__NSArrayI subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArrayI_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArrayI_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArrayI_safe_arrayByAddingObject:anObject];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI arrayByAddingObject:], object cannot be nil");
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
                NSLog(@"*** [CrashPreventor] warning, -[__NSPlaceholderArray initWithObjects:count:], object cannot be nil at %d", i);
            }
        }
        return [self __NSPlaceholderArray_safe_initWithObjects:newObjs count:newCnt];
    } else {
        return [self __NSPlaceholderArray_safe_initWithObjects:NULL count:0];
    }
}

// MARK: __NSArrayI_Transfer
- (id)__NSArrayI_Transfer_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSArrayI_Transfer_safe_objectAtIndex:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI_Transfer objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSArrayI_Transfer_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArrayI_Transfer_safe_objectAtIndexedSubscript:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI_Transfer objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSArrayI_Transfer_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI_Transfer subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArrayI_Transfer_safe_subarrayWithRange:range];
    } else {
        NSLog(@"*** [CrashPreventor]: warning: -[__NSArrayI_Transfer subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArrayI_Transfer_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArrayI_Transfer_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArrayI_Transfer_safe_arrayByAddingObject:anObject];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayI_Transfer arrayByAddingObject:], object cannot be nil");
        //return [self __NSArrayI_Transfer_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}

// MARK: __NSSingleObjectArrayI
- (id)__NSSingleObjectArrayI_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSSingleObjectArrayI_safe_objectAtIndex:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSSingleObjectArrayI objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSSingleObjectArrayI_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSSingleObjectArrayI_safe_objectAtIndexedSubscript:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSSingleObjectArrayI objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSSingleObjectArrayI_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSSingleObjectArrayI subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSSingleObjectArrayI_safe_subarrayWithRange:range];
    } else {
        NSLog(@"*** [CrashPreventor]: warning: -[__NSSingleObjectArrayI subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSSingleObjectArrayI_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSSingleObjectArrayI_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSSingleObjectArrayI_safe_arrayByAddingObject:anObject];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSSingleObjectArrayI arrayByAddingObject:], object cannot be nil");
        //return [self __NSSingleObjectArrayI_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}

// MARK: __NSFrozenArrayM
- (id)__NSFrozenArrayM_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSFrozenArrayM_safe_objectAtIndex:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSFrozenArrayM objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSFrozenArrayM_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSFrozenArrayM_safe_objectAtIndexedSubscript:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSFrozenArrayM objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSFrozenArrayM_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSFrozenArrayM subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSFrozenArrayM_safe_subarrayWithRange:range];
    } else {
        NSLog(@"*** warning: [CrashPreventor]: -[__NSFrozenArrayM subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSFrozenArrayM_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSFrozenArrayM_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSFrozenArrayM_safe_arrayByAddingObject:anObject];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSFrozenArrayM arrayByAddingObject:], object cannot be nil");
        //return [self __NSFrozenArrayM_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}


// MARK: __NSArrayReversed
- (id)__NSArrayReversed_safe_objectAtIndex:(NSUInteger)index {

    if (0 <= index && index < self.count) {
        return [self __NSArrayReversed_safe_objectAtIndex:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayReversed objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (id)__NSArrayReversed_safe_objectAtIndexedSubscript:(NSInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArrayReversed_safe_objectAtIndexedSubscript:index];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayReversed objectAtIndexedSubscript:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}
- (NSArray*)__NSArrayReversed_safe_subarrayWithRange:(NSRange)range {
    if (self.count == 0) {
        return nil;
    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayReversed subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArrayReversed_safe_subarrayWithRange:range];
    } else {
        NSLog(@"*** [CrashPreventor]: warning: -[__NSArrayReversed subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArrayReversed_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}
- (NSArray *)__NSArrayReversed_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArrayReversed_safe_arrayByAddingObject:anObject];
    } else {
        CPAssert(NO, @"*** [CrashPreventor]: -[__NSArrayReversed arrayByAddingObject:], object cannot be nil");
        //return [self __NSArrayReversed_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}


@end
