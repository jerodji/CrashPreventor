//
//  JJCrashGuard+handleError.h
//  JJCrashGuard
//
//  Created by CN210208396 on 2022/3/26.
//

#import <JJCrashGuard/JJCrashGuard.h>

@interface JJCrashGuard (handleError)
- (void)handleInfoMsg:(NSString*)msg;
- (void)handleWarningMsg:(NSString*)msg;
- (void)handleErrorMsg:(NSString*)msg;
@end
