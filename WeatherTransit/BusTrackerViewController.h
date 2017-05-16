//
//  BusTrackerViewController.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Upcoming.h"
#import "BusName.h"

@protocol BusTrackerViewControllerDelegate;

@interface BusTrackerViewController : UIViewController

@property (nonatomic, weak) id<BusTrackerViewControllerDelegate> delegate;
@property Upcoming *upcoming;

@end

@protocol BusTrackerViewControllerDelegate <NSObject>

-(void)busTrackerViewController:(BusTrackerViewController*)viewController didChooseValue:(BusName *)value;

@end
