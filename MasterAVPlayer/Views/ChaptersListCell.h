//
//  ChaptersListCell.h
//  Master
//
//  Created by eric on 2018/11/22.
//  Copyright © 2018 qushenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MCDetailModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ChaptersListCell : UIView

@property(nonatomic, strong) UIImageView *cCoverIV;  //chapter 封面

@property(nonatomic, strong) UILabel *cTitle;        //课程标题

@property(nonatomic, strong) UIImageView *lockIcon;  //锁图标

@property(nonatomic, strong) UILabel *playLable;     //播放中

@property(nonatomic, strong) UIView *maskView;

@property(nonatomic, strong) UIButton *maskBtn;

//@property(nonatomic, strong) MCClistModel *mcclistModel;


@end

NS_ASSUME_NONNULL_END
