//
//  GICReflectorPropertyInfo.h
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/27.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef enum{
    GICPropertyType_UnKown,// 未知类型
    GICPropertyType_Int,
    GICPropertyType_Int8,
    GICPropertyType_Int16,
    GICPropertyType_Int32,
//    GICPropertyType_Int64,//在64位处理器上，Int64等同于Int，因此已无必要单独列出
    GICPropertyType_UInt,
    GICPropertyType_UInt8,
    GICPropertyType_UInt16,
    GICPropertyType_UInt32,
//    GICPropertyType_UInt64,//在64位处理器上，Int64等同于Int，因此已无必要单独列出
    GICPropertyType_Double,
    GICPropertyType_Float,
    GICPropertyType_Bool,
    GICPropertyType_Decimal,
    GICPropertyType_String,
    GICPropertyType_Array,
    GICPropertyType_Number,
    GICPropertyType_Dictionary,
    GICPropertyType_OtherNSObjectClass //其他继承自NSOBject的类，包括自定义的类
}GICPropertyType;

@interface GICReflectorPropertyInfo : NSObject

/**
 是否只读属性
 */
@property (nonatomic,assign,readonly)BOOL isReadOnly;

/**
 属性名称
 */
@property (nonatomic,copy,readonly)NSString *propertyName;

/**
 属性对应的类型枚举
 */
@property (nonatomic,assign,readonly)GICPropertyType propertyType;

@property (nonatomic,assign)Class otherNsObjectClass;

-(id)initWithProperty:(objc_property_t)property;
@end
