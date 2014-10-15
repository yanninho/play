Exemple d'utilisation pour play framework : 

sudo docker run -d --name play --link [ some-mysql ]:mysql -P -v [ local project folder ]:/opt/workspace yanninho/play:2.1.0 play [ clean | run | compile] 



