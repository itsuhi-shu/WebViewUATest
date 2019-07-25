//
//  DetailViewController.m
//  WebViewUATest
//
//  Created by 周 軼飛 on 2019/07/24.
//  Copyright © 2019 F.O.X. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController () <WKNavigationDelegate>

@end

@implementation DetailViewController

- (void)configureView {
    if (_pattern < 3) {
        for (UIView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIWebView class]] || [subview isKindOfClass:[WKWebView class]]) {
                [subview removeFromSuperview];
                break;
            }
        }
        
        // Update the user interface for the detail item.
        if (self.ua) {
            self.detailDescriptionLabel.text = [self.ua description];
        }
    } else {
        NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"UserAgent" ofType:@"html"];
        if (_pattern == 3) {
            UIWebView *uiWebView = [[UIWebView alloc] initWithFrame: self.view.bounds];
            [self.view addSubview:uiWebView];
            [uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]]];
        } else if (_pattern == 4)  {
            WKWebView *wkWebView = [[WKWebView alloc] initWithFrame: self.view.bounds configuration:[WKWebViewConfiguration new]];
            [self.view addSubview:wkWebView];
            [wkWebView loadFileURL:[NSURL fileURLWithPath:urlPath] allowingReadAccessToURL:[NSBundle mainBundle].bundleURL];
        } else if (_pattern == 5) {
            WKWebView *wkWebView = [[WKWebView alloc] initWithFrame: self.view.bounds configuration:[WKWebViewConfiguration new]];
            wkWebView.navigationDelegate = self;
            [self.view addSubview:wkWebView];
            [wkWebView loadFileURL:[NSURL fileURLWithPath:urlPath] allowingReadAccessToURL:[NSBundle mainBundle].bundleURL];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}


#pragma mark - Managing the detail item

- (void)setUa:(NSString *)newUa {
    if (_ua != newUa) {
        _ua = newUa;
    }
    
    // Update the view.
    [self configureView];
}

- (void)setPattern:(NSInteger)pattern {
    _pattern = pattern;
    
    // Update the view.
    [self configureView];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences *))decisionHandler  API_AVAILABLE(ios(13.0)){
    if (_pattern == 5) {
        preferences.preferredContentMode = WKContentModeMobile;
    }
    decisionHandler(WKNavigationActionPolicyAllow, preferences);
}

@end
