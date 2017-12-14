//
//  ContentTableViewController.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/14.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "OMHotSongInfo.h"
#import "OMSongInfo.h"
#import "OMAlbumInfo.h"
#import "OMArtistInfo.h"
#import <MJRefresh.h>
#import "Const.h"
#import "MusicDownloader.h"
#import "DetailControlViewController.h"

@interface ContentTableViewController : UITableViewController

@property (nonatomic, strong) NSString *channelTitle;
@property (nonatomic, strong) DetailControlViewController *detailController;

- (void)reloadData;
- (void)getSelectedSong:(NSString *)songID index:(long)index;
@end
