//
//  Card.m
//  1 193 13
//
//  Created by Roger on 11/27/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}


@end
