//
//  SetCard.h
//  1 193 13
//
//  Created by Roger on 11/29/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger number;

+(NSArray *)validSymbols;
+(NSArray *)validColors;
+(NSArray *)validShadings;
+(NSArray *)validNumbers;
+(NSUInteger)maxNumber;


@end
