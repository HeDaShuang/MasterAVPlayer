//
//  MasterAVPlayer.m
//  MasterAVPlayer
//
//  Created by eric on 2019/1/11.
//  Copyright © 2019 eric. All rights reserved.
//

#import "MasterAVPlayer.h"

@implementation MasterAVPlayer

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.playerControlPanel = [[MPlayerControlPanel alloc] init];
        self.mpbView = [[MPlayerBottomView alloc] init];
        self.chaptersListView = [[ChaptersListView alloc] init];

        [self addSubview:self.playerControlPanel];
        [self addSubview:self.mpbView];
        [self addSubview:self.chaptersListView];
        
        testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        testView.backgroundColor = [UIColor purpleColor];
        //[self addSubview:testView];
        
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        testLabel.text = @"向上";
        testLabel.textAlignment = NSTextAlignmentCenter;
        testLabel.textColor = [UIColor whiteColor];
        
        [testView addSubview:testLabel];
        
        [self.playerSuperView addSubview:self];

        [self addObserver];
    }
    
    return self;
}

-(void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOritentationChangeSelector) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)deviceOritentationChangeSelector{
//    if (self.masterPlayer==nil){
//        return;
//    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
        }
            break;
        case UIInterfaceOrientationPortrait:{
            [self quitFromFullScreen];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            [self rotatetoFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            [self rotatetoFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}


//非全屏
-(void)quitFromFullScreen
{
//    if(!self.masterPlayer) return;
    NSLog(@"ScreenWidth = %f  ScreenHeight = %f", ScreenWidth, ScreenHeight);
    
    testView.frame = CGRectMake(0, 0, 50, 30);

    [self removeFromSuperview];
    
    WeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.transform = CGAffineTransformIdentity;
        weakSelf.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth/1.875);
        weakSelf.fullScreenFlag = NO;
    } completion:^(BOOL finished) {
    }];
    
    [self.playerSuperView addSubview:self];
    
}

//全屏
-(void)rotatetoFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    //    if(!self.masterPlayer) return;
    
    testView.frame = CGRectMake(0, 0, 50, 30);

    [self removeFromSuperview];
    
    self.transform = CGAffineTransformIdentity;


    [UIView animateWithDuration:0.3 animations:^{
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
        else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else{
            NSLog(@"不用旋转");
        }
        

    } completion:^(BOOL finished) {
        
    }];
    
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight); //0 0 375  667
    self.fullScreenFlag = YES;

    [[UIApplication sharedApplication].keyWindow addSubview:self];

}

-(void)setFullScreenFlag:(BOOL)fullScreenFlag{
    
    _fullScreenFlag = fullScreenFlag;
    
    [self setUI];
}


-(void)setUI{
    
    if (self.fullScreenFlag) {
        
        self.chaptersListView.hidden = NO;
        self.chaptersListView.frame = CGRectMake(0, self.width, self.height, 90);
        self.mpbView.frame = CGRectMake(0, self.width-50, self.height, 50);
        self.mplayerLayer.frame = CGRectMake(0, 0, self.height, self.width);
        self.playerControlPanel.frame = CGRectMake(0, 0, self.height, self.width);
 

    } else {
        self.chaptersListView.hidden = YES;
        
        self.mpbView.frame = CGRectMake(0, self.height-40, self.width, 40);
        self.mplayerLayer.frame = CGRectMake(0, 0, self.width, self.height);
        self.playerControlPanel.frame = CGRectMake(0, 0, self.width, self.height);
    }
        
    self.mpbView.fullScreenFlag = self.fullScreenFlag;
    self.chaptersListView.fullScreenFlag = self.fullScreenFlag;
    self.playerControlPanel.fullScreenFlag = self.fullScreenFlag;
}





@end
