# OLA-DPSS Overlap-Add windows with Discrete Prolate Spherical Sequences

Requires: Matlab

function vopt = ola_dpss(W, L, T)
DPSS window for overlap-add processing
Input parameters:
  W - bandwidth (typically in the range 4 to 10)
  L - total length of window
  T - length of flat top (default: 0); overlap length is then (L-T)/2.
Output:
  vopt - optimal window

Examples:

w = ola_dpss(4,100);
w = ola_dpss(8,50,10);


## Copyright notice

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.