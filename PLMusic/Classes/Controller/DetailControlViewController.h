//
//  DetailControlViewController.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/14.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
#import "MidView.h"
#import "BottomView.h"
#import "OMSongInfo.h"
#import "MusicPlayerManager.h"
#import "OMHotSongInfo.h"
#import "SongListView.h"
#import "Const.h"

@interface DetailControlViewController : UIViewController

@property (nonatomic, strong) SongListView *songListView;

@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) TopView *topView;

@property (nonatomic, strong) MidView *midView;

@property (nonatomic, strong) BottomView *bottomView;

@property (nonatomic, strong) UIImageView *backgroudImageView;

- (void)setBackgroundImage:(UIImage *)image;
- (void)playStateRecover;

@end
