//
//  NSMutableArray+preventor.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "NSMutableArray+JJShield.h"
//#import "JJCrashGuard.h"
#import "JJShieldCFuncs.h"


@implementation NSMutableArray (JJCrashShield)

+ (void)openShield {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_instance_method([NSMutableArray class], @selector(insertObjects:atIndexes:), @selector(safe_insertObjects:atIndexes:));
        
        //__NSArrayM
        Class __NSArrayM = NSClassFromString(@"__NSArrayM");
        swizzling_instance_method(__NSArrayM, @selector(objectAtIndex:), @selector(__NSArrayM_safe_objectAtIndex:));
        swizzling_instance_method(__NSArrayM, @selector(objectAtIndexedSubscript:), @selector(__NSArrayM_safe_objectAtIndexedSubscript:));
        swizzling_instance_method(__NSArrayM, @selector(subarrayWithRange:), @selector(__NSArrayM_safe_subarrayWithRange:));
        swizzling_instance_method(__NSArrayM, @selector(arrayByAddingObject:), @selector(__NSArrayM_safe_arrayByAddingObject:));
        
        swizzling_instance_method(__NSArrayM, @selector(insertObject:atIndex:), @selector(__NSArrayM_safe_insertObject:atIndex:));
        swizzling_instance_method(__NSArrayM, @selector(removeObjectAtIndex:), @selector(__NSArrayM_safe_removeObjectAtIndex:));
        swizzling_instance_method(__NSArrayM, @selector(removeObject:inRange:), @selector(__NSArrayM_safe_removeObject:inRange:));
        swizzling_instance_method(__NSArrayM, @selector(removeObjectsInRange:), @selector(__NSArrayM_safe_removeObjectsInRange:));
        swizzling_instance_method(__NSArrayM, @selector(replaceObjectAtIndex:withObject:), @selector(__NSArrayM_safe_replaceObjectAtIndex:withObject:));
        
        //__NSCFArray
//        Class __NSCFArray = NSClassFromString(@"__NSCFArray");
//        swizzling_instance_method(__NSCFArray, @selector(objectAtIndex:), @selector(__NSCFArray_safe_objectAtIndex:));
//        swizzling_instance_method(__NSCFArray, @selector(objectAtIndexedSubscript:), @selector(__NSCFArray_safe_objectAtIndexedSubscript:));
//        swizzling_instance_method(__NSCFArray, @selector(subarrayWithRange:), @selector(__NSCFArray_safe_subarrayWithRange:));
//        swizzling_instance_method(__NSCFArray, @selector(arrayByAddingObject:), @selector(__NSCFArray_safe_arrayByAddingObject:));
//
//        swizzling_instance_method(__NSCFArray, @selector(insertObject:atIndex:), @selector(__NSCFArray_safe_insertObject:atIndex:));
//        swizzling_instance_method(__NSCFArray, @selector(removeObjectAtIndex:), @selector(__NSCFArray_safe_removeObjectAtIndex:));
//        swizzling_instance_method(__NSCFArray, @selector(removeObject:inRange:), @selector(__NSCFArray_safe_removeObject:inRange:));
//        swizzling_instance_method(__NSCFArray, @selector(removeObjectsInRange:), @selector(__NSCFArray_safe_removeObjectsInRange:));
//        swizzling_instance_method(__NSCFArray, @selector(replaceObjectAtIndex:withObject:), @selector(__NSCFArray_safe_replaceObjectAtIndex:withObject:));
        
    });
}

- (void)safe_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    if (!objects || !indexes) {
        CPAssert(NO, @"*** -[NSMutableArray insertObjects:atIndexs:]: objects or indexes can not be nil");
        return;
    }
    [self safe_insertObjects:objects atIndexes:indexes];
}

