//
//  gbfs2geojsonTests.m
//  gbfs2geojsonTests
//
//  Created by Andrew Fischer on 06/28/2016.
//  Copyright (c) 2016 Andrew Fischer. All rights reserved.
//

@import XCTest;
#import "BlockMacros.h"
#import <gbfs2geojson/GBFSParser.h>

@interface Tests : XCTestCase
@property (strong, nonatomic) NSURL *CitiBikeAutoDiscovery;
@property (strong, nonatomic) NSBundle *bundle;
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    self.CitiBikeAutoDiscovery = [NSURL URLWithString:@"https://gbfs.citibikenyc.com/gbfs/gbfs.json"];
    self.bundle = [NSBundle bundleForClass:[self class]];

}

- (void)testValidDictFromAutoDiscovery {
    StartBlock();
    NSDictionary *expected = @{
                               @"station_information": @"https://gbfs.citibikenyc.com/gbfs/en/station_information.json",
                               @"station_status"     : @"https://gbfs.citibikenyc.com/gbfs/en/station_status.json",
                               @"system_alerts"      : @"https://gbfs.citibikenyc.com/gbfs/en/system_alerts.json",
                               @"system_information" : @"https://gbfs.citibikenyc.com/gbfs/en/system_information.json",
                               @"system_regions"     : @"https://gbfs.citibikenyc.com/gbfs/en/system_regions.json"
                               };
    
    NSString *autoDiscoveryFile = [self.bundle pathForResource:@"gbfs" ofType:@"json"];
    NSURL *autoDiscoveryURL = [NSURL fileURLWithPath:autoDiscoveryFile];
    
    NSDictionary *result = [GBFSParser feedsFromAutoDiscovery:autoDiscoveryURL onCompletion:^{
        EndBlock();
    }];
    WaitUntilBlockCompletes();
    XCTAssertEqualObjects(expected, result);

}


- (void)testIsValidJSON {
    StartBlock();
    NSString *autoDiscoveryFile = [self.bundle pathForResource:@"gbfs" ofType:@"json"];
    NSURL *autoDiscoveryURL = [NSURL fileURLWithPath:autoDiscoveryFile];
    

    NSDictionary *toValidateJson = [GBFSParser geoJSONFromAutoDiscovery:autoDiscoveryURL onCompletion:^{
        EndBlock();
    }];
    WaitUntilBlockCompletes();
    XCTAssertTrue([NSJSONSerialization isValidJSONObject:toValidateJson]);

}

- (void)tearDown
{
    [super tearDown];
}


@end

