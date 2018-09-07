//
//  AppDelegate.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.

#import <UIKit/UIKit.h>

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray * productSelected;

@end
