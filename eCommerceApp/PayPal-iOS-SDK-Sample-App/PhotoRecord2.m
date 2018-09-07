//
//  PhotoRecord2.m
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import "PhotoRecord2.h"

@implementation PhotoRecord2

@synthesize recordName = _name;
@synthesize recordThumbnailData = _image;
@synthesize recordThumbnailURL = _URL;
@synthesize recordImageData = _largeImage; // To store the actual image
@synthesize recordImageURL = RURL; // To store the URL of the image

@synthesize recordId;
@synthesize recordThumbnail;
@synthesize recordImage;
@synthesize recordBrief;
@synthesize recordDescription;
@synthesize recordPrice;
@synthesize recordCurrency;
@synthesize recordWeight;
@synthesize recordUnit;
@synthesize recordQuantity;

@synthesize hasImage = _hasImage;
@synthesize hasLargeImage = _hasLargeImage;
@synthesize filtered = _filtered;
@synthesize failed = _failed;


- (BOOL)hasImage {
    return _image != nil;
}

- (BOOL)hasLargeImage {
    return _largeImage != nil;
}

- (BOOL)isFailed {
    return _failed;
}


- (BOOL)isFiltered {
    return _filtered;
}

@end
