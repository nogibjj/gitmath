gitmath
=======

Performs Code Churn Analysis on Git using R

Relates to 'Use of Relative Code Churn Measures to Predict System Defect Density'

Instructions
===================

Requires R to be installed.  Run R then perform steps below:

Usage example:

```{r }
#source('gitMath.R')
#gs <- mkchurnline()    #lines, churn, churn/lines
#OR
#mkreport()             #generates report of top values, all and a plot of top values
#gitMathAll.txt and gitMathtop.txt is created in current working directory
#also creates pdf called topchurn.pdf
```

Here is an example of a report generated from the Rails repo:

![Rails](https://raw.github.com/noahgift/gitmath/master/docs/rails-churn.png)

Running a report will create three files in the git repo:  gitMathtop.txt gitMathall.txt and topchurn.pdf.  An example of the top
report for Rails is here:

```{r }
"files" "churn" "linecount" "relchurn"
"2961" "activerecord/lib/active_record/base.rb" 1315 323 4.07120743034056
"2897" "activerecord/lib/active_record/associations.rb" 783 1538 0.509102730819246
"597" "actionpack/lib/action_controller/base.rb" 561 259 2.16602316602317
"2878" "activerecord/CHANGELOG.md" 553 1955 0.282864450127877
"2990" "activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb" 500 921 0.542888165038002
"507" "actionpack/CHANGELOG.md" 475 1159 0.409836065573771
"1217" "actionpack/lib/action_dispatch/routing/mapper.rb" 469 1759 0.266628766344514
"1484" "actionpack/lib/action_view/helpers/form_helper.rb" 454 1827 0.248494800218938
"3290" "activerecord/test/cases/base_test.rb" 419 1637 0.255956017104459
"22" "actionmailer/lib/action_mailer/base.rb" 418 794 0.526448362720403
"6137" "Gemfile" 390 83 4.69879518072289
"8929" "railties/Rakefile" 373 61 6.11475409836066
"1441" "actionpack/lib/action_view/base.rb" 370 201 1.8407960199005
"2984" "activerecord/lib/active_record/connection_adapters/mysql_adapter.rb" 343 558 0.614695340501792
"3075" "activerecord/lib/active_record/relation/query_methods.rb" 334 1048 0.318702290076336
"3067" "activerecord/lib/active_record/relation.rb" 318 631 0.503961965134707
"3116" "activerecord/lib/active_record/validations.rb" 309 84 3.67857142857143
"8049" "railties/lib/rails/application.rb" 308 406 0.758620689655172
"1815" "actionpack/test/controller/routing_test.rb" 295 1921 0.153565851119209
"2448" "actionpack/test/template/form_helper_test.rb" 279 2959 0.0942886110172356
"3019" "activerecord/lib/active_record/fixtures.rb" 275 926 0.296976241900648
"3398" "activerecord/test/cases/relations_test.rb" 275 1541 0.17845554834523
"1462" "actionpack/lib/action_view/helpers/asset_tag_helper.rb" 271 315 0.86031746031746
"1874" "actionpack/test/dispatch/routing_test.rb" 268 3545 0.0755994358251058
"3274" "activerecord/test/cases/associations/has_many_associations_test.rb" 268 1791 0.14963707426019
```

