//
//  VVJSONSchemaArrayValidator.h
//  VVJSONSchemaValidation
//
//  Created by Vlas Voloshin on 1/01/2015.
//  Copyright (c) 2015 Vlas Voloshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVJSONSchemaValidator.h"

/**
 Implements "maxItems", "minItems" and "uniqueItems" keywords. Applicable to array instances.
 */
@interface VVJSONSchemaArrayValidator : NSObject <VVJSONSchemaValidator>

/** Maximum number of items a valid array instance must have. Unapplicable value is NSUIntegerMax. */
@property (nonatomic, readonly, assign) NSUInteger maximumItems;
/** Minimum number of items a valid array instance must have. Unapplicable value is 0. */
@property (nonatomic, readonly, assign) NSUInteger minimumItems;
/** If YES, a valid array instance must contain no equal items. */
@property (nonatomic, readonly, assign) BOOL uniqueItems;

@end
