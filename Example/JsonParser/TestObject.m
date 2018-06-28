//
//  TestObject.m
//  JsonParser_Example
//
//  Created by 龚海伟 on 2018/6/27.
//  Copyright © 2018年 龚海伟. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject
-(Class)jsonParseArrayObjectClass:(NSString *)arrayPropertyName{
    if([arrayPropertyName isEqualToString:@"testArrayObject"]){
        return [TestObject2 class];
    }
    return nil;
}
@end
