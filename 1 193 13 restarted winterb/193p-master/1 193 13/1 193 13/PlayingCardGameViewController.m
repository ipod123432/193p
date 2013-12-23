//
//  PlayingCardGameViewController.m
//  1 193 13
//
//  Created by Roger on 11/28/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"



@implementation PlayingCardGameViewController

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}



@end
