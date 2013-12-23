//
//  SetCardGameViewController.m
//  1 193 13
//
//  Created by Roger on 11/29/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"


@interface SetCardGameViewController()


@end

@implementation SetCardGameViewController

- (Deck *) createDeck
{
    return [[SetCardDeck alloc]init];
}

- (void) updateUI
{
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons)
    {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
    }
    self.moveDescriptionLabel.text = self.game.resultDescription;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
