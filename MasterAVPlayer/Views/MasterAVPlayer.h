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

#define TAPTCOUNT 4           //点击播放器空白处定时时间

NS_ASSUME_NONNULL_BEGIN

//手势操作的类型
typedef NS_ENUM(NSUInteger,MPControlType) {
    MPControlTypeDefault,   //无任何操作
    MPControlTypeProgress,  //视频进度调节操作
    MPControlTypeVoice,     //声音调节操作
    MPControlTypeLight      //屏幕亮度调节操作
};

static void * MasterPlayerStatusObservationContext = &MasterPlayerStatusObservationContext;

@interface MasterAVPlayer : UIView<mpplayerBottomDelegate,UIGestureRecognizerDelegate>
{
    BOOL showflag;         //是否显示控件标志
    
    NSTimer *tapGRTimer;   //播放中点击屏幕定时器  若timerCount秒后没有点击播放或者切换集按钮  则隐藏控件
    
    NSInteger timerCount;
}

//是否点击了播放按钮标志 YES表示点击了播放  NO表示暂停或未点击播放（默认）
@property(nonatomic, assign) BOOL playflag;

//是否在拖动滑竿
@property (nonatomic, assign) BOOL dragingSliderFlag;

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
@property(nonatomic, strong) MPlayerControlPanel *playerCPanel;

//播放器底部操控视图
@property(nonatomic, strong) MPlayerBottomView *mpbView;

//视频集列表
@property(nonatomic, strong) ChaptersListView *chaptersListView;

//测试视频数组数据
@property(nonatomic, strong) NSMutableArray *testVideoArr;

//播放中的监听者
@property(nonatomic, strong) __nullable id playingTimeObserver;

//跳到time时间播放
@property(nonatomic, assign) double  seekTime;

@end

NS_ASSUME_NONNULL_END
