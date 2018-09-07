//
//  ListOfProductTableViewController.m
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import "ListOfProductTableViewController.h"
@interface ListOfProductTableViewController ()

@end

@implementation ListOfProductTableViewController
{
    NSArray *products;
    NSMutableArray *sortedArrayOfProducts;
    PhotoRecord2   * _recordSelected;
    NSMutableArray *tempRecord;
}
@synthesize photos = _photos;
@synthesize pendingOperations = _pendingOperations;

- (PendingOperations *)pendingOperations {
    if (!_pendingOperations) {
        _pendingOperations = [[PendingOperations alloc] init]; 
    }
    return _pendingOperations;
}

#pragma mark - Lazy instantiation
- (NSArray *)photos {
    if (!_photos) {

        // step 1: initialize AFNetworking HTTPClient
        NSURL *baseURL = [NSURL URLWithString:kThinhMLeBaseURL];
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        
        // step 2: initialize RestKit
        RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
        // step 3: set up object mapping
        RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[Item class]]; //Venue
        [itemMapping addAttributeMappingsFromArray:@[@"productId", @"productName", @"productThumbnail", @"productImage", @"productBrief", @"productDescription", @"productPrice", @"productCurrency", @"productWeight", @"productUnit", @"productQuantity"]];
        // addAttributeMappingsFromDictionary:@{@"products":@"products"}
        
        // step 4: register mappings with the provider using a response descriptor
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemMapping method:RKRequestMethodGET pathPattern:@"/api/ProductList_1_skintree.json" keyPath:@"products" statusCodes:[NSIndexSet indexSetWithIndex:200]];
        //pathPattern:@"/v2/venues/search" keyPath:@"response.venues"
        
        // step 5: execution
        [objectManager addResponseDescriptor:responseDescriptor];
        
        [[RKObjectManager sharedManager]
         getObjectsAtPath:@"/api/ProductList_1_skintree.json"
         parameters:nil
         success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
             
             products = mappingResult.array;
             [self.tableView reloadData];
             
             // list of products are not in order, have to order it.
             NSMutableArray *unsortedArray = [[NSMutableArray alloc] init];
             for (int i=0; i<products.count; i++) {
                 Product *tproduct = products[i];
                 [unsortedArray addObject:tproduct.productId];
             }
             //NSLog(@"unsortedArray entries = %@, numberEntries = %lu", unsortedArray, (unsigned long)products.count);
             
             NSArray *sortedArray =[unsortedArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
             //NSLog(@"sortedArray entries = %@", sortedArray);
             
             // step3: form the sorted array-of-products using sorted-array-of-keys
             sortedArrayOfProducts = [[NSMutableArray alloc] init];
             for (int j = 0; j<sortedArray.count; j++) {
                 NSString *tempString = sortedArray[j];
                 for (int k=0; k<products.count; k++) {
                     Product *tproduct = products[k];
                     if ([tproduct.productId isEqualToString:tempString]) {
                         sortedArrayOfProducts[k] = tproduct;
                         //[sortedArrayOfProducts addObject:tproduct]; // works the same way
                     }
                 } // for k
             } // for j
             
             //==
             NSMutableArray *records2 = [[NSMutableArray array] init];
             for (int k=0; k<sortedArrayOfProducts.count; k++) {
                 Product *product = sortedArrayOfProducts[k];
                 PhotoRecord2 *record = [[PhotoRecord2 alloc] init];
                 
                 record.recordId = product.productId;
                 record.recordName = product.productName;
                 record.recordThumbnail = product.productThumbnail;
                 record.recordImage = product.productImage;
                 record.recordThumbnailURL = [NSURL URLWithString:product.productThumbnail];
                 record.recordImageURL = [NSURL URLWithString:product.productImage];
                 record.recordBrief = product.productBrief;
                 record.recordDescription = product.productDescription;
                 record.recordPrice = product.productPrice;
                 record.recordCurrency = product.productCurrency;
                 record.recordWeight = product.productWeight;
                 record.recordUnit = product.productUnit;
                 record.recordQuantity = product.productQuantity;
                 //NSLog(@"%@, Price = %.2f", product.productId, [product.productPrice doubleValue]);

                 [records2 addObject:record];
                 record = nil;
             }
             _photos = records2;
             //NSLog(@"numRecords = %d", _photos.count);

         }
         failure:^(RKObjectRequestOperation *operation, NSError *error) {
             NSLog(@"Load fail with error: %@", error);
         }];
        
        //[self.pendingOperations.downloadQueue addOperation:datasource_download_operation];

    } // !_photos
    
    return _photos;
    
} // end of method


- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@", [PayPalMobile libraryVersion]);
    self.navigationItem.title = @"Skin Care";
    //[self requestData]; // if coredata is used
    
    if (self.listOfProductsSelected == nil) {
        self.listOfProductsSelected = [[NSMutableArray alloc] init];
    }
    
    //create a dictionary of product ids on cart to keep track of the quantity of each.
    if (self.dictOfProductOnCart == nil) {
        self.dictOfProductOnCart = [[NSMutableDictionary alloc] init];
    }
}

