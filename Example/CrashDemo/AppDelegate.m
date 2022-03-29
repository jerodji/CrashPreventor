//
//  AppDelegate.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "AppDelegate.h"
#import <JJCrashGuard/JJCrashGuard.h>

void handleUncaughtException(NSException *exception) {
    NSString * crashInfo = [NSString stringWithFormat:@"[] Exception name：%@\nException reason：%@\nException stack：%@",[exception name], [exception reason], [exception callStackSymbols]];
    NSLog(@"%@", crashInfo);
}

void InstallUncaughtExceptionHandler(void) {
    NSSetUncaughtExceptionHandler( &handleUncaughtException );
}


@interface AppDelegate ()<JShieldLogDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    InstallUncaughtExceptionHandler();
      
    // open crash prevent
    [[JJCrashGuard shared] beginGuard];
    //[[JJCrashGuard shared] beginGuardTypes:JShieldTypeDictionary | JShieldTypeKVC | JShieldTypeArray];
    [JJCrashGuard shared].logLevel = JShieldLogLevelWarning;
    [JJCrashGuard shared].delegate = self;
    //[JJCrashGuard shared].debugger = YES;// open assert to help debug, it's not work on release
    
    return YES;
}



//JShieldLogDelegate
- (void)errorMsg:(NSString *)msg stackInfo:(NSString *)info {
    NSLog(@"1111 %@", msg);
}
- (void)warningMsg:(NSString *)msg stackInfo:(NSString *)info {
    NSLog(@"2222 %@", msg);
}
- (void)infoMsg:(NSString *)msg stackInfo:(NSString *)info {
    NSLog(@"3333 %@", msg);
}



@end
