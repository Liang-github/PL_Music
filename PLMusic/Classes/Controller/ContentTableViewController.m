//
//  ContentTableViewController.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/14.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "ContentTableViewController.h"
#define kCustomRowCount 7
@interface ContentTableViewController ()
{
    NSArray *hotArtistsArray;
    NSArray *newAlbumsArray;
    NSArray *onlineMusicArray;
    NSString *choosedAlbumID;
    NSString *choosedArtistUID;
    OMSongInfo *songInfo;
}
@property (nonatomic, strong) NSMutableArray *arrayList;

@property (nonatomic, strong) NSMutableDictionary *imageDownloadInProgress;

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@property (nonatomic, strong) MusicDownloader *downloader;

@end

static NSString *CellIdentifier = @"LazyTableCell";
static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";

@implementation ContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _downloader = [[MusicDownloader alloc] init];
    _downloader.isDataRequestFinish = NO;
    _imageDownloadInProgress = [NSMutableDictionary dictionary];
    songInfo = [OMSongInfo shareManager];
    
    [self setupBasic];
    [self setupRefresh];
}
-(void)setupBasic {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(104, 0, 0, 0);
}
-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadData
{
    uint8_t type;
    if ([self.channelTitle  isEqual: @"新歌"]) {
        type = NEW_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"热歌"]) {
        type = HOT_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"经典"]) {
        type = OLD_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"情歌"]) {
        type = LOVE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"网络"]) {
        type = INTERNET_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"影视"]) {
        type = MOVIE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"欧美"]) {
        type = EUROPE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"Bill"]) {
        type = BILLBOARD_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"摇滚"]) {
        type = ROCK_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"爵士"]) {
        type = JAZZ_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"流行"]) {
        type = POP_MUSIC_LIST;
    }else {
        return;
    }
    
    NSString *partOne = @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.billboard.billList&format=json&";
    NSString *partTwo = [NSString stringWithFormat:@"type=%d&offset=0&size=%d",type, 20];
    NSString *urlString = [partOne stringByAppendingString:partTwo];
    [self loadDataForType:1 withURL:urlString];
}
- (void)loadMoreData
{
    uint8_t type;
    if ([self.channelTitle  isEqual: @"新歌"]) {
        type = NEW_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"热歌"]) {
        type = HOT_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"经典"]) {
        type = OLD_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"情歌"]) {
        type = LOVE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"网络"]) {
        type = INTERNET_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"影视"]) {
        type = MOVIE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"欧美"]) {
        type = EUROPE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"Bill"]) {
        type = BILLBOARD_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"摇滚"]) {
        type = ROCK_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"爵士"]) {
        type = JAZZ_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"流行"]) {
        type = POP_MUSIC_LIST;
    }else {
        return;
    }
    
    NSString *partOne = @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.billboard.billList&format=json&";
    NSString *partTwo = [NSString stringWithFormat:@"type=%d&offset=%lu&size=%d",type,(unsigned long)self.arrayList.count, 20];
    NSString *urlString = [partOne stringByAppendingString:partTwo];
    [self loadDataForType:2 withURL:urlString];
}
- (void)loadDataForType:(int)loadingType withURL:(NSString *)urlString
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *path = urlString;
    
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = [responseObject objectForKey:@"song_list"];
            NSArray *loadSongArray = [OMHotSongInfo mj_objectArrayWithKeyValuesArray:array];
            
            if (loadingType == 1) {
                self.arrayList = [loadSongArray mutableCopy];
                [self.tableView.mj_header endRefreshing];
            }else if(loadingType == 2){
                
                if (self.arrayList.count >= 100) {
                    [self.tableView.mj_footer endRefreshing];
                    return;
                }
                
                [self.arrayList addObjectsFromArray:loadSongArray];
                [self.tableView.mj_footer endRefreshing];
            }
            songInfo.isDataREquestFinish = YES;
            songInfo.OMSongs = self.arrayList;
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];
    
}
- (void)startIconDownload:(OMHotSongInfo *)info forIndexPath:(NSIndexPath *)indexPath {
    MusicDownloader *downloader = (self.imageDownloadInProgress)[indexPath];
    if (downloader == nil) {
        downloader = [[MusicDownloader alloc] init];
        downloader.hotSonginfo = info;
        [downloader setCompletionHandler:^{
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.imageView.image = info.albumImage_small;
            [self.imageDownloadInProgress removeObjectForKey:indexPath];
        }];
        self.imageDownloadInProgress[indexPath] = downloader;
        [downloader startDownload];
    }
}
-(void) loadImagesForOnScreenRows {
    
    if (self.arrayList.count > 0) {
        NSArray *visiblePaths= [self.tableView indexPathsForVisibleRows];
        
        for (NSIndexPath *indexPath in visiblePaths) {
            OMHotSongInfo *info = (self.arrayList)[indexPath.row];
            
            if (!info.albumImage_small) {
                [self startIconDownload:info forIndexPath:indexPath];
            }
        }
    }
}
#pragma - mark TableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.channelTitle isEqualToString:@"新歌"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"热歌"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"经典"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"情歌"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"网络"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"影视"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"欧美"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"Bill"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"摇滚"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"爵士"]) {
        return self.arrayList.count;
    }else if ([self.channelTitle  isEqual: @"流行"]) {
        return self.arrayList.count;
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    NSUInteger nodeCount = self.arrayList.count;
    
    if (nodeCount == 0 && indexPath.row == 0)
    {
        // add a placeholder cell while waiting on table data
        cell = [self.tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:PlaceholderCellIdentifier];
        }
    }
    else
    {
        // add a placeholder cell while waiting on table data
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
        }
        
        // Leave cells empty if there's no data yet
        if (nodeCount > 0)
        {
            // Set up the cell representing the app
            OMHotSongInfo *info = (self.arrayList)[indexPath.row];
            
            cell.textLabel.text = info.title;
            cell.detailTextLabel.text = info.author;
            
            // Only load cached images; defer new downloads until scrolling ends
            if (!info.albumImage_small)
            {
                if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
                {
                    [self startIconDownload:info forIndexPath:indexPath];
                }
                // if a download is deferred or in progress, return a placeholder image
                cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
            }
            else
            {
                cell.imageView.image = info.albumImage_small;
            }
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OMHotSongInfo *info = (self.arrayList)[indexPath.row];
    NSLog(@"你选择了《%@》这首歌", info.title);
    [songInfo setSongInfo:info];
    [songInfo getSelectedSong:info.song_id index:indexPath.row];
}
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self loadImagesForOnScreenRows];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnScreenRows];
}


@end
