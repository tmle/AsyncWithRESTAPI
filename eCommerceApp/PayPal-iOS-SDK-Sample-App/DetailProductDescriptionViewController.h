//
//  DetailProductDescriptionViewController.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CartViewController.h"
#import "ProductSelected.h"
#import "PhotoRecord2.h"
#define kThinhMLeBaseURL @"https://www.thinhmle.com"

@interface DetailProductDescriptionViewController : UIViewController //<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *prodSelected_t;
@property (nonatomic, strong) PhotoRecord2 *recordSelected_t;

@property (nonatomic, strong) NSMutableArray *listOfProductsSelected;
@property (strong, nonatomic) NSMutableDictionary *dictOfProductOnCart;

@property (nonatomic, weak) IBOutlet UILabel *prodNameOnDetail;
@property (nonatomic, weak) IBOutlet UIImageView *prodThumbnailOnDetail;
@property (nonatomic, weak) IBOutlet UIImageView *prodImageOnDetail;
@property (nonatomic, weak) IBOutlet UILabel *prodBriefOnDetail;
@property (nonatomic, weak) IBOutlet UITextView *prodDescriptionOnDetail;
@property (nonatomic, weak) IBOutlet UILabel *prodPriceOnDetail;
@property (nonatomic, weak) IBOutlet UILabel *prodCurrencyOnDetail;
@property (nonatomic, weak) IBOutlet UILabel *prodWeightOnDetail;
@property (nonatomic, weak) IBOutlet UILabel *prodUnitOnDetail;

-(void)continueShopping:(id)sender;
-(void)addToShoppingCart:(id)sender;

@end