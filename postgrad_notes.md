# PCA/CCA/FA

### PCA 
* eigendecomp of variance matrix.
* reconstructs design matrix to maximize variance reconstructed. 
* Minimizes orthagonal loss (OLS minimizes vertical loss).
* errors are perpendicular to components
* rotation usually skipped

### Factor Analysis
* adds Ψ to WW<sup>T</sup> where Ψ is a diagonal matrix.  
* Ψ captures the variance, so WW<sup>T</sup> can focus on covariance. Thus FA opitmizes for preserving correlation structure.  
* Usually includes rotation
  * without rotation, factors account for variance in descending order, and must be orthagonal. Most items load on early factors.
  * rotation induces simplier structure with less mixed loading.
  * Varimax rotation: orthogonal of the factor axes. maxes variance of loadings<sup>2</sup>  of a factor (column) on all the variables  oblique rotation is more general and preferred (allows non-orthogonal factors). 
  * Quartimax rotation: orthogonal, minimizes the number of factors needed to explain each variable. 
  * promax: oblique rotation
* philosophically intends to identify latent factors, not just low-rank approx
* errors are isomorphic around origin
* Factor analysis splits total variance of the p input variables into two uncorrelated parts: 
  * communality part (m-dimensional, where m common factors rule)
  * uniqueness part (p-dimensional, where errors are, also called unique factors, mutually uncorrelated).
