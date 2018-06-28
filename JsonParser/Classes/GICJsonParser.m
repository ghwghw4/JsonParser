//
//  GICJsonParser.m
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/28.
//

#import "GICJsonParser.h"
#import "NSObject+Reflector.h"
#import "NSString+Extension.h"

@implementation GICJsonParser
+(id)parseObjectFromJsonData:(NSData *)jsonData withClass:(Class)klass{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if([jsonObject isKindOfClass:[NSDictionary class]]){
        return [self parseObjectFromDictionary:jsonObject withClass:klass];
    }
    return nil;
}

+(id)parseObjectFromDictionary:(NSDictionary *)jsonDict withClass:(Class)klass{
    id target = [klass new];
    NSDictionary<NSString *,GICReflectorPropertyInfo *> * properties = [NSObject gic_reflectProperties:klass];
    NSDictionary<NSString *,NSString *> *propertyNameMap = nil;
    if([target respondsToSelector:@selector(jsonParsePropertNameMap)]){
        propertyNameMap = [target jsonParsePropertNameMap];
    }
    
    for(NSString *key in jsonDict.allKeys){
        NSString *propertyName = key;
        if(propertyNameMap && [propertyNameMap.allKeys containsObject:key]){
            propertyName = [propertyNameMap objectForKey:key];
        }
        GICReflectorPropertyInfo *pInfo = [properties objectForKey:propertyName];
        id value = [jsonDict objectForKey:key];
        switch (pInfo.propertyType) {
            case GICPropertyType_Int:
            case GICPropertyType_Int8:
            case GICPropertyType_Int16:
            case GICPropertyType_Int32:
            case GICPropertyType_UInt:
            case GICPropertyType_UInt8:
            case GICPropertyType_UInt16:
            case GICPropertyType_UInt32:
            case GICPropertyType_Double:
            case GICPropertyType_Float:
            case GICPropertyType_Number:
            case GICPropertyType_Bool:{
                if([value isKindOfClass:[NSNumber class]]){
                    [target setValue:value forKey:propertyName];
                }else if ([value isKindOfClass:[NSString class]]){
                    [target setValue:@([value doubleValue]) forKey:propertyName];
                }
                break;
            }
                
            case GICPropertyType_String:{
                if([value isKindOfClass:[NSString class]]){
                    [target setValue:value forKey:propertyName];
                }else if ([value isKindOfClass:[NSNumber class]]){
                    [target setValue:[(NSNumber *)value stringValue] forKey:propertyName];
                }
                break;
            }
                
            case GICPropertyType_OtherNSObjectClass:{
                if([value isKindOfClass:[NSDictionary class]]){
                    [target setValue:[self parseObjectFromDictionary:value withClass:pInfo.otherNsObjectClass] forKey:propertyName];
                }
                break;
            }
                
            case GICPropertyType_Dictionary:{
                if([value isKindOfClass:[NSDictionary class]]){
                    [target setValue:value forKey:propertyName];
                }
                break;
            }
                
            case GICPropertyType_Array:{//解析array
                if([value isKindOfClass:[NSArray class]]){
                    if([target respondsToSelector:@selector(jsonParseArrayObjectClass:)]){
                        Class kls = [target jsonParseArrayObjectClass:propertyName];
                        [target setValue:[self parseObjectsFromArray:value withClass:kls] forKey:propertyName];
                    }else
                        [target setValue:value forKey:propertyName];
                }
                break;
            }
            default:
                break;
        }
    }
   
    // 对象解析完成的回调
    if([target respondsToSelector:@selector(jsonParseObjetCompelete:)]){
        [target jsonParseObjetCompelete:jsonDict];
    }
    return target;
}

+(NSArray *)parseObjectsFromJsonData:(NSData *)jsonData withClass:(Class)klass{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if([jsonObject isKindOfClass:[NSArray class]]){
        return [self parseObjectsFromArray:jsonObject withClass:klass];
    }
    return nil;
}

+(NSArray *)parseObjectsFromArray:(NSArray *)jsonArray withClass:(Class)klass{
    if(klass){
        NSMutableArray *mutArray = [NSMutableArray array];
        if([jsonArray count]>0 && [[jsonArray firstObject] isKindOfClass:[NSDictionary class]]){
            for(NSDictionary *obj in jsonArray){
                [mutArray addObject:[self parseObjectFromDictionary:obj withClass:klass]];
            }
        }
        return mutArray;
    }else{
        return jsonArray;
    }
}
@end
