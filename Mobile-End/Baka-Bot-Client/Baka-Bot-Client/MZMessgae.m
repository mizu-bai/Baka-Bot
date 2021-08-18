//
//  MZMessage.m
//  Baka-Bot-Client
//
//  Created by mizu bai on 2021/8/19.
//

#import "MZMessage.h"

@implementation MZMessage


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)messageWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}


@end
