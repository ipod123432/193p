//
//  SetCardDeck.m
//  1 193 13
//
//  Created by Roger on 11/30/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init
{
    self = [super init];
    if (self) {
        for (NSNumber *number in [SetCard validNumbers])
        {
            for (NSString *shading in [SetCard validShadings])
            {
                for (NSString *symbol in [SetCard validSymbols])
                {
                    for (NSString *color in [SetCard validColors])
                    {
                        SetCard *card = [[SetCard alloc]init];
                        card.number = [number integerValue];
                        card.shading = shading;
                        card.symbol = symbol;
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
