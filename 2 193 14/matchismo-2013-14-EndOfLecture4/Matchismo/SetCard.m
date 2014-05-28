//
//  SetCard.m
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(BOOL)compareThree:(NSArray *)threesome usingSelector:(SEL)cSelector
{
    BOOL place = false;
    // all equal
    if ([threesome[0] performSelector:cSelector withObject:threesome[1]] && [threesome[0] performSelector:cSelector withObject:threesome[2]]) {
        place = true;
    }
    // tests if any combo same. two same one diff
    else if (([threesome[0] performSelector:cSelector withObject:threesome[1]] || [threesome[0] performSelector:cSelector withObject:threesome[2]]) || [threesome[1] performSelector:cSelector withObject:threesome[2]])
    {
        place = false;
    }
    // all diff
    else {
        place = true;
    }
    return place;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 2) {
        id card = otherCards[0];
        id cardTwo = otherCards[1];
        if ([cardTwo isKindOfClass:[SetCard class]] &&
            [card isKindOfClass:[SetCard class]])
        {
            SetCard *setOne = (SetCard *)card;
            SetCard *setTwo = (SetCard *)cardTwo;
            
            // XOR is ^ ?
            
            NSArray *ranks = @[self.rank, setOne.rank, setTwo.rank];
            NSArray *colors = @[self.color, setOne.color, setTwo.color];
            NSArray *shadings = @[self.shading, setOne.shading, setTwo.shading];
            NSArray *shapes = @[self.shape, setOne.shape, setTwo.shape];
            if (([self compareThree:ranks usingSelector:@selector(isEqualToNumber:)] &&
                 [self compareThree:colors usingSelector:@selector(isEqualToString:)]) &&
                ([self compareThree:shadings usingSelector:@selector(isEqualToString:)] &&
                 [self compareThree:shapes usingSelector:@selector(isEqualToString:)]))
            {
                score = 2;
            }
        }
    }
    
    return score;
}


@synthesize color = _color;
@synthesize shape = _shape;
@synthesize shading = _shading;
@synthesize rank = _rank;

-(void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color])
    {
        _color = color;
    }
}
-(NSString *)color
{
    return _color ? _color : @"?";
}
-(void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}
-(NSString *)shape
{
    return _shape ? _shape : @"?";
}
-(void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading])
    {
        _shading = shading;
    }
}
-(NSString *)shading
{
    return _shading ? _shading : @"?";
}
-(void)setRank:(NSNumber *)rank
{
    if ([[SetCard rankStrings] containsObject:[NSString stringWithFormat:@"%@",rank]])
    {
        _rank = rank;
    }
}
-(NSNumber *)rank
{
    return _rank ? _rank : @-404;
}

+(NSArray *)validColors
{
    return @[@"red",@"green",@"blue"];
}
//▲ ● ■
+(NSArray *)validShapes
{
    return @[@"triangle",@"circle",@"square"];
}
+(NSArray *)validShadings
{
    return @[@"solid",@"striped",@"empty"];
}
+(NSArray *)rankStrings
{
    return @[@"1",@"2",@"3"];
}
+(NSUInteger)maxRank
{
    return [[self rankStrings]count];
}

@end
