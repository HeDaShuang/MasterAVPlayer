//
//  MPlayerControlPanel.h
//  MasterAVPlayer
//  播放器控制面板
//  Created by eric on 2019/1/16.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PLYERBTNWIDTH 40.0f   //按钮大小
#define FSBTNFX 55.0f         //课程集按钮全屏 fullscreen switch btn fx
#define SBTNFX 15.0f          //课程集按钮非全屏 fx

NS_ASSUME_NONNULL_BEGIN

@protocol playerPanelDelegate <NSObject>

//播放按钮代理事件
-(void)playerPanelDelegatePlayBtnTouchSelector;

//下一个视频
-(void)playerPanelDelegateNextBtnTouchSelector;

//上一个视频
-(void)playerPanelDelegatePreviousBtnTouchSelector;

//退出全屏按钮代理事件
-(void)playerPanelDelegateQuitFScreenBtnSelector;

@end

@interface MPlayerControlPanel : UIView

//全屏 YES
@property(nonatomic, assign) BOOL fullScreenFlag;

//视频封面
@property(nonatomic, strong) UIImageView *videoCover;

@property(nonatomic, copy) NSString *coverStr;

//全屏返回按钮(退出全屏)
@property(nonatomic, strong) UIButton *quitFScreenBtn;

//开始播放/暂停播放按钮
@property(nonatomic, strong) UIButton *playBtn;

//上一集按钮
@property(nonatomic, strong) UIButton *previousBtn;

//下一集按钮
@property(nonatomic, strong) UIButton *nextBtn;

//加载中指示器
@property(nonatomic, strong) UIImageView *loadingIV;

//加载中和加载失败提示
@property(nonatomic, strong) UILabel *reloadLabel;

@property(nonatomic, weak) id<playerPanelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
