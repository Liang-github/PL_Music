//
//  DetailControlViewController.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/14.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "DetailControlViewController.h"

@interface DetailControlViewController ()
{
    MusicPlayerManager *musicPlayer;
    OMSongInfo *songInfo;
}
@end

@implementation DetailControlViewController
int lrcIndex = 0;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configSubView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getShuffleAndRepeatState];
}
- (void)viewWillAppear:(BOOL)animated {
    [self playStateRecover];
}
- (void)configSubView {
    musicPlayer = [MusicPlayerManager sharedManager];
    songInfo = [OMSongInfo shareManager];
    
    _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/5)];
    [_topView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topView];
    
    _midView = [[MidView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/5, self.view.frame.size.width, self.view.frame.size.height/5*3)];
    [self.view addSubview:_midView];
    
    _bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/5*4, self.view.frame.size.width, self.view.frame.size.height/5)];
    [self.view addSubview:_bottomView];
    
    _songListView = [[SongListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.618)];
    _songListView.backgroundColor = [UIColor whiteColor];
    
    [_bottomView.playOrPauseButton addTarget:self action:@selector(playOrPauseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView.nextSongButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView.preSongButton addTarget:self action:@selector(preButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView.playModeButton addTarget:self action:@selector(shuffleAndRepeat) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView.songListButton addTarget:self action:@selector(songListButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView.songSlider addTarget:self action:@selector(playbackSliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [_bottomView.songSlider addTarget:self action:@selector(playbackSliderValueChangedFinish) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置背景图片
    [self setBackgroundImage:[UIImage imageNamed:@"backgroundImage3"]];
}
#pragma mark - 状态恢复
- (void)playStateRecover {
    [_midView.midIconView.imageView stopRotating];
    
    if (musicPlayer.play.rate == 1) {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_play"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_play_prs"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView resumeRotate];
    } else {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pause_prs"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView stopRotating];
    }
}
#pragma mark - 设置detail控制界面背景图片
- (void)setBackgroundImage:(UIImage *)image {
    _backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-[UIScreen mainScreen].bounds.size.width/2, -[UIScreen mainScreen].bounds.size.height/2, ScreenWidth*2, ScreenHeight*2)];
    _backgroudImageView.image = image;
    _backgroudImageView.clipsToBounds = YES;
    [self.view addSubview:_backgroudImageView];
    [self.view sendSubviewToBack:_backgroudImageView];
    
    // 毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualView.alpha = 1;
    visualView.frame = CGRectMake(-ScreenWidth/2, -ScreenHeight/2, ScreenWidth*2, ScreenHeight*2);
    visualView.clipsToBounds = YES;
    [_backgroudImageView addSubview:visualView];
}
#pragma mark - 播放或暂停
- (void)playOrPauseButtonAction {
    if (musicPlayer.play.rate == 0) {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_play"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_play_prs"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView resumeRotate];
        [musicPlayer startPlay];
    } else {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pause_prs"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView stopRotating];
        [musicPlayer stopPlay];
    }
}
#pragma mark -下一曲
- (void)nextButtonAction {
    musicPlayer.playingIndex = songInfo.playSongIndex;
    switch (musicPlayer.shuffleAndRepeatState) {
        case RepeatPlayMode:
        {
            musicPlayer.playingIndex ++;
            if (musicPlayer.playingIndex >= songInfo.OMSongs.count) {
                musicPlayer.playingIndex = 0;
            }
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            
        }
            break;
        case ShufflePlayMode:
        {
            if (musicPlayer.playingIndex == songInfo.OMSongs.count - 1) {
                musicPlayer.playingIndex = [self getRandomNumber:0 with:songInfo.OMSongs.count - 2];
            } else {
                musicPlayer.playingIndex = [self getRandomNumber:musicPlayer.playingIndex + 1 with:songInfo.OMSongs.count - 1];
            }
        }
            break;
            
        default:
            break;
    }
    
    if (musicPlayer.playingIndex != songInfo.playSongIndex) {
        if (songInfo.playSongIndex < songInfo.OMSongs.count) {
            OMHotSongInfo *info = songInfo.OMSongs[musicPlayer.playingIndex];
            [songInfo setSongInfo:info];
            [songInfo getSelectedSong:info.song_id index:songInfo.playSongIndex + 1];
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatPlay" object:self];
    }
}
#pragma - mark 上一曲
-(void) preButtonAction {
    
    musicPlayer.playingIndex = songInfo.playSongIndex;
    
    switch (musicPlayer.shuffleAndRepeatState)
    {
        case RepeatPlayMode:
        {
            if ( musicPlayer.playingIndex == 0)//第一首
            {
                musicPlayer.playingIndex = songInfo.OMSongs.count - 1;  //跳到最后一首
            }
            else
            {
                musicPlayer.playingIndex--;    //索引为上一首
            }
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            
        }
            break;
        case ShufflePlayMode:
        {
            if ( musicPlayer.playingIndex == 0)//是第一首歌
            {
                musicPlayer.playingIndex = [self getRandomNumber:1 with:(songInfo.OMSongs.count - 1)];//播放除第一首歌之外的所有歌曲
            }
            
            else
            {
                musicPlayer.playingIndex = [self getRandomNumber:0 with:( musicPlayer.playingIndex - 1)];
            }
        }
            break;
        default:
            break;
    }
    
    if ( musicPlayer.playingIndex != songInfo.playSongIndex ) {
        if (songInfo.playSongIndex > 0) {
            OMHotSongInfo *info = songInfo.OMSongs[songInfo.playSongIndex - 1];
            NSLog(@"即将播放上一首歌曲: 《%@》", info.title);
            [songInfo setSongInfo:info];
            [songInfo getSelectedSong:info.song_id index:songInfo.playSongIndex - 1];
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatPlay" object:self];
    }
    
}
#pragma mark - 歌曲列表
- (void)songListButtonAction {
    // 设置播放模式
    [_songListView setPlayModelButtonState];
    
    _shadowView = [[UIView alloc] init];
    _shadowView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight*(1-0.618));
    _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:_shadowView];
    [appWindow addSubview:_songListView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(responseGlide)];
    [_shadowView addGestureRecognizer:gesture];
    
    // SongListView弹出动画
    _songListView.transform = CGAffineTransformMakeTranslation(0.0, ScreenHeight);
    _shadowView.transform = CGAffineTransformMakeTranslation(0.0, ScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        
        _shadowView.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
        _songListView.transform = CGAffineTransformMakeTranslation(0.0, ScreenHeight * (1.0 - 0.618));
        
    } completion:^(BOOL finished){
        
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
    }];
}
#pragma mark - 下滑退出detail控制界面
- (void)responseGlide {
    
    // 设置播放模式
    [self setShuffleAndRepeatState];
    
    // SongListView隐藏动画
    [UIView animateWithDuration:0.3 animations:^{
        
        _songListView.transform = CGAffineTransformMakeTranslation(0.0, ScreenHeight);
        _shadowView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_shadowView removeFromSuperview];
        [_songListView removeFromSuperview];
    }];
    
}
#pragma - mark 进度条改变值结束时触发
-(void) playbackSliderValueChangedFinish {
    // 更新播放时间
    [self updateTime];
    
    //如果当前时暂停状态，则自动播放
    if (musicPlayer.play.rate == 0) {
        
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_play"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_play_prs"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView resumeRotate];
        [musicPlayer startPlay];
        
    }
}
#pragma - mark 更新播放时间
-(void) updateTime {
    
    CMTime duration = musicPlayer.play.currentItem.asset.duration;
    
    // 歌曲总时间和当前时间
    Float64 completeTime = CMTimeGetSeconds(duration);
    Float64 currentTime = (Float64)(_bottomView.songSlider.value) * completeTime;
    
    //播放器定位到对应的位置
    CMTime targetTime = CMTimeMake((int64_t)(currentTime), 1);
    [musicPlayer.play seekToTime:targetTime];
    
    int index = 0;
    for (NSString *indexStr in songInfo.mTimeArray) {
        if ((int)currentTime < [songInfo stringToInt:indexStr]) {
            songInfo.lrcIndex = index;
        } else {
            index = index + 1;
        }
    }
}
#pragma - mark 播放模式按键action
-(void) shuffleAndRepeat {
    
    switch (musicPlayer.shuffleAndRepeatState)
    {
        case RepeatPlayMode:
        {
            
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_one"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_one_prs"] forState:UIControlStateHighlighted];
            musicPlayer.shuffleAndRepeatState = RepeatOnlyOnePlayMode;  //单曲循环
            [self showMiddleHint:@"单曲循环"];
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_shuffle"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateHighlighted];
            musicPlayer.shuffleAndRepeatState = ShufflePlayMode;
            [self showMiddleHint:@"列表播放"];
        }
            break;
        case ShufflePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateHighlighted];
            musicPlayer.shuffleAndRepeatState = RepeatPlayMode;
            [self showMiddleHint:@"随机播放"];
        }
            break;
        default:
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:musicPlayer.shuffleAndRepeatState] forKey:@"SHFFLEANDREPEATSTATE"];//存储路径
}
#pragma - mark 获取保存的播放模式
- (void)getShuffleAndRepeatState
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *repeatAndShuffleNumber = [defaults objectForKey:@"SHFFLEANDREPEATSTATE"];
    if (repeatAndShuffleNumber == nil)
    {
        musicPlayer.shuffleAndRepeatState = RepeatPlayMode;
    }
    else
    {
        musicPlayer.shuffleAndRepeatState = (ShuffleAndRepeatState)[repeatAndShuffleNumber integerValue];
    }
    
    switch (musicPlayer.shuffleAndRepeatState)
    {
        case RepeatPlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateHighlighted];
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_one"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_one_prs"] forState:UIControlStateHighlighted];
        }
            break;
        case ShufflePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_shuffle"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateHighlighted];
            break;
        default:
            break;
        }
    }
}
#pragma - mark 设置播放模式
-(void) setShuffleAndRepeatState {
    
    switch (musicPlayer.shuffleAndRepeatState)
    {
        case RepeatPlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateHighlighted];
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_one"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_one_prs"] forState:UIControlStateHighlighted];
        }
            break;
        case ShufflePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_shuffle"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateHighlighted];
            break;
        default:
            break;
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:musicPlayer.shuffleAndRepeatState] forKey:@"SHFFLEANDREPEATSTATE"];//存储路径
}
#pragma mark - 播放模式提示框
- (void)showMiddleHint:(NSString *)hint {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0.f, 0.f);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.f];
}
-(void) backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma - mark 获取随机数，用于随机播放
-(NSUInteger) getRandomNumber:(NSUInteger)from with:(NSUInteger)to//包括两边边界
{
    NSUInteger res =  from + (arc4random() % (to - from + 1));
    return res;
}
@end
