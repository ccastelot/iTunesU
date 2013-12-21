//
//  Deck.h
//  Matchismo
//
//  Created by Chris Castelot on 12/19/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(NSMutableArray *)cards;

-(Card *)drawRandomCard;

@end
