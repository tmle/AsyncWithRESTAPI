//
//  TotalCell.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * totalItemOnCart;
@property (nonatomic, weak) IBOutlet UILabel * subTotalPriceOnCart;

@end
