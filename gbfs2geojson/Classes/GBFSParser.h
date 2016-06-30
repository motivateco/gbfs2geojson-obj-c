//
//  GBFSParser.h
//  Pods
//
//  Created by Andrew Fischer on 6/28/16.
//
//

#import <Foundation/Foundation.h>

@interface GBFSParser : NSObject
+ (NSDictionary *) feedsFromAutoDiscovery:(NSURL *) URL;
+ (NSDictionary *) geoJSONFromAutoDiscovery:(NSURL *) autoDiscoveryURL;
+ (NSDictionary *) geoJSONFromStatusURL:(NSURL *) statusURL infoURL:(NSURL *) infoURL;
@end
