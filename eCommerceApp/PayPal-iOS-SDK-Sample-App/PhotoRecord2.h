//
//  PhotoRecord2.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoRecord2 : NSObject

@property (nonatomic, strong) UIImage  *recordThumbnailData; // To store the actual thumbnail
@property (nonatomic, strong) NSURL    *recordThumbnailURL; // To store the URL of the thumbnail
@property (nonatomic, strong) UIImage  *recordImageData; // To store the actual image
@property (nonatomic, strong) NSURL    *recordImageURL; // To store the URL of the image

@property (nonatomic, strong) NSString *recordId;
@property (nonatomic, strong) NSString *recordName;  // To store the name of image
@property (nonatomic, strong) NSString *recordThumbnail;
@property (nonatomic, strong) NSString *recordImage;
@property (nonatomic, strong) NSString *recordBrief;
@property (nonatomic, strong) NSString *recordDescription;
@property (nonatomic, strong) NSString *recordPrice;
@property (nonatomic, strong) NSString *recordCurrency;
@property (nonatomic, strong) NSString *recordWeight;
@property (nonatomic, strong) NSString *recordUnit;
@property (nonatomic, strong) NSString *recordQuantity;

@property (nonatomic, readonly) BOOL hasImage; // Return YES if Thumbnail is downloaded.
@property (nonatomic, readonly) BOOL hasLargeImage; // Return YES if Image is downloaded.
@property (nonatomic, getter = isFiltered) BOOL filtered; // Return YES if image is sepia-filtered
@property (nonatomic, getter = isFailed) BOOL failed; // Return Yes if image failed to be downloaded

@end
