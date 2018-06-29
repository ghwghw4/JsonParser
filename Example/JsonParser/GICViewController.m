//
//  GICViewController.m
//  JsonParser
//
//  Created by 龚海伟 on 06/27/2018.
//  Copyright (c) 2018 龚海伟. All rights reserved.
//

#import "GICViewController.h"
#import "TestObject.h"
#import <GICJsonParser/NSObject+GICJsonParser.h>
#import <GICJsonParser/GICJsonParser.h>

@interface GICViewController ()

@end

@implementation GICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"TestJsonParser.json"]];
    TestObject *t = [TestObject gic_jsonParseObjectFromJsonData:jsonData];
    NSData *serJsonData = [GICJsonParser objectSerializeToJsonData:t];
    NSString *jsonString = [[NSString alloc] initWithData:serJsonData encoding:4];
    NSLog(@"%@",jsonString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
