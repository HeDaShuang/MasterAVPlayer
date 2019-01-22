//
//  ChaptersListView.h
//  Master
//
//  Created by eric on 2018/11/20.
//  Copyright © 2018 qushenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChaptersListCell.h"
//#import "MCDetailModel.h"

#define CLCELLW 100.0f
#define CLCELLH 78.0f
#define CLCELLFS 15.0f
#define CLCELLFY 0.0f

NS_ASSUME_NONNULL_BEGIN

@interface ChaptersListView : UIView

//黑色背景
@property(nonatomic, strong) UIView *blkTransparentView;

@property(nonatomic, strong) UIScrollView *clistScroll;

//@property(nonatomic, strong) MCDetailModel *mcDetailModel;

//全屏 YES
@property(nonatomic, assign) BOOL fullScreenFlag;

@property(nonatomic, copy) NSArray *chapterListArr;

//播放中index
@property(nonatomic, assign) NSInteger playingIndex;

@property(nonatomic, strong) NSMutableArray *cellArr;

@end

NS_ASSUME_NONNULL_END
