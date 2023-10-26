//
//  NSUserDefaults.m
//  web
//
//  Created by 潘雪 on 2023/10/13.
//

#import "NSUserDefaults+web.h"

@implementation NSUserDefaults (web)

+ (NSUserDefaults *)sharedUserDefaults {
    static NSUserDefaults *defaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[NSUserDefaults alloc] initWithSuiteName:@"defaults11"];
    });
    
    return defaults;
}

#define DEFAULTS_HOST    @"host.address"

+ (NSString *)GetHost {
    NSString *host = [[NSUserDefaults sharedUserDefaults] objectForKey:DEFAULTS_HOST];
    return host? : @"http://";
}

+ (void)SaveHost:(NSString *)host {
    [[NSUserDefaults sharedUserDefaults] setObject:host?:@"" forKey:DEFAULTS_HOST];
}

#define DEFAULTS_HOST_PORT  @"host.port"

+ (NSString *)GetHostPort {
    NSString *port = [[NSUserDefaults sharedUserDefaults] objectForKey:DEFAULTS_HOST_PORT];
    return port? : @"8001";
}

+ (void)SaveHostPort:(NSString *)port {
    [[NSUserDefaults sharedUserDefaults] setObject:port? : @"" forKey:DEFAULTS_HOST_PORT];
}

+ (NSString *)GetWebURL
{
    NSString *host = [[self GetHost] lowercaseString];
    NSString *port = [[self GetHostPort] lowercaseString];
    
    if (host.length > 0) {
        NSString *urlString = host;
        if (![host containsString:@"http"]) {
            urlString = [@"http://" stringByAppendingString:host];
        }
        
        if (port.length > 0) {
            urlString = [urlString stringByAppendingString:@":"];
            urlString = [urlString stringByAppendingString:port];
        }
        
        NSURLComponents *com = [NSURLComponents componentsWithString:urlString];
        if (com.scheme.length == 0 || com.host.length == 0)
        {
            return nil;
        }
        
        return urlString;
    }
    
    return nil;
}

@end
