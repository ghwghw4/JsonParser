# JsonParser

[![CI Status](https://img.shields.io/travis/龚海伟/JsonParser.svg?style=flat)](https://travis-ci.org/龚海伟/JsonParser)
[![Version](https://img.shields.io/cocoapods/v/JsonParser.svg?style=flat)](https://cocoapods.org/pods/JsonParser)
[![License](https://img.shields.io/cocoapods/l/JsonParser.svg?style=flat)](https://cocoapods.org/pods/JsonParser)
[![Platform](https://img.shields.io/cocoapods/p/JsonParser.svg?style=flat)](https://cocoapods.org/pods/JsonParser)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 介绍

`JsonParser`专门用来处理在Objective-C中自动将Json数据转换成对象实例的类库。支持嵌套对象的解析、支持数组的解析、支持自定义属性名称到Json key的映射。一行代码就能搞定。

## 示例

1. Step1 。首先是需要了解json的定义，这样才能知道如何定义我们的数据结构。这里直接贴一段json 示例，里面包含了所有当前类库能够支持的数据类型。

```json
{
    "testInt8": -23,
    "testInt16": -1234,
    "testInt32": -1234,
    "testInt": -1234,
    "testUInt8": 23,
    "testUInt16": 1234,
    "testUInt32": 1234,
    "testUInt": 1234,
    "testDouble": 3.1415926,
    "testFloat": 3.1415926,
    "testBool": true,
    "testNumber": 6789,
    "testString": "hello",
    "testStringToInt": "123",
    "testStringToBool": "1",
    "testNumberToString": 3.1415926,
    "testCustomObject": {
        "id": 12,
        "name": "海伟"
    },
    "testDict": {
        "a": 1,
        "b": "b"
    },
    "testArrayObject": [{
                        "id": 1,
                        "name": "海伟1"
                        }, {
                        "id": 2,
                        "name": "海伟2"
                        }],
    "testArrayString": ["a", "b", "c"],
    "testArrayNumber": [1, -2, 3.1315],
    "testCustomPropertyNameMap": "CustomPropertyName"
}

```

2. Step2 定义对应的数据结构。下面贴出按照上面的json对应的Objective-C数据结构的定义，涉及到两个类

```objective-c
#import <JsonParser/GICJsonParserDelegate.h>

@interface TestObject : NSObject<GICJsonParserDelegate>
@property (nonatomic,assign)int8_t testInt8;
@property (nonatomic,assign)int16_t testInt16;
@property (nonatomic,assign)int32_t testInt32;
@property (nonatomic,assign)NSInteger testInt;

@property (nonatomic,assign)uint8_t testUInt8;
@property (nonatomic,assign)uint16_t testUInt16;
@property (nonatomic,assign)uint32_t testUInt32;
@property (nonatomic,assign)uint testUInt;

@property (nonatomic,assign)double testDouble;
@property (nonatomic,assign)float testFloat;

@property (nonatomic,assign)BOOL testBool;

@property (nonatomic,strong)NSNumber *testNumber;

@property (nonatomic,copy)NSString *testString;

@property (nonatomic,assign)NSInteger testStringToInt;
@property (nonatomic,assign)BOOL testStringToBool;

@property (nonatomic,copy)NSString *testNumberToString;



@property (nonatomic,strong)TestObject2 *testCustomObject;

@property (nonatomic,strong)NSDictionary *testDict;

@property (nonatomic,strong)NSArray<TestObject2 *> *testArrayObject;

@property (nonatomic,strong)NSArray<NSString *> *testArrayString;
@property (nonatomic,strong)NSArray<NSNumber *> *testArrayNumber;

@property (nonatomic,copy)NSString *customPropertyName;
@end

  
@implementation TestObject
-(Class)jsonParseArrayObjectClass:(NSString *)arrayPropertyName{
    if([arrayPropertyName isEqualToString:@"testArrayObject"]){
        return [TestObject2 class];
    }
    return nil;
}

- (NSDictionary<NSString *,NSString *> *)jsonParsePropertNameMap{
    return @{@"testCustomPropertyNameMap":@"customPropertyName"};
}
@end
  
  
@interface TestObject2 : NSObject
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,copy)NSString *name;
@end
  
@implementation TestObject2

@end
```

3. Step3 解析数据。

   上面两部做好后，解析数据很简单，只需要一行代码就能解析。

```objective-c
TestObject *t = [GICJsonParser parseObjectFromJsonData:jsonData withClass:[TestObject class]];
```



注意点：

1. 对于数组的解析。

   > 由于OC是没有泛型的概念的 ，因此解析器也不知道数组里面到底保存的什么类型的数据。因此需要通过`GICJsonParserDelegate`明确的告知解析器数组中保存到数据类型，也就是说实现`jsonParseArrayObjectClass`这个方法，就算一个类中有多个数组也没问题，只需要你根据属性名称返回正确的Class 就行。
   >
   > 如果返回nil 或者 没有实现`jsonParseArrayObjectClass`方法，那么解析器会默认将原始的json array赋值到该属性上。
   >
   > 对于例子中直接解析一个字符串数组或者一个number 数组直接返回nil或者不实现`jsonParseArrayObjectClass`方法就能解析。

2. 自定义属性名称与Json key 的映射。

   > 有时候json数据中定义的key跟数据结构中定义的属性名称不一致，那么也可以通过实现`GICJsonParserDelegate`中的`jsonParsePropertNameMap`方法来明确告知解析器属性名称跟json key的映射关系。比如例子中的:testCustomPropertyNameMap 跟 customPropertyName 的映射关系。




## 安装

JsonParser is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JsonParser'
```

## Author

龚海伟, dagehaoshuang@163.com

## License

JsonParser is available under the MIT license. See the LICENSE file for more info.
