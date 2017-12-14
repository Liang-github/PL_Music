//
//  SCIconView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SCIconView.h"

@implementation SCIconView

- (void)setAlbumImage:(UIImage *)image {
    _imageView = [[SCImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.1, self.frame.size.height/2 - self.frame.size.width*0.4, self.frame.size.width*0.8, self.frame.size.width*0.8)];
    _imageView.image = image;
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius = self.frame.size.width*0.4;
    [self addSubview:_imageView];
}

@end
