//
//  FavoritesViewController.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusName.h"
#import "BusTrackerViewController.h"

@interface FavoritesViewController : UIViewController <BusTrackerViewControllerDelegate>

@property BusName *busName;
@property NSMutableArray *addedBus;

@end
