//
//  UIViewController+Container.m
//  UIViewController+Container
//
//  Created by Peter Paulis on 20.4.2013.
//  Copyright (c) 2013 Peter Paulis. All rights reserved.
//  min:60 - Building perfect apps - https://min60.com

#import "UIViewController+Container.h"

@implementation UIViewController (Container)

- (void)containerAddChildViewController:(UIViewController *)childViewController toContainerView:(UIView *)view resizeToContainer:(BOOL)resizeToContainer useAutolayout:(BOOL)autolayout {
	
	[self addChildViewController:childViewController];

    if (resizeToContainer){
		childViewController.view.frame = view.bounds;
		childViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}

	[view addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
    [view bringSubviewToFront:childViewController.view];
    
    if (resizeToContainer && autolayout) {
        UIView * parent = view;
        UIView * child = childViewController.view;
        [child setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [parent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[child]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(child)]];
        [parent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[child]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(child)]];
        [parent layoutIfNeeded];
    }
}

- (void)containerAddChildViewController:(UIViewController *)childViewController toContainerView:(UIView *)view {
	[self containerAddChildViewController:childViewController
						  toContainerView:view
						resizeToContainer:NO
							useAutolayout:NO];

}

- (void)containerAddChildViewController:(UIViewController *)childViewController toContainerView:(UIView *)view resizeToContainer:(BOOL)resizeToContainer{
	[self containerAddChildViewController:childViewController
						  toContainerView:view
						resizeToContainer:resizeToContainer
							useAutolayout:NO];

}

- (void)containerAddChildViewController:(UIViewController *)childViewController {
    [self containerAddChildViewController:childViewController toContainerView:self.view];
}

- (void)containerRemoveChildViewController:(UIViewController *)childViewController {
    [childViewController willMoveToParentViewController:nil];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
}

- (void)containerRemoveFromParentViewController {
	[self willMoveToParentViewController:nil];
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
}

@end