- (void)viewDidUnload {
    [self setPhotos:nil];
    [self setPendingOperations:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [self cancelAllOperations];
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count  = self.photos.count;
    //NSLog(@"numRows = %d", self.photos.count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"ProductCell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        // 1: To provide feedback to the user, create a UIActivityIndicatorView and set it as the cellís accessory view.
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = activityIndicatorView;
        
    }
    
    // 2
    PhotoRecord2 *aRecord = [self.photos objectAtIndex:indexPath.row];

    // 3
    if (aRecord.hasImage) {
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        //cell.productThumbnail.image = [UIImage imageWithData:imageData];
        cell.productThumbnail.image = aRecord.recordThumbnailData;
        cell.productPrice.text = aRecord.recordPrice;
        //NSLog(@"finish downloading image %d", indexPath.row);
    }
    // 4
    else if (aRecord.isFailed) {
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
        cell.productThumbnail.image = [UIImage imageNamed:@"Failed.png"];
        cell.productPrice.text = @"N/A";
        cell.productName.text = @"Failed to load";
    }
    // 5
    else {
        [((UIActivityIndicatorView *)cell.accessoryView) startAnimating];
        cell.productThumbnail.image = [UIImage imageNamed:@"Placeholder.png"];
        
        if (!tableView.dragging && !tableView.decelerating) {
            [self startOperationsForPhotoRecord:aRecord atIndexPath:indexPath];
        }

    }
    
    cell.productName.text     = aRecord.recordName;
    cell.productBrief.text    = aRecord.recordBrief;
    cell.productPrice.text    = [NSString stringWithFormat:@"%.2f", [aRecord.recordPrice floatValue]];
    cell.productCurrency.text = aRecord.recordCurrency;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    _recordSelected = [self.photos objectAtIndex:indexPath.row];
    //NSLog(@"weight = %@", _recordSelected.recordWeight);
    [self performSegueWithIdentifier:@"ShowDetailProductDescription" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetailProductDescription"]) {
        DetailProductDescriptionViewController * detailProductDescriptionViewController = (DetailProductDescriptionViewController *)segue.destinationViewController;
        detailProductDescriptionViewController.recordSelected_t       = _recordSelected; // more important
        detailProductDescriptionViewController.listOfProductsSelected = self.listOfProductsSelected;
        detailProductDescriptionViewController.dictOfProductOnCart    = self.dictOfProductOnCart;
    }
}

- (void)startOperationsForPhotoRecord:(PhotoRecord2 *)record atIndexPath:(NSIndexPath *)indexPath {
    if (!record.hasImage) {
        [self startImageDownloadingForRecord:record atIndexPath:indexPath];
    }

    if (!record.isFiltered) {
        [self startImageFiltrationForRecord:record atIndexPath:indexPath];
    }
}

