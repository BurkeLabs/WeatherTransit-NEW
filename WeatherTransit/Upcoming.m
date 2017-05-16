//
//  Upcoming.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "Upcoming.h"

@implementation Upcoming

-(NSString *)description{
    return [NSString stringWithFormat:@"stopID %i, stopName, %@, predictionTime %@", _stopID, _stopName, _predictionTime];
}

@end
