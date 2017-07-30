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



-(NSMutableArray *)getGamesInfo:(NSArray *)gamesIndexes pageNumber:(int)page
{
    int itemsOnScreen=45;
    UNIHTTPJsonResponse *gameResponse;
    NSMutableArray *gamesInfo=[NSMutableArray array];
    NSMutableString *gamesInfoReguestURL=[[NSMutableString alloc] initWithString:@"https://api-2445582011268.apicast.io/games/"];

    int count=0;
    int helpCount=page*itemsOnScreen;
    NSMutableArray *arrGames = [NSMutableArray arrayWithCapacity:itemsOnScreen];
    for (NSNumber *gameIndex in gamesIndexes) {
        if((count<itemsOnScreen)&&(helpCount<=0))        {
            gamesInfoReguestURL=[[NSMutableString alloc] initWithString:[gamesInfoReguestURL stringByAppendingString:[gameIndex stringValue]]];
            if (count<(itemsOnScreen-1))
            {
                gamesInfoReguestURL=[[NSMutableString alloc] initWithString:[gamesInfoReguestURL stringByAppendingString:@","]];
            }
            count++;
        }
        else
            if (count>(itemsOnScreen-1))
            {
            break;
        }
        helpCount--;
    }
    
    gameResponse = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:gamesInfoReguestURL];
        [request setHeaders:headers];
    }] asJson];
    gamesInfo=[[NSMutableArray alloc] initWithArray:gameResponse.body.array];
    
    
    
    
    for (int i=0;i<itemsOnScreen;i++) {
        GameBriefData* game = [[GameBriefData alloc] init];
        game.gameName = gamesInfo[i][@"name"];
        game.gameId=gamesInfo[i][@"id"];
        game.gameImgUrl=[[NSMutableString alloc] initWithString:@"https:"];
        game.gameImgUrl=[[NSMutableString alloc] initWithString:[game.gameImgUrl stringByAppendingString: gamesInfo[i][@"cover"][@"url"]]];
 
       /* NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString: game.gameImgUrl]];
        game.gameImg=[UIImage imageWithData:data];*/
        [arrGames addObject:game];
    }
    
    return arrGames;
}

-(NSArray *)getGameInfo:(NSNumber *)gameId
{
    UNIHTTPJsonResponse *gameResponse;


    NSMutableString *gamesInfoReguestURL=[[NSMutableString alloc] initWithString:@"https://api-2445582011268.apicast.io/games/"];
    
    gamesInfoReguestURL=[[NSMutableString alloc] initWithString:[gamesInfoReguestURL stringByAppendingString:[gameId stringValue]]];
    gamesInfoReguestURL=[[NSMutableString alloc] initWithString:[gamesInfoReguestURL stringByAppendingString:@"?fields=*"]];
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
