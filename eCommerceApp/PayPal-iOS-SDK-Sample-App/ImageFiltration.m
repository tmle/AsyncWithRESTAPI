//
//  ImageFiltration.m
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import "ImageFiltration.h"

@interface ImageFiltration ()
@property (nonatomic, readwrite, strong) NSIndexPath *indexPathInTableView;
//@property (nonatomic, readwrite, strong) PhotoRecord *photoRecord;
@property (nonatomic, readwrite, strong) PhotoRecord2 *photoRecord;

@end

@implementation ImageFiltration
@synthesize indexPathInTableView = _indexPathInTableView;
@synthesize photoRecord = _photoRecord;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark - Life cycle

- (id)initWithPhotoRecord:(PhotoRecord2 *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageFiltrationDelegate>)theDelegate {
    
    if (self = [super init]) {
        self.photoRecord = record;
        self.indexPathInTableView = indexPath;
        self.delegate = theDelegate;
    }
    return self;
}

#pragma mark -
#pragma mark - Main operation
- (void)main {
    @autoreleasepool {
        
        if (self.isCancelled)
            return;
        
        if (!self.photoRecord.hasImage)
            return;
        
        //UIImage *rawImage = self.photoRecord.image;
        UIImage *rawImage = self.photoRecord.recordThumbnailData;
        UIImage *processedImage = [self applySepiaFilterToImage:rawImage];
        
        if (self.isCancelled)
            return;
  
        if (rawImage) {
        //if (processedImage) {
            //self.photoRecord.image = rawImage; //processedImage;
            self.photoRecord.recordThumbnailData = rawImage; //processedImage;
            self.photoRecord.filtered = YES;
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageFiltrationDidFinish:) withObject:self waitUntilDone:NO];
        }
    }
    
}

#pragma mark -
#pragma mark - Filtering image
- (UIImage *)applySepiaFilterToImage:(UIImage *)image {
    // donothing for now
    return nil;
}

//- (UIImage *)applySepiaFilterToImage:(UIImage *)image {
//    
//    // This is expensive + time consuming
//    CIImage *inputImage = [CIImage imageWithData:UIImagePNGRepresentation(image)];
//    
//    if (self.isCancelled)
//        return nil;
//    
//    UIImage *sepiaImage = nil;
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, inputImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
//    CIImage *outputImage = [filter outputImage];
//    
//    if (self.isCancelled)
//        return nil;
//    
//    // Create a CGImageRef from the context
//    // This is an expensive + time consuming
//    CGImageRef outputImageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
//    
//    if (self.isCancelled) {
//        CGImageRelease(outputImageRef);
//        return nil;
//    }
//    
//    sepiaImage = [UIImage imageWithCGImage:outputImageRef];
//    CGImageRelease(outputImageRef);
//    return sepiaImage;
//}

@end
