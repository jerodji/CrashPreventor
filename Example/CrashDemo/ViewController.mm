//
//  ViewController.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "ViewController.h"
#import "CFuns.hpp"



@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemPinkColor];    
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (NSArray*)names {
    return @[
        @"__NSPlaceholderArray",
        @"__NSArray0",
        @"__NSSingleObjectArrayI",
        @"__NSArrayI",
        @"__NSArrayM",
        @"__NSPlaceholderDictionary",
        @"__NSDictionary0",
        @"__NSSingleEntryDictionaryI",
        @"__NSDictionaryI",
        @"__NSDictionaryM",
        @"KVC"
    ];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell_id"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self names].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    cell.textLabel.text = [self names][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * n = [self names][indexPath.item];
    // MARK: Array
    if ([n isEqualToString:@"__NSPlaceholderArray"]) {
        NSArray *arr = [NSArray alloc];
        NSLog(@"%@", arr.class);
        [arr objectAtIndex:0];//*** -[NSArray objectAtIndex:]: method sent to an uninitialized immutable array object"
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%lu: %@", (unsigned long)idx, obj);
        }];
    }
    if ([n isEqualToString:@"__NSArray0"]) {
//        NSArray *arr = [NSArray new];
        NSArray *arr = [NSArray array];
//        NSArray *arr = [[NSArray alloc] init];
        NSLog(@"%@", arr.class);
        id v1 = [arr objectAtIndex:1];//*** -[__NSArray0 objectAtIndex:]: index 0 beyond bounds for empty NSArray
        NSLog(@"v1:%@", v1);
        
        id v2 = [arr objectsAtIndexes:[NSIndexSet indexSetWithIndex:2]];//*** -[NSArray objectsAtIndexes:]: index 1 in index set beyond bounds for empty array
        NSLog(@"v2: %@", v2);
        
        id v3 = [arr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)]];//*** -[NSArray objectsAtIndexes:]: index 2 in index set beyond bounds [0 .. 1]
        NSLog(@"v3: %@", v3);
                
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%lu: %@", (unsigned long)idx, obj);
        }];
        
//        id *objects;
//        NSUInteger count = [arr count];
//        objects = malloc(sizeof(id) * count);
//        [arr getObjects:objects];
//        for (int i = 0; i < count; i++) {
//            NSLog(@"object at index %d: %@", i, objects[i]);
//        }
//        free(objects);
        
    }
    if ([n isEqualToString:@"__NSSingleObjectArrayI"]) {
        NSArray *arr = @[@1];
        NSLog(@"%@", arr.class);
    }
    if ([n isEqualToString:@"__NSArrayI"]) {
        NSArray *arr = @[@1, @2, @3];
        NSLog(@"%@", arr.class);
        id v1 = [arr objectAtIndex:2];//*** -[__NSArray0 objectAtIndex:]: index 2 beyond bounds for empty NSArray
        NSLog(@"v1:%@", v1);
        
        id v2 = [arr objectsAtIndexes:[NSIndexSet indexSetWithIndex:3]];//*** -[NSArray objectsAtIndexes:]: index 3 in index set beyond bounds [0 .. 1]
        NSLog(@"v2: %@", v2);
        
        id v3 = [arr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)]];//*** -[NSArray objectsAtIndexes:]: index 2 in index set beyond bounds [0 .. 1]
        NSLog(@"v3: %@", v3);
        
        NSInteger v4 = [arr indexOfObject:@3];
        NSLog(@"v4: %ld", (long)v4);//9223372036854775807
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%lu: %@", (unsigned long)idx, obj);
        }];
        
        
