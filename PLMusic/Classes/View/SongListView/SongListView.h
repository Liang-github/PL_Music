//
//  SongListView.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMSongInfo.h"
#import "MusicPlayerManager.h"
#import "SongListTopView.h"
#import "SongListTableView.h"
#import "Const.h"
#import <MBProgressHUD.h>

@interface SongListView : UIView

@property (nonatomic, strong) SongListTopView *topView;
@property (nonatomic, strong) SongListTableView *tableView;

- (void)setPlayModelButtonState;

@end
