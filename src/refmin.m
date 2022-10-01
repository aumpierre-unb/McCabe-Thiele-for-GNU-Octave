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

function [R]=refmin(data,X,q)
    # Syntax:
    # [R]=refmin(data,X,q)
    #
    # refmin computes the minimum value of the reflux ratio
    #  of a distillation column, given
    #  a function y = f(x) that relates the liquid fraction x and the vapor fraction y, or
    #  a x-y matrix of the liquid and the vapor fractions,
    #  the vector of the fractions of the distillate and the feed, and
    #  the feed quality q.
    #
    # Examples:
    # # Compute the minimum value of the reflux ratio
    # # of a distillation column, given
    # # a matrix that relates the liquid fraction and the vapor fraction,
    # # the composition xD = 88 % of the distillate,
    # # the composition xF = 46 % of the feed, and
    # # the feed quality q = 54 %:
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
    # Rmin=refmin(data,x,q)
    #
    # # Compute the number of theoretical stages of a distillation column
    # # from the top of the column, given
    # # the function that compute the vapor fraction given the liquid fraction,
    # # the composition xD = 88 % of the distillate,
    # # the composition xF = 46 % of the feed,
    # # the feed quality q = 54 %:
    #
    # f(x)=x.^1.11 .* (1-x).^1.09 + x;
    # x=[0.88 0.46];
    # q=0.54;
    # Rmin=refmin(f,x,q)
    #
    # See also: stages.
    try
      data(0.5);
      f=@(x) data(x);
    end
    try
      data+1;
      f=@(x) interp1(data(:,1),data(:,2),x);
    end
    xD=X(1);
    xF=X(2);
    foo=@(x) (f(x)-(q/(q-1)*x-xF/(q-1)));
    xi=bissection(foo,0,1);
    yi=q/(q-1)*xi-xF/(q-1);
    alpha=(xD-yi)/(xD-xi);
    R=alpha/(1-alpha);
end