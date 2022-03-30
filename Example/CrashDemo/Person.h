//
//  Person.h
//  CrashDemo
//
//  Created by CN210208396 on 2022/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

+ (void)existClassMethod:(NSString*)str;
- (void)existInstanceMethod:(NSString*)str;

+ (void)noExistClassMethod:(NSString*)str;
- (void)noExistInstanceMethod:(NSString*)str;

@end

NS_ASSUME_NONNULL_END
