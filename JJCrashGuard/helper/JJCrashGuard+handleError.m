//
//  JJCrashGuard+handleError.m
//  JJCrashGuard
//
//  Created by CN210208396 on 2022/3/26.
//

#import "JJCrashGuard+handleError.h"

@implementation JJCrashGuard (handleError)

- (void)handleInfoMsg:(NSString*)msg {
    if ([JJCrashGuard shared].delegate && [[JJCrashGuard shared].delegate respondsToSelector:@selector(shieldLogInfoMsg:stackInfo:)]) {
        [[JJCrashGuard shared].delegate shieldLogInfoMsg:msg stackInfo:nil];
    }
}

- (void)handleWarningMsg:(NSString*)msg {
    if ([JJCrashGuard shared].delegate && [[JJCrashGuard shared].delegate respondsToSelector:@selector(shieldLogWarningMsg:stackInfo:)]) {
        [[JJCrashGuard shared].delegate shieldLogWarningMsg:msg stackInfo:nil];
    }
}

- (void)handleErrorMsg:(NSString*)msg {
    if([JJCrashGuard shared].debugger) {
        NSAssert(NO, msg);
    }
    if ([JJCrashGuard shared].delegate && [[JJCrashGuard shared].delegate respondsToSelector:@selector(shieldLogErrorMsg:stackInfo:)]) {
        [[JJCrashGuard shared].delegate shieldLogErrorMsg:msg stackInfo:nil];
    }
}

@end
