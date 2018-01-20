'''
Created on Oct 8, 2017

@author: Jeet
'''
from song_recommender.ModelBuilder import ModelBuilder

if __name__ == '__main__':
    
    track_recommendation_count=5;
    model_builder=ModelBuilder()
    
    '''
        Build the Popularity Based Recommender
    '''
    pb_model_data_file="models/pb_model.dat";
    model_builder.build_recommender_model(pb_model_data_file,"pb")
    pb_model=model_builder.load_recommender_model(pb_model_data_file)
    
    
    #This song is available only if 30000 rows are sampled
    #recommendations=model.recommend("Mood Indigo")
    pb_recommendations=pb_model.recommend(track_recommendation_count)
    
    
    '''
        Build the Model based Collaborative Filtering Recommender
    '''
    
    mbcf_model_data_file="models/mbcf_model.dat";
    model_builder.build_recommender_model(mbcf_model_data_file,"mbfc")
    mbcf_model=model_builder.load_recommender_model(mbcf_model_data_file)
    
    # Get Recommendation
    
    mbfc_recommendations=mbcf_model.recommend(str.lower("Sun It Rises"),track_recommendation_count)
    
    if mbfc_recommendations=="":
        #get popularity based recommender
        pb_model=model_builder.load_recommender_model(pb_model_data_file)
        mbfc_recommendations=pb_model.recommend(track_recommendation_count);
    print("Popularity Based Recommendation",pb_recommendations)
    print("Model Based Collaborative Filtering Recommendation ",mbfc_recommendations)
