
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DELTA Grant Materials

This is a repository demonstrating a proposed method for creating
automated courses. The materials here need an Amazon Polly account,
using the credentials with a profile named `"polly"`, see number 5 on
[the aws.polly site](https://github.com/cloudyr/aws.polly). See the
instructions on setting up ARI on <https://github.com/seankross/ari>.

The required R packages necessary are as
follows:

``` r
install.packages(c("ari", "aws.polly", "ggplot2", "here", "officer", "xml2", "ggplot2", "magrittr"))
```

If you have all the requirements, to make the output MP4s, you can
simply run

    make

# Human recording

[I recorded](http://johnmuschelli.com/DELTA_GRANT/human.mp4) a bad
recording in a coffee shop for a human sounding lecture.

# Automated recordings

The output from `ari` for [Kimberly
voice](http://johnmuschelli.com/DELTA_GRANT/auto/kim.mp4) and [Joey
voice](http://johnmuschelli.com/DELTA_GRANT/auto/joey.mp4).
