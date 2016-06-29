//
//  VVJSONSchemaEnumValidator.h
//  VVJSONSchemaValidation
//
//  Created by Vlas Voloshin on 31/12/2014.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVJSONSchemaValidator.h"

/**
 Implements "enum" keyword. Applicable to all instance types.
 */
@interface VVJSONSchemaEnumValidator : NSObject <VVJSONSchemaValidator>

/** Array of valid instance values for the receiver. */
@property (nonatomic, readonly, strong) NSArray *valueOptions;

@end
