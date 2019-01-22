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

@interface MPlayerControlPanel : UIView

//全屏 YES
@property(nonatomic, assign) BOOL fullScreenFlag;

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




@end

NS_ASSUME_NONNULL_END
