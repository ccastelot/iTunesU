//
//  Card.m
//  Matchismo
//
//  Created by Chris Castelot on 12/19/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import "Card.h"

@interface Card()

@end


@implementation Card

-(int)match:(NSArray *)otherCards
{
    NSLog(@"%@",@"This is wrong.");
   int score = 0;
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end