// MARK: __NSArrayM
- (id)__NSArrayM_safe_objectAtIndex:(NSUInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSArrayM_safe_objectAtIndex:index];
    } else {
        CPAssert(NO, @"*** -[__NSArrayM objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}

- (id)__NSArrayM_safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (0 <= idx && idx < self.count) {
        return [self __NSArrayM_safe_objectAtIndexedSubscript:idx];
    } else {
        CPAssert(NO, @"*** -[__NSArrayM objectAtIndexedSubscript:]: index %d beyond bounds [0 .. %d]", (int)idx, (int)self.count-1);
        return nil;
    }
}

- (NSArray *)__NSArrayM_safe_subarrayWithRange:(NSRange)range {
//    if (self.count == 0) {
//        CPAssert(NO, @"*** -[__NSArrayM subarrayWithRange:], array is empty.");
//        return nil;
//    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** -[__NSArrayM subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSArrayM_safe_subarrayWithRange:range];
    } else {
        CPAssert(NO, @"*** -[__NSArrayM subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSArrayM_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}

- (NSArray *)__NSArrayM_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSArrayM_safe_arrayByAddingObject:anObject];
    } else {
        CPAssert(NO, @"*** -[__NSArrayM arrayByAddingObject:], object cannot be nil");
        //return [self __NSArrayM_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}

// addObject,
- (void)__NSArrayM_safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (0 <= index && index <= self.count && anObject) { //最后一个index可以插入
        [self __NSArrayM_safe_insertObject:anObject atIndex:index];
    } else {
        if (anObject) {
            CPAssert(NO, @"*** -[__NSArrayM insertObject:atIndex:]: index %d beyond bounds [0 .. %d]", (int)index, (int)self.count-1);
        } else {
            CPAssert(NO, @"*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil");
        }
    }
}

- (void)__NSArrayM_safe_removeObjectAtIndex:(NSUInteger)index {
    if (0 <= index && index < self.count) {
        [self __NSArrayM_safe_removeObjectAtIndex:index];
    } else {
        CPAssert(NO, @"*** -[__NSArrayM removeObjectAtIndex:], index %d beyond bounds [0 .. %d]", (int)index, (int)self.count-1);
    }
}

- (void)__NSArrayM_safe_removeObject:(id)anObject inRange:(NSRange)range {
    if (!anObject) {
        CPAssert(NO, @"*** -[__NSArrayM removeObject:inRange], object can not be nil");
        return;
    }
    if (range.location < 0 || range.length < 0) {
        CPAssert(NO, @"*** -[__NSArrayM removeObject:inRange], range (%d, %d) invalid", (int)range.location, (int)range.length);
    } else if ((range.location + range.length) > self.count) {
        CPAssert(NO, @"*** -[__NSArrayM removeObject:inRange], range (%d, %d) beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        [self __NSArrayM_safe_removeObject:anObject inRange:NSMakeRange(range.location, self.count - range.location)];
    } else {
        [self __NSArrayM_safe_removeObject:anObject inRange:range];
    }
}

- (void)__NSArrayM_safe_removeObjectsInRange:(NSRange)range {
    if (range.location < 0 || range.length < 0) {
        CPAssert(NO, @"*** -[__NSArrayM removeObjectsInRange], range (%d, %d) invalid", (int)range.location, (int)range.length);
    } else if ((range.location + range.length) > self.count) {
        CPAssert(NO, @"*** -[__NSArrayM removeObjectsInRange], range (%d, %d) beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        [self __NSArrayM_safe_removeObjectsInRange:NSMakeRange(range.location, self.count - range.location)];
    } else {
        [self __NSArrayM_safe_removeObjectsInRange:range];
    }
}

- (void)__NSArrayM_safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (0 <= index && index < self.count && anObject) {
        [self __NSArrayM_safe_replaceObjectAtIndex:index withObject:anObject];
    } else {
        CPAssert(NO, @"*** -[__NSArrayM replaceObjectAtIndex:withObject:], bounds [0 ... %d], beyond bounds index %d or object is nil", (int)self.count-1, (int)index);
    }
}

/*
// MARK: __NSCFArray
- (id)__NSCFArray_safe_objectAtIndex:(NSUInteger)index {
    if (0 <= index && index < self.count) {
        return [self __NSCFArray_safe_objectAtIndex:index];
    } else {
        CPAssert(NO, @"*** -[__NSCFArray objectAtIndex:], count %d, __boundsFail: index %d beyond bounds", (int)self.count,(int)index);
        return nil;
    }
}

- (id)__NSCFArray_safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (0 <= idx && idx < self.count) {
        return [self __NSCFArray_safe_objectAtIndexedSubscript:idx];
    } else {
        CPAssert(NO, @"*** -[__NSCFArray objectAtIndexedSubscript:]: index %d beyond bounds [0 .. %d]", (int)idx, (int)self.count-1);
        return nil;
    }
}

- (NSArray *)__NSCFArray_safe_subarrayWithRange:(NSRange)range {
//    if (self.count == 0) {
//        CPAssert(NO, @"*** -[__NSCFArray subarrayWithRange:], array is empty.");
//        return nil;
//    }
    if (range.location >= NSNotFound || range.length >= NSNotFound) {
        CPAssert(NO, @"*** -[__NSCFArray subarrayWithRange:], range NSNotFound");
        return nil;
    };
    if ((range.location + range.length) <= self.count) {
        return [self __NSCFArray_safe_subarrayWithRange:range];
    } else {
        CPAssert(NO, @"*** -[__NSCFArray subarrayWithRange:], range location %d + length %d beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        return [self __NSCFArray_safe_subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
    return nil;
}

- (NSArray *)__NSCFArray_safe_arrayByAddingObject:(id)anObject {
    if (anObject) {
        return [self __NSCFArray_safe_arrayByAddingObject:anObject];
    } else {
        CPAssert(NO, @"*** -[__NSCFArray arrayByAddingObject:], object cannot be nil");
        //return [self __NSCFArray_safe_arrayByAddingObject:[NSNull null]];
        return self;
    }
}

// addObject,
- (void)__NSCFArray_safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (0 <= index && index <= self.count && anObject) { //最后一个index可以插入
        [self __NSCFArray_safe_insertObject:anObject atIndex:index];
    } else {
        if (anObject) CPAssert(NO, @"*** -[__NSCFArray insertObject:atIndex:]: index %d beyond bounds [0 .. %d]", (int)index, (int)self.count-1);
        else CPAssert(NO, @"*** -[__NSCFArray insertObject:atIndex:]: object cannot be nil");
    }
}

- (void)__NSCFArray_safe_removeObjectAtIndex:(NSUInteger)index {
    if (0 <= index && index < self.count) {
        [self __NSCFArray_safe_removeObjectAtIndex:index];
    } else {
        CPAssert(NO, @"*** -[__NSCFArray removeObjectAtIndex:], index %d beyond bounds [0 .. %d]", (int)index, (int)self.count-1);
    }
}

- (void)__NSCFArray_safe_removeObject:(id)anObject inRange:(NSRange)range {
    if (!anObject) {
        CPAssert(NO, @"*** -[__NSCFArray removeObject:inRange], object can not be nil");
        return;
    }
    if (range.location < 0 || range.length < 0) {
        CPAssert(NO, @"*** -[__NSCFArray removeObject:inRange], range (%d, %d) invalid", (int)range.location, (int)range.length);
    } else if ((range.location + range.length) > self.count) {
        CPAssert(NO, @"*** -[__NSCFArray removeObject:inRange], range (%d, %d) beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        [self __NSCFArray_safe_removeObject:anObject inRange:NSMakeRange(range.location, self.count - range.location)];
    } else {
        [self __NSCFArray_safe_removeObject:anObject inRange:range];
    }
}

- (void)__NSCFArray_safe_removeObjectsInRange:(NSRange)range {
    if (range.location < 0 || range.length < 0) {
        CPAssert(NO, @"*** -[__NSCFArray removeObjectsInRange], range (%d, %d) invalid", (int)range.location, (int)range.length);
    } else if ((range.location + range.length) > self.count) {
        CPAssert(NO, @"*** -[__NSCFArray removeObjectsInRange], range (%d, %d) beyond bounds [0..%d]", (int)range.location, (int)range.length, (int)self.count-1);
        [self __NSCFArray_safe_removeObjectsInRange:NSMakeRange(range.location, self.count - range.location)];
    } else {
        [self __NSCFArray_safe_removeObjectsInRange:range];
    }
}

- (void)__NSCFArray_safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (0 <= index && index < self.count && anObject) {
        [self __NSCFArray_safe_replaceObjectAtIndex:index withObject:anObject];
    } else {
        CPAssert(NO, @"*** -[__NSCFArray replaceObjectAtIndex:withObject:], bounds [0 ... %d], beyond bounds index %d or object is nil", (int)self.count-1, (int)index);
    }
}
*/



@end
