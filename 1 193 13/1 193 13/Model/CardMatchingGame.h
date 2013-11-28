//
//  CardMatchingGame.h
//  1 193 13
//
//  Created by Roger on 11/27/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated init
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;


@end
