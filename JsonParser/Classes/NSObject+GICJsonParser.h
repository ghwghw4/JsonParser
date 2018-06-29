//
//  NSObject+GICJsonParser.h
//  GICJsonParser
//
//  Created by 龚海伟 on 2018/6/29.
//

#import <Foundation/Foundation.h>
#import "GICJsonParserDelegate.h"

@interface NSObject (GICJsonParser)
#pragma mark 解析对象
+(instancetype)gic_jsonParseObjectFromJsonData:(NSData*)jsonData;
+(instancetype)gic_jsonParseObjectFromDictionary:(NSDictionary*)jsonDict;

#pragma mark 解析数组
+(NSArray *)gic_jsonParseObjectArrayFromJsonData:(NSData *)jsonData;
+(NSArray *)gic_jsonParseObjectArrayFromArray:(NSArray *)jsonArray;


/**
 序列化成json 数据

 @return json data
 */
-(NSData *)gic_serializeToJsonData;
@end
