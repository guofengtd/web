//
//  NSUserDefaults.h
//  web
//
//  Created by 潘雪 on 2023/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (web)

+ (NSString *)GetHost;
+ (void)SaveHost:(NSString *)host;

+ (NSString *)GetHostPort;
+ (void)SaveHostPort:(NSString *)port;

+ (NSString *)GetWebURL;

@end

NS_ASSUME_NONNULL_END
