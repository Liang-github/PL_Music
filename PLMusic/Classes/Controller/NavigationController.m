//
//  NavigationController.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/14.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "NavigationController.h"
#import "Const.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationBarSetting];
}
- (void)navigationBarSetting {
    [self.navigationBar setBarTintColor:UIColorFromRGB(0xff0000)];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    // 去掉导航分割线
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}


@end
