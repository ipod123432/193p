//
//  SetCard.h
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validColors;
+(NSArray *)validShapes;
+(NSArray *)validShadings;
+(NSArray *)rankStrings;
+(NSUInteger)maxRank;

@end
