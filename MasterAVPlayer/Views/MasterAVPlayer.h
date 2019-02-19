//
//  MasterAVPlayer.h
//  MasterAVPlayer
//
//  Created by eric on 2019/1/11.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPlayerBottomView.h"
#import "MPlayerControlPanel.h"
#import "ChaptersListView.h"

NS_ASSUME_NONNULL_BEGIN

//播放状态
typedef NS_ENUM(NSInteger, MPlyerStatus) {
    MPlyerStatusFailed,       //失败
    MPlyerStatusBuffering,    //缓冲中
    MPlyerStatusReadytoplay,  //将要播放
    MPlyerStatusPlaying,      //播放中
    MPlyerStatusStopped,      //暂停播放
    MPlyerStatusFinished,     //播放完成
    MPlyerStatusPasue         //播放暂停
};

//手势操作的类型
typedef NS_ENUM(NSUInteger,MPControlType) {
    MPControlTypeDefault,   //无任何操作
    MPControlTypeProgress,  //视频进度调节操作
    MPControlTypeVoice,     //声音调节操作
    MPControlTypeLight      //屏幕亮度调节操作
};

static void * MasterPlayerStatusObservationContext = &MasterPlayerStatusObservationContext;

@interface MasterAVPlayer : UIView

@property(nonatomic, strong) UIView *playerSuperView;

//播放器
@property(nonatomic, strong) AVPlayer *masterPlayer;

//播放器图层
@property(nonatomic, strong) AVPlayerLayer *mplayerLayer;

//当前播放的item
@property (nonatomic, retain) AVPlayerItem *currentItem;

//播放器状态
@property(nonatomic, assign) MPlyerStatus mplyerstatus;

//手势类型
@property (nonatomic,assign) MPControlType controlType;

//是否全屏播放
@property (nonatomic, assign) BOOL fullScreenFlag;

//播放地址URL
@property(nonatomic, copy) NSString *playURLStr;

//播放器控制面板
@property(nonatomic, strong) MPlayerControlPanel *playerControlPanel;

//播放器底部操控视图
@property(nonatomic, strong) MPlayerBottomView *mpbView;

//视频集列表
@property(nonatomic, strong) ChaptersListView *chaptersListView;

//测试视频数组数据
@property(nonatomic, strong) NSMutableArray *testVideoArr;

@end

NS_ASSUME_NONNULL_END
