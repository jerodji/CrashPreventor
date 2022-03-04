//
//  AppDelegate.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "AppDelegate.h"
#import <JJCrashGuard/JJCrashGuard.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    // open crash prevent
    [[JJCrashGuard shared] openShield];
//
//    // open assert to help debug, it's not work on release
//    [[JJCrashGuard shared] openDebuggerAssert:YES];
    

    NSArray * arr = @[@1, @2];
    id obj1 = arr[5];
    id obj = [arr objectAtIndex:3];
    NSLog(@"== obj = %@", obj);
    
    
    NSMutableArray *mut = [NSMutableArray arrayWithArray:arr];
    id el = [mut objectAtIndex:7];
    id nu = mut[113];
    
    NSLog(@"--- %@", el);
    NSLog(@"--- %@", nu);
    
    
    return YES;
}





@end
