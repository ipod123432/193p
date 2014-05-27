//
//  PlayingCard.m
//  LampShade
//
//  Created by Roger on 5/26/14.
//  Copyright (c) 2014 handWave. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

@synthesize suit = _suit; // cuz provided setter and getter

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits]containsObject:suit]) {
        _suit=suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings]count]-1;
}

-(void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank=rank;
    }
}
@end
