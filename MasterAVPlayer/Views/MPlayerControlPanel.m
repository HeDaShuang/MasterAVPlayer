//
//  MPlayerControlPanel.m
//  MasterAVPlayer
//
//  Created by eric on 2019/1/16.
//  Copyright © 2019 eric. All rights reserved.
//

#import "MPlayerControlPanel.h"

@implementation MPlayerControlPanel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        self.alpha = 0.8;
        
        self.coverStr = @"testcover1";
        
        [self addSubview:self.videoCover];
        [self addSubview:self.quitFScreenBtn];
        [self addSubview:self.playBtn];
        [self addSubview:self.previousBtn];
        [self addSubview:self.nextBtn];
        [self addSubview:self.reloadLabel];
        [self addSubview:self.loadingIV];
    }
    
    return self;
}

-(void)setFullScreenFlag:(BOOL)fullScreenFlag{
    
    _fullScreenFlag = fullScreenFlag;
    [self setControlPanelUISelector];
}

-(void)setControlPanelUISelector{
    if (self.fullScreenFlag) {
        self.quitFScreenBtn.hidden = NO;
        self.videoCover.frame = CGRectMake(0, 0, self.height, self.width);
        self.quitFScreenBtn.frame = CGRectMake(0, 10, PLYERBTNWIDTH, PLYERBTNWIDTH);
        
        self.loadingIV.frame = CGRectMake(self.height/2-PLYERBTNWIDTH/2, self.width/2-PLYERBTNWIDTH/2-15, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.reloadLabel.frame = CGRectMake(self.height/2-130/2, self.width/2-PLYERBTNWIDTH/2+20, 130, PLYERBTNWIDTH);
        
        self.playBtn.frame = CGRectMake(self.height/2-PLYERBTNWIDTH/2, self.width/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.previousBtn.frame = CGRectMake(FSBTNFX, self.width/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.nextBtn.frame = CGRectMake(self.height-FSBTNFX-PLYERBTNWIDTH, self.width/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
    } else {
        self.quitFScreenBtn.hidden = YES;
        self.videoCover.frame = CGRectMake(0, 0, self.width, self.height);
        self.loadingIV.frame = CGRectMake(self.width/2-PLYERBTNWIDTH/2, self.height/2-PLYERBTNWIDTH/2-15, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.reloadLabel.frame = CGRectMake(self.width/2-130/2, self.height/2-PLYERBTNWIDTH/2+20, 130, PLYERBTNWIDTH);

        self.playBtn.frame = CGRectMake(self.width/2-PLYERBTNWIDTH/2, self.height/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.previousBtn.frame = CGRectMake(SBTNFX, self.height/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.nextBtn.frame = CGRectMake(self.width-SBTNFX-PLYERBTNWIDTH, self.height/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
    }
    
}

-(void)setCoverStr:(NSString *)coverStr{
    _coverStr = coverStr;
}


-(UIButton *)quitFScreenBtn{
    if (!_quitFScreenBtn) {
        _quitFScreenBtn = [UIButton new];
        [_quitFScreenBtn setImage:[UIImage imageNamed:@"backarrowicon50"] forState:UIControlStateNormal];
        
        //[_quitFScreenBtn addTarget:self action:@selector(quitFScreenBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _quitFScreenBtn;
}

-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton new];
        _playBtn.backgroundColor = [UIColor yellowColor];
        [_playBtn setImage:[UIImage imageNamed:@"c_pause_icon"] forState:UIControlStateNormal];
        //[_playBtn addTarget:self action:@selector(playBtnTouchSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(UIButton *)previousBtn{
    if (!_previousBtn) {
        _previousBtn = [UIButton new];
        _previousBtn.backgroundColor = [UIColor cyanColor];
        [_previousBtn setImage:[UIImage imageNamed:@"c_previous_icon"] forState:UIControlStateNormal];
        //[_previousBtn addTarget:self action:@selector(previousBtnTouchSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _previousBtn;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
        _nextBtn.backgroundColor = [UIColor redColor];
        [_nextBtn setImage:[UIImage imageNamed:@"c_next_icon"] forState:UIControlStateNormal];
        //[_nextBtn addTarget:self action:@selector(nextBtnTouchSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextBtn;
}

-(UIImageView *)videoCover{
    if (!_videoCover) {
        _videoCover = [UIImageView new];
        _videoCover.contentMode = UIViewContentModeScaleAspectFill;
        _videoCover.clipsToBounds = YES;
        _videoCover.backgroundColor = [UIColor blackColor];
        [_videoCover setImage:[UIImage imageNamed:@"testcover1"]];
    }
    
    return _videoCover;
}

-(UIImageView *)loadingIV{
    if (!_loadingIV) {
        _loadingIV = [UIImageView new];
        _loadingIV.hidden = YES;
        [_loadingIV setImage:[UIImage imageNamed:@"c_load_icon"]];
        _loadingIV.contentMode = UIViewContentModeCenter;
    }
    
    return _loadingIV;
}

-(UILabel *)reloadLabel{
    if (!_reloadLabel) {
        _reloadLabel = [UILabel new];
        _reloadLabel.hidden = YES;
        _reloadLabel.backgroundColor = [UIColor clearColor];
        _reloadLabel.font = [UIFont systemFontOfSize:15];
        _reloadLabel.textColor = [UIColor whiteColor];
        _reloadLabel.textAlignment = NSTextAlignmentCenter;
        _reloadLabel.text = @"加载失败 点击重试";
    }
    
    return _reloadLabel;
}


@end
