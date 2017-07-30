//
//  igdbAPIConnection.m
//  AppodealTesting
//
//  Created by Admin on 30.07.17.
//  Copyright © 2017 appodeal. All rights reserved.
//

#import "igdbAPIConnection.h"
#import "UNIRest.h"
#import "GameCell.h"
#import "GameBriefData.h"

#define headers @{@"user-key": @"6d8741820d7b76722e220a90295c16ea",@"Accept": @"application/json"}

@implementation igdbAPIConnection
{
    
}


-(NSArray *)getGamesIndexes
{
    UNIHTTPJsonResponse *response;
    
    response = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://api-2445582011268.apicast.io/genres/9?fields=name,games"];
        [request setHeaders:headers];
    }] asJson];
    
    return response.body.array[0][@"games"];
}



-(NSMutableArray *)getGamesInfo:(NSArray *)gamesIndexes
{
    int itemsOnScreen=30;
    UNIHTTPJsonResponse *gameResponse;
    NSMutableDictionary *currentGameInfo;
    NSMutableArray *gamesInfo=[NSMutableArray array];
    NSMutableString *gamesInfoReguestURL=@"https://api-2445582011268.apicast.io/games/";
    NSMutableString *gameInfoRequestURL=@"";
    
    int indexesCount=gamesIndexes.count;
    int count=0;
    NSMutableArray *arrGames = [NSMutableArray arrayWithCapacity:itemsOnScreen];
    for (NSNumber *gameIndex in gamesIndexes) {
        if(count<itemsOnScreen)
        {
            gamesInfoReguestURL=[gamesInfoReguestURL stringByAppendingString:[gameIndex stringValue]];
            if (count<(itemsOnScreen-1))
            {
                gamesInfoReguestURL=[gamesInfoReguestURL stringByAppendingString:@","];
            }
            count++;
        }
        else
        {
            break;
        }
    }
    
    gameResponse = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:gamesInfoReguestURL];
        [request setHeaders:headers];
    }] asJson];
    gamesInfo=gameResponse.body.array;
    
    
    
    
    for (int i=0;i<itemsOnScreen;i++) {
        GameBriefData* game = [[GameBriefData alloc] init];
        game.gameName = gamesInfo[i][@"name"];
        game.gameId=gamesInfo[i][@"id"];
        game.gameImgUrl=@"https:";
        game.gameImgUrl=[game.gameImgUrl stringByAppendingString: gamesInfo[i][@"cover"][@"url"]];
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString: game.gameImgUrl]];
        game.gameImg=[UIImage imageWithData:data];
        [arrGames addObject:game];
    }
    
    return arrGames;
}

-(NSArray *)getGameInfo:(NSNumber *)gameId
{
    UNIHTTPJsonResponse *gameResponse;
    NSMutableDictionary *currentGameInfo;
    NSMutableArray *gamesInfo=[NSMutableArray array];
    NSMutableString *gamesInfoReguestURL=@"https://api-2445582011268.apicast.io/games/";
    
    gamesInfoReguestURL=[gamesInfoReguestURL stringByAppendingString:[gameId stringValue]];
    gamesInfoReguestURL=[gamesInfoReguestURL stringByAppendingString:@"?fields=*"];
    gameResponse = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:gamesInfoReguestURL];
        [request setHeaders:headers];
    }] asJson];
    //currentGameInfo=gameResponse.body.array[0];
    //[gamesInfo addObject:currentGameInfo];
    NSArray *infoGame=gameResponse.body.array;
    return infoGame;
}

@end
