//
//  CardMatchingGame.m
//  1 193 13
//
//  Created by Roger on 11/27/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of cards

@end

@implementation CardMatchingGame

- (NSString *)resultDescription
{
    if (!_resultDescription) _resultDescription = @"";
    return _resultDescription;
}

- (int)mode
{
    if (!_mode) _mode = 2; //defaults to 2 card game
    return _mode;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSArray *otherCards = @[];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match w/ chosen cards
            for (Card *otherCard in self.cards)
            {
                // you have no idea how much grief that one ! gave me. broke the whole game
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    otherCards = [otherCards arrayByAddingObject:otherCard];
                }
            }
            if ([otherCards count] == self.mode - 1)
            {
                int matchScore = [card match:otherCards];
                NSString *buffer = @"";
                if (matchScore)
                {
                   
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *cards in otherCards)
                    {
                        cards.matched = YES;
                        buffer = [buffer stringByAppendingString: [NSString stringWithFormat: @"%@, ", cards.contents]];
                    }
                    card.matched = YES;
                    buffer = [buffer stringByAppendingString: [NSString stringWithFormat: @"and %@ match for %d points", card.contents, matchScore * MATCH_BONUS]];
                    
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *cards in otherCards)
                    {
                        cards.chosen = NO;
                        buffer = [buffer stringByAppendingString: [NSString stringWithFormat: @"%@, ", cards.contents]];
                    }
                    card.chosen = NO;
                    buffer = [buffer stringByAppendingString: [NSString stringWithFormat: @"and %@ don't match. %d point penalty", card.contents, MISMATCH_PENALTY]];
                }
                self.resultDescription = buffer;
            } else {
                self.resultDescription = [NSString stringWithFormat: @"Flipped up %@", card.contents];
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
}


@end
