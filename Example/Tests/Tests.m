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
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    self.CitiBikeAutoDiscovery = [NSURL URLWithString:@"https://gbfs.citibikenyc.com/gbfs/gbfs.json"];
}

- (void)testConformsToSchema {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];

    NSString *filepath = [bundle pathForResource:@"geoJSONSchema"
                                          ofType:@"json"];
    NSLog(@"filepath %@", filepath);
//    NSURL *schema = [NSURL fileURLWithPath:filepath];
//    NSData *schemaData = [NSData dataWithContentsOfURL:schema];
//    NSError *seralizationError = nil;
//    VVJSONSchema *jsonSchema = [VVJSONSchema schemaWithData:schemaData baseURI:nil referenceStorage:nil error:&error];
//    NSError *validationError = nil;
    NSDictionary *toValidateJson = [GBFSParser featureListFromAutoDiscovery:self.CitiBikeAutoDiscovery];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:toValidateJson
//                                                       options:0
//                                                         error:&seralizationError];

    XCTAssertTrue([NSJSONSerialization isValidJSONObject:toValidateJson]);
//    XCTAssertTrue([jsonSchema validateObject:jsonData withError:&validationError]);
}

- (void)testProducesCorrectOutput{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *infoPath = [bundle pathForResource:@"station_information" ofType:@"json"];
    NSString *statPath = [bundle pathForResource:@"station_status" ofType:@"json"];
    NSLog(@"PATHZ : : : : : %@ %@", infoPath, statPath);
    NSDictionary *geoJson = [GBFSParser featureListFromStatusURL:[NSURL fileURLWithPath:statPath]
                                                         infoURL:[NSURL fileURLWithPath:infoPath]];
    NSLog(@"%@", geoJson);
}

- (void)testExample
{

    XCTAssertNoThrow([GBFSParser feedsFromAutoDiscovery:self.CitiBikeAutoDiscovery]);
    XCTAssertNoThrow([GBFSParser featureListFromAutoDiscovery:self.CitiBikeAutoDiscovery]);
}

- (void)tearDown
{
    [super tearDown];
}


@end

