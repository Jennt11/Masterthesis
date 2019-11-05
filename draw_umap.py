#-------------------------------------------------------------------------------
# Name:        draw_umap
# Purpose:     umap fitting and subsequent plotting of the embedding
#
# Author:      Jennifer Them
#
# Created:     04.11.2019
# Copyright:   (c) Them 2019

#-------------------------------------------------------------------------------
import matplotlib.pyplot as plt
import umap


def draw_umap(data, neighbors, components, dist, u_metric):
    embedding = umap.UMAP(
        n_neighbors=neighbors,
        n_components=components,
        min_dist=dist,
        metric=u_metric
    ).fit_transform(data)
    
    
    if components<3:
        plt.scatter(embedding[:, 0], embedding[:, 1], s=0.1, cmap='Spectral');
        plt.title('UMAP Projection', fontsize=18);
    elif components ==3:
        fig = plt.figure(figsize = [10,8])
        ax = fig.add_subplot(111, projection='3d')
        ax.scatter(embedding[:,0], embedding[:,1], embedding[:,2], s=0.5)
        plt.title('UMAP Projection', fontsize=18)
        
    
    
    return embedding