'''
Created on Oct 8, 2017

@author: Jeet
'''
import pandas as pd
import numpy as np
from sklearn.decomposition import TruncatedSVD

class MBCFRecommender(object):
    
    RECOMMENDATION_COUNT=10;
    def __init__(self):
        '''
            Constructor of the class
        '''
    
    def create(self,data): 
        '''
            This function builds a popularity based recommender model
            to recommend songs based on model base collaborative filtering
            and then saves the model to a data file.
            
            Argument: data
            Returns: None  
        '''    
        ## Create the utility matrix based on users' history which contains
        ## user id and track-name and listen count
        user_history=data.groupby(['userid','track-name'],
                                    as_index=False)['listen-count'].count() 
        
        utility_matrix=user_history.pivot_table(values="listen-count",
                                    index="userid",columns="track-name", fill_value=0);
        
        # Create the list of items
        self.items=utility_matrix.columns;
        # COmpress the utility matrix to 16 latent variables
        SVD=TruncatedSVD(n_components=16)

        ## Fill the null values since SVD does not accept null values
        utility_matrix.fillna(0,inplace=True)

        # Transpose the utility matrix 
        compressed_user_track_matrix=SVD.fit_transform(utility_matrix.T)
        
        # Compute Correlation to find similarity between users
        self.correlation_matrix=np.corrcoef(compressed_user_track_matrix) 
                
    
    def recommend(self,item_feature,playlist_count):
        '''
        The function recommends similar songs for based  
        the current song being played.    
        
        Argument: feature of the item,playlist_count
        
        Returns: list of recommended songs     
            
        '''
        try:
            # Find correlation of this item based on feature
            correlation_vector=self.correlation_matrix[list(self.items).
                                                       index(item_feature)]
        except Exception as e:
            return ""   #Song is not in the database
        
        ## Since the items correlations with value 1 is not that insightful
        ## as it will be highly biased, hence we won't consider them
        
        #extract the indexes of similar items from correlation matrix
        index=(np.round(correlation_vector,5)<1) & (np.round(correlation_vector,5)!=0);
        correlations=correlation_vector[index]
        ## Fetch item names for correlated item
        correlated_items=self.items[index]
        
        recommendations=pd.DataFrame({
                            "Items":correlated_items,"Similarity":correlations}
                            ).sort_values('Similarity',ascending=False
                            ).reset_index(drop=True).head(playlist_count)
                                  
        recommendations=list(recommendations['Items'])
        recommendations = [recommendation.title() for recommendation in recommendations]
        return recommendations
    
    
    