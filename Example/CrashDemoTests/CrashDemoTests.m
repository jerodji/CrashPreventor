//
//  CrashDemoTests.m
//  CrashDemoTests
//
//  Created by Jerod on 2021/5/17.
//

#import <XCTest/XCTest.h>
#import <JJCrashGuard/JJCrashGuard.h>

@interface Human : NSObject
@property (nonatomic, copy) NSString *name;
@end
@implementation Human
- (NSString *)name {
    if (!_name) {
        _name = @"Jero";
    }
    return _name;
}
@end

@interface CrashDemoTests : XCTestCase
@property (nonatomic, strong) NSArray *arr;
@end

@implementation CrashDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    Human * a = [Human new];
    Human * b = [Human new]; b.name = @"Tom";
    self.arr = @[a, b];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testArr {
//    id obj = [self.arr objectAtIndex:3];
//    NSLog(@" >>>>> %@", obj);
    
    NSString * k = nil;
    NSArray * ks = @[@"nono", k, @"qwe"];
    NSLog(@"ks %@", ks);
    
    NSArray * aa = [[NSArray alloc] initWithObjects:nil count:3];
    NSLog(@"aa %@", aa);
}

- (void)testDic {
//    NSDictionary * dic = [NSDictionary dictionaryWithObject:nil forKey:@"kkk"];//Thread 1: "*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]"
    
//    NSDictionary * dic = @{@"kkk": @"vvv"};//__NSSingleEntryDictionaryI
//    NSDictionary* dic = [NSDictionary dictionary]; // !!!: __NSDictionary0
//    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:@{@"kkk": @"vvv"}];//__NSSingleEntryDictionaryI
//    NSDictionary * dic1= [[NSDictionary alloc] initWithDictionary:@{@"kkk": @"vvv"}];//__NSSingleEntryDictionaryI
//    NSDictionary * dic2= [[NSDictionary alloc] initWithObjectsAndKeys:@"kkk", @"vvv", nil];//__NSSingleEntryDictionaryI
//    [dic setValue:@"vvv" forKey:@"kkk"]; // !!!: crash, wait to preventor
    NSDictionary * dic = [[NSDictionary alloc] initWithObjects:@[@"a", @"b"] forKeys:@[@"k1", @"k2", @"k3"]];//__NSDictionaryI, Thread 1: "*** -[NSDictionary initWithObjects:forKeys:]: count of objects (2) differs from count of keys (3)"
    
    
//    NSDictionary * dic = [[NSDictionary alloc] initWithObjects:nil forKeys:nil];
    
    NSLog(@"--- >>> dic %@", dic);
    
//    id obj = [dic objectForKey:nil];
//    id obj = dic[nil];
//    NSLog(@"%@", obj);
}


- (void)testMutableDic {
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary]; // __NSDictionaryM
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"a":@"b"}];
    [dic setObject:@"vvv" forKey:@"kkk"];
//    id obj = [dic objectForKey:nil];
//    [dic setObject:nil forKey:@"dd"];//Thread 1: "*** -[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: dd)"
//    [dic setObject:@"sdf" forKey:nil]; //Thread 1: "*** -[__NSDictionaryM setObject:forKey:]: key cannot be nil"
    dic[@"qwe"] = @"qwe";
    NSLog(@">>> %@", dic);
//    NSLog(@">>>>> %@", obj);
    dic[@"asd"] = nil;// ok, do nothing
//    dic[nil] = @"zxc";// Thread 1: "*** -[__NSDictionaryM setObject:forKeyedSubscript:]: key cannot be nil"
    
//    [dic removeObjectForKey:nil];//Thread 1: "*** -[__NSDictionaryM removeObjectForKey:]: key cannot be nil"
//    [dic removeObjectForKey:@"nono"];
    
    NSString * k = nil;
    NSArray * ks = @[@"nono", k];
    [dic removeObjectsForKeys:ks];
    [dic removeObjectsForKeys:nil];
    
    NSLog(@">>> %@", dic);
}

@end
