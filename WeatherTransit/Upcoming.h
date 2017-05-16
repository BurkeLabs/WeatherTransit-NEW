//
//  Upcoming.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Upcoming : NSObject

@property int stopID;
@property NSString *vehicleID;
@property NSString *message;
@property NSString *timeStamp;
@property NSString *stopName;
@property NSString *destination;
@property NSString *route;
@property NSString *routeDirection;
@property int destinationPoint;
@property NSDate *predictionTime;
@property NSString *routeDestination;
@property BOOL delay;

@end
