//
//  MasterAVPlayer.m
//  MasterAVPlayer
//
//  Created by eric on 2019/1/11.
//  Copyright © 2019 eric. All rights reserved.
//

#import "MasterAVPlayer.h"

@implementation MasterAVPlayer

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        showflag = YES;      //默认显示播放器操作控件
        self.playflag = NO;  //默认未点击播放按钮

        self.playerCPanel = [[MPlayerControlPanel alloc] init];
        self.mpbView = [[MPlayerBottomView alloc] init];
        self.mpbView.delegate = self;
        [self.mpbView.playSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.mpbView.playSlider addTarget:self action:@selector(sliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tapSlider = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
        tapSlider.delegate = self;
        
        
        [self.mpbView.playSlider addGestureRecognizer:tapSlider];

        
        self.chaptersListView = [[ChaptersListView alloc] init];

        [self addSubview:self.playerCPanel];
        [self addSubview:self.mpbView];
        [self addSubview:self.chaptersListView];
        
        [self.playerSuperView addSubview:self];

        [self addObserver];
        
        //添加点击手势
        UITapGestureRecognizer *tapGRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRSelector)];
        [self addGestureRecognizer:tapGRecognizer];

    }
    
    return self;
}

-(void)tapGRSelector{
    NSLog(@"tapGRSelector");
    if (showflag) {
        [self hideplayerWidgets];
    } else {
        
        [self showplayerWidgets];
    }
    
    [self invalidateTimer];

    if (self.playflag) {
        //播放中TAPTCOUNT秒后自动隐藏控件
        tapGRTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tapGRTimerSelector) userInfo:nil repeats:YES];
        [tapGRTimer setFireDate:[NSDate distantPast]];
    }
}

-(void)hideplayerWidgets{
    [self.playerCPanel hidePanelWidgetsBool:YES];
    self.mpbView.hidden = YES;
    showflag = NO;
}

-(void)showplayerWidgets{
    [self.playerCPanel hidePanelWidgetsBool:NO];
    self.mpbView.hidden = NO;
    showflag = YES;

}

-(void)tapGRTimerSelector{
    ++timerCount;
    if (timerCount > TAPTCOUNT) {
        [self hideplayerWidgets];
    }
}

-(void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOritentationChangeSelector) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)deviceOritentationChangeSelector{
    //    if(!self.masterPlayer) return;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
        }
            break;
        case UIInterfaceOrientationPortrait:{
            [self quitFromFullScreen];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            [self rotatetoFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            [self rotatetoFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}


//非全屏
-(void)quitFromFullScreen
{
//    if(!self.masterPlayer) return;
    
    [self removeFromSuperview];
    
    WeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.transform = CGAffineTransformIdentity;
        weakSelf.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth/1.875);
        weakSelf.fullScreenFlag = NO;
    } completion:^(BOOL finished) {
    }];
    
    [self.playerSuperView addSubview:self];
    
}

//全屏
-(void)rotatetoFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    //    if(!self.masterPlayer) return;
    
    [self removeFromSuperview];
    
    self.transform = CGAffineTransformIdentity;


    [UIView animateWithDuration:0.3 animations:^{
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
        else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else{
            NSLog(@"不用旋转");
        }
        

    } completion:^(BOOL finished) {
        
    }];
    
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight); //0 0 375  667
    self.fullScreenFlag = YES;

    [[UIApplication sharedApplication].keyWindow addSubview:self];

}

-(void)setFullScreenFlag:(BOOL)fullScreenFlag{
    
    _fullScreenFlag = fullScreenFlag;
    
    [self setUI];
}


-(void)setUI{
    
    if (self.fullScreenFlag) {
        
        self.chaptersListView.hidden = NO;
        self.chaptersListView.frame = CGRectMake(0, self.width, self.height, 90);
        self.mpbView.frame = CGRectMake(0, self.width-50, self.height, 50);
        self.mplayerLayer.frame = CGRectMake(0, 0, self.height, self.width);
        self.playerCPanel.frame = CGRectMake(0, 0, self.height, self.width);
        
    } else {
        self.chaptersListView.hidden = YES;
        
        self.mpbView.frame = CGRectMake(0, self.height-40, self.width, 40);
        self.mplayerLayer.frame = CGRectMake(0, 0, self.width, self.height);
        self.playerCPanel.frame = CGRectMake(0, 0, self.width, self.height);
    }
    
    //for test data
    self.mpbView.durationStr = @"00:00:50";
    self.mpbView.playdurationStr = @"00:00:10";
    
    self.mpbView.fullScreenFlag = self.fullScreenFlag;
    self.chaptersListView.fullScreenFlag = self.fullScreenFlag;
    self.playerCPanel.fullScreenFlag = self.fullScreenFlag;
}

