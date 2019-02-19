//
//  MPlayerBottomView.m
//  Master
//
//  Created by eric on 2018/11/19.
//  Copyright © 2018 qushenghuo. All rights reserved.
//

#import "MPlayerBottomView.h"

#define WIDGETHEIGHT 40.0f   //控件高度,按钮宽度
#define TIMELABELSEP 10.0f   //时间标签前后间隔
#define WIDGETFX 15.0f       //控件起始fx

@implementation MPlayerBottomView

-(UIView *)blkTransparentView{
    if (!_blkTransparentView) {
        _blkTransparentView = [UIView new];
        _blkTransparentView.backgroundColor = [UIColor blackColor];
        _blkTransparentView.alpha = 0.6;
    }
    
    return _blkTransparentView;
}

-(UIView *)widgetBGView{
    if (!_widgetBGView) {
        _widgetBGView = [UIView new];
        _widgetBGView.backgroundColor = [UIColor clearColor];
    }
    
    return _widgetBGView;
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [UIProgressView new];
        [_progressView setProgress:0];
        _progressView.progressTintColor = APP230GRAY;
    }
    
    return _progressView;
}

-(UISlider *)playSlider{
    if (!_playSlider) {
        _playSlider = [UISlider new];
        _playSlider.minimumTrackTintColor = APPGOLDERCOLOR;
        _playSlider.maximumTrackTintColor = [UIColor clearColor];
        [_playSlider setThumbImage:[UIImage imageNamed:@"c_thumb_icon"] forState:UIControlStateNormal];
    }
    
    return _playSlider;
}

-(UILabel *)currentTimeLabel{
    if (!_currentTimeLabel) {
        _currentTimeLabel = [UILabel new];
        _currentTimeLabel.font = [UIFont systemFontOfSize:11];
        _currentTimeLabel.textColor = APPGOLDERCOLOR;
        _currentTimeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _currentTimeLabel;
}

-(UILabel *)timeSepLabel{
    if (!_timeSepLabel) {
        _timeSepLabel = [UILabel new];
        _timeSepLabel.font = [UIFont systemFontOfSize:11];
        _timeSepLabel.textColor = APPGOLDERCOLOR;
        _timeSepLabel.text = @"/";
        _timeSepLabel.backgroundColor = [UIColor clearColor];
        _timeSepLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _timeSepLabel;
}

-(UILabel *)totalTimeLabel{
    if (!_totalTimeLabel) {
        _totalTimeLabel = [UILabel new];
        _totalTimeLabel.font = [UIFont systemFontOfSize:11];
        _totalTimeLabel.textColor = APPGOLDERCOLOR;
        _totalTimeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _totalTimeLabel;
}

-(UIButton *)selectCapBtn{
    if (!_selectCapBtn) {
        _selectCapBtn = [UIButton new];
        _selectCapBtn.backgroundColor = [UIColor clearColor];
        [_selectCapBtn setTitle:@"选择" forState:UIControlStateNormal];
        _selectCapBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_selectCapBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectCapBtn addTarget:self action:@selector(selectCapBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _selectCapBtn;
}

-(UIButton *)fullScreenBtn{
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton new];
        _fullScreenBtn.backgroundColor = [UIColor clearColor];
        [_fullScreenBtn addTarget:self action:@selector(fullScreenBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _fullScreenBtn;
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
    
    fw = self.width;
    fh = self.height;
    
    [self setUIWith:self.fullScreenFlag];
}

-(void)setPlaydurationStr:(NSString *)playdurationStr{
    if (!playdurationStr) {
        return;
    }
    
    _playdurationStr = playdurationStr;
    self.currentTimeLabel.text = _playdurationStr;
}

-(void)setDurationStr:(NSString *)durationStr{
    if (!durationStr) {
        return;
    }
    _durationStr = durationStr;
    
    WeakSelf;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *durationTimeStr = durationStr;
        
        CGSize labelSize = CGSizeMake(MAXFLOAT, 30);
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:11],NSFontAttributeName,nil];
        CGSize  actualsize =[durationTimeStr boundingRectWithSize:labelSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        
        self->timeLabelWidth = actualsize.width+6;
        
        self->timeshowSepWidth = TIMELABELSEP+2*self->timeLabelWidth+TIMELABELSEP+5;

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setUIWith:weakSelf.fullScreenFlag];
            weakSelf.totalTimeLabel.text = durationTimeStr;
        });
    });
}

