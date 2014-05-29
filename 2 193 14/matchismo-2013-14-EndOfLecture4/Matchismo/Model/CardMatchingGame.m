//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Roger Zou on 05.26.14.
//  Copyright (c) 2013 m2m server software gmbh. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSUInteger)mode
{
    //default card mode is 2
    if (!_mode) _mode=2;
    return _mode;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
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

//#define MISMATCH_PENALTY 2
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)matchAll:(NSArray *)cards
{
    // maybe change to id later for ... that thing
    for (Card *card in cards)
    {
        card.matched = YES;
    }
}
- (void)unchooseAll:(NSArray *)cards
{
    for (Card *card in cards)
    {
        card.chosen = NO;
    }
}
- (void)chooseCardAtIndex:(NSUInteger)index
{
    NSLog(@"cardChoose failing");
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against another card
            NSMutableArray *daCards = [NSMutableArray new];
            self.lastScore = 0;
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [daCards addObject:otherCard];
                    if ([daCards count] == (self.mode-1))
                    {
                        break;
                    }
                }
            }
            self.lastCards = [daCards arrayByAddingObject:card];
            if ([daCards count] == (self.mode-1))
            {
                int matchScore = [card match:daCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    self.lastScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    [self matchAll:daCards];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    self.lastScore = -MISMATCH_PENALTY;
                    [self unchooseAll:daCards];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    NSLog(@"cardChoose worked");
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
