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
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        
        self.coverStr = @"testcover1";
        self.statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        
        [self addSubview:self.videoCover];
        [self addSubview:self.quitFScreenBtn];
        [self addSubview:self.playBtn];
        [self addSubview:self.previousBtn];
        [self addSubview:self.nextBtn];
        [self addSubview:self.reloadLabel];
        [self addSubview:self.loadingIV];
        [self addSubview:self.statusBar];
        
    }
    
    return self;
}


-(void)setFullScreenFlag:(BOOL)fullScreenFlag{
    _fullScreenFlag = fullScreenFlag;
    [self setControlPanelUISelector];
}

-(void)setMplyerstatus:(MPlyerStatus)mplyerstatus{
    _mplyerstatus = mplyerstatus;
    if (self.mplyerstatus == MPlyerStatusFailed) {
        [self showPlayerLoading];
    }
    else if (self.mplyerstatus == MPlyerStatusBuffering){
        [self showPlayerLoading];
    }
    else if (self.mplyerstatus == MPlyerStatusReadytoplay){
        [self stopLoadingAnimat];
        [self hideLoadingWidgets:YES];
        self.videoCover.hidden = YES;
    }
    else if (self.mplyerstatus == MPlyerStatusPlaying){
        [self stopLoadingAnimat];
    }
    else if (self.mplyerstatus == MPlyerStatusStopped){
        [self stopLoadingAnimat];
    }
    else {
        //播放完成
        [self stopLoadingAnimat];
        [self hideLoadingWidgets:YES];
        [_playBtn setImage:[UIImage imageNamed:@"c_pause_icon"] forState:UIControlStateNormal];
    }

}

