#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GICJsonParser.h"
#import "GICJsonParserDelegate.h"
#import "GICReflectorPropertyInfo.h"
#import "NSObject+Reflector.h"
#import "NSString+Extension.h"

FOUNDATION_EXPORT double GICJsonParserVersionNumber;
FOUNDATION_EXPORT const unsigned char GICJsonParserVersionString[];

