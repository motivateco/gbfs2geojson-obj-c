//
//  VVJSONSchemaObjectValidator.h
//  VVJSONSchemaValidation
//
//  Created by Vlas Voloshin on 1/01/2015.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVJSONSchemaValidator.h"

/**
 Implements "maxProperties", "minProperties" and "required" keywords. Applicable to object instances.
 */
@interface VVJSONSchemaObjectValidator : NSObject <VVJSONSchemaValidator>

/** Maximum number of properties a valid object instance must have. Unapplicable value is NSUIntegerMax. */
@property (nonatomic, readonly, assign) NSUInteger maximumProperties;
/** Minimum number of properties a valid object instance must have. Unapplicable value is 0. */
@property (nonatomic, readonly, assign) NSUInteger minimumProperties;
/** A set of keys a valid object instance must contain. If nil, no keys are required. */
@property (nonatomic, readonly, copy) NSSet *requiredProperties;

@end
