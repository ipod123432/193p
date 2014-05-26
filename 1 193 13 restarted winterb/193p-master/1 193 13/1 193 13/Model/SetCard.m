//
//  SetCard.m
//  1 193 13
//
//  Created by Roger on 12/21/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


-(NSString *)contents
{
    return [NSString stringWithFormat:@"%@ %@ %@ %lu", self.symbol, self.shading, self.color, (unsigned long)self.number];
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count])
    {
        for (SetCard *otherCard in otherCards)
        {
            // DO LATER PLZ
        }
        
    }
    
    return score;
}


@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;
@synthesize number = _number;
-(void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol= symbol;
    }
}
-(NSString *)symbol
{
    if (_symbol)
        return _symbol;
    else
        return @"?";
}
-(void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings]containsObject:shading])
        _shading = shading;
}
-(NSString *)shading
{
    return _shading ? _shading : @"?";
}
-(void)setColor:(NSString *)color
{
    if ([[SetCard validColors]containsObject:color])
        _color=color;
}
-(NSString *)color
{
    return _color ? _color : @"?";
}



// I can't remember how to package an int to NSNumber...
-(void)setNumber:(NSUInteger)number
{
    if ([[SetCard validNumbers]containsObject:[NSNumber numberWithInteger:number]])
        _number=number;
}




-(NSUInteger)number
{
    return _number ? _number : 0;
}

+(NSArray *)validSymbols
{
    return @[@"triangle", @"circle", @"square"];
}
+(NSArray *)validShadings
{
    return @[@"open", @"shaded", @"filled"];
}
+(NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}
+(NSArray *)validNumbers
{
    return @[@1, @2, @3];
}
+(NSUInteger)maxNumber
{
    return [[SetCard validNumbers] count];
}



@end
