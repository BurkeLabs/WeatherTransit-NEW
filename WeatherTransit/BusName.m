//
//  BusName.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "BusName.h"

@implementation BusName

-(NSString *)description{
    return [NSString stringWithFormat:@"route, %@, routeName, %@", _route, _routeName];
}

+(void)retrieveBusWithCompletion:(void (^)(NSMutableArray *))complete{

}

@end
