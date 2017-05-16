//
//  StatusListViewController.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusList.h"


@interface StatusListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *statusTableView;

@property StatusList *statusArray;
@property StatusList *statusList;

@end
