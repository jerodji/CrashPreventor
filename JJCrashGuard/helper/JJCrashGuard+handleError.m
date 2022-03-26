//
//  JJCrashGuard+handleError.m
//  JJCrashGuard
//
//  Created by CN210208396 on 2022/3/26.
//

#import "JJCrashGuard+handleError.h"

@implementation JJCrashGuard (handleError)

- (void)handleInfoMsg:(NSString*)msg {
    NSLog(@"%@", msg);
}

- (void)handleWarningMsg:(NSString*)msg {
    NSLog(@"%@", msg);
}

- (void)handleErrorMsg:(NSString*)msg {
    NSLog(@"%@", msg);
    if([JJCrashGuard shared].debugger) {
        NSAssert(NO, msg);
    }
    [[JJCrashGuard shared] reportLog:msg stackInfo:nil];
}

@end
