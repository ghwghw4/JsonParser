//
//  NSObject+GICJsonParser.m
//  GICJsonParser
//
//  Created by 龚海伟 on 2018/6/29.
//

#import "NSObject+GICJsonParser.h"
#import "GICJsonParser.h"
@implementation NSObject (GICJsonParser)
+(instancetype)gic_jsonParseObjectFromJsonData:(NSData*)jsonData{
    return [GICJsonParser parseObjectFromJsonData:jsonData withClass:[self class]];
}

+(instancetype)gic_jsonParseObjectFromDictionary:(NSDictionary*)jsonDict{
    return [GICJsonParser parseObjectFromDictionary:jsonDict withClass:[self class]];
}

+(NSArray *)gic_jsonParseObjectArrayFromJsonData:(NSData *)jsonData{
    return [GICJsonParser parseObjectArrayFromJsonData:jsonData withClass:[self class]];
}

+(NSArray *)gic_jsonParseObjectArrayFromArray:(NSArray *)jsonArray{
    return [GICJsonParser parseObjectArrayFromArray:jsonArray withClass:[self class]];
}

-(NSData *)gic_serializeToJsonData{
    if([self isKindOfClass:[NSArray class]]){
        return [GICJsonParser objectArraySerializeToJsonData:(NSArray *)self];
    }else if ([self isKindOfClass:[NSDictionary class]]){
        return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
    return [GICJsonParser objectSerializeToJsonData:self];
}
@end
