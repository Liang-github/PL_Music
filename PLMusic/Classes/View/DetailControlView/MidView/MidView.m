//
//  MidView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "MidView.h"
#import "Const.h"
@implementation MidView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(ScreenWidth*2, 0);
        
        // 专辑图片视图配置
        _midIconView = [[SCIconView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, frame.size.height)];
        [self addSubview:_midIconView];
        
        // 歌词视图配置
        _midLrcView = [[SCLrcTableView alloc] initWithStyle:UITableViewStylePlain];
        [_midLrcView SC_SetUpLrcTableViewFrame:CGRectMake(ScreenWidth, 0, frame.size.width, frame.size.height)];
        _midLrcView.tableView.allowsSelection = NO;
        _midLrcView.tableView.backgroundColor = [UIColor clearColor];
        _midLrcView.tableView.separatorStyle = 0;
        _midLrcView.tableView.showsVerticalScrollIndicator = NO;
        _midLrcView.tableView.contentInset = UIEdgeInsetsMake(frame.size.height/2, 0, frame.size.height/2, 0);
        [self addSubview:_midLrcView.view];
        
        return self;
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double spread = self.contentOffset.x/ScreenWidth;
    _midIconView.alpha = 1 - spread;
    _midLrcView.tableView.alpha = spread;
}
@end
