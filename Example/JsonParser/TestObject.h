//
//  TestObject.h
//  JsonParser_Example
//
//  Created by 龚海伟 on 2018/6/27.
//  Copyright © 2018年 龚海伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestObject2.h"
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
@end
