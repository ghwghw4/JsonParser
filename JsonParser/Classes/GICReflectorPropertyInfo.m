//
//  GICReflectorPropertyInfo.m
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/27.
//

#import "GICReflectorPropertyInfo.h"

@implementation GICReflectorPropertyInfo
static NSDictionary<NSString *,NSNumber *> *propertyTypeMap;
+(void)initialize{
    propertyTypeMap = @{
                        @"c" : @(GICPropertyType_Int8),
                        @"s" : @(GICPropertyType_Int16),
                        @"i" : @(GICPropertyType_Int32),
                        @"q" : @(GICPropertyType_Int), //also: Int64, NSInteger, only true on 64 bit platforms
                        @"C" : @(GICPropertyType_UInt8),
                        @"S" : @(GICPropertyType_UInt16),
                        @"I" : @(GICPropertyType_UInt32),
                        @"Q" : @(GICPropertyType_UInt), //also UInt64, only true on 64 bit platforms
                        @"B" : @(GICPropertyType_Bool),
                        @"d" : @(GICPropertyType_Double),
                        @"f" : @(GICPropertyType_Float),
                        @"{" : @(GICPropertyType_Decimal)};
}


-(id)initWithProperty:(objc_property_t)property{
    self = [super init];
    _propertyName = [NSString stringWithUTF8String:property_getName(property)];
    
    NSString *typeString = [NSString stringWithUTF8String:property_getAttributes(property)];
    // 解析是否只读属性
    NSArray *attributesDotArray = [typeString componentsSeparatedByString:@","];//采用逗号分隔的数组
    if(attributesDotArray.count>1){
        _isReadOnly = [[attributesDotArray objectAtIndex:1] rangeOfString:@"R"].length > 0;
    }
    
    if([typeString characterAtIndex:0] == 'T'){//只有第一个字母是T，才能继续解析类型
        // 解析实际类型
        NSArray *slices = [typeString componentsSeparatedByString:@"\""];
        if(slices.count>1){
            Class cls = NSClassFromString(slices[1]);
            if(cls == [NSString class]){
                _propertyType = GICPropertyType_String;
            }else if (cls == [NSArray class]){
                _propertyType = GICPropertyType_Array;
            }else if (cls == [NSDictionary class]){
                _propertyType = GICPropertyType_Dictionary;
            }else if (cls == [NSNumber class]){
                _propertyType = GICPropertyType_Number;
            }else{
                _propertyType = GICPropertyType_OtherNSObjectClass;
                _otherNsObjectClass = cls;
            }
        }else{
            NSString *letter = [typeString substringWithRange:NSMakeRange(1, 1)];
            if([propertyTypeMap.allKeys containsObject:letter]){
                _propertyType = (GICPropertyType)[propertyTypeMap[letter] integerValue];
            }
        }
        
    }
    return self;
}

@end
