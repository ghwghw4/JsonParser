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
        if(pInfo.isReadOnly)
            continue;
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
                        [target setValue:[self parseObjectArrayFromArray:value withClass:kls] forKey:propertyName];
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

+(NSArray *)parseObjectArrayFromJsonData:(NSData *)jsonData withClass:(Class)klass{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if([jsonObject isKindOfClass:[NSArray class]]){
        return [self parseObjectArrayFromArray:jsonObject withClass:klass];
    }
    return nil;
}

+(NSArray *)parseObjectArrayFromArray:(NSArray *)jsonArray withClass:(Class)klass{
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



+(NSDictionary *)objectSerializeToJsonDictionary:(id)target{
    if([target isKindOfClass:[NSArray class]] || [target isKindOfClass:[NSString class]] || [target isKindOfClass:[NSNumber class]]){
        return nil;
    }
    
    NSDictionary<NSString *,id> *objectKVODictionary = nil;
    if([target isKindOfClass:[NSDictionary class]]){
        objectKVODictionary = target;
    }else{
        NSDictionary<NSString *,GICReflectorPropertyInfo *> *properties = [NSObject gic_reflectProperties:[target class]];
        objectKVODictionary = [target dictionaryWithValuesForKeys:properties.allKeys];
    }
    
    NSDictionary<NSString *,NSString *> *propertyNameMap = nil;
    if([target respondsToSelector:@selector(jsonParsePropertNameMap)]){
        propertyNameMap = [target jsonParsePropertNameMap];
    }
    NSMutableDictionary *serializeDictionary = [NSMutableDictionary dictionary];
    for(NSString *propertyName in objectKVODictionary.allKeys){
        NSString *jsonKey = propertyName;
        if(propertyNameMap && [propertyNameMap.allValues containsObject:propertyName]){
            jsonKey = [[propertyNameMap allKeysForObject:propertyName] firstObject];
        }
        id value = [objectKVODictionary objectForKey:propertyName];
        if(!value || [value isKindOfClass:[NSNull class]])
            continue;
        if([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
            [serializeDictionary setValue:value forKey:jsonKey];
        }else if ([value isKindOfClass:[NSDictionary class]]){
            [serializeDictionary setValue:[self objectSerializeToJsonDictionary:value] forKey:jsonKey];
        }else if ([value isKindOfClass:[NSArray class]]){
            [serializeDictionary setValue:[self objectArraySerializeToJsonArray:value] forKey:jsonKey];
        }else{
            [serializeDictionary setValue:[self objectSerializeToJsonDictionary:value] forKey:jsonKey];
        }
    }
    return serializeDictionary;
}


+(NSData *)objectSerializeToJsonData:(id)object{
    NSDictionary *dict = [self objectSerializeToJsonDictionary:object];
    return [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
}

+(NSArray *)objectArraySerializeToJsonArray:(NSArray *)objects{
    if(objects.count==0)
        return objects;
    NSMutableArray *mutArray = [NSMutableArray array];
    for(id obj in objects){
        if([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]]){
            [mutArray addObject:obj];
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            [mutArray addObject:obj];
        }else{
            [mutArray addObject:[self objectSerializeToJsonDictionary:obj]];
        }
    }
    return mutArray;
}

+(NSData *)objectArraySerializeToJsonData:(NSArray *)objects{
    NSArray *array = [self objectArraySerializeToJsonArray:objects];
    return [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
}
@end
