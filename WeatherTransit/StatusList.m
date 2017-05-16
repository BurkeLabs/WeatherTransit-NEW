//
//  StatusList.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "StatusList.h"

@implementation StatusList

-(NSString *)description{
    return [NSString stringWithFormat:@"Route %@, RouteStatus %@, ", _Route, _RouteStatus];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];

    if (self) {
        self.Route = dictionary[@"Route"];
        self.RouteStatus = dictionary[@"RouteStatus"];
    }
    return self;
}

@end
