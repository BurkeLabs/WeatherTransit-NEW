//
//  BusStops.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "BusStops.h"

@implementation BusStops

-(NSString *)description{
    return [NSString stringWithFormat:@"route %@, direction %@, stopID %d, stopName, %@", _route, _direction, _stopID, _stopName];
}

@end
