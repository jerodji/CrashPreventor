//
//  ViewController.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "ViewController.h"
#import "CFuns.hpp"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemPinkColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"enter app ---");
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ccfuns(22);
}


@end
