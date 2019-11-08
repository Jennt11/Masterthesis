#-------------------------------------------------------------------------------
# Name:        draw_hdbscan
# Purpose:     hdbscan clustering and subsequent plotting
#
# Author:      Jennifer Them
#
# Created:     04.11.2019
# Copyright:   (c) Them 2019

#-------------------------------------------------------------------------------
import numpy as np
import hdbscan
import matplotlib.pyplot as plt


# dimension: dimension of the data
def draw_umap(data, min_sample, min_size_clu, cluster_method, dimension):
    labels = hdbscan.HDBSCAN(
    min_samples=min_sample,
    min_cluster_size=min_size_clu,
    cluster_selection_method=cluster_method).fit_predict(data)
    
    
    if dimension<3:
        clustered = (labels >= 0)
        plt.scatter(data[~clustered, 0],
            data[~clustered, 1],
            c=(0.5, 0.5, 0.5),
            s=0.1,
            alpha=0.5)
        plt.scatter(data[clustered, 0],
            data[clustered, 1],
            c=labels[clustered],
            s=0.1,
            cmap='Spectral');
    elif dimension ==3:
        clustered = (labels >= 0)
        fig = plt.figure(figsize = [10,8])
        ax = fig.add_subplot(111, projection='3d')
        ax.scatter(data[~clustered, 0], data[~clustered, 1], data[~clustered, 2],s=0.5, c=(0.5, 0.5, 0.5),alpha=0.5)

        ax.scatter(data[clustered, 0],data[clustered, 1],data[clustered, 2],
           c=labels[clustered],
           s=0.1,
           cmap='Spectral')
        plt.title('Clustering', fontsize=18)
        
    
    percent_clustered = (np.sum(clustered) / data.shape[0]) * 100
    print(percent_clustered + "% of your data was clustered")
    
    return labels