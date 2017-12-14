//
//  RootViewController.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/14.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "OMHotSongInfo.h"
#import "OMSongInfo.h"
#import "MusicPlayerManager.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <notify.h>
#import "SCImageView.h"
#import "DetailControlViewController.h"
#import "Const.h"
#import "TTTopChannelContianerView.h"
#import "ContentTableViewController.h"
#import <Masonry.h>

@interface RootViewController : UIViewController<UIScrollViewDelegate, TTTopchannelContianerViewDelegate>

@property (nonatomic, strong) NSMutableArray *currentChannelsArray;
@property (nonatomic, weak) TTTopChannelContianerView *topContianerView;
@property (nonatomic, strong) DetailControlViewController *detailController;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *arrayLists;

@property (nonatomic, assign) NSInteger currentRow;

@property (nonatomic, strong) UIImageView *lrcImageView;
@property (nonatomic, strong) UIImage *lastImage;

@property (nonatomic, strong) UIView *playControllerView;
@property (nonatomic, strong) SCImageView *currentPlaySongImage;
@property (nonatomic, strong) UIButton *playAndPauseButton;
@property (nonatomic, strong) UIButton *nextSongButton;
@property (nonatomic, strong) UISlider *songSlider;
@property (nonatomic, strong) UILabel *songName;
@property (nonatomic, strong) UILabel *singerName;

@property (nonatomic, strong) id playerTimeObserver;

@end
