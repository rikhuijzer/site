---
title: 'Combinations and permutations'
date: 2020-06-28
tags: ['order', 'statistics']
---

[//]: # (GENERATED FILE. DO NOT MODIFY.)


Counting seems really basic up until the point that the numbers become extremely large.
Combinations and permutations are such a case.
Suppose we want to count the number of possible results we can obtain from picking <img src="/latex/14358829268891314259.svg" width="9.6" height="14.4" style="margin:0;vertical-align:-0.0px"> numbers, without replacement, from an equal or larger set of numbers, that is, from <img src="/latex/17169281079250121527.svg" width="12.8" height="9.6" style="margin:0;vertical-align:-0.0px"> where <img src="/latex/17584461032860528710.svg" width="46.4" height="17.6" style="margin:0;vertical-align:-2.611px">.
When the same set of numbers in different orders should be counted separately, then the count is called the number of *permutations*.
So, if we have some set of numbers and shuffle some numbers around, then we say that the numbers are **permuted**.
When the same set of numbers in different orders should be counted only once, then the count is called the number of *combinations*.
Which makes sense since it is only about the **combination** of numbers and not the order.

The equations for permutations and combinations can be derived as follows:
We can depict this little universe <img src="/latex/7314959353237692408.svg" width="14.4" height="16.0" style="margin:0;vertical-align:-0.0px"> containing <img src="/latex/17169281079250121527.svg" width="12.8" height="9.6" style="margin:0;vertical-align:-0.0px"> numbers as

<center><img src="/latex/15486953016151741937.svg" width="112.0" height="20.8"></center>

and the set of <img src="/latex/14358829268891314259.svg" width="9.6" height="14.4" style="margin:0;vertical-align:-0.0px"> drawn numbers as

<center><img src="/latex/700383182315432913.svg" width="134.4" height="20.8"></center>

Since we know that <img src="/latex/17584461032860528710.svg" width="46.4" height="17.6" style="margin:0;vertical-align:-2.611px"> we could split <img src="/latex/7314959353237692408.svg" width="14.4" height="16.0" style="margin:0;vertical-align:-0.0px"> up into <img src="/latex/15788114649771942697.svg" width="19.2" height="17.6" style="margin:0;vertical-align:-2.88px"> and <img src="/latex/11610903023740320290.svg" width="17.6" height="17.6" style="margin:0;vertical-align:-2.88px">,

<center><img src="/latex/8949204946710385079.svg" width="275.2" height="20.8"></center>

and define <img src="/latex/17968388429991569374.svg" width="11.2" height="16.0" style="margin:0;vertical-align:-0.0px"> to be the union of <img src="/latex/6281239148799629866.svg" width="17.6" height="17.6" style="margin:0;vertical-align:-2.88px"> and <img src="/latex/10529997433932184871.svg" width="17.6" height="17.6" style="margin:0;vertical-align:-2.88px"> such that <img src="/latex/834268851905750715.svg" width="108.8" height="20.8" style="margin:0;vertical-align:-4.8px">,

<center><img src="/latex/15017434823975705680.svg" width="288.0" height="20.8"></center>

For the number of permutations, denoted by <img src="/latex/15792774008561035899.svg" width="24.0" height="20.8" style="margin:0;vertical-align:-4.993px">, let us fill <img src="/latex/17968388429991569374.svg" width="11.2" height="16.0" style="margin:0;vertical-align:-0.0px"> by drawing numbers from <img src="/latex/7314959353237692408.svg" width="14.4" height="16.0" style="margin:0;vertical-align:-0.0px">.
Then, observe that to fill <img src="/latex/7143766633495147364.svg" width="14.4" height="12.8" style="margin:0;vertical-align:-2.88px"> we can pick from <img src="/latex/17169281079250121527.svg" width="12.8" height="9.6" style="margin:0;vertical-align:-0.0px"> numbers.
To fill <img src="/latex/8780871231960279958.svg" width="14.4" height="12.8" style="margin:0;vertical-align:-2.88px"> we can pick from <img src="/latex/11061919429115116572.svg" width="43.2" height="14.4" style="margin:0;vertical-align:-1.6px"> numbers.
Continuing this, we can fill <img src="/latex/17968388429991569374.svg" width="11.2" height="16.0" style="margin:0;vertical-align:-0.0px"> in <img src="/latex/4420149610468114684.svg" width="166.4" height="20.8" style="margin:0;vertical-align:-4.8px"> different ways (where the order is important).
However, this was not the original goal.
Instead, we want to fill only <img src="/latex/6281239148799629866.svg" width="17.6" height="17.6" style="margin:0;vertical-align:-2.88px">.
To this end, remove all the possibilities from <img src="/latex/10529997433932184871.svg" width="17.6" height="17.6" style="margin:0;vertical-align:-2.88px">.
Note that <img src="/latex/18067862101583738547.svg" width="64.0" height="20.8" style="margin:0;vertical-align:-4.8px"> and <img src="/latex/11283396531947458233.svg" width="97.6" height="20.8" style="margin:0;vertical-align:-4.8px">.
So, the number of permutations is given by,

<center><img src="/latex/4285968891557604056.svg" width="121.6" height="46.4"></center>

For the number of combinations, denoted by <img src="/latex/5456730186659188416.svg" width="24.0" height="20.8" style="margin:0;vertical-align:-4.993px"> or <img src="/latex/2559919950703108146.svg" width="20.8" height="25.6" style="margin:0;vertical-align:-6.72px">, we expect a smaller number of total possibilities since we ignore different orderings.
This smaller number is simply all the possible orderings for <img src="/latex/6281239148799629866.svg" width="17.6" height="17.6" style="margin:0;vertical-align:-2.88px">, that is, <img src="/latex/10338438448263624252.svg" width="14.4" height="14.4" style="margin:0;vertical-align:-0.0px">.
So, the number of combinations is given by

<center><img src="/latex/1116421237307746676.svg" width="201.6" height="48.0"></center>

