//
//  ProductCell.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * productName;
@property (nonatomic, weak) IBOutlet UIImageView * productThumbnail;
@property (nonatomic, weak) IBOutlet UIImageView * productImage;
@property (nonatomic, weak) IBOutlet UILabel * productBrief;
@property (nonatomic, weak) IBOutlet UILabel * productDescription;
@property (nonatomic, weak) IBOutlet UILabel * productPrice;
@property (nonatomic, weak) IBOutlet UILabel * productCurrency;
@property (nonatomic, weak) IBOutlet UILabel * productWeight;
@property (nonatomic, weak) IBOutlet UILabel * productUnit;

@end
