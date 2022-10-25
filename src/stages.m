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

function [N]=stages(data,X,q,R,updown=true,fig=true)
    # Syntax:
    #
    # [N]=stages(data,X,q,R[,updown[,fig]])
    #
    # stages computes the number of theoretical stages
    #  of a distillation column
    #  using the McCabe-Thiele method given
    #  a function y = y(x) that relates the liquid fraction x and the vapor fraction y, or
    #  a x-y matrix of the liquid and the vapor fractions,
    #  the vector of the fractions of the products and the feed,
    #  the feed quality, and
    #  the reflux ratio at the top of the column.
    # If feed is a saturated liquid, feed quality q = 1,
    #  feed quality is reset to q = 1 - 1e-10.
    # By default, theoretical stages are computed
    #  from the stripping section to the rectifying section, updown = true.
    # If updown = false is given, theoretical stages are computed
    #  from the rectifying section to the stripping section.
    # By default, stages plots a schematic diagram of the solution, fig = true.
    # If fig = false is given, no plot is shown.
    # stages is a main function of
    #  the mccabe-thiele toolbox for GNU Octave.
    #
    # Examples:
    #
    # # Compute the number of theoretical stages
    # # of a distillation column
    # # from the bottom to the top of the column given
    # # a matrix that relates the liquid fraction and the vapor fraction,
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the composition of the column's bottom product is 11 %,
    # # the feed quality is 54 %, and
    # # the reflux ratio R at the top of the column is
    # # 70 % higher that the minimum reflux ratio r:
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
    # x=[0.88 0.46 0.11];
    # q=0.54;
    # r=refmin(data,x,q);
    # R=1.70*r;
    # N=stages(data,x,q,R,false,false)
    #
    # # Compute the number of theoretical stages
    # # of a distillation column
    # # from the top to the bottom of the column given
    # # the function that compute the vapor fraction given the liquid fraction,
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the composition of the column's bottom product is 11 %,
    # # the feed is saturated liquid, and
    # # the reflux ratio R at the top of the column is
    # # 70 % higher that the minimum reflux ratio r
    # # and plot a schematic diagram of the solution:
    # y=@(x) (x.^0.9 .* (1-x).^1.2 + x);
    # x=[0.88 0.46 0.11];
    # q=1;
    # r=refmin(y,x,q);
    # R=1.70*r;
    # N=stages(y,x,q,R)
    #
    # See also: refmin, qR2S.
    xD=X(1);
    xF=X(2);
    xB=X(3);
    if xD<xF || xB>xF
      error("Inconsistent feed and/or products compositions.")
    end
    if q==1
        q=1-1e-10;
    end
    if R<=refmin(data,X,q)
      error("Minimum reflux ratio exceeded.")
    end
    try
      data(0.5);
      f=@(x) data(x);
      dots=false;
    end
    try
      data+1;
      f=@(x) interp1(data(:,1),data(:,2),x);
      dots=true;
    end
    xi=(xD/(R+1)+xF/(q-1))/(q/(q-1)-R/(R+1));
    yi=q/(q-1)*xi-xF/(q-1);
    X=[xD xF xB xi yi];
    if updown
        [N,x,y]=stages_updown(f,X,R);
    else
        [N,x,y]=stages_downup(f,X,R);
    end
    if fig
        doplots(dots,updown,f,x,y,data,X,q,R);
    end
end
