//
//  GBFSParser.m
//  Pods
//
//  Created by Andrew Fischer on 6/28/16.
//
//

#import "GBFSParser.h"
/**
 
 GBFSParser is a tool for converting GBFS feeds to geoJSON. By passing a NSURL
 to the methods, a NSJSON-serializeable NSDictionary will be returned.
 
 */
@interface GBFSParser ()
@end

@implementation GBFSParser

///--------------------------
/// @name Convenience Methods
///--------------------------

/**
 Returns a NSDictionary containing the URLs and Names of feeds from a given
 auto discovery URL.
 
 @param URL the autodiscovery url for the bikeshare, usually ending in .gbfs
*/
+ (NSDictionary *) feedsFromAutoDiscovery:(NSURL *) URL {
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: URL];
    NSDictionary *autoDiscoveryJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableDictionary *feeds = [[NSMutableDictionary alloc] init];
    for (NSDictionary *feed in autoDiscoveryJSON[@"data"][@"en"][@"feeds"]){
        [feeds setValue:feed[@"url"] forKey:feed[@"name"]];
    }
    return feeds;
}

///-----------------------
/// @name Converting Feeds
///-----------------------

/**
 Returns a NSDictionary containing the geoJSON information from a given auto
 discovery URL.
 
 @param URL the autodiscovery url for the bikeshare, usually ending in .gbfs
 */
+ (NSDictionary *) geoJSONFromAutoDiscovery:(NSURL *) autoDiscoveryURL {
    NSDictionary *feeds = [self feedsFromAutoDiscovery:autoDiscoveryURL];
    NSURL *statusURL = [NSURL URLWithString:feeds[@"station_status"]];
    NSURL *infoURL   = [NSURL URLWithString:feeds[@"station_information"]];
    return [self geoJSONFromStatusURL:statusURL infoURL:infoURL];
}

/**
 Returns a NSDictionary containing the geoJSON information from two
 URLs.
 
 @param statusURL Path to the bikeshare's station_status.json
 @param infoURL Path to the bikeshare's station_information.json
 */
+ (NSDictionary *) geoJSONFromStatusURL:(NSURL *) statusURL infoURL:(NSURL *) infoURL {
    NSMutableDictionary *geoJSON  = @{@"type": @"FeatureCollection"};
    NSMutableDictionary *allStations = [[NSMutableDictionary alloc] init];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        NSError *statusError;
        NSData *statusData = [NSData dataWithContentsOfURL: statusURL];
        NSDictionary *stationStatus = [NSJSONSerialization JSONObjectWithData:statusData options:kNilOptions error:&statusError];

        for (NSDictionary *station in stationStatus[@"data"][@"stations"]) {
            NSMutableDictionary *stationStatusDict = [allStations objectForKey:station[@"station_id"]];
            NSMutableDictionary *thisStation = [station mutableCopy];
            [thisStation addEntriesFromDictionary:stationStatusDict];
            [allStations setObject:thisStation forKey:station[@"station_id"]];
        }
    });
    
    
    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        NSError *infoError;
        NSData *infoData   = [NSData dataWithContentsOfURL: infoURL];
        NSDictionary *stationInfo = [NSJSONSerialization JSONObjectWithData:infoData options:kNilOptions error:&infoError];
        
        for (NSDictionary *station in stationInfo[@"data"][@"stations"]) {
            NSMutableDictionary *stationInfoDict = [allStations objectForKey:station[@"station_id"]];
            NSMutableDictionary *thisStation = [station mutableCopy];
            [thisStation addEntriesFromDictionary:stationInfoDict];
            [allStations setObject:thisStation forKey:station[@"station_id"]];
        }
    });
    
    dispatch_group_notify(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        NSMutableArray *features = [[NSMutableArray alloc] init];
        for (NSDictionary *station in allStations){
            NSDictionary *properties = [[NSDictionary alloc] initWithDictionary:allStations[station]];
            NSDictionary *geometry   =  @{
                                          @"type": @"Point",
                                          @"coordinates": @[allStations[station][@"lat"],
                                                            allStations[station][@"lon"]
                                                            ]
                                          };
            [features addObject:@{
                                  @"type": @"Feature",
                                  @"properties": properties,
                                  @"geometry": geometry
                                  }];
        }
        [geoJSON setObject:features forKey:@"features"];
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return geoJSON;
}
@end
