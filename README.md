CONTEXTUALISATION DU PROJET
 
#Objectif: 

Le défi photo 2021 est un projet développé en collaboration et sous la tutelle de la commission scolaire, d’après ses requêtes.  
Les étudiants du collège de Bois-De-Boulogne ont comme objectif de développer une application visant à faciliter la communication entre des élèves en stage et leur mentors/professeurs.  
Cette application amène des fonctionnalités telles que le partage de photos, de messages et de questions spécifiques visant à évaluer la situation de l’élève au sein de son milieu.  
Notre projet est en lien avec le PFAE, le parcours de formation axée sur l’emploi. Ce programme s’adresse aux jeunes de 15 ans et plus qui ont des difficultés d’apprentissage et qui sentent que le système scolaire ne correspond pas tout à fait à leur besoin. Il leur offre la possibilité de faire des stages auprès d’entreprises variées dans le but d’obtenir un certificat qui leur permettra soit d’accéder au marché du travail, soit de poursuivre leurs études en formation professionnelle ou générale. 
La progression des élèves durant le programme est supervisée et évaluée par des enseignants.
 
#Emploi de l’application : 

Chaque utilisateur se connecte à travers la page de connexion ayant 2 champs à remplir : leur ID et un mot de passe relatif à ce dernier. 
Ils sont ensuite dirigés vers une page d’accueil dans laquelle il y aura une icône de profil pour visionner leur profil, une bulle « d’aide » afin d’aider les utilisateurs dans leur utilisation de l’application et comprendre l’accessibilité des options disponibles, entre-autres l’acronyme MÉTIER.  
Une option de déconnection au haut de la page vers la droite est aussi incluse.  
Pour les étudiants, une option progression sera visible, dans laquelle ces derniers pourront voir leur progression dans chaque lettre de l’acronyme métier ainsi que leur progression totale dans la réponse des questions.
Un bouton «plus d’options» les emmène vers un second menu propre 
à chaque type d’utilisateur.  L’application possède aussi un mode hors ligne accessible aux étudiants.

1.	Étudiants

Le menu propre aux étudiants leur offre deux options. La première est d’accéder à la page de questions auxquelles ils devront répondre. Ces questions fournies par l’enseignant en charge sont divisées selon l’acronyme suivant :
 
L’acronyme « MÉTIER » se définit par les 6 sous-catégories suivantes :

·         M : Matière et produits  
·         É : Équipements  
·         T : Tâches  
·          I : Individu  
·         E : Environnement  
·         R : Ressource humaine  

La deuxième option leur permet d’observer leur progression pour chacune des catégories. Ils pourront ainsi voir plus clairement le travail restant.  L’élève recevra des questions reliées à chacune de ces catégories.


2.	Enseignants


Le menu propre aux enseignants leur offre quatre options. 

La première (1) est de créer des questions pour la catégorie de leur choix.  Ces derniers auront alors à entrer leur question dans une boîte texte prévue à cet effet et cocher la catégorie de la question relative à l’acronyme « MÉTIER ».

La deuxième (2) est pour gérer les questions, c’est-à-dire modifier les questions afin d’avoir plus de précision si voulu, ou de les supprimer.

La troisième leur permet de voir la liste des étudiants dont ils sont en charge ainsi que leur travail (les questions qui leurs ont été posées ainsi que leur réponses ).  Il peut aussi voir le temps depuis laquelle la question a été posée.
Ils peuvent accéder aux profils des étudiants dans lesquels ils pourront recueillir leur nom et prénom, leur ID and leur présent stage.

La quatrième leur permet de créer des comptes pour de nouveaux stagiaires.


3.	Administrateur


Cet utilisateur a accès aux échanges faits entre les étudiants et enseignants, que cela soit pour les questions, photos ou autres.   Il a aussi accès aux profils de ces derniers ainsi que la possibilité de créer de nouveaux utilisateurs (nouveau comptes étudiants,  enseignants,  administrateurs).  Il a accès aux profils de tous les utilisateurs.


#LOGINS : 

Concernant les logins, plusieurs identifiants sont déjà existants :

		ID	MOT DE PASSE

Élève		8521	123123
Enseignant	2396	123123	
Admin		999	123123

 
#ÉCHÉANCIER 
 
 





 
#COMMENT REPRODUIRE LE PROJET?  
 
 
 
 
 
 
 
 
 
 
 
