'''
Created on Oct 8, 2017

@author: Jeet
'''
import pandas as pd
import numpy as np
from sklearn.decomposition import TruncatedSVD

class PBRecommender(object):
    
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
        ''' Create a Song listen count table which contains the track-name and the number of times
        the song has been listen to and sort them using as per the listen count '''
        
        self.track_listen_count=data.groupby(['track-name'],as_index=False)['listen-count'].count()
        self.track_listen_count=self.track_listen_count.sort_values('listen-count',ascending=False).reset_index(drop=True)        
    
    def recommend(self,playlist_count):
        '''
        The function recommends most popular songs
        based on the songs listen count    
        
        Argument: playlist_count 
        
        Returns: list of recommended songs    
            
        '''
        recommendations=list(self.track_listen_count['track-name'].
                             head(playlist_count))
        recommendations = [recommendation.title() for recommendation in recommendations]
        
        return recommendations;
    
    
    