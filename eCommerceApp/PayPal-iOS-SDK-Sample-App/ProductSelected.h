//
//  ProductSelected.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductSelected : NSObject

@property (nonatomic, strong) NSString * prodSelName;
@property (nonatomic, strong) UIImage  * prodSelThumbnail;
@property (nonatomic, strong) UIImage  * prodSelImage;
@property (nonatomic, strong) NSString * prodSelBrief;
@property (nonatomic, strong) NSString * prodSelDescription;
@property (nonatomic, strong) NSNumber * prodSelPrice;
@property (nonatomic, strong) NSString * prodSelCurrency;
@property (nonatomic, strong) NSNumber * prodSelWeight;
@property (nonatomic, strong) NSString * prodSelUnit;
@property (nonatomic, strong) NSNumber * prodSelQuantity;

@property (nonatomic, strong) NSString * prodSelId;
@property (nonatomic, strong) NSNumber * prodSelCount;

//@property (nonatomic, strong) NSNumber *distance;

@end
