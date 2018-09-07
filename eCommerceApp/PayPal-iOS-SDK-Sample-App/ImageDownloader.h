//
//  ImageDownloader.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoRecord.h"
#import "PhotoRecord2.h"

@protocol ImageDownloaderDelegate;

@interface ImageDownloader : NSOperation
@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) PhotoRecord2 *photoRecord;
- (id)initWithPhotoRecord:(PhotoRecord2 *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>) theDelegate;
@end

@protocol ImageDownloaderDelegate <NSObject>
- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader;
@end
