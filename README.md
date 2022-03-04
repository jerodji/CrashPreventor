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

目前支持 NSArray，NSMutableArrat，NSDictionary，NSMutableDictionary.

其它支持正在更新中...

## Use

开启所有防护。

```objc
// open crash prevent
[[JJCrashGuard shared] openShield];
```

也可以选择需要的防护类型：

```objc
[self openShieldWith:@[
    [NSArray class], [NSMutableArray class],
    [NSDictionary class], [NSMutableDictionary class]]
];
```



可以打开断言调试，Release模式下此设置无效

```objc
// open assert to help debug, it's not work on release
[[JJCrashGuard shared] openDebuggerAssert:YES];
```



如果需要上报日志，需要给 `JJCrashGuard` 增加一个扩展，重写下面的方法，第一个参数是日志信息，第二个参数是堆栈信息。

```objc
@implementation JJCrashGuard (report)

- (void)reportLog:(NSString*)log stackInfo:(NSString*)info {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"扩展, 自己的上报方法, %@", log);
    });
}

@end
```





## Author

Jerod, jjd510@163.com

## License

CrashPreventor is available under the MIT license. See the LICENSE file for more info.
