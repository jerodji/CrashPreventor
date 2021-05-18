# CrashPreventor

[![Version](https://img.shields.io/cocoapods/v/RJSBridge.svg?style=flat)](https://cocoapods.org/pods/RJSBridge)
[![License](https://img.shields.io/cocoapods/l/CrashPreventor.svg?style=flat)](https://cocoapods.org/pods/RJSBridge)
[![Platform](https://img.shields.io/cocoapods/p/CrashPreventor.svg?style=flat)](https://cocoapods.org/pods/CrashPreventor)



## Installation

```ruby
pod 'CrashPreventor'
```

## Introduce

Crash防护框架，无感知，无乳入侵。

目前支持 NSArray，NSMutableArrat，NSDictionary，NSMutableDictionary.

其它支持正在更新中...

## Use

```objc
// open crash prevent
// 开启防护
[[CrashPreventor shared] openPreventor];

// open assert to help debug, it's not work on release
// 是否打开断言帮助调试，Release模式下此设置无效。
[[CrashPreventor shared] openDebuggerAssert:YES];
```



## Author

Jerod, jjd510@163.com

## License

CrashPreventor is available under the MIT license. See the LICENSE file for more info.
