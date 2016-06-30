//
//  GBFSParser.m
//  Pods
//
//  Created by Andrew Fischer on 6/28/16.
//
//

#import "GBFSParser.h"

@interface GBFSParser ()
@end

@implementation GBFSParser

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

+ (NSDictionary *) geoJSONFromAutoDiscovery:(NSURL *) autoDiscoveryURL {
    NSDictionary *feeds = [self feedsFromAutoDiscovery:autoDiscoveryURL];
    NSURL *statusURL = [NSURL URLWithString:feeds[@"station_status"]];
    NSURL *infoURL   = [NSURL URLWithString:feeds[@"station_information"]];
    return [self geoJSONFromStatusURL:statusURL infoURL:infoURL];
}

+ (NSDictionary *) geoJSONFromStatusURL:(NSURL *) statusURL infoURL:(NSURL *) infoURL {
    NSMutableDictionary *geoJSON  = [[NSMutableDictionary alloc] initWithDictionary:@{@"type": @"FeatureCollection"}];
    NSMutableDictionary *allStations = [[NSMutableDictionary alloc] init];
    
    NSError *statusError;
    NSData *statusData = [NSData dataWithContentsOfURL: statusURL];
    NSDictionary *stationStatus = [NSJSONSerialization JSONObjectWithData:statusData options:kNilOptions error:&statusError];

    for (NSDictionary *station in stationStatus[@"data"][@"stations"]) {
        NSMutableDictionary *stationStatusDict = [allStations objectForKey:station[@"station_id"]];
        NSMutableDictionary *thisStation = [station mutableCopy];
        [thisStation addEntriesFromDictionary:stationStatusDict];
        [allStations setObject:thisStation forKey:station[@"station_id"]];
    }

    NSError *infoError;
    NSData *infoData   = [NSData dataWithContentsOfURL: infoURL];
    NSDictionary *stationInfo = [NSJSONSerialization JSONObjectWithData:infoData options:kNilOptions error:&infoError];
    
    for (NSDictionary *station in stationInfo[@"data"][@"stations"]) {
        NSMutableDictionary *stationInfoDict = [allStations objectForKey:station[@"station_id"]];
        NSMutableDictionary *thisStation = [station mutableCopy];
        [thisStation addEntriesFromDictionary:stationInfoDict];
        [allStations setObject:thisStation forKey:station[@"station_id"]];
    }


    NSMutableArray *features = [[NSMutableArray alloc] init];
    for (NSDictionary *station in allStations){
        NSDictionary *properties = [[NSDictionary alloc] initWithDictionary:allStations[station]];
        NSDictionary *geometry   = [[NSDictionary alloc] initWithDictionary:
                                    @{
                                      @"type": @"Point",
                                      @"coordinates": @[allStations[station][@"lat"],
                                                        allStations[station][@"lon"]
                                                        ]
                                      }];
        [features addObject:@{
                              @"type": @"Feature",
                              @"properties": properties,
                              @"geometry": geometry
                              }];
    }
    [geoJSON setObject:features forKey:@"features"];
    return geoJSON;
    
}
@end
