//
//  MZMessage.h
//  Baka-Bot-Client
//
//  Created by mizu bai on 2021/8/19.
//

#import <Foundation/Foundation.h>

typedef enum {
    MZMessageClient = 0, // client side message
    MZMessageServer = 1  // server side message
} MZMessageType;

NS_ASSUME_NONNULL_BEGIN

@interface MZMessage : NSObject


@property(nonatomic, assign) MZMessageType type; // message type (number), 0: client side, 1: server side
@property(nonatomic, copy) NSString *name;       // user name (string)
@property(nonatomic, assign) int time;           // unix time (number)
@property(nonatomic, copy) NSString *content;    // message content (string)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)messageWithDictionary:(NSDictionary *)dictionary;

+ (NSDictionary *)dictionaryValue;


@end

NS_ASSUME_NONNULL_END