//        id *objects;
//        NSRange range = NSMakeRange(1, 2);
//        objects = malloc(sizeof(id) * range.length);
//        [arr getObjects:objects range:range];
//        for (int i = 0; i < range.length; i++) {
//            NSLog(@"objects: %@", objects[i]);
//        }
//        free(objects);
        
    }
    if ([n isEqualToString:@"__NSArrayM"]) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@0,@1]];//__NSArrayM
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@0]];//__NSArrayM
//        NSMutableArray *arr = [NSMutableArray array];//__NSArrayM
//        NSMutableArray *arr = [[NSMutableArray alloc] init];//__NSArrayM
//        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];//__NSArrayM
//        NSMutableArray *arr = [NSMutableArray new];
        NSLog(@"%@", arr.class);
        id el = [arr objectAtIndex:7];
        id nu = arr[113];
        arr[1] = @11;
        arr[1] = nil;//*** -[__NSArrayM setObject:atIndexedSubscript:]: object cannot be nil
        arr[20] = @20;//*** -[__NSArrayM setObject:atIndexedSubscript:]: index 20 beyond bounds [0 .. 1]
        [arr addObject:nil];
        [arr addObject:@2];
        [arr addObjectsFromArray:nil];
        [arr arrayByAddingObject:@31];
        [arr arrayByAddingObject:nil];
        [arr insertObject:@3 atIndex:3];
        [arr insertObject:nil atIndex:30];
        NSLog(@"%@", arr);
