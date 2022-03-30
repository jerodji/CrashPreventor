# JJCrashGuard

[![Version](https://img.shields.io/cocoapods/v/RJSBridge.svg?style=flat)](https://cocoapods.org/pods/RJSBridge)
[![License](https://img.shields.io/cocoapods/l/CrashPreventor.svg?style=flat)](https://cocoapods.org/pods/RJSBridge)
[![Platform](https://img.shields.io/cocoapods/p/CrashPreventor.svg?style=flat)](https://cocoapods.org/pods/CrashPreventor)

## Installation

0.1.0 版本：

```ruby
pod 'CrashPreventor', '0.1.0'
```

0.2.0 版本以后，更新中...

```ruby
pod 'JJCrashGuard'
```

## Introduce

Crash防护框架，无感知，无入侵。

目前支持如下的 crash 防护

- NSArray 类簇
- NSMutableArray 类簇
- NSDictionary 类簇
- NSMutableDictionary 类簇
-  KVC
-  方法没有实现

其它支持正在更新中...

## Use

开启所有防护。

```objc
// open crash prevent
[[JJCrashGuard shared] beginGuard];
```

也可以选择需要的防护类型：

```objc
[[JJCrashGuard shared] beginGuardTypes:JShieldTypeDictionary | JShieldTypeKVC | JShieldTypeArray];
```



设置日志级别：

```objc
[JJCrashGuard shared].logLevel = JShieldLogLevelError;
```



可以打开断言调试，Release模式下此设置无效

```objc
// open assert to help debug, it's not work on release
[JJCrashGuard shared].debugger = YES;
```



如果需要获取日志信息，或者上报日志，需要给 `JJCrashGuard` 实现代理，第一个参数是日志信息，第二个参数是堆栈信息。

```objc

// 0.2.0 之前版本通过扩展重写 reportLog:stackInfo: 方法
@implementation JJCrashGuard (report)

- (void)reportLog:(NSString*)log stackInfo:(NSString*)info {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"扩展, 自己的上报方法, %@", log);
    });
}

@end
  
  
// 0.3.0 之后版本通过代理获取日志信息

  [JJCrashGuard shared].delegate = self;

- (void)errorMsg:(NSString *)msg stackInfo:(NSString *)info {
    NSLog(@"1111 %@", msg);
}
- (void)warningMsg:(NSString *)msg stackInfo:(NSString *)info {
    NSLog(@"2222 %@", msg);
}
- (void)infoMsg:(NSString *)msg stackInfo:(NSString *)info {
    NSLog(@"3333 %@", msg);
}
  
```





## Author

Jerod, jjd510@163.com

## License

CrashPreventor is available under the MIT license. See the LICENSE file for more info.
