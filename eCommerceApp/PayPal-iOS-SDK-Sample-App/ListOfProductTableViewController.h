//
//  ListOfProductTableViewController.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoRecord.h"
#import "PhotoRecord2.h"
#import "PendingOperations.h"
#import "ImageDownloader.h"
#import "ImageFiltration.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "Product.h"
#import "ProductList.h"
#import "Item.h"
#import "DetailProductDescriptionViewController.h"
#import "ProductCell.h"
#import "ProductSelected.h"

// https://www.facebook.com/pandacat.chan/videos/10153565060417431/
#define kThinhMLeBaseURL @"https://www.thinhmle.com"

@interface ListOfProductTableViewController : UITableViewController <ImageDownloaderDelegate, ImageFiltrationDelegate>

@property (strong, nonatomic) NSArray *productListing;
@property (strong, nonatomic) NSMutableArray *listOfProductsSelected;
@property (strong, nonatomic) NSMutableDictionary *dictOfProductOnCart;

@property (nonatomic, strong) NSArray *photos; // main data source of controller
@property (nonatomic, strong) PendingOperations *pendingOperations;
@end
