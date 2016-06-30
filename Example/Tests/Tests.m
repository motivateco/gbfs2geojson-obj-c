//
//  gbfs2geojsonTests.m
//  gbfs2geojsonTests
//
//  Created by Andrew Fischer on 06/28/2016.
//  Copyright (c) 2016 Andrew Fischer. All rights reserved.
//

@import XCTest;
#import <gbfs2geojson/GBFSParser.h>
#import <VVJSONSchemaValidation/VVJSONSchema.h>

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
    NSDictionary *expected = @{
                               @"station_information": @"https://gbfs.citibikenyc.com/gbfs/en/station_information.json",
                               @"station_status"     : @"https://gbfs.citibikenyc.com/gbfs/en/station_status.json",
                               @"system_alerts"      : @"https://gbfs.citibikenyc.com/gbfs/en/system_alerts.json",
                               @"system_information" : @"https://gbfs.citibikenyc.com/gbfs/en/system_information.json",
                               @"system_regions"     : @"https://gbfs.citibikenyc.com/gbfs/en/system_regions.json"
                               };
    
    NSString *autoDiscoveryFile = [self.bundle pathForResource:@"gbfs" ofType:@"json"];
    NSURL *autoDiscoveryURL = [NSURL fileURLWithPath:autoDiscoveryFile];
    NSDictionary *result = [GBFSParser feedsFromAutoDiscovery:autoDiscoveryURL];
    XCTAssertEqualObjects(expected, result);
}


- (void)testConformsToSchema {
    NSString *filepath = [self.bundle pathForResource:@"geoJSONSchema"
                                          ofType:@"json"];
    NSLog(@"filepath %@", filepath);
    NSURL *schema = [NSURL fileURLWithPath:filepath];
    NSData *schemaData = [NSData dataWithContentsOfURL:schema];
    NSError *seralizationError = nil;
    VVJSONSchema *jsonSchema = [VVJSONSchema schemaWithData:schemaData baseURI:nil referenceStorage:nil error:&seralizationError];
    NSError *validationError = nil;
    NSDictionary *toValidateJson = [GBFSParser geoJSONFromAutoDiscovery:self.CitiBikeAutoDiscovery];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:toValidateJson
                                                       options:0
                                                         error:&seralizationError];

    XCTAssertTrue([NSJSONSerialization isValidJSONObject:toValidateJson]);
    XCTAssertTrue([jsonSchema validateObject:jsonData withError:&validationError]);
}

- (void)testProducesCorrectOutput{
    NSString *infoPath = [self.bundle pathForResource:@"station_information" ofType:@"json"];
    NSString *statPath = [self.bundle pathForResource:@"station_status" ofType:@"json"];
    NSLog(@"PATHZ : : : : : %@ %@", infoPath, statPath);
    NSDictionary *geoJson = [GBFSParser geoJSONFromStatusURL:[NSURL fileURLWithPath:statPath]
                                                     infoURL:[NSURL fileURLWithPath:infoPath]];
    
    NSString *fileName = @"myJsonDict.dat"; // probably somewhere in 'Documents'
    NSOutputStream *os = [[NSOutputStream alloc] initToFileAtPath:fileName append:NO];
    
    [os open];
    [NSJSONSerialization writeJSONObject:geoJson toStream:os options:0 error:nil];
    [os close];

}

- (void)testExample
{

    XCTAssertNoThrow([GBFSParser feedsFromAutoDiscovery:self.CitiBikeAutoDiscovery]);
    XCTAssertNoThrow([GBFSParser geoJSONFromAutoDiscovery:self.CitiBikeAutoDiscovery]);
}

- (void)tearDown
{
    [super tearDown];
}


@end

