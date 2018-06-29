//
//  GICJsonParser.h
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/28.
//

#import <Foundation/Foundation.h>
#import "GICJsonParserDelegate.h"

@interface GICJsonParser : NSObject
#pragma mark 反序列化(将json 数据 反序列化 成实例对象)

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
+(NSArray *)parseObjectArrayFromJsonData:(NSData *)jsonData withClass:(Class)klass;

/**
 将Array 解析成某个对象的实例数组

 @param jsonArray jsonArray
 @param klass 对象的类型
 @return 对象的实例数组
 */
+(NSArray *)parseObjectArrayFromArray:(NSArray *)jsonArray withClass:(Class)klass;

#pragma mark 序列化 (将实例对象序列化成json 数据)

/**
 将一个对象实例序列化成Dictionary

 @param object 对象实例
 @return Dictionary
 */
+(NSDictionary *)objectSerializeToJsonDictionary:(id)object;
+(NSData *)objectSerializeToJsonData:(id)object;

/**
 将一个数组序列化成能够转成jsonstring的数组

 @param objects <#objects description#>
 @return <#return value description#>
 */
+(NSArray *)objectArraySerializeToJsonArray:(NSArray *)objects;
+(NSData *)objectArraySerializeToJsonData:(NSArray *)objects;
@end
