//
//  MPlayerControlPanel.h
//  MasterAVPlayer
//  播放器控制面板
//  Created by eric on 2019/1/16.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPlayerControlPanel : UIView

//视频封面
@property(nonatomic, strong) UIImageView *courseCover;

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

//获取底部操控视图的滑竿
@property(nonatomic, strong) UISlider *pSlider;


@end

NS_ASSUME_NONNULL_END
