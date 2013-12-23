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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.type = @"Playing Card Game";
}

/*
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 [self touchCardButton:self.cardButton];
 [self touchCardButton:self.cardButton];
 self.flipCount = 0;
 
 
 // careful technically already 2 flips, 1 card went thru
 }
 */


@end
