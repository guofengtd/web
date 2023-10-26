//
//  SettingsViewController.m
//  web
//
//  Created by 潘雪 on 2023/10/13.
//

#import "SettingsViewController.h"
#import "NSUserDefaults+web.h"

@interface SettingsViewController ()

@property (nonatomic, strong) UITextField *hostField;
@property (nonatomic, strong) UITextField *portField;

@end

@implementation SettingsViewController

- (void)loadView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *container = [UIView new];
    [view addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    
    UILabel *hostLabel = [UILabel new];
    hostLabel.textAlignment = NSTextAlignmentRight;
    hostLabel.text = @"Address";
    [container addSubview:hostLabel];
    [hostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@96);
        make.left.equalTo(container);
    }];
    
    UITextField *hostField = [UITextField new];
    hostField.borderStyle = UITextBorderStyleRoundedRect;
    hostField.placeholder = @"Please input the host address";
    hostField.keyboardType = UIKeyboardTypeURL;
    hostField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    hostField.text = [NSUserDefaults GetHost];
    
    [container addSubview:hostField];
    [hostField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(hostLabel);
        make.width.equalTo(@260);
        make.left.equalTo(hostLabel.mas_right).offset(8);
        make.centerY.equalTo(hostLabel);
        make.top.right.equalTo(container);
    }];
    self.hostField = hostField;
    
    UILabel *portLabel = [UILabel new];
    portLabel.textAlignment = NSTextAlignmentRight;
    portLabel.text = @"Port";
    [container addSubview:portLabel];
    [portLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(hostLabel);
        make.left.equalTo(container);
    }];
    
    UITextField *portField = [UITextField new];
    portField.borderStyle = UITextBorderStyleRoundedRect;
    portField.placeholder = @"Please input the port number";
    portField.keyboardType = UIKeyboardTypeNumberPad;
    hostField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    portField.text = [NSUserDefaults GetHostPort];
    
    [container addSubview:portField];
    [portField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(hostField);
        make.width.equalTo(hostField);
        make.top.equalTo(hostField.mas_bottom).offset(8);
        make.centerY.equalTo(portLabel);
        make.left.right.equalTo(hostField);
        make.bottom.right.equalTo(container);
    }];
    self.portField = portField;
    
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Settings";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                            action:@selector(touchCancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                             style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                            action:@selector(touchSave)];
}

- (void)touchCancel {
    [self.delegate canceledSettings:self];
}

- (void)touchSave {
    NSString *host = [self.hostField.text lowercaseString];
    NSString *port = [self.portField.text lowercaseString];
    
    NSString *urlString = host;
    if (![host containsString:@"http"]) {
        urlString = [@"http://" stringByAppendingString:host];
    }
    
    if (port.length) {
        urlString = [urlString stringByAppendingString:@":"];
        urlString = [urlString stringByAppendingString:port];
    }
    
    NSURLComponents *com = [NSURLComponents componentsWithString:urlString];
    if (com.scheme.length == 0 || com.host.length == 0) {
        return;
    }
    
    [NSUserDefaults SaveHost:host];
    [NSUserDefaults SaveHostPort:port];
    
    [self.delegate savedSettings:self string:urlString];
}

@end