-(void)setControlPanelUISelector{
    
    self.quitFScreenBtn.hidden = YES;
    self.videoCover.frame = CGRectMake(0, 0, self.width, self.height);
    self.loadingIV.frame = CGRectMake(self.width/2-PLYERBTNWIDTH/2, self.height/2-PLYERBTNWIDTH/2-15, PLYERBTNWIDTH, PLYERBTNWIDTH);
    self.reloadLabel.frame = CGRectMake(self.width/2-130/2, self.height/2-PLYERBTNWIDTH/2+20, 130, PLYERBTNWIDTH);
    
    self.playBtn.frame = CGRectMake(self.width/2-PLYERBTNWIDTH/2, self.height/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
    self.previousBtn.frame = CGRectMake(SBTNFX, self.height/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
    self.nextBtn.frame = CGRectMake(self.width-SBTNFX-PLYERBTNWIDTH, self.height/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
    
    self.statusBar.frame = CGRectMake(0, 0, self.width, 20);
    
    if (self.fullScreenFlag) {
        self.statusBar.hidden = NO;
        self.quitFScreenBtn.hidden = YES;
    } else {
        self.statusBar.hidden = NO;
        self.quitFScreenBtn.hidden = NO;
    }

}

-(void)setCoverStr:(NSString *)coverStr{
    _coverStr = coverStr;
}

-(UIButton *)quitFScreenBtn{
    if (!_quitFScreenBtn) {
        _quitFScreenBtn = [UIButton new];
        [_quitFScreenBtn setImage:[UIImage imageNamed:@"backarrowicon50"] forState:UIControlStateNormal];
        [_quitFScreenBtn addTarget:self action:@selector(quitFScreenBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _quitFScreenBtn;
}

-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton new];
        _playBtn.backgroundColor = [UIColor clearColor];
        [_playBtn setImage:[UIImage imageNamed:@"c_pause_icon"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnTouchSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(UIButton *)previousBtn{
    if (!_previousBtn) {
        _previousBtn = [UIButton new];
        _previousBtn.backgroundColor = [UIColor clearColor];
        [_previousBtn setImage:[UIImage imageNamed:@"c_previous_icon"] forState:UIControlStateNormal];
        [_previousBtn addTarget:self action:@selector(previousBtnTouchSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _previousBtn;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
        _nextBtn.backgroundColor = [UIColor clearColor];
        [_nextBtn setImage:[UIImage imageNamed:@"c_next_icon"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnTouchSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextBtn;
}

-(UIImageView *)videoCover{
    if (!_videoCover) {
        _videoCover = [UIImageView new];
        _videoCover.contentMode = UIViewContentModeScaleAspectFill;
        _videoCover.clipsToBounds = YES;
        _videoCover.backgroundColor = [UIColor clearColor];
        [_videoCover setImage:[UIImage imageNamed:@"bb"]];
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


-(void)playBtnTouchSelector{
    if ([_delegate respondsToSelector:@selector(playerPanelDelegatePlayBtnTouchSelector)]) {
        [_delegate playerPanelDelegatePlayBtnTouchSelector];
    }
}

-(void)nextBtnTouchSelector{
    if ([_delegate respondsToSelector:@selector(playerPanelDelegateNextBtnTouchSelector)]) {
        [_delegate playerPanelDelegateNextBtnTouchSelector];
    }
}

-(void)previousBtnTouchSelector{
    if ([_delegate respondsToSelector:@selector(playerPanelDelegatePreviousBtnTouchSelector)]) {
        [_delegate playerPanelDelegatePreviousBtnTouchSelector];
    }
}

-(void)quitFScreenBtnSelector{
    if ([_delegate respondsToSelector:@selector(playerPanelDelegateQuitFScreenBtnSelector)]) {
        [_delegate playerPanelDelegateQuitFScreenBtnSelector];
    }
}

//显示和隐藏播放相关控件
-(void)hidePanelWidgetsBool:(BOOL) hideFlag{
    
    WeakSelf;
    
    if (hideFlag) {
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.previousBtn.alpha = 0;
            weakSelf.playBtn.alpha = 0;
            weakSelf.nextBtn.alpha = 0;
            weakSelf.quitFScreenBtn.alpha = 0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.previousBtn.alpha = 1;
            weakSelf.playBtn.alpha = 1;
            weakSelf.nextBtn.alpha = 1;
            weakSelf.quitFScreenBtn.alpha = 1;
            
            weakSelf.loadingIV.hidden = YES;
            weakSelf.reloadLabel.hidden = YES;
        }];
    }
}

-(void)showPlayerLoadFailed{
    //显示加载中
    self.reloadLabel.hidden = NO;
    self.loadingIV.hidden = NO;
    
    if (self.fullScreenFlag) {
        self.loadingIV.frame = CGRectMake(self.height/2-PLYERBTNWIDTH/2, self.width/2-PLYERBTNWIDTH/2-15, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.reloadLabel.frame = CGRectMake(self.height/2-130/2, self.width/2-PLYERBTNWIDTH/2+20, 130, PLYERBTNWIDTH);
        
    } else {
        self.loadingIV.frame = CGRectMake(self.width/2-PLYERBTNWIDTH/2, self.height/2-PLYERBTNWIDTH/2-15, PLYERBTNWIDTH, PLYERBTNWIDTH);
        self.reloadLabel.frame = CGRectMake(self.width/2-130/2, self.height/2-PLYERBTNWIDTH/2+20, 130, PLYERBTNWIDTH);
    }
    
    //隐藏其他控件
    [self hidePanelWidgetsBool:YES];
}

-(void)showPlayerLoading{
    
    //隐藏其他控件
    [self hidePanelWidgetsBool:YES];

    self.loadingIV.hidden = NO;
    self.reloadLabel.hidden = YES;

    //显示加载中
    if (self.fullScreenFlag) {
        self.loadingIV.frame = CGRectMake(self.height/2-PLYERBTNWIDTH/2, self.width/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
    } else {
        self.loadingIV.frame = CGRectMake(self.width/2-PLYERBTNWIDTH/2, self.height/2-PLYERBTNWIDTH/2, PLYERBTNWIDTH, PLYERBTNWIDTH);
    }
    
    //加载动画
    [self startLoadingAnimat];
}

//开始加载动画
-(void)startLoadingAnimat{
    
    [self invalidateTimer];
    [self.loadingIV.layer removeAllAnimations];
    
    loadingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadingTimerSelector) userInfo:nil repeats:YES];
    [loadingTimer setFireDate:[NSDate distantPast]];
    
    WeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotationAnimation.toValue = @(2*M_PI);
        rotationAnimation.duration = 1;
        rotationAnimation.removedOnCompletion = false;
        rotationAnimation.repeatCount = MAXFLOAT;
        [weakSelf.loadingIV.layer addAnimation:rotationAnimation forKey:nil];
    }) ;
}

//停止加载动画
-(void)stopLoadingAnimat{
    [self hidePanelWidgetsBool:YES];
    
    [self.loadingIV.layer removeAllAnimations];
    [self invalidateTimer];
}

-(void)loadingTimerSelector{
    ++loadingTCount;
    
    if (loadingTCount > LOADTCOUNT) {
        [self stopLoadingAnimat];
        [self invalidateTimer];
        WeakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showPlayerLoadFailed];
        });
    }
}

-(void)invalidateTimer{
//    timerCount = 0;
//    [tapGRTimer invalidate];
//    tapGRTimer = nil;
    
    loadingTCount = 0;
    [loadingTimer invalidate];
    loadingTimer = nil;
}

-(void)hideLoadingWidgets:(BOOL) hideFlag{
    if (hideFlag) {
        self.loadingIV.hidden = YES;
        self.reloadLabel.hidden = YES;

    } else {
        self.loadingIV.hidden = NO;
        self.reloadLabel.hidden = NO;

    }
}



@end
