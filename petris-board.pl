#!/usr/bin/perl -w

# $Id: petris-board.pl,v 1.2 1999/01/23 13:03:25 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


$Board{CANVAS} = $Win->Canvas(
            -width  => $Const{BOARD_X_LENGTH},
            -height => $Const{BOARD_Y_LENGTH},
            )->pack() ;


1 ;
