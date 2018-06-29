//
//  NSString+Extension.m
//  JsonParser
//
//  Created by 龚海伟 on 2018/6/28.
//

#import "NSString+Extension.h"
#import "GICJsonParser.h"

@implementation NSString (Extension)
-(id)gic_toJsonObject{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
}
@end
