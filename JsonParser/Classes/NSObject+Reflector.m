//
//  NSObject+Reflector.m
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/27.
//

#import "NSObject+Reflector.h"

@implementation NSObject (Reflector)



/**
 反射后得到的属性信息缓存

 @return <#return value description#>
 */
+ (NSMutableDictionary<NSString *,NSDictionary<NSString *,GICReflectorPropertyInfo *> *> *)gic_classPropertisInfoCache {
    static NSMutableDictionary *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [NSMutableDictionary dictionary];
    });
    return _instance;
}

+(NSDictionary<NSString *,GICReflectorPropertyInfo *> *)gic_reflectProperties{
    return [self gic_reflectProperties:[self class]];
}

+(NSDictionary<NSString *,GICReflectorPropertyInfo *> *)gic_reflectProperties:(Class)klass{
    if ([NSObject class] == klass) {
        return [NSDictionary dictionary];
    }
    
    NSString *className = NSStringFromClass(klass);
    NSDictionary<NSString *,GICReflectorPropertyInfo *> *value = [self.gic_classPropertisInfoCache objectForKey:className];
    if (value) {
        return value;
    }
    
    NSMutableDictionary *propertyInfosMap = [NSMutableDictionary dictionary];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i) {
        GICReflectorPropertyInfo * propertyInfo = [[GICReflectorPropertyInfo alloc] initWithProperty:properties[i]];
        if([propertyInfo.propertyName isEqualToString:@"description"] || [propertyInfo.propertyName isEqualToString:@"debugDescription"])
            continue;
        [propertyInfosMap setValue:propertyInfo forKey:propertyInfo.propertyName];
    }
    free(properties);//用完后释放
    NSDictionary *map = [self gic_reflectProperties:class_getSuperclass(klass)];//递归获取父类的属性
    [propertyInfosMap addEntriesFromDictionary:map];
    return propertyInfosMap;
}
@end