-(void)setUIWith:(BOOL) fullSFlag{
    
    if (fullSFlag) {
        self.widgetBGView.frame = CGRectMake(0, 5, fw, WIDGETHEIGHT);
        
        self.playSlider.frame = CGRectMake(WIDGETFX-2, 5, fw-11-timeshowSepWidth-WIDGETHEIGHT*2, 30);
        self.progressView.frame = CGRectMake(WIDGETFX, 19, fw-WIDGETFX-timeshowSepWidth-WIDGETHEIGHT*2, 2);
        
        self.fullScreenBtn.frame = CGRectMake(fw-WIDGETHEIGHT, 0, WIDGETHEIGHT, WIDGETHEIGHT);
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"c_zoomout_icon"] forState:UIControlStateNormal];

        self.selectCapBtn.frame = CGRectMake(fw-WIDGETHEIGHT-WIDGETHEIGHT, 0, WIDGETHEIGHT, WIDGETHEIGHT);
        [self.widgetBGView addSubview:self.selectCapBtn];
        
        CGFloat timeLabelStartx = self.progressView.frame.size.width+TIMELABELSEP+WIDGETFX;
        self.currentTimeLabel.frame = CGRectMake(timeLabelStartx, 0, timeLabelWidth, WIDGETHEIGHT);
        self.timeSepLabel.frame = CGRectMake(timeLabelStartx+timeLabelWidth, 0, 5, WIDGETHEIGHT);
        self.totalTimeLabel.frame = CGRectMake(timeLabelStartx+timeLabelWidth+5, 0, timeLabelWidth, WIDGETHEIGHT);

    } else {
        [self.selectCapBtn removeFromSuperview];
        
        self.widgetBGView.frame = CGRectMake(0, 0, fw, WIDGETHEIGHT);
        
        self.playSlider.frame = CGRectMake(WIDGETFX-2, 5, fw-11-timeshowSepWidth-WIDGETHEIGHT, 30);
        self.progressView.frame = CGRectMake(WIDGETFX, 19, fw-WIDGETFX-timeshowSepWidth-WIDGETHEIGHT, 2);
        self.fullScreenBtn.frame = CGRectMake(fw-WIDGETHEIGHT, 0, WIDGETHEIGHT, WIDGETHEIGHT);
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"c_fullscreen_icon"] forState:UIControlStateNormal];

        CGFloat timeLabelStartx = self.progressView.frame.size.width+TIMELABELSEP+WIDGETFX;
        self.currentTimeLabel.frame = CGRectMake(timeLabelStartx, 0, timeLabelWidth, WIDGETHEIGHT);
        self.timeSepLabel.frame = CGRectMake(timeLabelStartx+timeLabelWidth, 0, 5, WIDGETHEIGHT);
        self.totalTimeLabel.frame = CGRectMake(timeLabelStartx+timeLabelWidth+5, 0, timeLabelWidth, WIDGETHEIGHT);
    }

    [self.widgetBGView addSubview:self.progressView];
    [self.widgetBGView addSubview:self.playSlider];
    [self.widgetBGView addSubview:self.fullScreenBtn];
    [self.widgetBGView addSubview:self.currentTimeLabel];
    [self.widgetBGView addSubview:self.timeSepLabel];
    [self.widgetBGView addSubview:self.totalTimeLabel];

    self.blkTransparentView.frame = CGRectMake(0, 0, fw, fh);
    
    [self addSubview:self.blkTransparentView];
    [self addSubview:self.widgetBGView];
}


-(void)showMPBottomView{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

-(void)hideMPBottomView{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }];
}

-(void)fullScreenBtnTouch{
    
    if ([_delegate respondsToSelector:@selector(fullScreenBtnTouchSelector)]) {
        [_delegate fullScreenBtnTouchSelector];
    }
    
}

-(void)selectCapBtnTouch{
    NSLog(@"selectCapBtnTouch");
    if ([_delegate respondsToSelector:@selector(selectCapBtnTouchSelector)]) {
        [_delegate selectCapBtnTouchSelector];
    }

}


@end
