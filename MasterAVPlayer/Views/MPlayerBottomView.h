//
//  MPlayerBottomView.h
//  Master
//  播放器底部操控视图
//  Created by eric on 2018/11/19.
//  Copyright © 2018 qushenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol mpplayerBottomDelegate <NSObject>

-(void)fullScreenBtnTouchSelector:(BOOL) fullSFlag; //全屏和退出全屏按钮事件

-(void)selectCapBtnTouchSelector;                   //选集按钮事件

@end

@interface MPlayerBottomView : UIView
{
    CGFloat fw;
    CGFloat fh;
    
    CGFloat timeshowSepWidth;
    CGFloat timeLabelWidth;

    NSString *testdurationTimeStr;
}

//全屏 YES
@property(nonatomic, assign) BOOL fullScreenFlag;

//视频总时长
@property(nonatomic, copy) NSString *durationStr;

//播放时长
@property(nonatomic, copy) NSString *playdurationStr;

//黑色背景
@property(nonatomic, strong) UIView *blkTransparentView;

//控件容器视图高度30pt 宽度同self.h
@property(nonatomic, strong) UIView *widgetBGView;

//进度滑条
@property(nonatomic, strong) UIProgressView *progressView;

//播放进度滑竿
@property(nonatomic, strong) UISlider *playSlider;

//当前播放时间
@property(nonatomic, strong) UILabel *currentTimeLabel;

//时间之间的分割
@property(nonatomic, strong) UILabel *timeSepLabel;

//视频总时间
@property(nonatomic, strong) UILabel *totalTimeLabel;

//全屏按钮(退出全屏按钮)
@property(nonatomic, strong) UIButton *fullScreenBtn;

//选集按钮(全屏才会有)
@property(nonatomic, strong) UIButton *selectCapBtn;

@property (nonatomic, weak) id<mpplayerBottomDelegate> delegate;

-(void)show;

-(void)hide;

@end

NS_ASSUME_NONNULL_END
