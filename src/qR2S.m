# Copyright (C) 2022 Alexandre Umpierre
#
# This file is part of mccabe-thiele toolbox for GNU Octave.
# mccabe-thiele toolbox for GNU Octave is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License (GPL) version 3
# as published by the Free Software Foundation.
#
# mccabe-thiele toolbox for GNU Octave is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the
# GNU General Public License along with this program
# (license GNU GPLv3.txt).
# It is also available at https://www.gnu.org/licenses/.

function [S]=qR2S(X,q,R)
    # Syntax:
    #
    # [S]=qR2S(X,q,R)
    #
    # qR2S computes the reflux ratio at the bottom
    #  of a distillation column
    #  using the McCabe-Thiele method given
    #  the reflux ratio at the top of the column,
    #  the vector of the fractions of the products and the feed, and
    #  the feed quality.
    # If feed is a saturated liquid, feed quality q = 1,
    #  feed quality is reset to q = 1 - 1e-10.
    # qR2S is a main function of
    #  the mccabe-thiele toolbox for GNU Octave.
    #
    # Examples:
    #
    # # Compute the reflux ratio at the bottom of the column given
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the composition of the column's bottom product is 11 %,
    # # the feed quality is 54 %, and
    # # the reflux ratio R at the top of the column is 2:
    # x=[0.88 0.46 0.11];
    # q=0.54;
    # R=2;
    # S=qR2S(x,q,R)
    #
    # # Compute the reflux ratio at the bottom of the column given
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the composition of the column's bottom product is 11 %,
    # # the feed is saturated liquid, and
    # # the reflux ratio R at the top of the column is 2:
    # x=[0.88 0.46 0.11];
    # q=1;
    # R=2;
    # S=qR2S(x,q,R)
    #
    # See also: stages, refmin.
    xD=X(1);
    xF=X(2);
    xB=X(3);
    if xD<xF || xB>xF
      error("Inconsistent feed and/or products compositions.")
    end
    if q==1
        q=1-1e-10;
    end
    xi=(xD/(R+1)+xF/(q-1))/(q/(q-1)-R/(R+1));
    yi=q/(q-1)*xi-xF/(q-1);
    alpha=(yi-xB)/(xi-xB);
    S=1/(alpha-1);
end
