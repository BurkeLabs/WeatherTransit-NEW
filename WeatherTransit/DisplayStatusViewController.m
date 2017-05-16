//
//  DisplayStatusViewController.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "DisplayStatusViewController.h"
#import "DisplayStatus.h"

@interface DisplayStatusViewController () <UITextViewDelegate>

@property DisplayStatus *displayStatus;
@property (weak, nonatomic) IBOutlet UITextView *statusText;
@property NSArray *alerts;

@end

@implementation DisplayStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.transitchicago.com/api/1.0/alerts.aspx?routeid=%@&outputType=JSON", self.displayStatus.ServiceId]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *displayDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *cta = [displayDictionary objectForKey:@"CTAAlerts"];
        self.alerts = [cta objectForKey:@"Alert"];

        NSString *displayStatus;
        if (self.alerts == 0) {
            displayStatus = @"There are no alerts at this time for this route";
        } else {
            NSMutableString *formattedAlerts = [NSMutableString new];
            for (NSDictionary *alert in self.alerts) {
                [formattedAlerts appendFormat:@"%@\%@\n%@\n\n", [alert objectForKey:@"ServiceId"], [alert objectForKey:@"Headline"], [alert objectForKey:@"ShortDescription"]];
            }
            displayStatus = formattedAlerts;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statusText.text = displayStatus;
        });
    }];
    [task resume];
}

@end
