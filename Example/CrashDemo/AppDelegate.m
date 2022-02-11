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
    id obj = arr[5];
//    NSLog(@"");
    
    
    return YES;
}





@end
