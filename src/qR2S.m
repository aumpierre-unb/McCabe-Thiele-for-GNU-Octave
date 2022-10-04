# Copyright (C) 2022 Alexandre Umpierre
#
# This file is part of Internal Fluid Flow Toolbox.
# Internal Fluid Flow Toolbox is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License (GPL) version 3
# as published by the Free Software Foundation.
#
# Internal Fluid Flow Toolbox is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the
# GNU General Public License along with this program
# (license GNU GPLv3.txt).
# It is also available at https://www.gnu.org/licenses/.

function [S]=qR2S(R,X,q)
    # Syntax:
    # [S]=qR2S(R,X,q)
    #
    # qR2S computes the reflux ratio at the bottom of the column, given
    #  the reflux ratio at the top of the column,
    #  the vector of the fractions of the products and the feed, and
    #  the feed quality.
    # If feed is a saturated liquid, feed quality q = 1,
    #  feed quality is reset to q = 1 - eps.
    #
    # Examples:
    # # Compute the reflux ratio at the bottom of the column, given
    # # the reflux ratio R = 2 at the top of the column,
    # # the composition xB = 11 % of the column's bottom,
    # # the composition xD = 88 % of the distillate,
    # # the composition xF = 46 % of the feed, and
    # # the feed quality q = 54 %:
    # R=2;
    # x=[0.88 0.46 0.11];
    # q=0.54;
    # S=qR2S(R,x,q)
    #
    # See also: stages, refmin.
    if q==1 q=1-eps end
    xD=X(1);
    xF=X(2);
    xB=X(3);
    xi=(xD/(R+1)+xF/(q-1))/(q/(q-1)-R/(R+1));
    yi=q/(q-1)*xi-xF/(q-1);
    alpha=(yi-xB)/(xi-xB);
    S=1/(alpha-1);
end
