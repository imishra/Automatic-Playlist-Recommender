# APRSystem

Below are the environmental setup requirements and steps required to run this application.

# Virtual Environment: 
Create a virtual environment using the below command with environment name as APR and install the below python libraries. Please install Anaconda with python 3.7 to ease the setup process.
conda create -n APR python=3.6 numpy=1.13.3 scipy=1.0.0 matplotlib=2.1.0 pandas=0.21.0 scikit-learn=0.19.1 scipy=0.15.0 flask=0.12.2
# Web Framework: Flask
# Project Root Directory: APRSystem
# Library Required:
1.	pandas (0.21.0)
2.	numpy (1.11.3)
3.	sklearn (0.19.1)
4.	flask (0.12.2)
# Deployment Server: 
No separate production server is required for this application it will run on the default flask server implementation.
# Deployment: 
Just need to run the start-server.bat from the project root directory to start the server and deploy the web service. To stop the server run shutdown-server.bat.
