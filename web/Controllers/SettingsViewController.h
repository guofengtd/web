//
//  SettingsViewController.h
//  web
//
//  Created by 潘雪 on 2023/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>

- (void)canceledSettings:(SettingsViewController *)settings;
- (void)savedSettings:(SettingsViewController *)settings string:(NSString *)string;

@end

@interface SettingsViewController : UIViewController

@property (nonatomic, weak) id < SettingsViewControllerDelegate > delegate;

@end

NS_ASSUME_NONNULL_END
