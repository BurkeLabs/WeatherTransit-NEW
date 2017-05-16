//
//  BusName.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusName : NSObject

@property NSString *route;
@property NSString *routeName;

+(void)retrieveBusWithCompletion:(void(^)(NSMutableArray *))complete;

@end
