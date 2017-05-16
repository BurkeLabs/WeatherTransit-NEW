//
//  DisplayStatus.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "DisplayStatus.h"

@implementation DisplayStatus

-(NSString *)description{
    return [NSString stringWithFormat:@"Route %@, Headline %@, Short Description %@", _ServiceId, _Headline, _ShortDescription];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];

    if (self) {
        self.Headline = dictionary[@"Headline"];
        self.ShortDescription = dictionary[@"ShortDescription"];
    }
    return self;
}

@end
