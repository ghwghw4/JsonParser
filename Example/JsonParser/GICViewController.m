//
//  GICViewController.m
//  JsonParser
//
//  Created by 龚海伟 on 06/27/2018.
//  Copyright (c) 2018 龚海伟. All rights reserved.
//

#import "GICViewController.h"
#import "GICJsonParser.h"
#import "TestObject.h"
#import <JsonParser/GICJsonParser.h>
#import <JsonParser/NSString+Extension.h>

@interface GICViewController ()

@end

@implementation GICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"TestJsonParser.json"]];
    
    TestObject *t = [GICJsonParser parseObjectFromJsonData:jsonData withClass:[TestObject class]];
    NSLog(t);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