//        [arr insertObjects:@[@5,@6] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 2)]]; // ✅
//        [arr insertObjects:@[@5,@6] atIndexes:nil];//*** -[NSMutableArray insertObjects:atIndexes:]: index set cannot be nil
//        [arr insertObjects:nil atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)]];//*** -[NSMutableArray insertObjects:atIndexes:]: count of array (0) differs from count of index set (2)
//        [arr insertObjects:nil atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 2)]];//*** -[NSMutableArray insertObjects:atIndexes:]: index 5 in index set beyond bounds [0 .. 3]
//        [arr insertObjects:@[@4] atIndexes:[NSIndexSet indexSetWithIndex:4]];//✅
//        [arr insertObjects:@[@4, @5] atIndexes:[NSIndexSet indexSetWithIndex:4]];//*** -[NSMutableArray insertObjects:atIndexes:]: count of array (2) differs from count of index set (1)
//        [arr insertObjects:@[@5] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 2)]];//*** -[NSMutableArray insertObjects:atIndexes:]: index 5 in index set beyond bounds [0 .. 4]
//        [arr insertObjects:@[@4,@5,@6] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 2)]];//*** -[NSMutableArray insertObjects:atIndexes:]: count of array (3) differs from count of index set (2)
//        [arr insertObjects:@[] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 2)]];//*** -[NSMutableArray insertObjects:atIndexes:]: index 5 in index set beyond bounds [0 .. 3]
//        [arr insertObjects:@[@4,@5] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 2)]];//✅
//        [arr insertObjects:@[@4,@5] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 2)]];//*** -[NSMutableArray insertObjects:atIndexes:]: index 6 in index set beyond bounds [0 .. 5]
//        [arr insertObjects:@[@5,@6] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 3)]];//*** -[NSMutableArray insertObjects:atIndexes:]: index 6 in index set beyond bounds [0 .. 5]
//        [arr insertObjects:@[@5,@6] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, -2)]];//Thread 1: "*** -[NSMutableArray insertObjects:atIndexes:]: count of array (2) differs from count of index set (18446744073709551614)"
        NSLog(@"%@", arr);
        [arr removeObject:@4];
        [arr removeObjectAtIndex:5];
        [arr removeObject:@1 inRange:NSMakeRange(5, 2)];
        [arr removeObjectsInArray:@[@1]];
        [arr removeObjectsAtIndexes:nil];
        [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:4]];//*** -[NSMutableArray removeObjectsAtIndexes:]: index 4 in index set beyond bounds [0 .. 1]
        [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 3)]];
        [arr removeObjectsInRange:NSMakeRange(4, 3)];
        NSLog(@"%@", arr);
        
    }
    // MARK: Dictionary
    if ([n isEqualToString:@"__NSPlaceholderDictionary"]) {
        NSDictionary *dic = [NSDictionary alloc];
        NSLog(@"%@", dic.class);
        
        [dic setValue:@"1" forKey:@"11"];//*** -[NSDictionary setObject:forKey:]: method sent to an uninitialized immutable dictionary object
        NSLog(@"%@", dic.class);
        
        NSLog(@"allKeys: %@", dic.allKeys);//*** -[NSDictionary count]: method sent to an uninitialized immutable dictionary object
        
        //NSString *key = nil;
        NSString *key = @"kkp";
        id v1 = [dic objectForKey:key];//*** -[NSDictionary objectForKey:]: method sent to an uninitialized immutable dictionary object
        NSLog(@"v1: %@", v1);
        id v2 = dic[key];
        NSLog(@"v2: %@", v2);
    }
    if ([n isEqualToString:@"__NSDictionary0"]) { //空字典
        
        NSDictionary *dic = [[NSDictionary alloc] init];
//        NSDictionary *dic = [NSDictionary dictionary];
//        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:nil, nil, nil];
//        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:nil forKeys:@[@"a", @"b"]];
//        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[@1, @2] forKeys:nil];
//        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:nil];
//        NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:nil];

        NSLog(@"%@", dic.class);
        [dic setValue:@1 forKey:@"k1"];
        [dic setValue:nil forKey:@"knil"];
        NSLog(@"%@", dic.class);
        NSLog(@"allKeys : %@", dic.allKeys);
        id v1 = [dic objectForKey:@"kk"];
        NSLog(@"v1 : %@", v1);
        id v2 = dic[@"k"];
        NSLog(@"v2: %@", v2);
        id v3 = [dic valueForKey:@"ll"];
        NSLog(@"v3 : %@", v3);
    }
    if ([n isEqualToString:@"__NSSingleEntryDictionaryI"]) { //只有一个元素
        NSDictionary *dic = @{
            @"a": @1
        };
        NSLog(@"%@", dic.class);
        [dic setValue:@1 forKey:@"k1"];
        [dic setValue:nil forKey:@"knil"];
        NSLog(@"%@", dic.class);
        NSLog(@"allKeys : %@", dic.allKeys);
        id v1 = [dic objectForKey:@"kk"];
        NSLog(@"v1 : %@", v1);
        id v2 = dic[@"k"];
        NSLog(@"v2: %@", v2);
        id v3 = [dic valueForKey:@"ll"];
        NSLog(@"v3 : %@", v3);
    }
    if ([n isEqualToString:@"__NSDictionaryI"]) { //多个元素
        NSDictionary *dic = @{
            @"a": @1, @"b": @2
        };
        NSLog(@"%@", dic.class);
        [dic setValue:@1 forKey:@"k1"];
        [dic setValue:nil forKey:@"knil"];
        NSLog(@"%@", dic.class);
        NSLog(@"allKeys : %@", dic.allKeys);
        id v1 = [dic objectForKey:@"kk"];
        NSLog(@"v1 : %@", v1);
        id v2 = dic[@"k"];
        NSLog(@"v2: %@", v2);
        id v3 = [dic valueForKey:@"ll"];
        NSLog(@"v3 : %@", v3);
    }
    
    if ([n isEqualToString:@"__NSDictionaryM"]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];//__NSDictionaryM
        NSLog(@"%@", dic.class);
        [dic setValue:@"1" forKey:@"11"];
        [dic setObject:@"po" forKey:@"po"];
//        [dic setObject:nil forKey:@"pp"];
//        [dic setObject:@"oo" forKey:nil];
        [dic setObject:nil forKeyedSubscript:@"oo"];
//        [dic setObject:@"qq" forKeyedSubscript:nil];
        [dic objectForKey:@"22"];
        dic[@"99"];
        dic[@"33"] = [NSNull null];
        dic[@"44"] = nil;
        dic[@"100"] = @100;
        NSString * k101 = nil;
        dic[k101] = @101;
        NSLog(@"%@", dic);
        [dic removeObjectsForKeys:@[@"66"]];
        [dic removeObjectsForKeys:@[@"11", @"22", @"55"]];
        [dic removeObjectForKey:@"77"];
//        [dic removeObjectForKey:nil];
        [dic removeAllObjects];
    }
    // MARK: KVC
    if ([n isEqualToString:@"KVC"]) {
        NSObject *obj = [NSObject new];
//        [obj setValue:@1 forKey:@"uk"];
        [obj valueForKey:@"uu"];
    }
}


//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ccfuns(22);
//}


@end
