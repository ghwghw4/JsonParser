//
//  GICJsonParserDelegate.h
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/28.
//

#ifndef GICJsonParserDelegate_h
#define GICJsonParserDelegate_h

@protocol GICJsonParserDelegate <NSObject>
@optional

/**
 根据属性名称返回该属性对应的array保存的对象的Class

 @param arrayPropertyName 属性名称
 @return 对象class。目前仅支持自定义的Object。如果返回nil，那么默认将原始的array 设置为该属性的值
 */
-(Class)jsonParseArrayObjectClass:(NSString *)arrayPropertyName;

/**
 *  对该类解析结束的时候调用
 *
 *  @param jsonDict 该类对应的json字典
 */
- (void)jsonParseObjetCompelete:(NSDictionary *)jsonDict;
@end

#endif /* GICJsonParserDelegate_h */
