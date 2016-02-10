//
//  Note.m
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/6/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import "Note.h"
@class Note;

@implementation Note

-(id)initWithTitle:(NSString *)title detail:(NSString *)detail {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    self.title = title;
    self.detail = detail;
    return self;
}

//returns if note is blank
-(BOOL)isBlank {
    return !(self.title && self.title.length>0 && self.detail && self.detail.length>0);
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.detail    forKey:@"detail"];
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.title = [coder decodeObjectForKey:@"title"];
    self.detail    = [coder decodeObjectForKey:@"detail"];
    return self;
}


@end
