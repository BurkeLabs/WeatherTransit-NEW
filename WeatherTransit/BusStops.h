//
//  BusStops.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusStops : NSObject

@property NSString *route;
@property NSString *direction;
@property int stopID;
@property NSString *stopName;

@end
