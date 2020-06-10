# Mapping traces of ketamine in the mesocorticolimbic circuit


This project deals with a new analysis of functional connectivity in resting-state fMRI data in a pharmacological drug study.
In state-of-the-art functional connectivity studies signal measured in voxels are averaged across pre-defined regions
leading to a loss of information. The goal of this analysis is to harness more information by using high-dimensional
voxel-to-voxel functional connectivity data and reducing its dimensionality with state-of-the-art dimensionality reduction
algorithm [UMAP](https://arxiv.org/abs/1802.03426).


___

### The repository includes scripts for the following analysis:

- Calculating Pearson's correlation distance from voxel-to-voxel functional connectivity measures
- Uniform Manifold Approximation Projection (UMAP) dimensionality reduction
- HDBScan (density based) clustering
- Centroid analysis for region-of-interest membership
- Bootstrap for centroid analyses to compare drug vs. placebo
- Regression analysis with elastic net regularization

#### UMAP dimensionality reduction visualizations

![Caption for the picture.](/Plots/Baseline_Ket.png)
