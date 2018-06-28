//
//  NSObject+Reflector.h
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/27.
//

#import <Foundation/Foundation.h>
#import "GICReflectorPropertyInfo.h"

@interface NSObject (Reflector)

/**
 反射获取某个类的属性信息

 @param klass <#klass description#>
 @return <#return value description#>
 */
+(NSDictionary<NSString *,GICReflectorPropertyInfo *> *)gic_reflectProperties:(Class)klass;
+(NSDictionary<NSString *,GICReflectorPropertyInfo *> *)gic_reflectProperties;
@end
