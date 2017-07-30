//
//  igdbAPIConnection.h
//  AppodealTesting
//
//  Created by Admin on 30.07.17.
//  Copyright © 2017 appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface igdbAPIConnection : NSObject

    -(NSArray *)getGamesIndexes;
    -(NSMutableArray *)getGamesInfo:(NSArray *)gamesIndexes;
    -(NSArray *)getGameInfo:(NSNumber *)gameId;
@end