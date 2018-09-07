//
//  FlipsideViewController.h
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate

- (BOOL)acceptCreditCards;
- (void)setAcceptCreditCards:(BOOL)processCreditCards;
- (void)setPayPalEnvironment:(NSString *)environment;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;

@end

#pragma mark -

@interface FlipsideViewController : UIViewController

@property(weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@end