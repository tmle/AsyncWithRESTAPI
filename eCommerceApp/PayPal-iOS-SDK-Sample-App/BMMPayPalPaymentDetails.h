//
//  BMMPayPalPaymentDetails.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMMPayPalPaymentDetails : NSObject

/// Sub-total (amount) of items being paid for. 10 characters max with support for 2 decimal places.
@property(nonatomic, copy, readwrite) NSDecimalNumber *BMMsubtotal;

/// Amount charged for shipping. 10 characters max with support for 2 decimal places.
@property(nonatomic, copy, readwrite) NSDecimalNumber *BMMshipping;

/// Amount charged for tax. 10 characters max with support for 2 decimal places.
@property(nonatomic, copy, readwrite) NSDecimalNumber *BMMtax;

@end
