//
//  SongListTableView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SongListTableView.h"
#import "SongListTableViewCell.h"
#import "MusicPlayerManager.h"
#import "OMSongInfo.h"
#import "OMHotSongInfo.h"

static NSString *CellIdentifier = @"SCTableViewCell";
static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";


@interface SongListTableView ()
{
    MusicPlayerManager *musicPlayer;
    OMSongInfo *songInfo;
}
@end
@implementation SongListTableView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        musicPlayer = MusicPlayerManager.sharedManager;
        songInfo = OMSongInfo.shareManager;
        
        self.delegate = self;
        self.dataSource = self;
        self.sectionHeaderHeight = 0.1;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollIndicatorInsets = UIEdgeInsetsMake(104, 0, 0, 0);
        [self reloadData];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return songInfo.OMSongs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OMHotSongInfo *info = songInfo.OMSongs[indexPath.row];
    
    SongListTableViewCell *cell = (SongListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SongListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.songNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.songName.text = info.title;
    cell.singerName.text = info.author;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OMHotSongInfo *info
    = songInfo.OMSongs[indexPath.row];
    NSLog(@"你选择了《%@》这首歌",info.title);
    [songInfo setSongInfo:info];
    [songInfo getSelectedSong:info.song_id index:indexPath.row];
}
@end
