//
//  FavoritedBus+CoreDataProperties.h
//  WeatherTransit
//
//  Created by Michelle Burke on 5/29/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "FavoritedBus+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoritedBus (CoreDataProperties)

+ (NSFetchRequest<FavoritedBus *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *route;
@property (nullable, nonatomic, copy) NSString *routeName;
@property (nullable, nonatomic, copy) NSString *direction;

@end

NS_ASSUME_NONNULL_END
