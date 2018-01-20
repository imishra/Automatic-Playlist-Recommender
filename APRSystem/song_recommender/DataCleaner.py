'''
Created on Oct 8, 2017

@author: Jeet
'''
import re
import pandas as pd
class DataCleaner(object):
    '''
    This class represents the data cleaner which loads the input data 
    and perform the cleaning
    '''
    @classmethod
    def load_csv_data(self,filename,columns=None):  
        ''' 
        This function reads csv data from the given file  return the data in
        pandas DataFrame.
    
        Argument: filename (string)
                : number of header rows(int)
        Returns: DataFrame
        '''        
        if(columns==None):
            data=pd.read_csv(filename,error_bad_lines=False)
        else:
            data=pd.read_csv(filename,error_bad_lines=False,names=columns)
        return data
    
    @classmethod
    def load_tsv_data(self,filename,columns=None):  
        ''' 
        This function reads tsv data from the given file  return the data in
        pandas DataFrame.
    
        Argument: filename (string)
                : number of header rows(int)
        Returns: DataFrame
        '''        
        if(columns==None):
            data=pd.read_csv(filename,error_bad_lines=False,sep="\t")
        else:
            data=pd.read_csv(filename,error_bad_lines=False,names=columns,sep="\t")
        
        return data
    
    @classmethod
    def clean(self,data):
        ''' 
        This function perform the cleaning on the data by selecting 
        required column which was decided after a detailed data analysis
            
        Argument: data (DataFrame)
        Returns: subset of the data (DataFrame)
        '''
        
        
        '''
        During the analysis we found there were few null values in the track-name
        hence will drop those rows and insert the listen count column to the dataset
        '''
        data=data[~data['track-name'].isnull()]
        data.insert(data.shape[1],'listen-count',1)
        
        '''
        Since the data-set contains data for 1 million songs which is not 
        feasible to be processed on the computer resource we have hence we 
        are considering the subset of the data set with only 30000 songs
        '''
        songs_list=data['track-name'].unique()
        songs_list=list(songs_list[0:30000])
        
        data=data[data['track-name'].isin(songs_list)]   
        
        
        '''
        The data contains some track names which are not from English alphabet
        so we will drop those tracks from the track data-set.
        '''
        data=data[data.apply(DataCleaner.isValid,axis=1)]
        data['track-name']=data['track-name'].apply(str.lower)
        return data
    @classmethod
    def containsAlpha(self,text):  
        ''' 
        This function checks if a string contains a letter from English alphabet 
    
        Argument: text (string)
        Returns: Boolean
        ''' 
        
        if re.search('[a-zA-Z]', text):
            return True
        else:
            return False
    
    @classmethod
    def isNotUntitled(self,text):
        ''' 
        This function checks if a string contains untitled label
    
        Argument: text (string)
        Returns: Boolean
        '''
        if 'untitled' not in str.lower(text):
            return True
        else:
            return False
        
    @classmethod
    def isValid(self,record):
        ''' 
        This function checks if a track of the user history contains any 
        character which is not from English alphabet and contains at least 
        a single English alphabet character and should not contains the 
        Untitled label.
    
        Argument: record (Pandas Series)
        Returns: Boolean
        '''     
        track_name=record['track-name']
        try:
            track_name.encode(encoding='utf-8').decode('ascii')
        except UnicodeDecodeError:
            return False
        else:
            if DataCleaner.containsAlpha(track_name) and  DataCleaner.isNotUntitled(track_name):
                return True
            else:
                return False