-(void)setTestVideoArr:(NSMutableArray *)testVideoArr{
    if (!testVideoArr) {
        return;
    }
    
    NSLog(@"%@", testVideoArr);
    NSDictionary *dic = [testVideoArr objectAtIndex:0];
    self.playURLStr = [NSString stringWithFormat:@"%@", dic[@"url"]];
}

-(void)setPlayURLStr:(NSString *)playURLStr{
    if (!playURLStr) {
        return;
    }
    
    _playURLStr = playURLStr;
    self.currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.playURLStr]];
    [self loadORRloadPlayer];
}

-(void)loadORRloadPlayer{
    if (!_masterPlayer) {
        self.masterPlayer = [AVPlayer playerWithPlayerItem:self.currentItem];
        self.masterPlayer.usesExternalPlaybackWhileExternalScreenIsActive = YES;
        self.mplayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.masterPlayer];
        self.mplayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer insertSublayer:self.mplayerLayer atIndex:0];
        
    } else {
        [self.masterPlayer replaceCurrentItemWithPlayerItem:nil];
        [self.masterPlayer replaceCurrentItemWithPlayerItem:self.currentItem];
    }
    
    if (self.fullScreenFlag) {
        self.mplayerLayer.frame = CGRectMake(0, 0, self.height, self.width);
    }
    else{
        self.mplayerLayer.frame = CGRectMake(0, 0, self.width, self.height);
    }
}

-(void)setCurrentItem:(AVPlayerItem *)currentItem{
    if (!currentItem || (_currentItem == currentItem)) {
        return;
    }
    
    _currentItem = currentItem;
    if (_currentItem) {
        //这里导致不走dealloc
        [_currentItem addObserver:self
                       forKeyPath:@"status"
                          options:NSKeyValueObservingOptionNew
                          context:MasterPlayerStatusObservationContext];
        [_currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:MasterPlayerStatusObservationContext];
        // 缓冲区空了，需要等待数据
        [_currentItem addObserver:self forKeyPath:@"playbackBufferEmpty" options: NSKeyValueObservingOptionNew context:MasterPlayerStatusObservationContext];
        // 缓冲区有足够数据可以播放了
        [_currentItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options: NSKeyValueObservingOptionNew context:MasterPlayerStatusObservationContext];
        // 添加视频播放结束通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playDidFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
    }
}

