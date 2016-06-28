//
//  gbfs2geojsonTests.m
//  gbfs2geojsonTests
//
//  Created by Andrew Fischer on 06/28/2016.
//  Copyright (c) 2016 Andrew Fischer. All rights reserved.
//

@import XCTest;
#import <gbfs2geojson/GBFSParser.h>

@interface Tests : XCTestCase
@property (strong, nonatomic) NSURL *CitiBikeAutoDiscovery;
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    self.CitiBikeAutoDiscovery = [NSURL URLWithString:@"https://gbfs.citibikenyc.com/gbfs/gbfs.json"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{

    XCTAssertNoThrow([GBFSParser feedsFromAutoDiscovery:self.CitiBikeAutoDiscovery]);
    XCTAssertNoThrow([GBFSParser featureListFromAutoDiscovery:self.CitiBikeAutoDiscovery]);
}

@end

