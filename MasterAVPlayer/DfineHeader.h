//
//  DfineHeader.h
//  MasterAVPlayer
//
//  Created by eric on 2019/1/16.
//  Copyright © 2019 eric. All rights reserved.
//

#ifndef DfineHeader_h
#define DfineHeader_h

#define WeakSelf __weak typeof(self) weakSelf = self;

#define color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b) color(r, g, b, 1.0f)
#define APPGOLDERCOLOR RGB(198,171,99)      //新金色
#define APP230GRAY RGB(230,230,230)
#define APP51GRAY RGB(51,51,51)  //333333

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger,MPlyerStatus){
    MPlyerStatusFailed,       //失败
    MPlyerStatusBuffering,    //缓冲中
    MPlyerStatusReadytoplay,  //将要播放
    MPlyerStatusPlaying,      //播放中
    MPlyerStatusStopped,      //暂停播放
    MPlyerStatusFinished,     //播放完成
    MPlyerStatusPasue         //播放暂停
};

#endif /* DfineHeader_h */
