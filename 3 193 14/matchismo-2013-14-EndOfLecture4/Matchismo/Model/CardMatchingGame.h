//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Roger Zou on 05.26.14.
//  Copyright (c) 2013 m2m server software gmbh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger mode;
@property (nonatomic) NSInteger lastScore;
@property (nonatomic, strong) NSArray *lastCards;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic) NSTimeInterval interval;
@property (nonatomic, strong) NSString *gameType;

@end
