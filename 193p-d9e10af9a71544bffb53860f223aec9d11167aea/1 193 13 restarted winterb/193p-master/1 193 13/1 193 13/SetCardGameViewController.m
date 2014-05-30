//
//  SetCardGameViewController.m
//  1 193 13
//
//  Created by Roger on 12/21/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "PlayingCardDeck.h"



@implementation SetCardGameViewController

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.type = @"Set Card Game";
}


@end
