//
//  Note.h
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/6/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;

@interface Note : NSObject<NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
-(id)initWithTitle:(NSString *)title detail:(NSString *)detail;
-(BOOL)isBlank;



@end
