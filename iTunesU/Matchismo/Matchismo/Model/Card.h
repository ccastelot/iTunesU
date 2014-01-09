//
//  Card.h
//  Matchismo
//
//  Created by Chris Castelot on 12/19/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic, getter = hasBeenPlayed) BOOL played;
@property (nonatomic, getter = isEliminated) BOOL eliminated;

-(int)match:(NSArray *)otherCards;
@end
