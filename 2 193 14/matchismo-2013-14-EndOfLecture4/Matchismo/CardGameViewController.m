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
    
    
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastCards count])
        {
            NSMutableArray *cardContents =  [NSMutableArray array];
            for (Card *card in self.game.lastCards)
            {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            description = [NSString stringWithFormat:@"%@ don't match. %d point penalty.", description, -self.game.lastScore];
        }
        self.resultLabel.text = description;
        [self.pastMoves addObject: description];
        self.historySlider.maximumValue = [self.pastMoves count]-1;
        self.historySlider.value = self.historySlider.maximumValue;
        self.resultLabel.alpha = 1;
    }
}




@end
