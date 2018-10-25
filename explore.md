Traffic violations
================
Taavi Päll
2018-10-25 (updated 2018-10-25)

## Load libraries

``` r
library(tidyverse)
library(skimr)
```

## Import dataset

Here we use `fread` function from **data.table** library because we have
no idea what delimiters are being used in this file (we cannot trust
file extension) and `fread` has automatic delimiter detection.

``` r
violations <- data.table::fread("data/liiklusjarelevalve_3.csv") %>% 
  as_data_frame()
violations
```

    ## # A tibble: 139,028 x 26
    ##    JuhtumId ToimKpv ToimKell ToimNadalapaev Seadus Paragrahv ParagrahvTais
    ##    <chr>    <chr>   <chr>    <chr>          <chr>  <chr>     <chr>        
    ##  1 95ff96e… 2012-1… 22:50    Esmaspäev      Liikl… § 224.    § 224. Mooto…
    ##  2 95ffa3c… 2012-1… 22:17    Esmaspäev      Liikl… § 227.    § 227. Mooto…
    ##  3 95ff953… 2012-1… 21:50    Esmaspäev      Liikl… § 242.    § 242. Mooto…
    ##  4 95ff988… 2012-1… 21:45    Esmaspäev      Liikl… § 227.    § 227. Mooto…
    ##  5 95ff988… 2012-1… 21:45    Esmaspäev      Liikl… § 207.    Tehnonõuetel…
    ##  6 95ffb01… 2012-1… 21:34    Esmaspäev      Liikl… § 242.    § 242. Mooto…
    ##  7 95ffb01… 2012-1… 21:34    Esmaspäev      Liikl… § 207.    Tehnonõuetel…
    ##  8 95ffa9b… 2012-1… 21:33    Esmaspäev      Liikl… § 227.    § 227. Mooto…
    ##  9 95ff97d… 2012-1… 21:32    Esmaspäev      Liikl… § 227.    § 227. Mooto…
    ## 10 95ffa1e… 2012-1… 21:09    Esmaspäev      Liikl… § 259.    § 259. Jalak…
    ## # ... with 139,018 more rows, and 19 more variables: Loige <chr>,
    ## #   Punkt <chr>, RikutudOigusnorm <chr>, MaakondNimetus <chr>,
    ## #   ValdLinnNimetus <chr>, KohtNimetus <chr>, MntVoiTanav <chr>,
    ## #   MntTanavNimetus <chr>, KM <int>, Lest_X <chr>, Lest_Y <chr>,
    ## #   SoidukLiik <chr>, SoidukRegRiik <chr>, SoidukMark <chr>,
    ## #   SoidukVlAasta <chr>, RikkujaSugu <chr>, RikkujaVanus <chr>,
    ## #   RikkujaElukoht <chr>, SyyteoLiik <chr>

## Explore

Let’s have a look how this dataset looks like and what kind of variables
it has in it.

``` r
skim(violations)
```

    ## Skim summary statistics
    ##  n obs: 139028 
    ##  n variables: 26 
    ## 
    ## ── Variable type:character ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ##          variable missing complete      n min max  empty n_unique
    ##          JuhtumId       0   139028 139028  36  36      0   128229
    ##       KohtNimetus       0   139028 139028   0  23    162     1146
    ##            Lest_X       0   139028 139028   0  15      1      446
    ##            Lest_Y       0   139028 139028   0  13      3      682
    ##             Loige       0   139028 139028   0   6  15890        5
    ##    MaakondNimetus       0   139028 139028   0  18    162       16
    ##   MntTanavNimetus       0   139028 139028   0  49   4240     2599
    ##       MntVoiTanav       0   139028 139028   3   3      0        2
    ##         Paragrahv       0   139028 139028   6   9      0       59
    ##     ParagrahvTais       0   139028 139028  31 183      0       59
    ##             Punkt       0   139028 139028  20  20      0        4
    ##    RikkujaElukoht       0   139028 139028   0   3 117815        3
    ##       RikkujaSugu       0   139028 139028   0   1   1055        4
    ##      RikkujaVanus       0   139028 139028   0   5   1054       10
    ##  RikutudOigusnorm       0   139028 139028   0  47   6217     1550
    ##            Seadus       0   139028 139028  13  17      0        2
    ##        SoidukLiik       0   139028 139028   0  14  19043       18
    ##        SoidukMark       0   139028 139028   0 128  21175      257
    ##     SoidukRegRiik       0   139028 139028   0   3  18807        3
    ##     SoidukVlAasta       0   139028 139028   0   4  29724       43
    ##        SyyteoLiik       0   139028 139028   2   2      0        2
    ##          ToimKell       0   139028 139028   0   5    336     1441
    ##           ToimKpv       0   139028 139028  10  10      0      366
    ##    ToimNadalapaev       0   139028 139028   8  10      0        7
    ##   ValdLinnNimetus       0   139028 139028   0  18    162      239
    ## 
    ## ── Variable type:integer ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ##  variable missing complete      n  mean    sd p0 p25 p50 p75 p100     hist
    ##        KM   91203    47825 139028 53.75 60.45  0  10  27  75  287 ▇▂▁▁▁▁▁▁

## Translate variable names to English

We have mostly character data and we need to translate variable names to
English.

