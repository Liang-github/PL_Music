//
//  SCLrcTableView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SCLrcTableView.h"

@interface SCLrcTableView ()

{
    OMSongInfo *songInfo;
}
@end

@implementation SCLrcTableView

- (void)setLrc_Index:(int)Lrc_Index {
    if (_Lrc_Index == Lrc_Index || Lrc_Index > songInfo.mLRCDictinary.count - 1) {
        return;
    }
    
    id indexPath = [NSIndexPath indexPathForRow:Lrc_Index inSection:0];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Lrc_Index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:indexPath];
    _currentCell = (SCLrcTableViewCell *)currentCell;
    [_currentCell.textLabel setTextColor:[UIColor redColor]];
    
    id oldIndexPath = [NSIndexPath indexPathForRow:_Lrc_Index inSection:0];
    UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:oldIndexPath];
    _lrcOldCell = (SCLrcTableViewCell *)oldCell;
    [_lrcOldCell.textLabel setTextColor:[UIColor whiteColor]];
    [_currentCell addAnimation:scaleAlways];
    
    // 锁屏歌词更新
    [_lockScreenTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Lrc_Index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    UITableViewCell *lockCurrentCell = [_lockScreenTableView cellForRowAtIndexPath:indexPath];
    _currentCell = (SCLrcTableViewCell *)lockCurrentCell;
    [_currentCell.textLabel setTextColor:[UIColor redColor]];
    
    id lockOldIndexPath = [NSIndexPath indexPathForRow:_Lrc_Index inSection:0];
    UITableViewCell *lockOldCell = [_lockScreenTableView cellForRowAtIndexPath:lockOldIndexPath];
    _lrcOldCell = (SCLrcTableViewCell *)lockOldCell;
    [_lrcOldCell.textLabel setTextColor:[UIColor whiteColor]];
    
    _Lrc_Index = Lrc_Index;
}
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        songInfo.mLRCDictinary = [[NSMutableDictionary alloc] init];
        songInfo.mTimeArray = [[NSMutableArray alloc] init];
        if (!_lockScreenTableView) {
            _lockScreenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 800 - 44*7 + 20, 480, 44*3) style:UITableViewStyleGrouped];
            _lockScreenTableView.dataSource = self;
            _lockScreenTableView.delegate = self;
            _lockScreenTableView.separatorStyle = 0;
            _lockScreenTableView.backgroundColor = [UIColor clearColor];
            [_lockScreenTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lrccellID"];
        }
    }
    return self;
}
- (void)SC_SetUpLrcTableViewFrame:(CGRect)frame {
    self.view.frame = frame;
}
- (void)AnalysisLRC:(NSString *)lrcStr {
    if (songInfo.isLrcExistFlg) {
        NSString *contentStr = lrcStr;
        
        NSArray *lrcArray = [contentStr componentsSeparatedByString:@"\n"];
        
        [songInfo.mLRCDictinary removeAllObjects];
        [songInfo.mTimeArray removeAllObjects];
        
        for (NSString *line in lrcArray) {
            if ([line containsString:@"[0"] || [line containsString:@"[1"] || [line containsString:@"[2"] || [line containsString:@"[3"]) {
                NSArray *lineArr = [line componentsSeparatedByString:@"]"];
                NSString *str1 = [line substringWithRange:NSMakeRange(3, 1)];
                NSString *str2 = [line substringWithRange:NSMakeRange(6, 1)];
                
                if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                    NSString *lrcStr = lineArr[1];
                    NSString *timeStr = [lineArr[0] substringWithRange:NSMakeRange(1, 5)];
                    [songInfo.mLRCDictinary setObject:lrcStr forKey:timeStr];
                    [songInfo.mTimeArray addObject:timeStr];
                }
            } else {
                continue;
            }
        }
        _mIsLRCPrepared = YES;
        [self.tableView reloadData];
    } else {
        [songInfo.mLRCDictinary removeAllObjects];
        [songInfo.mTimeArray removeAllObjects];
        
        [songInfo.mLRCDictinary setObject:@"没有找到歌词" forKey:@"0:0"];
        [songInfo.mTimeArray addObject:@"0:0"];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self.tableView reloadData];
    }
}
- (UIImage *)getBlurredImage:(UIImage *)image {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:@5.0f forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef *ref = [context createCGImage:result fromRect:[result extent]];
    return [UIImage imageWithCGImage:ref];
}
#pragma - mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return songInfo.mLRCDictinary.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCLrcTableViewCell *cell = [SCLrcTableViewCell SC_CellForRowWithTableView:tableView];
    
    cell.textLabel.text = songInfo.mLRCDictinary[songInfo.mTimeArray[indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_currentRow == indexPath.row) {
        cell.textLabel.textColor = [UIColor redColor];
        //cell.textLabel.alpha = 1.0;
    }else{
        cell.textLabel.textColor = [UIColor whiteColor];
        //cell.textLabel.alpha = 1.0 - (float)(labs(indexPath.row - _currentRow)) / 6;
    }
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDragging = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isDragging = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
