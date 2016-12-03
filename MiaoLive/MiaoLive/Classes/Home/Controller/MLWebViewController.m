//
//  MLWebViewController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLWebViewController.h"

@interface MLWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUrl:(NSString *)url{
    _url = [url copy];
    NSURL *urls = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    [self.webView loadRequest:request];
}

@end
