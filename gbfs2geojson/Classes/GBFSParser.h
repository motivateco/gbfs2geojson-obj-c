//
//  GBFSParser.h
//  Pods
//
//  Created by Andrew Fischer on 6/28/16.
//
//

#import <Foundation/Foundation.h>

@interface GBFSParser : NSObject
+ (NSDictionary *) feedsFromAutoDiscovery:(NSURL *) URL onCompletion:(void (^)())completionBlock;
+ (NSDictionary *) geoJSONFromAutoDiscovery:(NSURL *) autoDiscoveryURL onCompletion:(void (^)())completionBlock;
+ (NSDictionary *) geoJSONFromStatusURL:(NSURL *) statusURL infoURL:(NSURL *) infoURL onCompletion:(void (^)())completionBlock;
@end
