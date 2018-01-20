'''
Created on Nov 19, 2017

@author: Jeet
'''


import pickle
from song_recommender.DataCleaner import DataCleaner
from song_recommender.MBCFRecommender import MBCFRecommender
from song_recommender.PBRecommender import PBRecommender

class ModelBuilder(object):
    '''
    This class represents the data cleaner which loads the input data 
    and perform the cleaning
    '''
    def build_recommender_model(self,path,recommender_type):
        ''' 
        This function clean and builds a recommender model
        and saves the model to a pickle data file
                
        Argument: path of the file for saving recommender object (string)
                  Type of recommender to build
        
        Returns: None
        '''   
        
        '''
            pb - Popularity Based
            mbfc- model based collaborative filtering 
        '''
        
        #Load the training data-sets
        columns=['userid','timestamp','artist-id','artist-name','track-id','track-name']
        data=DataCleaner.load_tsv_data("data/training/userid-timestamp-artid-artname-traid-traname.tsv",columns)
        #Clean the training data-sets
        data=DataCleaner.clean(data);
        
        # Create the recommendation model as requested
        if recommender_type=="pb":
            recommender_model=PBRecommender();
        else:
            recommender_model=MBCFRecommender();
            
        recommender_model.create(data);
        
        with open(path, 'wb') as datafile:
            pickle.dump(recommender_model, datafile, pickle.HIGHEST_PROTOCOL)
    
    def load_recommender_model(self,path):
        ''' 
        This function reads the pickle data file to load the
        recommender model
                
        Argument: path (String)
        
        Returns: model (Recommender)
        '''      
        
        with open(path, 'rb') as datafile:
            model=pickle.load(datafile)
            
        return model
