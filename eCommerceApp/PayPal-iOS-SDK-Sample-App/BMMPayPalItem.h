//
//  BMMPayPalItem.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMMPayPalItem : NSObject

// paypalItem
@property(nonatomic, copy, readwrite) NSString *BMMname;

/// Number of a particular item. 10 characters max. Required.
@property(nonatomic, assign, readwrite) NSUInteger BMMquantity;

/// Item cost. 10 characters max. May be negative for "coupon" etc. Required.
@property(nonatomic, copy, readwrite) NSDecimalNumber *BMMprice;

/// ISO standard currency code (http://en.wikipedia.org/wiki/ISO_4217). Required.
@property(nonatomic, copy, readwrite) NSString *BMMcurrency;

/// Stock keeping unit corresponding (SKU) to item. 50 characters max.
@property(nonatomic, copy, readwrite) NSString *BMMsku;

//NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithDecimal:[aNumber decimalValue]];

//converting NSString to NSNumber
//NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//f.numberStyle = NSNumberFormatterDecimalStyle;
//NSNumber *myNumber = [f numberFromString:@"42"];

// need NSUInteger <-> NSString conversion

// need NSDecimalNumber <-> NSString conversion

// need NSNumber <-> NSString conversion
// NSString *newStr = [NSString stringWithFormat:@"%2@", @"anyNumber"];
// NSNumber *newNum =

// plist allows: data, dict, boolean, data, date, number, string

@end
