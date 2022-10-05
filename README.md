# `mccabe-thiele` Toolbox for GNU-Octave (under construction)

[![DOI](https://zenodo.org/badge/544044423.svg)](https://zenodo.org/badge/latestdoi/544044423)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aumpierre-unb/McCabe-Thiele-for-GNU-Octave)

## Installing and Loading `mccabe-thiele`

```dotnetcli
# use this call to install version 0.1.2, or modify the command line for match the version
pkg install https://github.com/aumpierre-unb/McCabe-Thiele-for-GNU-Octave/archive/refs/tags/v0.1.2.tar.gz
pkg load mccabe-thiele
```

## Citation of `mccabe-thiele`

You can cite all versions (both released and pre-released), by using
[DOI 10.5281/zenodo.7133683](https://doi.org/10.5281/zenodo.7133683).

This DOI represents all versions, and will always resolve to the latest one.

For citation of the last released version of `mccabe-thiele`, please check CITATION file at the [maintainer's repository](https://github.com/aumpierre-unb/McCabe-Thiele-for-GNU-Octave).

---

The following is a very short introduction to the `mccabe-thiele` Toolbox for GNU Octave.

This text is divided in two main sections: The Theory and The `mccabe-thiele` Toolbox.

## The Theory

The McCabe-Thiele method is a simplified method to calculate the number of theoretical stages of equilibrium of a distillation column for a two component mixture. The method depends of three premisses:

- components have the same molar heats of vaporization,
- for every mole of liquid vaporized, a mole of vapor is condensed, and
- heat effects are negligible.

Distillation is a unit operation based on the difference of volatility to separate different chemical species of a mixture and on gravity to separate vapor and liquid streams. There are several types of distillation.

Typically, continuous distillation is performed in a vertical column fed at its intermediate section while products at its top and bottom are recovered. As a rule of thumb, the higher the column, the higher the number of stages of equilibrium and the best is the separations of the components of the mixture fed.

The McCabe-Thiele method is a simplifyied method to calculate the number of stages of equilibrium of a distillation column fo a two component mixture.

### Stages of Equilibrium

An equilibrium stage is an abstract control volume such that the effluent currents are all in thermodynamic equilibrium. All multistage operatations are based on the concept of satge of equilibrium.

### The Feed Line

Idealy, the feed current separates into a liquid stream *q* and a vapor stream 1-*q*, where *q* is the liquid fraction of the feed. If *x*<sub>*n*+1</sub>, *y*<sub>*n*</sub> and *x*<sub>*y*</sub> are the compositions of the liquid and the vapor streams, respectively, then the material balance is

$$
(1 - q)\ y_n + q\ x_{n+1} = x_F
$$

or

$$
y_n = {q \over q-1}x_{n+1} + {x_F \over q-1}
$$

### Operation Lines

The global and specific material balances for any equilibrium stage *n* is given by

$$
V_{n-1} - L_n = V_n - L_{n+1}
$$

$$
V_{n-1}\ y_{n-1} - L_n\ x_n = V_n\ y_n - L_{n+1}\ x_{n+1}
$$

As this is true for any stage in its section, then the material stream is constant in the section. For the last theoretical stage *N* (the top of the column), the global material balance is given by

$$
D = V_N - L_{N+1} = V_n - L_{n+1}
$$

and the specific material balance is given by

$$
D\ x_D = V_n\ y_n - L_{n+1}\ x_{n+1}
$$

The ratio between the distillate *D* and the refluxing current *L*<sub>*n*+1</sub> is the reflux ratio at the top of the column,

$$
R = {L_{n+1} \over D}
$$

Now, introducing the reflux ratio in the specific material balance of the rectifying section, we have

$$
y_n = {R \over R+1}x_{n+1} + {x_F \over {R+1}}
$$

Notice that *y*<sub>*n*+1</sub> = *x*<sub>*D*</sub> for *x*<sub>*n*</sub> = *x*<sub>*D*</sub> as well.

One can apply the very same procedure to find the operation line for the stripping section based on the reflux ratio at the bottom of the column, and find that *y*<sub>*n*+1</sub> = *x*<sub>*B*</sub> for *x*<sub>*n*</sub> = *x*<sub>*B*</sub> and that both operation lines and the feed line have a common interception.

It means that, given the compositions of the feed and the top and bottom products, the feed quality and the reflux ratios at the top and the bottom of the column can be calculated provided the other two are given.

Given the reflux ratio *R* at the top of the column and the quality of the feed *q*, alongside with the compositions of feed and products and the thermodynamical relation between the compositions in equilibrium, one can calculate the stages of equilibrium of a column using the McCabe-Thiele method.

## The `mccabe-thiele` Toolbox

`mccabe-thiele` provides the following functions:

- stages
- refmin
- qR2S

### `stages`

`stages` computes the number of theoretical stages
of a distillation column using the method of McCabe-Thiele, given
a function *y* = *y*(*x*) that relates the liquid fraction *x* and the vapor fraction *y*, or
a *x*-*y* matrix of the liquid and the vapor fractions,
the vector of the fractions of the products and the feed,
the feed quality, and
the reflux ratio at the top of the column.

If feed is a saturated liquid, feed quality *q* = 1,
feed quality is reset to *q* = 1 - 1e-10.

By default, theoretical stages are computed
from the stripping section to the rectifying section, *updown* = *true*.

If *updown* = *false* is given, theoretical stages are computed
from the rectifying section to the stripping section.

By default, stages plots a schematic diagram of the solution, *fig* = *true*.

If *fig* = *false* is given, no plot is shown.

**Syntax:**

```dotnetcli
stages(y,X,q,R[,updown[,fig]])
```

**Examples:**

Compute the number of theoretical stages of a distillation column
from the bottom of the column, given
a matrix that relates the liquid fraction and the vapor fraction,
the composition *x*<sub>*B*</sub> = 11 % of the column's bottom product,
the composition *x*<sub>*D*</sub> = 88 % of the distillate,
the composition *x*<sub>*y*</sub> = 46 % of the feed,
the feed quality *q* = 54 %, and
the reflux ratio at the top of the column 70 % higher that the minimum reflux ratio:

```dotnetcli
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
x=[0.88 0.46 0.11];
q=0.54;
Rmin=refmin(data,x,q)
R=1.70*Rmin;
N=stages(data,x,q,R,false,false)
```

Compute the number of theoretical stages of a distillation column
from the top of the column, given
the function that compute the vapor fraction given the liquid fraction,
the composition *x*<sub>*B*</sub> = 11 % of the column's bottom product,
the composition *x*<sub>*D*</sub> = 88 % of the distillate,
the composition *x*<sub>*y*</sub> = 46 % of the feed,
the feed quality *q* = 54 %, and
the reflux ratio at the top of the column 70 % higher that the minimum reflux ratio,
and plot a schematic diagram of the solution:

```dotnetcli
y=@(x) (x.^1.11 .* (1-x).^1.09 + x);
x=[0.88 0.46 0.11];
q=0.54;
Rmin=refmin(y,x,q)
R=1.70*Rmin;
N=stages(y,x,q,R)
```

### `refmin`

`refmin` computes the minimum value of the reflux ratio
of a distillation column, given
a function *y* = *y*(*x*) that relates the liquid fraction *x* and the vapor fraction *y*, or
a *x*-*y* matrix of the liquid and the vapor fractions,
the vector of the fractions of the distillate and the feed, and
the feed quality.

If feed is a saturated liquid, feed quality *q* = 1,
feed quality is reset to *q* = 1 - 1e-10.

**Syntax:**

```dotnetcli
R=refmin(f,X,q)
```

**Examples:**

Compute the minimum value of the reflux ratio
of a distillation column, given
a matrix that relates the liquid fraction and the vapor fraction,
the composition *x*<sub>*D*</sub> = 88 % of the distillate,
the composition *x*<sub>*y*</sub> = 46 % of the feed, and
the feed quality *q* = 54 %:

```dotnetcli
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
x=[0.88 0.46];
q=0.54;
Rmin=refmin(data,x,q)
```

Compute the number of theoretical stages of a distillation column
from the top of the column, given
the function that compute the vapor fraction given the liquid fraction,
the composition *x*<sub>*D*</sub> = 88 % of the distillate,
the composition *x*<sub>*y*</sub> = 46 % of the feed,
the feed quality *q* = 54 %:

```dotnetcli
y=@(x) (x.^1.11 .* (1-x).^1.09 + x);
x=[0.88 0.46];
q=0.54;
Rmin=refmin(y,x,q)
```

### `qR2S`

`qR2S` computes the reflux ratio at the bottom of the column, given
the reflux ratio at the top of the column,
the vector of the fractions of the products and the feed, and
the feed quality.

If feed is a saturated liquid, feed quality *q* = 1,
feed quality is reset to *q* = 1 - 1e-10.

**Syntax:**

```dotnetcli
R=refmin(f,X,q)
```

**Examples:**

Compute the minimum value of the reflux ratio
of a distillation column, given
a matrix that relates the liquid fraction and the vapor fraction,
the composition *x*<sub>*D*</sub> = 88 % of the distillate,
the composition *x*<sub>*y*</sub> = 46 % of the feed, and
the feed quality *q* = 54 %:

```dotnetcli
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
x=[0.88 0.46];
q=0.54;
Rmin=refmin(data,x,q)
```

Compute the number of theoretical stages of a distillation column
from the top of the column, given
the function that compute the vapor fraction given the liquid fraction,
the composition *x*<sub>*D*</sub> = 88 % of the distillate,
the composition *x*<sub>*y*</sub> = 46 % of the feed,
the feed quality *q* = 54 %:

```dotnetcli
y=@(x) (x.^1.11 .* (1-x).^1.09 + x);
x=[0.88 0.46];
q=0.54;
Rmin=refmin(y,x,q)
```

Copyright &copy; 2022 Alexandre Umpierre

email: <aumpierre@gmail.com>
