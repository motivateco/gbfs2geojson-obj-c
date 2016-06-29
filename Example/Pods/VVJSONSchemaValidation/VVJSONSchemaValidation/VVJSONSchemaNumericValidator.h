//
//  VVJSONSchemaNumericValidator.h
//  VVJSONSchemaValidation
//
//  Created by Vlas Voloshin on 30/12/2014.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVJSONSchemaValidator.h"

/**
 Implements "multipleOf", "maximum", "exclusiveMaximum", "minimum" and "exclusiveMinimum" keywords. Applicable to integer and number instances.
 */
@interface VVJSONSchemaNumericValidator : NSObject <VVJSONSchemaValidator>

/** A number that validated number must be a multiple of. If nil, multiplier is not validated. */
@property (nonatomic, readonly, strong) NSDecimalNumber *multipleOf;

/** Maximum value of the validated number. If nil, maximum is not validated. */
@property (nonatomic, readonly, strong) NSNumber *maximum;
/** If YES, validated number must be strictly less than `maximum`, otherwise - less than or equal. */
@property (nonatomic, readonly, assign) BOOL exclusiveMaximum;

/** Minimum value of the validated number. If nil, minimum is not validated. */
@property (nonatomic, readonly, strong) NSNumber *minimum;
/** If YES, validated number must be strictly greater than `minimum`, otherwise - greater than or equal. */
@property (nonatomic, readonly, assign) BOOL exclusiveMinimum;

@end
