
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cocosoR

<!-- badges: start -->
<!-- badges: end -->

This program is an implementation of the Combined Compromise Solution
(CoCoSo) Method (A combined compromise solution (CoCoSo) method for
multi-criteria decision-making problems, Yazdani, M., Zarate, P.,
Kazimieras Zavadskas, E., & Turskis, Z. (2019),
<https://doi.org/10.1108/MD-05-2017-0458> ) based on an integrated
simple additive weighting and compromise exponentially weighted product
model.

## Installation

You can install the development version of cocosoR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("sergiofloquet/cocosoR")
```

``` r
library(cocosoR)
```

## CoCoSo Method

This package is an implementation of the Combined Compromise Solution
(CoCoSo) Method \[1\] based on an integrated simple additive weighting
and compromise exponentially weighted product model. We can use the data
from \[1\] as example:

``` r
data(example_cocoso)
example_cocoso
#>                                                                        
#> 1       Criteria Criteria_1 Criteria_2 Criteria_3 Criteria_4 Criteria_5
#> 2        Weights      0.036      0.192      0.326      0.326       0.12
#> 3  Optimal_value        MAX        MIN        MAX        MAX        MAX
#> 4  Alternative_1         60        0.4       2540        500        990
#> 5  Alternative_2       6.35       0.15       1016       3000       1041
#> 6  Alternative_3        6.8        0.1     1727.2       1500       1676
#> 7  Alternative_4         10        0.2       1000       2000        965
#> 8  Alternative_5        2.5        0.1        560        500        915
#> 9  Alternative_6        4.5       0.08       1016        350        508
#> 10 Alternative_7          3        0.1       1778       1000        920
```

CoCoSo method can be apply making the final ranking of all alternatives.

``` r
result<- cocoso(example_cocoso)
result
#>     Alternatives Order        k       ki_a     ki_b      ki_c        Si
#> 4  Alternative_1     5 2.041313 0.13062317 3.245282 0.7242238 0.4299734
#> 5  Alternative_2     2 2.787990 0.17546935 4.473498 0.9728678 0.6082495
#> 6  Alternative_3     1 2.882350 0.18036300 4.639646 1.0000000 0.6363392
#> 7  Alternative_4     4 2.416046 0.16332196 3.720904 0.9055181 0.4470733
#> 8  Alternative_5     7 1.298692 0.08779670 2.000000 0.4867778 0.2402679
#> 9  Alternative_6     6 1.443143 0.09737208 2.225040 0.5398672 0.2683310
#> 10 Alternative_7     3 2.519094 0.16505373 3.951291 0.9151197 0.5031435
#>          Pi
#> 4  3.291361
#> 5  4.390712
#> 6  4.502038
#> 7  4.205820
#> 8  2.260980
#> 9  2.505710
#> 10 4.199086
```

In addition we present in results all three aggregation strategies and
the sum and product weight, used in \[1\].

## References:

\[1\] Yazdani, M., Zarate, P., Kazimieras Zavadskas, E., & Turskis, Z.
(2019). A combined compromise solution (CoCoSo) method for
multi-criteria decision-making problems. Management Decision, 57(9),
2501-2519.
