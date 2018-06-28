//
//  GICJsonParser.h
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/28.
//

#import <Foundation/Foundation.h>
#import "GICJsonParserDelegate.h"

@interface GICJsonParser : NSObject

/**
 将jsonData 解析成某个对象的实例

 @param jsonData jsonData
 @param klass 对象的类型
 @return klass 对应的实例
 */
+(id)parseObjectFromJsonData:(NSData *)jsonData withClass:(Class)klass;

/**
 将dictionary 解析成某个对象的实例

 @param jsonDict jsonDict
 @param klass 对象的类型
 @return 对应的实例
 */
+(id)parseObjectFromDictionary:(NSDictionary *)jsonDict withClass:(Class)klass;


/**
 将jsonData 解析成某个对象的实例数组

 @param jsonData jsonData
 @param klass 对象的类型
 @return 对象的实例数组
 */
+(NSArray *)parseObjectsFromJsonData:(NSData *)jsonData withClass:(Class)klass;

/**
 将Array 解析成某个对象的实例数组

 @param jsonArray jsonArray
 @param klass 对象的类型
 @return 对象的实例数组
 */
+(NSArray *)parseObjectsFromArray:(NSArray *)jsonArray withClass:(Class)klass;
@end
