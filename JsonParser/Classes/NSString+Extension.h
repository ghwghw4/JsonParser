//
//  NSString+Extension.h
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/28.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 将字符串转换成json对象，要么是Dictionary，要么是NSArray

 @return return  Dictionary / NSArray
 */
-(id)gic_toJsonObject;
@end
