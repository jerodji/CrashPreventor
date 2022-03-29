//
//  JJCrashGuard+handleError.m
//  JJCrashGuard
//
//  Created by CN210208396 on 2022/3/26.
//

#import "JJCrashGuard+handleError.h"

@implementation JJCrashGuard (handleError)

- (void)handleInfoMsg:(NSString*)msg {
    if ([JJCrashGuard shared].delegate && [[JJCrashGuard shared].delegate respondsToSelector:@selector(infoMsg:stackInfo:)]) {
        [[JJCrashGuard shared].delegate infoMsg:msg stackInfo:nil];
    }
}

- (void)handleWarningMsg:(NSString*)msg {
    if ([JJCrashGuard shared].delegate && [[JJCrashGuard shared].delegate respondsToSelector:@selector(warningMsg:stackInfo:)]) {
        [[JJCrashGuard shared].delegate warningMsg:msg stackInfo:nil];
    }
}

- (void)handleErrorMsg:(NSString*)msg {
    if([JJCrashGuard shared].debugger) {
        NSAssert(NO, msg);
    }
    if ([JJCrashGuard shared].delegate && [[JJCrashGuard shared].delegate respondsToSelector:@selector(errorMsg:stackInfo:)]) {
        [[JJCrashGuard shared].delegate errorMsg:msg stackInfo:nil];
    }
}

@end
