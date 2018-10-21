//
//  MPLocationCell.m
//  MIAIOS
//
//  Created by Daniel Nielsen on 01/08/16.
//  Copyright © 2017-2018 MapsPeople. All rights reserved.
//

#import "MPMenuItemCell.h"

@interface MPMenuItemCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    spaceBetweenImageAndLabelConstraint;

@end


@implementation MPMenuItemCell

@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;

- (void) prepareForReuse {

    [super prepareForReuse];
    self.hideImage = NO;
}

- (void) setHideImage:(BOOL)hideImage {
    
    if ( self.imageView.hidden != hideImage ) {
        
        self.imageView.hidden = hideImage;
        
        if ( hideImage ) {
            self.spaceBetweenImageAndLabelConstraint.constant = - self.imageView.bounds.size.width;
        } else {
            self.spaceBetweenImageAndLabelConstraint.constant = 15;
        }
    }
}

@end
