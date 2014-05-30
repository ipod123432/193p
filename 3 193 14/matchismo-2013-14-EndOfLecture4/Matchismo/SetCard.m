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
            
            NSArray *ranks = @[[NSNumber numberWithInteger:self.rank], [NSNumber numberWithInteger:setOne.rank], [NSNumber numberWithInteger:setTwo.rank]];
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


/* "solutions" matching method, doesn't account for if a b b combo
 http://cs193p.m2m.at/cs193p-assignment-3-task-2-fall-2013-14/#more-2436
 
 - (int)match:(NSArray *)otherCards
 {
 int score = 0;
 if ([otherCards count] == self.numberOfMatchingCards - 1) {
 NSMutableArray *colors = [[NSMutableArray alloc] init];
 NSMutableArray *symbols = [[NSMutableArray alloc] init];
 NSMutableArray *shadings = [[NSMutableArray alloc] init];
 NSMutableArray *numbers = [[NSMutableArray alloc] init];
 [colors addObject:self.color];
 [symbols addObject:self.symbol];
 [shadings addObject:self.shading];
 [numbers addObject:@(self.number)];
 for (id otherCard in otherCards) {
 if ([otherCard isKindOfClass:[SetCard class]]) {
 SetCard *otherSetCard = (SetCard *)otherCard;
 if (![colors containsObject:otherSetCard.color])
 [colors addObject:otherSetCard.color];
 if (![symbols containsObject:otherSetCard.symbol])
 [symbols addObject:otherSetCard.symbol];
 if (![shadings containsObject:otherSetCard.shading])
 [shadings addObject:otherSetCard.shading];
 if (![numbers containsObject:@(otherSetCard.number)])
 [numbers addObject:@(otherSetCard.number)];
 if (([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
 && ([symbols count] == 1 || [symbols count] == self.numberOfMatchingCards)
 && ([shadings count] == 1 || [shadings count] == self.numberOfMatchingCards)
 && ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards)) {
 score = 4;
 }
 }
 }
 }
 return score;
 }
 
 */


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
-(void)setRank:(NSUInteger)rank
{
    if ([[SetCard rankStrings] containsObject:[NSString stringWithFormat:@"%lu",(unsigned long)rank]])
    {
        _rank = rank;
    }
}
-(NSUInteger)rank
{
    return _rank ? _rank : -404;
}

+(NSArray *)validColors
{
    return @[@"red",@"green",@"blue"];
}
//▲ ● ■
+(NSArray *)validShapes
{
    return @[@"oval",@"squiggle",@"diamond"];
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

// for debugging
-(NSString *)contents
{
    return [NSString stringWithFormat:@"%@%@%@%d",self.shape,self.shading,self.color,self.rank];
}

@end
