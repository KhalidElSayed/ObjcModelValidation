//
//  NSString+Validations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "NSString+Validations.h"
#import "NSObject+Validations.h"

@implementation NSString (Validations)

-(BOOL)exclusion:(NSArray *)exclusionArray{
    BOOL valid = YES;
    
    for (NSString *string in exclusionArray) {
        if ([string isKindOfClass:[NSString class]]) {
            if ([self containsString:string]) {
                valid = NO;
                return valid;
            }
        }
    }
    
    // this happens if no invalid string where found
    // or array is empty
    return valid;
}

-(BOOL)format:(NSString *)regexExpression{
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexExpression];
    return [test evaluateWithObject:self];
}

-(BOOL)inclusion:(NSArray *)inclusionArray{
    BOOL valid = NO;
    
    for (NSString *string in inclusionArray) {
        if ([string isKindOfClass:[NSString class]]) {
            if ([self containsString:string]) {
                valid = YES;
                return valid;
            }
        }
    }
    
    // this happens if no invalid string where found
    // or array is empty
    return valid;
}

-(BOOL)containsString:(NSString *)string{
    return !([self rangeOfString:string].location == NSNotFound);
}

-(BOOL)lengthMin:(NSInteger)length{
    return self.length > length;
}

-(BOOL)lengthMax:(NSInteger)length{
    return self.length < length;
}

-(BOOL)lengthIn:(NSInteger)lengthMin and:(NSInteger)lengthMax{
    return (self.length > lengthMin && self.length < lengthMax);
}

-(BOOL)lengthIs:(NSInteger)length{
    return self.length == length;
}

-(BOOL)presence{
    return ![self lengthIs:0];
}

-(BOOL)absence{
    return [self lengthIs:0];
}

@end
