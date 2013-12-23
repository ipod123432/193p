//
//  SetCard.h
//  1 193 13
//
//  Created by Roger on 12/21/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+(NSArray *)validSymbols;
+(NSArray *)validShadings;
+(NSArray *)validColors;
+(NSArray *)validNumbers;
+(NSUInteger)maxNumber;


@end
