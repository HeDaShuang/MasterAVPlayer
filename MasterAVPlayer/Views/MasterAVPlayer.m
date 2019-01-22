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
        self.backgroundColor = [UIColor greenColor];
        
        self.playerControlPanel = [[MPlayerControlPanel alloc] init];
        self.mpbView = [[MPlayerBottomView alloc] init];
        self.chaptersListView = [[ChaptersListView alloc] init];

        [self addSubview:self.playerControlPanel];
        [self addSubview:self.mpbView];
        [self addSubview:self.chaptersListView];
    }
    
    return self;
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
 
//        self.statusBar.frame = CGRectMake(0, 0, self.height, 20);
//        self.statusBar.hidden = YES;
        
    } else {
        self.chaptersListView.hidden = YES;
        
        self.mpbView.frame = CGRectMake(0, self.height-40, self.width, 40);
        self.mplayerLayer.frame = CGRectMake(0, 0, self.width, self.height);
        self.playerControlPanel.frame = CGRectMake(0, 0, self.width, self.height);
        
//        if ([ToolBox ifDeviceisiPhoneX]) {
//            self.statusBar.frame = CGRectMake(0, -35, self.width, 20);
//        } else {
//            self.statusBar.frame = CGRectMake(0, 0, self.width, 20);
//        }
//        self.statusBar.hidden = NO;
    }
    
    //self.mpbView.delegate = self;
//    if (self.selectMCCModel.videoDuration) {
//
//        self.mpbView.durationStr = self.selectMCCModel.videoDuration;
//    } else {
//        self.mpbView.durationStr = @"00:00:00";
//    }
    
    self.mpbView.fullScreenFlag = self.fullScreenFlag;
    self.chaptersListView.fullScreenFlag = self.fullScreenFlag;
    self.playerControlPanel.fullScreenFlag = self.fullScreenFlag;
}





@end
