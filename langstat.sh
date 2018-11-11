#!/bin/bash

#On récupere le dernier parametre dans la variable param
for i in $@
do
	param=$i
done

#On teste si le nombre de parametre est different de 0
if [ $# -ne 0 ]
	then
		if [ -f $param ]
			then 
				#On parcours l'alphabet
				for lettre in {A..Z}
					do
						#On compte le nombre de ligne contenant la lettre dans le fichier
    					nbLettre=$(grep -c "$lettre" $param) 

    					#On ajoute dans un nouveau fichier nbLettre.txt la variable nbLettre qui contient 
    					#le nombre de ligne puis on ajoute la lettre
    					echo "$nbLettre - $lettre" >> nbLettre.txt
    				done

				if [ $# -eq 1 ]
					then
						echo
						echo "Nombre de mot contenant la lettre : "
						echo
    					#On trie du plus grand au plus petit 
    					sort -rn nbLettre.txt

    					echo

					else
						if [ $# -eq 2 ]
							then
								if [ $1 = "-p" ]
									then

    									#On trie du plus grand au plus petit 
										sort -rn nbLettre.txt >> resultat.txt

										#on recupere le nombre de mots et la lettre correspondante dans le fichier
										cut -d "-" -f 1 resultat.txt >> nombre.txt

										cut -d "-" -f 2 resultat.txt >> lettre.txt

										#On compte le nombre de mots dans le fichier dico.txt

										nombreTotal=$(wc -w dico.txt | cut -d " " -f 1)

										#Affichage
										echo 
										echo "Fréquence de présence d'une lettre dans un mot :"
										echo

										for i in {1..26}
										do
											#On récupere chaque nombre
											nb=$(head -$i nombre.txt | tail -1 )

											#On récupere la lettre correspondante
											lettre=$(head -$i lettre.txt | tail -1)

											#On calcule le pourcentage
											let "pourcent = (nb*100)/nombreTotal"

											#On affiche
											if [ $pourcent -eq 0 ]
												then 
													echo "< 1% - $lettre"
												else
													echo "$pourcent % - $lettre" 
											fi

										done

										echo

										#On supprime les fichiers
										rm nombre.txt
										rm resultat.txt
										rm lettre.txt

									else
										#On affiche un message d'erreur si l'option n'est pas correcte
										echo "Option $1 inconnue"
										echo "Option possible: -p = Résultat en pourcentage"
								fi
							else
								#On affiche un message d'erreur si le nombre de parametre est trop important
								echo "Vous avez entré trop de paramètre"
						fi
				fi
				rm nbLettre.txt
			else
				#On affiche un message d'erreur si le fichier n'existe pas
				echo "Le fichier $param n'existe pas"
				echo "Veuillez indiquer le fichier en dernier paramètre"	 
		fi
	else
		#On affiche un message d'erreur si la commande ne contient pas de parametre
		echo "Merci d'indiquer un fichier texte en paramètre "
fi
