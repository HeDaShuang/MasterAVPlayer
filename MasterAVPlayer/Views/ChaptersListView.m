//
//  ChaptersListView.m
//  Master
//
//  Created by eric on 2018/11/20.
//  Copyright © 2018 qushenghuo. All rights reserved.
//

#import "ChaptersListView.h"

@implementation ChaptersListView

-(NSMutableArray *)cellArr{
    if (!_cellArr) {
        _cellArr = [NSMutableArray new];
    }
    
    return _cellArr;
}

-(UIView *)blkTransparentView{
    if (!_blkTransparentView) {
        _blkTransparentView = [UIView new];
        _blkTransparentView.backgroundColor = [UIColor blackColor];
        _blkTransparentView.alpha = 0.6;
    }
    return _blkTransparentView;
}

-(UIScrollView *)clistScroll{
    if (!_clistScroll) {
        _clistScroll = [UIScrollView new];
        _clistScroll.showsVerticalScrollIndicator = NO;
        _clistScroll.showsHorizontalScrollIndicator = NO;
        _clistScroll.scrollEnabled = YES;
    }
    
    return _clistScroll;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)setFullScreenFlag:(BOOL)fullScreenFlag{
    _fullScreenFlag = fullScreenFlag;
    CGFloat fw = self.width;
    CGFloat fh = self.height;
    
    self.blkTransparentView.frame = CGRectMake(0, 0, fw, fh);
    [self addSubview:self.blkTransparentView];
    
    self.clistScroll.frame = CGRectMake(0, 6, fw, fh-12);
    [self addSubview:self.clistScroll];

}


//-(void)setMcDetailModel:(MCDetailModel *)mcDetailModel{
//    if (!mcDetailModel) {
//        return;
//    }
//    _mcDetailModel = mcDetailModel;
//
//    self.chapterListArr = _mcDetailModel.data.chapterList;
//
//    [self.clistScroll setContentSize:CGSizeMake(self.chapterListArr.count*(CLCELLW+CLCELLFS)+CLCELLFS, 78)];
//
//    [self.cellArr removeAllObjects];
//
//    for (int i = 0; i < self.chapterListArr.count; i++) {
//        ChaptersListCell *cell = [[ChaptersListCell alloc] initWithFrame:CGRectMake(CLCELLFS+(CLCELLFS+CLCELLW)*i, CLCELLFY, CLCELLW, CLCELLH)];
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.mcclistModel = [self.chapterListArr objectAtIndex:i];
//        [self.clistScroll addSubview:cell];
//
//        UIButton *maskBtn = [[UIButton alloc] initWithFrame:CGRectMake(CLCELLFS+(CLCELLFS+CLCELLW)*i, CLCELLFY, CLCELLW, CLCELLH)];
//        maskBtn.backgroundColor = [UIColor clearColor];
//        maskBtn.tag = i;
//        [maskBtn addTarget:self action:@selector(clmaskBtnTouchSelector:) forControlEvents:UIControlEventTouchUpInside];
//        [self.clistScroll addSubview:maskBtn];
//
//        [self.cellArr addObject:cell];
//    }
//}

//-(void)setPlayingIndex:(NSInteger)playingIndex{
//    _playingIndex = playingIndex;
//    
//    if (_playingIndex == -1) {
//        return;
//    }
//    
//    for (int i = 0; i < self.cellArr.count; i ++) {
//        ChaptersListCell *cell = [self.cellArr objectAtIndex:i];
//        if (playingIndex == i) {
//            cell.playLable.hidden = YES;
//            cell.lockIcon.hidden = YES;
//            cell.maskView.alpha = 0;
//            cell.cTitle.textColor = MASTERBLUECOLOR;
//        } else {
//            cell.playLable.hidden = YES;
//            cell.lockIcon.hidden = NO;
//            cell.maskView.alpha = 0.5;
//            cell.cTitle.textColor = MASTER51GRAY;
//        }
//    }
//    
//}
//
//-(void)clmaskBtnTouchSelector:(UIButton *) btn{
//    MCClistModel *mcclistModel = [self.chapterListArr objectAtIndex:btn.tag];
//    if (mcclistModel.isBuy == 0) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:SelectUnlockChapterIndexNotification object:@{@"unlockselectCIndex":@(btn.tag)}];
//    } else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:SelectChapterIndexNotification object:@{@"selectCIndex":@(btn.tag)}];
//    }
//    
//}


@end
