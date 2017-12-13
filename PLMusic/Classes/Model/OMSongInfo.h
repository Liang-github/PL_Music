//
//  OMSongInfo.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "OMHotSongInfo.h"


@interface OMSongInfo : NSObject

+ (OMSongInfo *)shareManager;
@property (nonatomic, strong) UIImage *pic_big;
@property (nonatomic, strong) UIImage *pic_small;
@property (nonatomic, copy) NSString *song_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *album_title;
@property (nonatomic, copy) NSString *file_duration;
@property (nonatomic, copy) NSString *file_link;
@property (nonatomic, copy) NSString *file_size;
@property (nonatomic, copy) NSString *lrclink;
@property (nonatomic, assign) BOOL isLrcExistFlg;
@property (nonatomic, copy) NSString *lrcString;
@property (nonatomic, strong) NSMutableDictionary *mLRCDictinary;
@property (nonatomic, strong) NSMutableArray *mTimeArray;
@property (nonatomic, assign) int lrcIndex;
@property (nonatomic, assign) long playSongIndex;
@property (nonatomic, assign) BOOL isDataREquestFinish;
@property (nonatomic, strong) NSArray *OMSongs;

- (void)loadNewSongs:(UITableView *)songListTableView;
- (void)loadHotSongs:(UITableView *)songListTableView;
- (void)loadHotArtists:(UITableView *)songListTableView;
- (void)loadClassicOldSongs:(UITableView *)songListTableView;
- (void)loadLoveSongs:(UITableView *)songListTableView;
- (void)loadMovieSongs:(UITableView *)songListTableView;
- (void)loadEuropeAndTheUnitedStatesSongs:(UITableView *)songListTableView;
- (void)getSelectedSong:(NSString *)songID index:(long)index;
- (void)setSongInfo:(OMHotSongInfo *)info;
- (NSString *)intToString:(int)needTransformInteger;
- (int)stringToInt:(NSString *)timeString;

@end