- (void)startImageDownloadingForRecord:(PhotoRecord2 *)record atIndexPath:(NSIndexPath *)indexPath {
    // 1
    if (![self.pendingOperations.downloadsInProgress.allKeys containsObject:indexPath]) {
        
        // 2
        // Start downloading
        ImageDownloader *imageDownloader = [[ImageDownloader alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        [self.pendingOperations.downloadsInProgress setObject:imageDownloader forKey:indexPath];
        [self.pendingOperations.downloadQueue addOperation:imageDownloader];
    }
}

- (void)startImageFiltrationForRecord:(PhotoRecord2 *)record atIndexPath:(NSIndexPath *)indexPath {
    // 3
    if (![self.pendingOperations.filtrationsInProgress.allKeys containsObject:indexPath]) {
        
        // 4
        // Start filtration
        ImageFiltration *imageFiltration = [[ImageFiltration alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        
        // 5
        ImageDownloader *dependency = [self.pendingOperations.downloadsInProgress objectForKey:indexPath];
        if (dependency)
            [imageFiltration addDependency:dependency];
        
        [self.pendingOperations.filtrationsInProgress setObject:imageFiltration forKey:indexPath];
        [self.pendingOperations.filtrationQueue addOperation:imageFiltration];
    }
}

#pragma mark - Image Downloader delegate
- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader {
    
    // 1
    NSIndexPath *indexPath = downloader.indexPathInTableView;
    // 2
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    // 3
    [self.pendingOperations.downloadsInProgress removeObjectForKey:indexPath];
}

#pragma mark - Image Filtration delegate
- (void)imageFiltrationDidFinish:(ImageFiltration *)filtration {
    NSIndexPath *indexPath = filtration.indexPathInTableView;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.pendingOperations.filtrationsInProgress removeObjectForKey:indexPath];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 1
    [self suspendAllOperations];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 2
    if (!decelerate) {
        [self loadImagesForOnscreenCells];
        [self resumeAllOperations];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 3
    [self loadImagesForOnscreenCells];
    [self resumeAllOperations];
}

#pragma mark - Cancelling, suspending, resuming queues / operations
- (void)suspendAllOperations {
    [self.pendingOperations.downloadQueue setSuspended:YES];
    [self.pendingOperations.filtrationQueue setSuspended:YES];
}

- (void)resumeAllOperations {
    [self.pendingOperations.downloadQueue setSuspended:NO];
    [self.pendingOperations.filtrationQueue setSuspended:NO];
}

- (void)cancelAllOperations {
    [self.pendingOperations.downloadQueue cancelAllOperations];
    [self.pendingOperations.filtrationQueue cancelAllOperations];
}

- (void)loadImagesForOnscreenCells {
    
    // 1
    NSSet *visibleRows = [NSSet setWithArray:[self.tableView indexPathsForVisibleRows]];
    
    // 2
    NSMutableSet *pendingOperations = [NSMutableSet setWithArray:[self.pendingOperations.downloadsInProgress allKeys]];
    [pendingOperations addObjectsFromArray:[self.pendingOperations.filtrationsInProgress allKeys]];
    
    NSMutableSet *toBeCancelled = [pendingOperations mutableCopy];
    NSMutableSet *toBeStarted = [visibleRows mutableCopy];
    
    // 3
    [toBeStarted minusSet:pendingOperations];
    // 4
    [toBeCancelled minusSet:visibleRows];
    
    // 5
    for (NSIndexPath *anIndexPath in toBeCancelled) {
        
        ImageDownloader *pendingDownload = [self.pendingOperations.downloadsInProgress objectForKey:anIndexPath];
        [pendingDownload cancel];
        [self.pendingOperations.downloadsInProgress removeObjectForKey:anIndexPath];
        
        ImageFiltration *pendingFiltration = [self.pendingOperations.filtrationsInProgress objectForKey:anIndexPath];
        [pendingFiltration cancel];
        [self.pendingOperations.filtrationsInProgress removeObjectForKey:anIndexPath];
    }
    toBeCancelled = nil;
    
    // 6
    for (NSIndexPath *anIndexPath in toBeStarted) {
        PhotoRecord2 *recordToProcess = [self.photos objectAtIndex:anIndexPath.row];
        [self startOperationsForPhotoRecord:recordToProcess atIndexPath:anIndexPath];
    }
    toBeStarted = nil;
    
}

#pragma mark - RESTKit
- (void)requestData {
    NSString *requestPath = @"api/ProductList_1_skintree.json"; //dict of dict, json list of products with full details
    
    [[RKObjectManager sharedManager]
     getObjectsAtPath:requestPath
     parameters:nil
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //articles have been saved in core data by now
         [self fetchProductsFromContext];
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
}

- (void)fetchProductsFromContext {
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ProductList"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"categoryId" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSLog(@"fetchedObjects = %@", fetchedObjects);
    
    ProductList *productList = [fetchedObjects firstObject];
    products = [productList.products allObjects];
    NSLog(@"finish downloading and storing productList");
    
    // list of products are not in order, have to order it.
    NSMutableArray *unsortedArray = [[NSMutableArray alloc] init];
    for (int i=0; i<products.count; i++) {
        Product *tproduct = products[i];
        [unsortedArray addObject:tproduct.productId];
    }
    //NSLog(@"unsortedArray entries = %@, numberEntries = %lu", unsortedArray, (unsigned long)self.products.count);
    
    NSArray *sortedArray =[unsortedArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    //NSLog(@"sortedArray entries = %@", sortedArray);
    
    // step3: form the sorted array-of-products using sorted-array-of-keys
    BOOL found = NO;
    sortedArrayOfProducts = [[NSMutableArray alloc] init];
    for (int j = 0; j<sortedArray.count; j++) {
        NSString *tempString = sortedArray[j];
        //NSLog(@"tempString = %@", sortedArray[j]);
        for (int k=0; k<products.count; k++) {
            Product *tproduct = products[k];
            if (found == NO) {
                if ([tproduct.productId isEqualToString:tempString]) {
                    found = YES;
                    //NSLog(@"found = %d", found);
                } // if

                if (found == YES) {
                    sortedArrayOfProducts[j] = tproduct;
                    found = NO;
                }
            } // if not found
        } // for k
    } // for j
    
    //==
    NSMutableArray *records2 = [[NSMutableArray array] init];
    //NSLog(@"self.product.count = %d", self.products.count);
    for (int k=0; k<sortedArrayOfProducts.count; k++) {
        Product *product = sortedArrayOfProducts[k];
        PhotoRecord2 *record = [[PhotoRecord2 alloc] init];
        
        record.recordId = product.productId;
        record.recordName = product.productName;
        record.recordThumbnail = product.productThumbnail;
        record.recordImage = product.productImage;
        record.recordThumbnailURL = [NSURL URLWithString:product.productThumbnail];
        record.recordImageURL = [NSURL URLWithString:product.productImage];
        record.recordBrief = product.productBrief;
        record.recordDescription = product.productDescription;
        record.recordPrice = product.productPrice;
        record.recordCurrency = product.productCurrency;
        record.recordWeight = product.productWeight;
        record.recordUnit = product.productUnit;
        record.recordQuantity = product.productQuantity;
        
        //NSLog(@"Record2 - name, URL: %@, %@", record.recordName, record.recordThumbnailURL);
        [records2 addObject:record];
        record = nil;
    }
    tempRecord = records2;
    //==
    //[self.tableView reloadData];
}

@end
