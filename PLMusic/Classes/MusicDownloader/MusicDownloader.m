//
//  MusicDownloader.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "MusicDownloader.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "OMHotSongInfo.h"
#import "OMSongInfo.h"

#define kAppIconSize 48

@interface MusicDownloader ()

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;

@end

@implementation MusicDownloader

- (instancetype)init {
    self = [super init];
    if (self) {
        _songInfo = OMSongInfo.shareManager;
    }
    return self;
}

- (void)startDownload {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.hotSonginfo.pic_small]];
    
    _sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection) {
                abort();
            }
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIImage *image = [[UIImage alloc] initWithData:data];
            if (image.size.width != kAppIconSize || image.size.height != kAppIconSize) {
                CGSize itemSize = CGSizeMake(kAppIconSize, kAppIconSize);
                UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
                CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
                [image drawInRect:imageRect];
                self.hotSonginfo.albumImage_small = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            } else {
                self.hotSonginfo.albumImage_small = image;
            }
            if (self.completionHandler != nil) {
                self.completionHandler();
            }
        }];
    }];
    
    [self.sessionTask resume];
}
- (void)cancelDownload {
    [self.sessionTask cancel];
    _sessionTask = nil;
}
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    
    // alert user that our current record was deleted, and then we leave this view controller
    //
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Show Top Paid Apps"
                                                                   message:errorMessage
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         // dissmissal of alert completed
                                                     }];
    [alert addAction:OKAction];
}
@end
