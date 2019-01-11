//
//  MasterAVPlayer.h
//  MasterAVPlayer
//
//  Created by eric on 2019/1/11.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

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
    MPControlTypeDefault,//无任何操作
    MPControlTypeProgress,//视频进度调节操作
    MPControlTypeVoice,//声音调节操作
    MPControlTypeLight//屏幕亮度调节操作
};

@interface MasterAVPlayer : UIView

//播放器状态
@property(nonatomic, assign) MPlyerStatus mplyerstatus;

@property (nonatomic,assign) MPControlType controlType;

@end

NS_ASSUME_NONNULL_END
