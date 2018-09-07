//
//  AppDelegate.m
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-28.
//  Copyright (c) 2015 Skin Tree. All rights reserved.

#import "AppDelegate.h"
#import "PayPalMobile.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                         PayPalEnvironmentSandbox : @"AYsPxLG6cZGYo7603gIJ90TYK-cLWd5jjHbX2Q2i31AxJzO4_nuOH23gaYHWzjKWEdReH4H0UhbRd6uf"}];
    // YOUR_CLIENT_ID_FOR_SANDBOX
    
    /*
    // step 1: initialize URL
    NSURL *baseURL = [NSURL URLWithString:@"https://thinhmle.com/"];
    
    // step 2: initialize RestKit
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Initialize managed object model from bundle
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Initialize managed object store
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    // Complete Core Data stack initialization
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"ProductsDB.sqlite"];
    
    //NSLog(@"storePath = %@", storePath);
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError  *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    RKEntityMapping *articleListMapping = [RKEntityMapping mappingForEntityForName:@"ProductList" inManagedObjectStore:managedObjectStore];
    articleListMapping.identificationAttributes = @[@"categoryName"];
    [articleListMapping addAttributeMappingsFromArray:@[@"categoryName", @"categoryDescription", @"categoryId"]];
    
    RKEntityMapping *articleMapping = [RKEntityMapping mappingForEntityForName:@"Product" inManagedObjectStore:managedObjectStore];
    articleMapping.identificationAttributes = @[@"productId"];
    [articleMapping addAttributeMappingsFromArray:@[@"productName", @"productId", @"productThumbnail", @"productBrief", @"productDescription", @"productPrice", @"productCurrency", @"productWeight", @"productUnit", @"productQuantity", @"productImage"]];
    
    [articleListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"products" toKeyPath:@"products" withMapping:articleMapping]];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *articleListResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleListMapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // step ?? : execution
    [objectManager addResponseDescriptor:articleListResponseDescriptor];
     

    // Enable Activity Indicator Spinner, belongs to ClassicPhotos program
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
     */
    
  return YES;
}

@end
