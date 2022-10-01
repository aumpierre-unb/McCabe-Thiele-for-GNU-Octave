function R=refmin(data,x,q)
    try
      data(0.5);
      f=@(x) data(x);
    end
    try
      data+1;
      f=@(x) interp1(data(:,1),data(:,2),x);
    end
    xD=x(1);
    xF=x(2);
    foo=@(x) (f(x)-(q/(q-1)*x-xF/(q-1)));
    xi=bissection(foo,0,1);
    yi=q/(q-1)*xi-xF/(q-1);
    alpha=(xD-yi)/(xD-xi);
    R=alpha/(1-alpha);
end

#{
data=@(x) (x.^0.9.*(1-x).^1.08+x);
x=[0.88 0.55 0.11];
q=0.54;
Rmin=refmin(data,x,q)

#}

#{
data=[0.  0.;
      0.1 0.212;
      0.2 0.384;
      0.3 0.529;
      0.4 0.651;
      0.5 0.752;
      0.6 0.833;
      0.7 0.895;
      0.8 0.942;
      0.9 0.974;
      1.  1.];
x=[0.1 0.5 0.9];
x=[0.11 0.55 0.88];
q=0.54;
Rmin=refmin(data,x,q)
#}
