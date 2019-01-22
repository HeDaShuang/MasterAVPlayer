//
//  ChaptersListCell.m
//  Master
//
//  Created by eric on 2018/11/22.
//  Copyright © 2018 qushenghuo. All rights reserved.
//

#import "ChaptersListCell.h"

@implementation ChaptersListCell

-(UIImageView *)cCoverIV{
    if (!_cCoverIV) {
        _cCoverIV = [UIImageView new];
        _cCoverIV.contentMode = UIViewContentModeScaleAspectFill;
        _cCoverIV.clipsToBounds = YES;
    }
    
    return _cCoverIV;
}

-(UIImageView *)lockIcon{
    if (!_lockIcon) {
        _lockIcon = [UIImageView new];
        _lockIcon.contentMode = UIViewContentModeScaleAspectFill;
        _lockIcon.clipsToBounds = YES;
        _lockIcon.hidden = NO;
    }
    
    return _lockIcon;
}


-(UILabel *)cTitle{
    if (!_cTitle) {
        _cTitle = [UILabel new];
        _cTitle.font = [UIFont systemFontOfSize:11];
        _cTitle.textColor = APP51GRAY;
    }
    
    return _cTitle;
}

-(UILabel *)playLable{
    if (!_playLable) {
        _playLable = [UILabel new];
        _playLable.font = [UIFont systemFontOfSize:15];
        _playLable.textColor = [UIColor whiteColor];
        _playLable.textAlignment = NSTextAlignmentCenter;
        _playLable.text = @"播放中";
        _playLable.hidden = YES;
    }
    
    return _playLable;
}

-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
    }
    
    return _maskView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setUI];
    }
    return self;
}


-(void)setUI{
    self.cCoverIV.frame = CGRectMake(5, 5, 90, 48);
    self.maskView.frame = CGRectMake(5, 5, 90, 48);
    self.cTitle.frame = CGRectMake(5, 53, 90, 25);
    self.lockIcon.frame = CGRectMake(40, 20, 20, 20);
    self.playLable.frame = CGRectMake(5, 20, 90, 20);
    self.maskBtn.frame = CGRectMake(0, 0, 100, 78);

    [self addSubview:self.cCoverIV];
    [self addSubview:self.maskView];
    [self addSubview:self.cTitle];
    [self addSubview:self.lockIcon];
    [self addSubview:self.playLable];
    [self addSubview:self.maskBtn];
}

//-(void)setMcclistModel:(MCClistModel *)mcclistModel{
//    if (!mcclistModel) {
//        return;
//    }
//
//    _mcclistModel = mcclistModel;
//
//    NSURL *picURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", _mcclistModel.cover,masterSmallPic]];
//    [self.cCoverIV sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"pic_placeholder"]];
//
//    if (self.mcclistModel.isBuy == 1) {
//        [self.lockIcon setImage:[UIImage imageNamed:@"c_unlock_icon"]];
//    }
//    else{
//        [self.lockIcon setImage:[UIImage imageNamed:@"c_lock_icon"]];
//    }
//
//    self.cTitle.text = self.mcclistModel.title;
//}

-(void)testSelector{
    
}




@end
