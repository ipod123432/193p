//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

-(instancetype) init
{
    self = [super init];
    if (self) {
        for (NSString *shape in [SetCard validShapes]) {
            for (NSString *shading in [SetCard validShadings]) {
                for (NSString *color in [SetCard validColors]) {
                    for (int rank = [SetCard maxRank]; rank > 0; rank--) {
                        SetCard *card = [[SetCard alloc]init];
                        card.rank = rank;
                        card.shape = shape;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}


@end
