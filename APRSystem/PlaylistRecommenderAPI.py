from flask import Flask, jsonify, request
from song_recommender.ModelBuilder import ModelBuilder

#Create the flask app
app = Flask(__name__)

#To store the loaded model
cache = {}

class PlaylistRecommenderAPI(object):
    
    @staticmethod
    def start_setup():
        ''' 
        This function is invoked when ther server starts and loads the
        recommendation models
                
        Argument: None
        
        Returns: None
        '''  
        pb_model_data_file="models/pb_model.dat"
        mbcf_model_data_file="models/mbcf_model.dat";
        model_builder=ModelBuilder()
        cache["pb_model"]=model_builder.load_recommender_model(pb_model_data_file)
        cache["mbfc_model"]=model_builder.load_recommender_model(mbcf_model_data_file)
        
    
    @staticmethod
    @app.route('/playlist', methods=['POST'])
    def recommend():
        ''' 
        This function is invoked when the the above url pattern is invoked
        recommender model
                
        Argument: None
        
        Returns: recommendations (json)
        '''  
        try:
            #Decode the requests parameters
            request_data_json = request.get_json()
            request_data=request_data_json[0]
            type_of_recommendation=request_data['rcom']
            track_recommendation_count=int(request_data['count'])
            
            #If its model based collaborative filtering
            if type_of_recommendation=="mbcf":
                query_song=str.lower(request_data['qs'])
        
        except Exception as e:
            return(jsonify(result="failure",playlist=""))
        
        #If request is valid i.e contains required parameter
        if type_of_recommendation:
            
            recommendations="";
                            
            #If popularity based recommendation is requested
            if type_of_recommendation=="pb":
                recommendations=cache["pb_model"].recommend(track_recommendation_count)
            else:
                recommendations=cache["mbfc_model"].recommend(query_song,track_recommendation_count)
                   
                '''If no recommendation generated by personalized model
                    then generate based on popularity '''
                
                if recommendations=="":
                    #recommend using popularity based recommender
                    recommendations=cache["pb_model"].recommend(track_recommendation_count)
                
            return(jsonify(result="success",playlist=recommendations))
        else:
            return(jsonify(result="failure",playlist=""))

if __name__ == '__main__':
    #Load the recommendation models before exposing the web service
    PlaylistRecommenderAPI.start_setup();
    app.run()