//
//  CartViewController.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-29.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@interface CartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PayPalPaymentDelegate, UIPopoverControllerDelegate>

// environment setting
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL     acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;

@property (nonatomic, strong) NSMutableArray *listOfPPItems;

// Tax and shipping
@property (nonatomic, strong) NSString *totalItemOnCart;
@property (nonatomic, strong) NSString *subTotalPriceOnCart;

@property (strong, nonatomic) NSMutableArray *listOfProductsSelected; //
@property (strong, nonatomic) NSMutableDictionary *dictOfProductOnCart;

@property (nonatomic, weak) IBOutlet UILabel *subTotalOnCart;
@property (nonatomic, weak) IBOutlet UILabel *estShippingOnCart;
@property (nonatomic, weak) IBOutlet UILabel *taxOnCart;
@property (nonatomic, weak) IBOutlet UILabel *grandTotalOnCart;
@property (nonatomic, weak) IBOutlet UILabel *currencyDisplayed;
@property (weak, nonatomic) IBOutlet UILabel *totalWeightOnCart;

@end
