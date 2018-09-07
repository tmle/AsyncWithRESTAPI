//
//  DetailProductDescriptionViewController.m
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import "DetailProductDescriptionViewController.h"

@interface DetailProductDescriptionViewController ()

@end

@implementation DetailProductDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem * continueShoppingButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cont. Shop.", nil) style:UIBarButtonItemStyleDone target:self action:@selector(continueShopping:)];
    self.navigationItem.leftBarButtonItem = continueShoppingButton;
    
    UIBarButtonItem * addToShoppingCartButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Add to Cart", nil) style:UIBarButtonItemStyleDone target:self action:@selector(addToShoppingCart:)];
    self.navigationItem.rightBarButtonItem = addToShoppingCartButton;
    
    self.navigationItem.title = @"Details";
    
    PhotoRecord2 *aRecord = self.recordSelected_t;
    // 3
    if (aRecord.hasLargeImage) {
        self.prodImageOnDetail.image = aRecord.recordImageData;
    }
    // 4
    else if (aRecord.isFailed) {
        self.prodImageOnDetail.image = [UIImage imageNamed:@"Failed.png"];
        self.prodPriceOnDetail.text = @"N/A";
        self.prodNameOnDetail.text = @"Failed to load";
        
    }
    // 5
    else {
        self.prodImageOnDetail.image = [UIImage imageNamed:@"Placeholder.png"];
        //[self startOperationsForPhotoRecord:aRecord];
    }
    
    self.prodNameOnDetail.text        = aRecord.recordName;
    self.prodDescriptionOnDetail.font = [UIFont systemFontOfSize:15.0f];
    self.prodDescriptionOnDetail.textColor = [UIColor darkGrayColor];
    self.prodDescriptionOnDetail.text = aRecord.recordDescription;
    self.prodPriceOnDetail.text       = [NSString stringWithFormat:@"%.2f", [aRecord.recordPrice floatValue]];
    self.prodCurrencyOnDetail.text    = aRecord.recordCurrency;
    self.prodWeightOnDetail.text      = [NSString stringWithFormat:@"%.2f", [aRecord.recordWeight floatValue]];
    //NSLog(@"weight = %@", self.prodWeightOnDetail.text);
    self.prodUnitOnDetail.text        = aRecord.recordUnit;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)continueShopping:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)addToShoppingCart:(id)sender
{
    // A. algorithm to add product in to the shopping cart
    //if cart is empty, add product, increase counter_of_product
    //if not, go through items by items, check product Id,
        // if there, increase counter of product
        // if not there, add product, increase counter of product
    
    // B. algorithm to take care of the product id and the corresponding quantity
    //    1. create a new dictionary with key = prodId, value = quantity
    //    2. update quantity based on the prodId.

    // add to shopping cart
    BOOL found = NO;
    NSString *key = self.recordSelected_t.recordId;
    NSLog(@"product seletected [%@] = %@", self.recordSelected_t.recordId, self.recordSelected_t.recordQuantity);

    if ([self.listOfProductsSelected count] == 0) {
        [self.listOfProductsSelected addObject:self.recordSelected_t];
        NSLog(@"first item to be placed on cart");
        NSLog(@"# of items on cart is now %lu", (unsigned long)self.listOfProductsSelected.count);
        
         NSNumber *value = [NSNumber numberWithInt:1];
         [self.dictOfProductOnCart setValue:value forKey:key];
    }
    else {
        for (int i = 0; i <[self.listOfProductsSelected count]; ++i) {
            NSString *newlyArrivedId = self.recordSelected_t.recordId;
            
            PhotoRecord2 *tempRec = self.listOfProductsSelected[i];
            NSString *existingId = tempRec.recordId;
            if ([newlyArrivedId isEqualToString:existingId]) {
                NSNumber *quan = [self.dictOfProductOnCart objectForKey:key];
                int quantity = (int)[quan integerValue];
                quantity++;
                quan = [NSNumber numberWithInt:quantity];
                [self.dictOfProductOnCart setValue:quan forKey:key];
                found = YES;
                
                NSLog(@"# of product selected = %d", quantity);

            }
        }
     
        if (!found) {
            [self.listOfProductsSelected addObject:self.recordSelected_t];
            NSNumber *quan = [self.dictOfProductOnCart objectForKey:key];
            int quantity =  (int)[quan integerValue];
            quantity++;
            quan = [NSNumber numberWithInt:quantity];
            [self.dictOfProductOnCart setValue:quan forKey:key];
        }
     } // else
        
    [self performSegueWithIdentifier:@"ShowShoppingCart" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowShoppingCart"]) {
        CartViewController * cartViewController   = (CartViewController *)segue.destinationViewController;
        cartViewController.listOfProductsSelected = self.listOfProductsSelected;
        cartViewController.dictOfProductOnCart    = self.dictOfProductOnCart;
    }
}

@end
