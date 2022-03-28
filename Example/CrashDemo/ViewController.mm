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
        @"NSArray",
        @"NSMutableArray",
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
    if ([n isEqualToString:@"NSArray"]) {
        NSArray * arr = @[@1, @2];
        id obj1 = arr[5];
        id obj = [arr objectAtIndex:3];
    }
    if ([n isEqualToString:@"NSMutableArray"]) {
//        NSMutableArray *mut = [NSMutableArray arrayWithArray:@[@0,@1]];//__NSArrayM
//        NSMutableArray *mut = [NSMutableArray arrayWithArray:@[@0]];//__NSArrayM
//        NSMutableArray *mut = [NSMutableArray array];//__NSArrayM
//        NSMutableArray *mut = [[NSMutableArray alloc] init];//__NSArrayM
        NSMutableArray *mut = [NSMutableArray arrayWithCapacity:1];//__NSArrayM
        NSLog(@"%@", mut.class);
//        id el = [mut objectAtIndex:7];
//        id nu = mut[113];
//        [mut insertObject:nil atIndex:3];
    }
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
