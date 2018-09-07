//
//  ProductList.h
//  eCommerce-App
//
//  Created by Thinh Le on 2015-05-29.
//  Copyright (c) 2015 Skin Tree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface ProductList : NSManagedObject

@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * categoryDescription;
@property (nonatomic, strong) NSString * categoryId;
@property (nonatomic, strong) NSSet *products;

@end

@interface ProductList (CoreDataGeneratedAccessors)

- (void)addArticlesObject:(Product *)value;
- (void)removeArticlesObject:(Product *)value;
- (void)addArticles:(NSSet *)values;
- (void)removeArticles:(NSSet *)values;

@end