#CLASSES RELATIVES À L’APPLICATION FLUTTER DÉVELOPPÉE 
 
 
•	PageLogin : Elle permet aux utilisateurs de se connecter à l’application. 

 
•	MenuPrincipal : Les utilisateurs sont envoyés à cette page après s’être connecté. 
•	PageAide : Cette page sert à guider les utilisateurs s’ils sont confus à propos des fonctionnalités de l’application.
 
•	MenuEleve : C’est la page dans laquelle l’étudiant arrive après avoir cliqué sur le bouton «plus d’option» situé dans le menu principal. 
 
•	MenuProf : C’est la page dans laquelle l’enseigant arrive après avoir cliqué sur le bouton «plus d’option» situé dans le menu principal. 
 
 
#Différentes fonctionnalités de l’application 
 
•	Connexion automatique: 
•	 Envoi de photos:
 
#IMAGES DU PROJET

Voici une vue de la page de progression de l’étudiant avec l’acronyme « MÉTIER ».  Chaque catégorie a sa propre barre de progression  ainsi que son pourcentage achevé dans la réponse de questions.  Un cercle au bas de la page nous montre notre progression totale sur l’ensemble de nos catégories.


![MicrosoftTeams-image](https://user-images.githubusercontent.com/79108574/118507147-f649a480-b6fb-11eb-8f7f-d4087b87b563.png)






PAGE DE LOGIN

Ici nous pouvons observer la page de login dans laquelle chaque utilisateur devra entrer ses identifiants afin d’avoir accès à son compte.  2 Champs sont visibles, soit l’un étant l’ID de login and l’autre le mot de passe, en lettre cachées.



![MicrosoftTeams-image (1)](https://user-images.githubusercontent.com/79108574/118507166-fb0e5880-b6fb-11eb-9160-fd9b3ba22758.png)








INTERFACE POUR CRÉER UN NOUVEL UTILISATEUR

L’interface pour créer un compte par un administrateur, d’où les cases pour choisir le type d’utilisateur voulu (étudiant, professeur, admin).  On y entre les informations demandées pour ensuite créer un nouvel utilisateur.  À noter que le mot de passe requiert 6 caractères.



![MicrosoftTeams-image (2)](https://user-images.githubusercontent.com/79108574/118507200-02cdfd00-b6fc-11eb-9119-0122febc6f16.png)





INTERFACE POUR CRÉER UNE QUESTION

Le professeur peut créer une question en l’écrivant dans une boite texte et choisir la catégorie relative à sa question au bas de la page.  Le professeur doit choisir au moins 1 destinataire avant d’envoyer sa question.





![CreationQuestion](https://user-images.githubusercontent.com/79108574/118507569-593b3b80-b6fc-11eb-97e9-4be98f9dc9e6.PNG)







INTERFACE D'UN PROFIL ÉTUDIANT

Vue de l’interface du profil d’un étudiant comportant ses informations personnelles, telles que 

-	L’ID
-	Le nom
-	Le prénom
-	L’enseignant auquel il est attribué
-	Le stage auquel il participe


![MicrosoftTeams-image (3)](https://user-images.githubusercontent.com/79108574/118507623-67895780-b6fc-11eb-8fb8-d3d0bdfd090b.png)



INTERFACE POUR LA MODIFICATION  D'UNE QUESTION

Un enseignant a la possibilité de modifier une question pour l’envoyer à ses élèves, ou comme l’indique le bouton rouge, annuler ses changements en cliquant sur « supprimer ».



![ModifierQuestion](https://user-images.githubusercontent.com/79108574/118507634-6bb57500-b6fc-11eb-8040-9b166aa92b61.PNG)




INTERFACE DE LA LISTE D'ÉTUDIANTS

Vue de l’enseignant sur la liste d’élèves sous
son aile.  En cliquant sur chaque élève, 
  l’enseignant peut accéder à leurs profils
         respectifs.



![MicrosoftTeams-image (4)](https://user-images.githubusercontent.com/79108574/118507670-73751980-b6fc-11eb-9a3d-92f335b74763.png)




INTERFACE DU MENU D'AIDE RELATIF À CHAQUE UTILISATEUR
	
Depuis le menu principal pour chaque utilisateur, l’option aide est offerte et mène à cet interface dans le but d’expliquer l’acronyme « MÉTIER ».  L’autre onglet de fonctionnement explique à l’utilisateur le fonctionnement de l’application.



![MicrosoftTeams-image (5)](https://user-images.githubusercontent.com/79108574/118507683-75d77380-b6fc-11eb-8d33-f3b909303b8b.png)




