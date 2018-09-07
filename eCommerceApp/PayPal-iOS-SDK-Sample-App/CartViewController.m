//
//  CartViewController.m
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-29.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import "CartViewController.h"
#import "ListOfProductTableViewController.h"
#import "ProductSelected.h"
#import "CartCell.h"
#import "TotalCell.h"

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

// Set the environment:
// - For live charges,  use PayPalEnvironmentProduction (default).
// - For PayPal sandbox,use PayPalEnvironmentSandbox.
// - For testing,       use PayPalEnvironmentNoNetwork.
//#define kPayPalEnvironment PayPalEnvironmentNoNetwork
#define kPayPalEnvironment PayPalEnvironmentSandbox

@interface CartViewController ()
@property(nonatomic, strong, readwrite) IBOutlet UIButton   *payNowButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView     *successView;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation CartViewController {
    // within each unique item on cart, to be displayed as a row in the table
    NSString * _prodId_quan;
    NSString * _quantity;
    float _prodId_price;
    float _prodId_subTotal;
    
    // for the entire items on cart, to be displayed at the bottom of the table
    float _totalWeight;
    float _subtotal;
    float _shipping;
    float _tax;
    float _total;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PayPal SDK Demo";
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = @"Awesome Shirts, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    // Setting the payPalShippingAddressOption property is optional.
    // See PayPalConfiguration.h for details.
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    //self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;

//    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
//    self.navigationItem.rightBarButtonItem = doneButton;

    // update listOfPPItems with listOfProductsSelected
    NSMutableArray *items = [[NSMutableArray array] init];
    //NSLog(@"self.product.count = %d", self.products.count);
    for (int i=0; i<self.listOfProductsSelected.count; i++) {
        PayPalItem *item = [[PayPalItem alloc] init];
        PhotoRecord2 *tempRec = [self.listOfProductsSelected objectAtIndex:i];
        
        item.name = tempRec.recordName;
        //item.BMMquantity = (unsigned int)[[self.dictOfProductOnCart objectForKey:@"productId"] integerValue]; //quantity is stored in self.dictOfProductOnCart, with key=productId
        item.price = [NSDecimalNumber decimalNumberWithString:tempRec.recordPrice];
        item.currency = tempRec.recordCurrency;
        item.sku = tempRec.recordId;
        
        for (NSString *key in [self.dictOfProductOnCart allKeys]) {
            if ([item.sku isEqualToString:key]) {
                item.quantity = (unsigned int)[[self.dictOfProductOnCart objectForKey:key] integerValue]; //quantity is stored in self.dictOfProductOnCart, with key=productId
            }
        }
        //NSLog(@"listOfPPItems: %@, %lu, %@, %@, %@", item.name, (unsigned long)item.quantity, item.price, item.currency, item.sku);
        
        [items addObject:item];
        item = nil;
    }
    self.listOfPPItems = items;
    
    // update PPPaymentDetails subtotal, Shipping, and Tax
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    _subtotal = [subtotal floatValue];
    //NSLog(@"subtotal in float = %.6f\n", _subtotal);
    
    // update shipping cost, assuming $0.05 for now.
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"8.05"];
    _shipping = [shipping floatValue];
    //NSLog(@"shipping in float = %.6f\n", _shipping);
    
    // update on tax
    _tax = 0.08 * [subtotal floatValue];
    NSDecimalNumber *tax = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:_tax] decimalValue]];
    //NSLog(@"tax in float      = %.6f\n", _tax);
    
    // Total order
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    _total = [total floatValue];
    //NSLog(@"total in float    = %.6f\n", _total);
    
    // display grandTotal
    //self.totalWeightOnCart.text = [NSString stringWithFormat:@"%.2f", [totalWeight floatValue]];
    self.subTotalOnCart.text    = [NSString stringWithFormat:@"%.2f", [subtotal floatValue]];
    self.estShippingOnCart.text = [NSString stringWithFormat:@"%.2f", [shipping floatValue]];
    self.taxOnCart.text         = [NSString stringWithFormat:@"%.2f", [tax floatValue]];
    self.grandTotalOnCart.text  = [NSString stringWithFormat:@"%.2f", [total floatValue]];
    
    PhotoRecord2 *tempRec3 = [self.listOfProductsSelected objectAtIndex:0];

    self.currencyDisplayed.text =  tempRec3.recordCurrency; //[[self.listOfProductsSelected objectAtIndex:0] objectForKey:@"productCurrency"];
}

- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem * continueShoppingButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cont. Shop.", nil) style:UIBarButtonItemStyleDone target:self action:@selector(continueShopping:)];
    self.navigationItem.leftBarButtonItem = continueShoppingButton;
    
    UIBarButtonItem * addToShoppingCartButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Checkout", nil) style:UIBarButtonItemStyleDone target:self action:@selector(checkOut:)];
    self.navigationItem.rightBarButtonItem = addToShoppingCartButton;
    
    self.navigationItem.title = @"Cart";
}

-(void)continueShopping:(id)sender
{
    ListOfProductTableViewController * listOfProductTableViewController = [[ListOfProductTableViewController alloc] init];
    listOfProductTableViewController.listOfProductsSelected = self.listOfProductsSelected;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)checkOut:(id)sender
{
    NSDecimalNumber *stt = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f", _subtotal]];
    NSDecimalNumber *shp = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f", _shipping]];
    NSDecimalNumber *ttx = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f", _tax]];
    NSDecimalNumber *ttl = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f", _total]];
    NSLog(@"stt, shp, ttx, ttl in NSDecimalNumber = %@, %@, %@, %@", stt, shp, ttx, ttl);

    //Optional: include payment details
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:stt
                                                                               withShipping:shp
                                                                                    withTax:ttx];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = ttl;
    
    PhotoRecord2 *tempRec4 = [self.listOfProductsSelected objectAtIndex:0];

    payment.currencyCode = tempRec4.recordCurrency; //[[self.listOfProductsSelected objectAtIndex:0] objectForKey:@"productCurrency"];
    payment.shortDescription = @"Supplements";
    payment.items = nil; //self.listOfPPItems;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.payPalConfig delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation
- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

- (void)didReceiveMemoryWarning {
    //[self cancelAllOperations];
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"in cartviewcontroller, array size = %lu", (unsigned long)self.listOfProductsSelected.count);
    return [self.listOfProductsSelected count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartCell" forIndexPath:indexPath];
    
    // NSArray implementation
    PhotoRecord2 *tempRec2 = [self.listOfProductsSelected objectAtIndex:indexPath.row];
    
    cell.prodNameOnCart.text   = tempRec2.recordName;
    
    // 3
    if (tempRec2.hasImage) {
        cell.prodImageOnCart.image = tempRec2.recordImageData;
    }
    
    // 4
    else if (tempRec2.isFailed) {
        cell.prodImageOnCart.image = [UIImage imageNamed:@"Failed.png"];
        cell.prodPriceOnCart.text = @"N/A";
        cell.prodNameOnCart.text = @"Failed to load";
        
    }
    // 5
    else {
        cell.prodImageOnCart.image = [UIImage imageNamed:@"Placeholder.png"];
        //[self startOperationsForPhotoRecord:aRecord];
    }
    
    cell.prodBriefOnCart.text  = tempRec2.recordBrief;
    cell.prodPriceOnCart.text = [NSString stringWithFormat:@"%.2f", [tempRec2.recordPrice floatValue]];
    cell.prodCurrencyOnCart.text = tempRec2.recordCurrency;
    cell.prodWeightOnCart.text = [NSString stringWithFormat:@"%.2f", [tempRec2.recordWeight floatValue]];
    cell.prodUnitOnCart.text = tempRec2.recordUnit;
    
    // show quantity and subTotal at each product selected
    _quantity = [NSString stringWithFormat:@"%2@", [self.dictOfProductOnCart objectForKey:tempRec2.recordId]];
    cell.prodQuantityOnCart.text = _quantity;
    //NSLog(@"# of product with Id[%@] = %ld\n", tempRec2.recordId, (long)[_quantity integerValue]);

    _prodId_price = [tempRec2.recordPrice floatValue];
    _prodId_subTotal = [_quantity floatValue] * _prodId_price;
    
    cell.subTotalPriceOnCart.text = [NSString stringWithFormat:@"%.2f", _prodId_subTotal];
    
    return cell;
}

#pragma mark - Helpers
- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"ShowShoppingCart"]) {
//        DetailProductDescriptionViewController * detailProductDescriptionViewController = (DetailProductDescriptionViewController *)segue.destinationViewController;
//        detailProductDescriptionViewController.listOfProductsSelected = self.listOfProductsSelected;
//    }
//}

@end
