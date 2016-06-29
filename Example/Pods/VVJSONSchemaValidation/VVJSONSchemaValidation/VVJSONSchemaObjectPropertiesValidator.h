//
//  VVJSONSchemaObjectPropertiesValidator.h
//  VVJSONSchemaValidation
//
//  Created by Vlas Voloshin on 1/01/2015.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVJSONSchemaValidator.h"

@class VVJSONSchema;

/**
 Implements "properties", "additionalProperties" and "patternProperties" keywords. Applicable to object instances.
 */
@interface VVJSONSchemaObjectPropertiesValidator : NSObject <VVJSONSchemaValidator>

/**
 Dictionary of schemas each corresponding property of a valid object instance must validate against. Keys are property names, values are schemas.
 */
@property (nonatomic, readonly, copy) NSDictionary *propertySchemas;

/** Schema to validate any object properties with keys beyond those contained in `propertySchemas`, if it is not nil. */
@property (nonatomic, readonly, strong) VVJSONSchema *additionalPropertiesSchema;
/**
 If NO, a valid object instance must contain no other keys other than those contained in `propertySchemas`. If the latter is nil, this property is not applicable.
 If YES, all properties in a valid object instance with names other than keys contained in `propertySchemas` must validate against `additionalPropertiesSchema`, unless the latter is nil.
 */
@property (nonatomic, readonly, assign) BOOL additionalPropertiesAllowed;

/**
 Dictionary of schemas each corresponding property of a valid object instance must validate against. Keys are regular expressions to match against property names, values are schemas.
 */
@property (nonatomic, readonly, copy) NSDictionary *patternBasedPropertySchemas;

@end