``` r
colnames(violations)
```

    ##  [1] "JuhtumId"         "ToimKpv"          "ToimKell"        
    ##  [4] "ToimNadalapaev"   "Seadus"           "Paragrahv"       
    ##  [7] "ParagrahvTais"    "Loige"            "Punkt"           
    ## [10] "RikutudOigusnorm" "MaakondNimetus"   "ValdLinnNimetus" 
    ## [13] "KohtNimetus"      "MntVoiTanav"      "MntTanavNimetus" 
    ## [16] "KM"               "Lest_X"           "Lest_Y"          
    ## [19] "SoidukLiik"       "SoidukRegRiik"    "SoidukMark"      
    ## [22] "SoidukVlAasta"    "RikkujaSugu"      "RikkujaVanus"    
    ## [25] "RikkujaElukoht"   "SyyteoLiik"

Liiklusseadus = Traffic Act väärtegu =
misdemeanour

``` r
colnames(violations) <- c("case_id", "date", "time", "weekday", "legislative_act", "section", 
  "section_title", "subsection", "clause", "violated_point_of_law", "county",
  "municipality", "district", "road_type", "road_name", "km", "lest_x", 
  "lest_y", "car_type", "reg_country", "car_make", "car_year", "sex", "age", "residence", "offence")
write_csv(violations, "output/traffic_supervision.csv")
```

Print out table with English names

``` r
violations
```

    ## # A tibble: 139,028 x 26
    ##    case_id date  time  weekday legislative_act section section_title
    ##    <chr>   <chr> <chr> <chr>   <chr>           <chr>   <chr>        
    ##  1 95ff96… 2012… 22:50 Esmasp… Liiklusseadus   § 224.  § 224. Mooto…
    ##  2 95ffa3… 2012… 22:17 Esmasp… Liiklusseadus   § 227.  § 227. Mooto…
    ##  3 95ff95… 2012… 21:50 Esmasp… Liiklusseadus   § 242.  § 242. Mooto…
    ##  4 95ff98… 2012… 21:45 Esmasp… Liiklusseadus   § 227.  § 227. Mooto…
    ##  5 95ff98… 2012… 21:45 Esmasp… Liiklusseadus   § 207.  Tehnonõuetel…
    ##  6 95ffb0… 2012… 21:34 Esmasp… Liiklusseadus   § 242.  § 242. Mooto…
    ##  7 95ffb0… 2012… 21:34 Esmasp… Liiklusseadus   § 207.  Tehnonõuetel…
    ##  8 95ffa9… 2012… 21:33 Esmasp… Liiklusseadus   § 227.  § 227. Mooto…
    ##  9 95ff97… 2012… 21:32 Esmasp… Liiklusseadus   § 227.  § 227. Mooto…
    ## 10 95ffa1… 2012… 21:09 Esmasp… Liiklusseadus   § 259.  § 259. Jalak…
    ## # ... with 139,018 more rows, and 19 more variables: subsection <chr>,
    ## #   clause <chr>, violated_point_of_law <chr>, county <chr>,
    ## #   municipality <chr>, district <chr>, road_type <chr>, road_name <chr>,
    ## #   km <int>, lest_x <chr>, lest_y <chr>, car_type <chr>,
    ## #   reg_country <chr>, car_make <chr>, car_year <chr>, sex <chr>,
    ## #   age <chr>, residence <chr>, offence <chr>

Skim

``` r
skim(violations)
```

    ## Skim summary statistics
    ##  n obs: 139028 
    ##  n variables: 26 
    ## 
    ## ── Variable type:character ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ##               variable missing complete      n min max  empty n_unique
    ##                    age       0   139028 139028   0   5   1054       10
    ##               car_make       0   139028 139028   0 128  21175      257
    ##               car_type       0   139028 139028   0  14  19043       18
    ##               car_year       0   139028 139028   0   4  29724       43
    ##                case_id       0   139028 139028  36  36      0   128229
    ##                 clause       0   139028 139028  20  20      0        4
    ##                 county       0   139028 139028   0  18    162       16
    ##                   date       0   139028 139028  10  10      0      366
    ##               district       0   139028 139028   0  23    162     1146
    ##        legislative_act       0   139028 139028  13  17      0        2
    ##                 lest_x       0   139028 139028   0  15      1      446
    ##                 lest_y       0   139028 139028   0  13      3      682
    ##           municipality       0   139028 139028   0  18    162      239
    ##                offence       0   139028 139028   2   2      0        2
    ##            reg_country       0   139028 139028   0   3  18807        3
    ##              residence       0   139028 139028   0   3 117815        3
    ##              road_name       0   139028 139028   0  49   4240     2599
    ##              road_type       0   139028 139028   3   3      0        2
    ##                section       0   139028 139028   6   9      0       59
    ##          section_title       0   139028 139028  31 183      0       59
    ##                    sex       0   139028 139028   0   1   1055        4
    ##             subsection       0   139028 139028   0   6  15890        5
    ##                   time       0   139028 139028   0   5    336     1441
    ##  violated_point_of_law       0   139028 139028   0  47   6217     1550
    ##                weekday       0   139028 139028   8  10      0        7
    ## 
    ## ── Variable type:integer ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ##  variable missing complete      n  mean    sd p0 p25 p50 p75 p100     hist
    ##        km   91203    47825 139028 53.75 60.45  0  10  27  75  287 ▇▂▁▁▁▁▁▁
