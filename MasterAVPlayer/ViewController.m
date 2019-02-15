//
//  ViewController.m
//  MasterAVPlayer
//
//  Created by eric on 2018/12/29.
//  Copyright © 2018 eric. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    NSString *str = @"ABC";
//    NSString *AStr = [str mutableCopy];
//    NSString *BStr = [str copy];
//
//    NSLog(@"%zd", class_getInstanceSize([NSObject class])); //实列大小
//    NSLog(@"%zd", class_getInstanceSize([NSString class]));
//
//    NSLog(@"%zd",malloc_size((__bridge const void *)str)); //分配空间大小
//
//    NSLog(@"str:%@ %p", str, str);
//    NSLog(@"AStr:%@ %p", AStr, AStr);
//    NSLog(@"BStr:%@ %p", BStr, BStr);
//
//    NSLog(@"========");
//    str = nil;
//
//    NSLog(@"str:%@ %p", str, str);
//    NSLog(@"AStr:%@ %p", AStr, AStr);
//    NSLog(@"BStr:%@ %p", BStr, BStr);
//
//    NSObject *obj = [[NSObject alloc] init];
//    //获取NSObject实例对象的成员变量所占用的大小 ： 8
//    NSLog(@"%zd",class_getInstanceSize([NSObject class]));
//
//    //获取*obj指针所指向内存的大小：16
//    NSLog(@"%zd",malloc_size((__bridge const void *)obj));
    
    [self addPlayer];
    
}

-(void)addPlayer{
    self.masterPlayer = [[MasterAVPlayer alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/1.875)];
    self.masterPlayer.fullScreenFlag = NO;
    self.masterPlayer.playerSuperView = self.view;
    
    [self.view addSubview:self.masterPlayer];
    
}


@end
