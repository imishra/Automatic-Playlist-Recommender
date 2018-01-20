# Create the Users table which contains the user basic details
create table APR.Users(
   user_name VARCHAR(30) NOT NULL,
   email VARCHAR(100) NOT NULL,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   sex CHAR NOT NULL,
   street_address VARCHAR(40) NOT NULL,
   city	VARCHAR(40) NOT NULL,
   country VARCHAR(40) NOT NULL,
   PRIMARY KEY (user_name)
);

# Create the credentials table which contains the user credentails
create table APR.Credentials(
   user_name VARCHAR(30) NOT NULL,
   password VARCHAR(100) NOT NULL,
   PRIMARY KEY (user_name),
   FOREIGN KEY (user_name) REFERENCES Users(user_name)
);

# Create the user_info table which contains the user data given in the input dataset
create table APR.user_info(
   id VARCHAR(30) NOT NULL,
   gender VARCHAR(100) NOT NULL,
   age  INT(10) NOT NULL,
   country VARCHAR(100) NOT NULL,
   registered datetime,
   PRIMARY KEY (id)
);



#insert user in Users table
insert into APR.Users
values
("imishra","imishra@uncc.com","Jeet","Mishra","M","9613 Grove Crest Lane","Charlotte", "United States");

#insert user in Users table
insert into APR.Credentials
values("imishra","e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");

#Load the input datasets
LOAD DATA LOCAL INFILE 'E:/Workspace/Python/IPython/user_listening_history.csv' INTO TABLE APR.user_history FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'E:/Workspace/Python/IPython/user_details.csv' INTO TABLE APR.user_info FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

#Update the  username of the dataset to match a current user to get the recommendation
update APR.user_history set user_name="imishra" where user_name="user_000001";