-(void)playDidFinished{
    self.mplyerstatus = MPlyerStatusFailed;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == MasterPlayerStatusObservationContext) {
        if ([keyPath isEqualToString:@"status"]) {
            AVPlayerStatus avplayerStatus = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
            switch (avplayerStatus) {
                case AVPlayerStatusUnknown:
                {
                    self.mplyerstatus = MPlyerStatusBuffering;
                }
                    break;
                case AVPlayerStatusReadyToPlay:
                {
                    self.mplyerstatus = MPlyerStatusReadytoplay;
                    
                    //监听播放中
                    //[self playingTimeObserverSelector];
                }
                    break;
                case AVPlayerStatusFailed:
                {
                    NSError *error = [self.masterPlayer.currentItem error];
                    if (error) {
                        self.mplyerstatus = MPlyerStatusFailed;
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
            // 计算缓冲进度
//            NSTimeInterval timeInterval = [self availableDuration];
//            CMTime duration             = self.currentItem.duration;
//            CGFloat totalDuration       = CMTimeGetSeconds(duration);
//            if (isnan(totalDuration)) {
//                totalDuration = 0;
//            }
//
//            [self.mpbView.progressView setProgress:timeInterval/totalDuration animated:NO];
//            if (self.mplyerstatus == MPlyerStatusBuffering) {
//                [self showLoading];
//            }
//            else{
//                self.loadingIV.hidden = YES;
//                self.reloadLabel.hidden = YES;
//                self.mpsharePopView.hidden = YES;
//            }
        }
        else if([keyPath isEqualToString:@"playbackBufferEmpty"]){
            //缓冲区为空
            if (self.currentItem.playbackBufferEmpty ) {
                self.mplyerstatus = MPlyerStatusBuffering;
//                [self bufferingCallback];
            }
        }
        else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
            //缓冲区有足够的数据可以播放了
            if (self.currentItem.playbackLikelyToKeepUp && self.mplyerstatus == MPlyerStatusBuffering) {
                if (!(self.mplyerstatus==MPlyerStatusStopped||self.mplyerstatus==MPlyerStatusPasue)) {
                    self.mplyerstatus = MPlyerStatusPlaying;
                }
            }
        }
        else {
            NSLog(@"无效keypath");
        }
    }
}

-(void)setMplyerstatus:(MPlyerStatus)mplyerstatus{
    _mplyerstatus = mplyerstatus;
    
    NSLog(@"_mplyerstatus = %ld", (long)_mplyerstatus);
    
    self.playerCPanel.mplyerstatus = mplyerstatus;
    
    if (self.mplyerstatus == MPlyerStatusFailed) {
        [self.masterPlayer play];
    }
    else if (self.mplyerstatus == MPlyerStatusBuffering){

    }
    else if (self.mplyerstatus == MPlyerStatusReadytoplay){
        [self.masterPlayer play];
    }
    else if (self.mplyerstatus == MPlyerStatusPlaying){
        //停止加载动画
        //[self masterplayerPlay];
    }
    else if (self.mplyerstatus == MPlyerStatusStopped){
    }
    else {
        //播放完成
    }
}


//mpplayerBottomDelegate
-(void)fullScreenBtnTouchSelector{
    if (self.fullScreenFlag) {
        [self quitFromFullScreen];
    } else {
        [self rotatetoFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }
}

-(void)selectCapBtnTouchSelector{
    
}

-(void)invalidateTimer
{
    timerCount = 0;
    [tapGRTimer invalidate];
    tapGRTimer = nil;
}


-(void)sliderValueChanged:(UISlider *)slider{
    self.dragingSliderFlag = YES;
}

-(void)sliderTouchEnded:(UISlider *)slider{
    self.dragingSliderFlag = NO;
    
    CGFloat total = (CGFloat)self.currentItem.duration.value/self.currentItem.duration.timescale;
    NSInteger slideSeconds = floor(total*slider.value);
    
    [self sliderValuechageplay:slideSeconds];
}

- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchLocation = [sender locationInView:self.mpbView.playSlider ];
    CGFloat value = (self.mpbView.playSlider.maximumValue - self.mpbView.playSlider.minimumValue) * (touchLocation.x/self.mpbView.playSlider.frame.size.width);
    
    [self.mpbView.playSlider  setValue:value animated:YES];
    
    CGFloat total = (CGFloat)self.currentItem.duration.value/self.currentItem.duration.timescale;
    NSInteger slideSeconds = floor(total*self.mpbView.playSlider.value);
    
    [self sliderValuechageplay:slideSeconds];
}

-(void)sliderValuechageplay:(NSInteger) slideSeconds{
    [self.masterPlayer seekToTime:CMTimeMakeWithSeconds(slideSeconds, _currentItem.currentTime.timescale)];
    if (self.masterPlayer.rate != 1.f) {
        //[self masterplayerPlay];
    }
}

//获取视频长度
-(double)videoDuration{
    AVPlayerItem *playerItem = self.masterPlayer.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }
    else
        return 0.f;
}

//获取视频当前播放的时间
- (double)videocurrentTime{
    if (self.masterPlayer) {
        return CMTimeGetSeconds([self.masterPlayer currentTime]);
    }else{
        return 0.0;
    }
}

//设置当前播放时间
-(void)setVideoCurrentTime:(double) time{
    WeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.masterPlayer seekToTime:CMTimeMakeWithSeconds(time, weakSelf.currentItem.currentTime.timescale) completionHandler:^(BOOL finished) {
        }];
    });
}








@end
