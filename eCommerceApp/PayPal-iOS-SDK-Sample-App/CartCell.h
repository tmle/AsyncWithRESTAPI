//
//  CartCell.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * prodNameOnCart;
@property (nonatomic, weak) IBOutlet UIImageView * prodThumbnailOnCart;
@property (nonatomic, weak) IBOutlet UIImageView * prodImageOnCart;
@property (nonatomic, weak) IBOutlet UILabel * prodBriefOnCart;
@property (nonatomic, weak) IBOutlet UILabel * prodDescriptionOnCart;
@property (nonatomic, weak) IBOutlet UILabel * prodPriceOnCart;
@property (nonatomic, weak) IBOutlet UILabel * prodCurrencyOnCart;
@property (nonatomic, weak) IBOutlet UILabel * prodWeightOnCart;
@property (nonatomic, weak) IBOutlet UILabel * prodUnitOnCart;
@property (nonatomic, weak) IBOutlet UILabel * prodQuantityOnCart;
@property (nonatomic, weak) IBOutlet UILabel * subTotalPriceOnCart;

@end
