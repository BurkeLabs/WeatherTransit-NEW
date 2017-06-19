//
//  FavoritedBus+CoreDataProperties.m
//  WeatherTransit
//
//  Created by Michelle Burke on 5/29/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "FavoritedBus+CoreDataProperties.h"

@implementation FavoritedBus (CoreDataProperties)

+ (NSFetchRequest<FavoritedBus *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FavoritedBus"];
}

@dynamic route;
@dynamic routeName;
@dynamic direction;

@end
