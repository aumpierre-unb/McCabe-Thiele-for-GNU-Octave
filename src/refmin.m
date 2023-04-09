# Copyright (C) 2022 2023 Alexandre Umpierre
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

function [R]=refmin(data,X,q)
    # Syntax:
    #
    # [R]=refmin(data,X,q)
    #
    # refmin computes the minimum value of the reflux ratio
    #  of a distillation column
    #  using the McCabe-Thiele method given
    #  a function y = y(x) that relates the liquid fraction x and the vapor fraction y, or
    #  a x-y matrix of the liquid and the vapor fractions,
    #  the vector of the fractions of the distillate and the feed, and
    #  the feed quality.
    # If feed is a saturated liquid, feed quality q = 1,
    #  feed quality is reset to q = 1 - 1e-10.
    # refmin is a main function of
    #  the mccabe-thiele toolbox for GNU Octave.
    #
    # Examples:
    #
    # # Compute the minimum value of the reflux ratio
    # # of a distillation column given
    # # a matrix that relates the liquid fraction and the vapor fraction,
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the feed quality is 54 %:
    # data=[0.  0.;
    #       0.1 0.212;
    #       0.2 0.384;
    #       0.3 0.529;
    #       0.4 0.651;
    #       0.5 0.752;
    #       0.6 0.833;
    #       0.7 0.895;
    #       0.8 0.942;
    #       0.9 0.974;
    #       1.  1.];
    # x=[0.88 0.46];
    # q=0.54;
    # r=refmin(data,x,q)
    #
    # # Compute the number of theoretical stages
    # # of a distillation column given
    # # the function that compute the vapor fraction given the liquid fraction,
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the feed is saturated liquid:
    # y=@(x) (x.^0.9 .* (1-x).^1.2 + x);
    # x=[0.88 0.46];
    # q=1;
    # r=refmin(y,x,q)
    #
    # See also: stages, qR2S.
    xD=X(1);
    xF=X(2);
    if xD<xF
      error("Inconsistent feed and/or products compositions.")
    end
    if q==1
        q=1-1e-10;
    end
    try
      data(0.5);
      f=@(x) data(x);
    end
    try
      data+1;
      f=@(x) interp1(data(:,1),data(:,2),x);
    end
    foo=@(x) (f(x)-(q/(q-1)*x-xF/(q-1)));
    xi=bissection(foo,0,1);
    yi=q/(q-1)*xi-xF/(q-1);
    alpha=(xD-yi)/(xD-xi);
    R=alpha/(1-alpha);
end
