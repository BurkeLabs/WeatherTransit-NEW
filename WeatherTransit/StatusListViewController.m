//
//  StatusListViewController.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "StatusListViewController.h"
#import "StatusList.h"
#import "DisplayStatusViewController.h"

@interface StatusListViewController () <UITableViewDelegate, UITableViewDataSource>

//@property (weak, nonatomic) IBOutlet UITableView *statusTableView;


//@property StatusList *statusList;

@end

@implementation StatusListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.transitchicago.com/api/1.0/routes.aspx?routeid=%@&outputType=JSON", self.statusList.ServiceId]];
    NSLog(@"url: %@", url);
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"error: %@", error);
        NSLog(@"data: %@", data);
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *ctaRoutes = [responseDictionary objectForKey:@"CTARoutes"];
        NSDictionary *routeInfo = [ctaRoutes objectForKey:@"RouteInfo"];

        //        NSLog(@"error");

        self.statusList = [[StatusList alloc] initWithDictionary:routeInfo];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.statusTableView reloadData];
        });
    }];
    [task resume];
}

#pragma mark - UITableView DataSource and Delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Status"];
    cell.textLabel.text = self.statusList.Route;
    cell.detailTextLabel.text = self.statusList.RouteStatus;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.statusList == NULL) {
        return 0;
    } else {
        return 1;
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DisplayStatusViewController *displayStatusVC = segue.destinationViewController;
}

@end
