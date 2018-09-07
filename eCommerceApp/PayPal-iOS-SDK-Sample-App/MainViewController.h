//
//  MainViewController.h
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//

#import "FlipsideViewController.h"
#import "PayPalMobile.h"

@interface MainViewController : UIViewController <PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL     acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;

@end
