//
//  JJCrashGuard+report.m
//  CrashDemo
//
//  Created by CN210208396 on 2022/2/10.
//

#import "JJCrashGuard+report.h"

@implementation JJCrashGuard (report)

- (void)report:(NSString*)info {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%s 扩展, 自己的上报方法, %@", __func__, info);        
    });
}

@end
