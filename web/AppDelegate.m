//
//  AppDelegate.m
//  web
//
//  Created by 潘雪 on 2023/10/12.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor blackColor];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
    [window makeKeyAndVisible];
    
    self.window = window;
    
    return YES;
}


@end
