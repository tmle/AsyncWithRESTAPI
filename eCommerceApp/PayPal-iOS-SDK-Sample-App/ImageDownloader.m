//
//  ImageDownloader.m
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import "ImageDownloader.h"

// 1
@interface ImageDownloader ()
@property (nonatomic, readwrite, strong) NSIndexPath *indexPathInTableView;
//@property (nonatomic, readwrite, strong) PhotoRecord *photoRecord;
@property (nonatomic, readwrite, strong) PhotoRecord2 *photoRecord;

@end

@implementation ImageDownloader
@synthesize delegate = _delegate;
@synthesize indexPathInTableView = _indexPathInTableView;
@synthesize photoRecord = _photoRecord;

#pragma mark - Life Cycle

- (id)initWithPhotoRecord:(PhotoRecord2 *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>)theDelegate {
    
    if (self = [super init]) {
        // 2
        self.delegate = theDelegate;
        self.indexPathInTableView = indexPath;
        self.photoRecord = record;
    }
    return self;
}

#pragma mark - Downloading image
// 3
- (void)main {
    
    // 4
    @autoreleasepool {
        
        if (self.isCancelled)
            return;
        
        NSData *thumbnailData = [[NSData alloc] initWithContentsOfURL:self.photoRecord.recordThumbnailURL];
        NSData *imageData     = [[NSData alloc] initWithContentsOfURL:self.photoRecord.recordImageURL];
        
        if (self.isCancelled) {
            thumbnailData = nil;
            imageData = nil;
            return;
        }
        
        if ((thumbnailData) && (imageData)){
        //if (imageData) {
            UIImage *downloadedThumbnail = [UIImage imageWithData:thumbnailData];
            UIImage *downloadedImage     = [UIImage imageWithData:imageData];

            self.photoRecord.recordThumbnailData = downloadedThumbnail;
            self.photoRecord.recordImageData = downloadedImage;

        }
        else {
            self.photoRecord.failed = YES;
        }
        thumbnailData = nil;
        imageData = nil;

        if (self.isCancelled)
            return;
        
        // 5
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageDownloaderDidFinish:) withObject:self waitUntilDone:NO];
        
    }
}

@end