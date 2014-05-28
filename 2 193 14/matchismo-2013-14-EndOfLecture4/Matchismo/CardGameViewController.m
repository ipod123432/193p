//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Roger Zou on 05.26.14.
//  Copyright (c) 2013 m2m server software gmbh. All rights reserved.
//

#import "CardGameViewController.h"


@interface CardGameViewController ()


@end

@implementation CardGameViewController



- (NSString *)titleForCard:(Card *)card
{
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


-(void)updateUI
{
    [super updateUI];
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
}




@end
