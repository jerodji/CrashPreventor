//
//  AppDelegate.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "AppDelegate.h"
#import <CrashPreventor/CrashPreventor.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // open crash prevent
    [[CrashPreventor shared] openPreventor];
    
    // open assert to help debug, it's not work on release
    [[CrashPreventor shared] openDebuggerAssert:YES];
    
    
    return YES;
}





@end
