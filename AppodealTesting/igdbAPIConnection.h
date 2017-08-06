//
//  igdbAPIConnection.h
//  AppodealTesting
//
//  Created by Admin on 30.07.17.
//  Copyright © 2017 appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface igdbAPIConnection : NSObject


// Все запросы синхронные - лаги UI
    -(NSArray *)getGamesIndexes;
    -(NSMutableArray *)getGamesInfo:(NSArray *)gamesIndexes pageNumber:(int)page;
    -(NSArray *)getGameInfo:(NSNumber *)gameId;
@end
