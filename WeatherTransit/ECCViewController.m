//
//  ECCViewController.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "ECCViewController.h"
#import <WebKit/WebKit.h>

@interface ECCViewController () <UITabBarDelegate, UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGesture;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, readonly, copy) NSURL *URL;

@end

@implementation ECCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.spinner.hidesWhenStopped = YES;
    [self openURL:@"http://www.emergencyclosingcenter.com"];
}

-(void)openURL:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.webView.scrollView setDelegate:self];
}

@end
