//
//  MainViewController.m
//  web
//
//  Created by 潘雪 on 2023/10/12.
//

#import "MainViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import "SettingsViewController.h"
#import "NSUserDefaults+web.h"
#import "DomainViewController.h"

@interface MainViewController () < SettingsViewControllerDelegate >

@property (nonatomic, strong)   WKWebView *webView;
@property WebViewJavascriptBridge* bridge;

@end

@implementation MainViewController

- (void)loadView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *webView = [WKWebView new];
    [view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    [self.bridge registerHandler:@"connect"
                         handler:^(id data, WVJBResponseCallback responseCallback) {
        [self showDomainWithData:data];
        responseCallback(@{@"status": @"OK"});
    }];
    
    self.webView = webView;
    
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Remote desktop";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(touchSettings)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(touchSettings)];
    
    NSString *string = [NSUserDefaults GetWebURL];
    if (string.length)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showSettingsAnimated:TRUE];
        });
    }
}

- (void)showSettingsAnimated:(BOOL)animated {
    SettingsViewController *settings = [SettingsViewController new];
    settings.delegate = self;
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:settings]
                       animated:animated
                     completion:nil];
}

- (void)touchSettings {
    [self showSettingsAnimated:TRUE];
}

- (void)showDomainWithData:(NSDictionary *)data {
    DomainViewController *domain = [[DomainViewController alloc] initWithName:data[@"name"] urlString:data[@"url"]];
    domain.modalPresentationStyle = UIModalPresentationFullScreen;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:domain];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}

#pragma mark - SettingsViewControllerDelegate

- (void)canceledSettings:(SettingsViewController *)settings {
    [settings dismissViewControllerAnimated:YES
                                 completion:nil];
}

- (void)savedSettings:(SettingsViewController *)settings string:(NSString *)string {
    if (string) {
        NSURL *url = [NSURL URLWithString:string];
        
        [settings dismissViewControllerAnimated:YES
                                     completion:^{
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        }];
    }
}

@end
