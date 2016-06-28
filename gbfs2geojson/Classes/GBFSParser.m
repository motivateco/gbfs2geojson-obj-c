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

+ (NSDictionary *) featureListFromAutoDiscovery:(NSURL *) autoDiscoveryURL {
    NSDictionary *feeds = [self feedsFromAutoDiscovery:autoDiscoveryURL];
    NSURL *statusURL = [NSURL URLWithString:feeds[@"station_status"]];
    NSURL *infoURL   = [NSURL URLWithString:feeds[@"station_information"]];
    return [self featureListFromStatusURL:statusURL infoURL:infoURL];
}

+ (NSDictionary *) featureListFromStatusURL:(NSURL *) statusURL infoURL:(NSURL *) infoURL {
    NSMutableDictionary *features = [[NSMutableDictionary alloc] init];
    NSError *statusError;
    NSError *infoError;
    
    NSData *statusData = [NSData dataWithContentsOfURL: statusURL];
    NSData *infoData   = [NSData dataWithContentsOfURL: infoURL];
    
    NSDictionary *stationStatus = [NSJSONSerialization JSONObjectWithData:statusData options:kNilOptions error:&statusError];
    NSDictionary *stationInfo = [NSJSONSerialization JSONObjectWithData:infoData options:kNilOptions error:&infoError];
    
    
    for (NSDictionary *station in stationStatus[@"data"][@"stations"]) {
        NSMutableDictionary *stationStatusDict = [features objectForKey:station[@"station_id"]];
        NSMutableDictionary *thisStation = [station mutableCopy];
        [thisStation addEntriesFromDictionary:stationStatusDict];
        [features setObject:thisStation forKey:station[@"station_id"]];
    }
    
    for (NSDictionary *station in stationInfo[@"data"][@"stations"]) {
        NSMutableDictionary *stationInfoDict = [features objectForKey:station[@"station_id"]];
        NSMutableDictionary *thisStation = [station mutableCopy];
        [thisStation addEntriesFromDictionary:stationInfoDict];
        [features setObject:thisStation forKey:station[@"station_id"]];
    }
    
    
    return @{@"HI":@"HI"};
    
}
@end
