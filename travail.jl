# ---
# title: 21 jours plus tard
# repository: tpoisot/BIO245-modele
# auteurs:
#    - nom: Bhandari
#      prenom: Snehal
#      matricule: XXXXXXXX
#      github: snehal12b
#    - nom: Fournier
#      prenom: Rosanne
#      matricule: 20332066
#      github: rosannefournier
#    - nom: Lafontaine
#      prenom: Laurianne
#      matricule: XXXXXXXX
#      github: lauriannelafontaine
# ---

# # Introduction 

# Les maladies infectieuses sont l'une des principales menaces pour la santé de la population. Nous l'avons bien observé avec le 
# Covid19, l'isolation et les nombreux décès. De nos jours, les virus deviennent de plus en plus virulent et sont transmis facilement,
# que ça soit par goutelettes, contact ou voyagement. Les virus sont insivibles, donc il peut être difficile de prévenir l'infection.
# En prévention, il y a la vaccination qui permet de se protéger en s'immunisant contre le virus et les tests de détection pour 
# protéger les autres.

# Dans certaines situations épidémiologiques, les individus infectés peuvent demeurer asympotomatiques tout en étant capables de transmettre la maladie.
# Dans ces conditions, l'identification des personnes infectieuses dépend de l'utilisation de tests diagnostiques qui ne sont pas toujours fiables.
# Cette incertitude représente un défi important pour la mise en place d'interventions de santé publique efficaces, puisque la prévalence réelle de la
# maladie ne peut être estimée qu'à partir des résultats de dépistage.

# Pour étudier ces enjeux, nous utilisons un modèle de simulation agent basé qui représente la propagation d'une maladie infectieuse dans une population
# qui est initialement saine. La maladie simulée possède une transmision par contact direct, une durée d'infection fixe et une mortalité complète en absence d'ntervention.
# Un vaccin entièrement efficace est disponible, mais il y a un délai de deux générations après son administration avant que l'immunité ne soit acquise.
# De plus, la gestion de l'épidémie doit être réalisée sous des contraintes budgétaires, où les ressources peuvent être allouées soit au dépistage par
# des tests antigéniques rapides, soit à la vaccination des individu.

# L'objectif de ce travail est donc de développer et d'évaluer une stratégie de vaccination permettant de réduire la mortalité associée à l'épidémie, tout en
# respectant les contraintes biologiques et budgétaires imposées par le modèle. 

# # Présentation du modèle

# Dans cette simulation, nous avons un virus causant la mort après trois semaines d'infection (21 jours), comme observé pour certaines maladie infectieuses très virulentes
# (par exemple, Ebola). La population initiale est complètement saine, et un individu est choisi au hasard pour être infecté au début de la simulation.
# Chaque agent infectieux a une probabilité de transmission de 40% à ses voisins dans la même cellule, ce qui représente un contact direct.

# Les individus infectés sont asymptomatiques, ce qui signifie que l'infection ne peut être détectée qu'à l'aide d'un test antigénique rapide (RAT).
# Ce test présente une précision de 95%, ce qui implique un taux de faux négatifs de 5%. Cette incertitude reflète le fait qu'en réalité, les tests diagnostiques
# ne sont jamais parfaits et que la prévalence réelle de la maladie reste inconnue sans un dépistage systématique.

# Pour prévenir la propagation de l'infection, un vaccin entièrement efficace est disponible. Cependant, son effet protecteur n'apparaît que deux générations après
# son administration, ce qui correspond à un délai biologique pour le développement de l'immunité. La vaccination protège donc contre l'infection, mais aussi la mortalité
# et empêche aussi toute réinfection.

# La simulation intègre des contraintes budgétaires strictes: (1) Chaque dose de vaccin coûte 17$; (2) Chaque test RAT coûte 4$; (3) Le budget total disponible est de 21 000$.
# La stratégie de vaccination doit donc être conçue en tenant compte de la limite financière, en répartissant les ressources entre dépistage et vaccination.

# La simulation prend en compte que l'intervention, donc les tests et vaccinations, ne peut commencer qu'après le décès du premier individu, reflétant ainsi le fait que la
# détection initiale et l'intervention des autorités peuvent être retardées dans une épidémie réelle.


# A AJOUTER : DEPLACEMENT DES INDIVIDUS, STRATEGIE DE VACCINATION (IMPOTANT), ISOLATION DES MALADES VACCINE
#TEST ALEATOIRE CAR ASYMPTOMATIQUE, LATTICE TORUS, QUARENTAINE, ON ARRETE LES RDV QD IL N'AS PLUS DE BUDGET 
# MAXIMUM DE 1% PAR JOUR CAR IL Y A DES CONTRAINTES LOGISTIQUE POUR ACCEUILLIR LES AGENTS EN CLINIQUE 

# # Implémentation

# 1. Durée et suivi de la maladie: Chaque agent infectieux reste malade pendant 21 jours avant de mourir si aucune intervention n'est appliquée.
# La durée de la maladie est suivie dans le modèle par le compteur `clock` de chaque agent. Le décès survient automatiquement lorsque le compteur atteint zéro.

# 2. Déclenchement: Campagne commence après le décès du premier cas.

# 3. Détection des individus infectieux (test RAT): On teste les agents choisis au hasard dans la population saine pour identifier les infectés.
#Les tests coûtent 4$ chacun et détectent 95% des infectés.

# 4. Vaccination: Tous les individus sains détectés après test RAT sont vaccinés. Chaque vaccin coûte 17$ et devient actif après 2 jours . 
# Les agents vaccinés sont marqués dans le modèle (vaccinated=true) et le compteur vaccine_timer suit le délai jusqu'à l'immunité.
# On continue jusqu'à épuisement du budget (tests RAT + vaccins)

# 5. Budget: 21 000$ pour l'ensemble de la campagne. Le code vérifie à chaque test ou vaccinaition que le budget restant est suffisant.
# Chaque test ou vaccination réduit le budget disponible. Quand le budget est épuisé, on arrête les tests et les vaccinations
# mais la simulation continue jusqu'à extinction de l'épidémie.

# 6. Règles de propagation: Individus infectieux sont asymptomatiques et peuvent infecter les voisins avec une probabilité de 40%. Le modèle suit le temps de maladie (clock).
# L'infection ne peut pas survenir chez un agent vacciné après l'activation du vaccin.

# 7. Mise à jour des agents: À chaque génération, les états des agents sont mis à jour: `infectious` pour les agents infectés, `vaccinated` pour les agents vaccinés 
# `vaccine_timer` pour déclencher l'effet du vaccin après 2 générations, et `clock` pour suivre la durée de la maladie et déclencher le décès au bon moment.

# # Code pour le modèle

# ## Packages nécessaires (mettre dans project)

# Pour les graphiques
using CairoMakie            
CairoMakie.activate!(px_per_unit=6.0)
import StatsBase 
using StatsBase
using Random 

# Initialisation de nombre aléatoire       
import Random 
Random.seed!(2045)

# Pour donner un identifiant unique aux agents
import UUIDs
UUIDs.uuid4()

# ## Création des types

# Type d'agents
# Les agents se déplacent dans un environnement en deux dimension représenté par une lattice, 
# et on doit donc suivre leur position et leur état : 
# soit si ils sont vaccinés, et si l'effet protecteur du vaccin est effectif ( soit 2 jours après l'injection)
# et si ils sont infectieux, et dans ce cas, combien de jours il leur reste.

Base.@kwdef mutable struct Agent        ## création de valeurs par défaut pouvant changer pendant la simulation
    x::Int64 = 0
    y::Int64 = 0
    clock::Int64 = 21                   ## nombre de jours avant la mort si infecté (C4)
    infectious::Bool = false            ## Savoir si agent est infectueux 
    vaccin_clock:: Int64 = 2                    ## Nombre de jour avant l'immunité une fois le vaccin administé
    vaccinated::Bool = false            ## savoir si agent immunisé par vaccin (C6)
    id::UUIDs.UUID = UUIDs.uuid4()      ## identifiant unique généré automatiquement
    tested::Bool = false                ## Savoir si agent est testé 
    pending::Bool = false               ## Savoir si l'agent est en attente de l'efficacité du vaccin, et en isolation
end

# Type paysage
# Définit les limites de la grille où les agents se déplacent
# Ici, c'est une grille de -50 à 50 dans les deux directions, donc 100x100 = 10 000 cases au total (C1)
# Les agents se trouvant dans la même cases sont considérés très proches, donc en contact direct 

Base.@kwdef mutable struct Landscape
    xmin::Int64 = -25
    xmax::Int64 = 25
    ymin::Int64 = -25
    ymax::Int64 = 25
end

# Nous allons maintenant créer un paysage de départ:

L = Landscape(xmin=-50, xmax=50, ymin=-50, ymax=50)

# ## Création de nouvelles fonctions

# Création d'agents aléatoires
# On va commencer par générer une fonction pour créer des agents au hasard. Il
# existe une fonction pour faire ceci dans _Julia_: `rand`. Pour que notre code
# soit facile a comprendre, nous allons donc ajouter une méthode à cette
# fonction:

"""
    Random.rand(arg1, arg2, arg3)

 Génère des agents avec des position aléatoires dans le paysage, qui est une lattice dont la dimention se trouve entre x, y min etx, y max

 # Arguments 
 arg1 = Le type d'agent généré
 arg 2: paysage ou les agent sont généré,  qui se trouve dans la lattice L 
 arg 3 : ( facultatif ) nombre d'agents généré

 # Retour
 La fonction retourne un agent ou un tableau d'agent, selon l'argument 3

 # Exemple 
 Cette fonction nous permet donc de générer un nouvel agent dans un paysage:

 rand(Agent, L)

 Mais aussi de générer plusieurs agents:

 rand(Agent, L, 3)

"""
Random.rand(::Type{Agent}, L::Landscape) = Agent(x=rand(L.xmin:L.xmax), y=rand(L.ymin:L.ymax))
Random.rand(::Type{Agent}, L::Landscape, n::Int64) = [rand(Agent, L) for _ in 1:n]

# Fonction du déplacement des agents dans le paysage
# Puisque la position de l'agent va changer, notre fonction se termine par `!`:
# La lattice est  de type torus. Ainsi, si un agent atteint la limite de la lattice, elle réapparait de l'autre côté
# Les déplacements sont aléatoires et peuvent être de -1, 0 ou 1 sur l'axe des x entraîne Y  
"""
    move!(arg1, arg2, arg3)

  Permet le déplacement des aléatoire des agents sur la lattice dans les cases adjacentes 
  chaques jours, ou rester sur place.

 # Arguments 
 arg1 = L'agent qui se déplace
 arg 2: paysage ou les agents se déplacent
 arg 3 : Si la lattice est torridale ou pas ( TRUE or FALSE)

 # Retour
 La fonction retourne l'agent A, avec sa nouvelle position 

"""
function move!(A::Agent, L::Landscape; torus=true)
    A.x += rand(-1:1)
    A.y += rand(-1:1)
    if torus
        A.y = A.y < L.ymin ? L.ymax : A.y
        A.x = A.x < L.xmin ? L.xmax : A.x
        A.y = A.y > L.ymax ? L.ymin : A.y
        A.x = A.x > L.xmax ? L.xmin : A.x
    else
        A.y = A.y < L.ymin ? L.ymin : A.y
        A.x = A.x < L.xmin ? L.xmin : A.x
        A.y = A.y > L.ymax ? L.ymax : A.y
        A.x = A.x > L.xmax ? L.xmax : A.x
    end
    return A
end

# Nous pouvons maintenant définir des fonctions qui vont nous permettre de nous simplifier la rédaction du code

# Vérifier si un agent est infectieux

"""
 isinfectious(arg1)

 Vérifie si L'agent est infecté 

 # Arguments 
 arg1 = un agent

 # Retour
 True si infecté 

"""

isinfectious(agent::Agent) = agent.infectious

# Vérifier si un agent est sain
"""
 ishealthy(arg1)

 Vérifie si L'agent est sain

 # Arguments 
 arg1 =  un agent

 # Retour
 True si sain
 
 """
ishealthy(agent::Agent) = !isinfectious(agent)

# Vérifier si un agent est vacciné

"""
 isvaccinated(arg1)

 Vérifie si L'agent est vacciné

 # Arguments 
 arg1 = un agent

 # Retour
 True si vacciné
 """
isvaccinated(agent::Agent) = agent.vaccinated

vaccinated(pop::Vector{Agent}) = filter(isvaccinated, pop)


# Vérifier si un agent est testé
"""
 istested(arg1)

 Vérifie si L'agent est testé

 # Arguments 
 arg1 = un agent

 # Retour
 True si testé
 """
istested(agent::Agent) = agent.tested

untested(pop::Vector{Agent}) = filter(!istested, pop)
tested(pop::Vector{Agent}) = filter(istested, pop)

# Vérifier si un agent est un attente de l'efficacité du vaccin 
# Après avoir été en contact avec le pathogène dans le vaccin, le corps prend un délais de 2 jours pour développer l'immunnité

"""
 ispending(arg1)

 Vérifie si L'agent est vacciné mais il n'as pas encore l'immunité, car la période de 2 jours n'est pas passée. 
 Cela correspond également à la période d'isolation des agents infectueux qui viennent d'être vaccinés. 

 # Arguments 
 arg1 = un agent

 # Retour
 True si vacciné mais pas encore efficace
 """
ispending(agent::Agent)= agent.vaccin_clock


# On peut maintenant définir une fonction pour prendre uniquement les agents qui
# sont infectieux dans une population. Pour que ce soit clair, nous allons créer
# un _alias_, `Population`, qui voudra dire `Vector{Agent}`:

const Population = Vector{Agent}

# retourne les agents malades

"""
 infectious(arg1)

 Créer un vecteur qui contient la un sous-groupe de la population totale avec tout les individu infectueux

 # Arguments 
 arg1 = la population

 # Retour
 Tout les individus infectueux
 """
infectious(pop::Population) = filter(isinfectious, pop)     

# Retourne les agents sains 

"""
 Healthy(arg1)

 Créer un vecteur qui contient la un sous-groupe de la population totale avec tout les individu sains

 # Arguments 
 arg1 = la population

 # Retour
 Tout les individus sains
 """
healthy(pop::Population) = filter(ishealthy, pop)          

# Retourne les agents non testés, qui seront ceux qui ont des RDV à la clinique 
"""
 untested(arg1)

 Créer un vecteur qui contient la un sous-groupe de la population totale avec tout les individu non-testés

 # Arguments 
 arg1 = la population

 # Retour
 Tout les individus non testés
 """
untested(pop::Population) = filter(!istested, pop)  


# Nous allons enfin écrire une fonction pour trouver l'ensemble des agents d'une
# population qui sont dans la même cellule qu'un agent: retourne les agents qui ont exactement
# les mêmes coordonées que l'agent cible (contatcs potentiels)
# Cela peut permet d'intégré la propagation spatiale de la pandémie en fonciton des contacts directes entre individus, qui sont dans la même case de la lattice

"""
 incell(arg1, arg2 )

 identifie tout les agents d'une populaiton qui sont en contact directs, avec un agent 
 Ils ont en fait les même coordonnés sur la lattice 

 # Arguments 
 arg1 = l'agent dont l'ont veut connaitre les contacts directs
 arg 2 = la population 

 # Retour
 Tout les agents de la population qui sont dans la même case qu'un agent 
 
 """
incell(target::Agent, pop::Population) = filter(ag -> (ag.x, ag.y) == (target.x, target.y), pop)


# ## Gestion vaccins



# Lorsque l'on administre un vaccin, il y a un délais de 2 jours avant que celui-ci devienne efficace.

"""
 administrer_vaccin!(arg1)

 Initie un compte à rebourd de 2 jours ( 2 générations ) lorsqu'un agent devient vacciné ( changement de statut)

 # Arguments 
 arg1 = un agent 

 # Retour
 L'agent obtient le statut de "ispending" et un compte a rebour de 2 jours avant l'immunité est débuté
 
 """
function administrer_vaccin!(agent::Agent)
    agent.vaccin_clock = 2
    return agent
end

# Fonction qui simule les visites à la clinique selon la stratégie de gestion que nous avons adopté 
# Notre stratégie de gestion permet à 1% de la population d'obtenir un rdv en clinique chaques jours, dans le groupe de la population qui n'as pas été testé 
# Lors du rendez-vous, on effectue d'abord un test RAP pour déterminée si la personne est saine ou infecté. 
# La simulation prévoit un taux de faux positif de 5% lors des test RAP
# Si la personne est infecté, on lui administre le vaccin directement et la place en isolation pendant 2 jours 

# Contraines budégtaires 
# Lorsque le budget est dépassé, on ne peut plus tester ou vacciner les agens qui sont présentement dans leur visite à la clinique
# Le budget est vérifier avant les tests et avant les vaccins. Certaines individus de la dernière génération qui a un rdv seront donc testés mais pas vaccinés. 
# Le pourcentage d'individus qui ont un rdv en clinique chaques jours est de 1%. Cela représente la capacité d'acceuil et de gestion limité d'un village avec 3750 habitants


budget_restant = 21000 ## Au départ, le budget restant est le budget total de 21 000$ 
cout_vaccin = 17
cout_rat = 4
pourcent = 0.01 ## pourcentage de la population qui se présente au rdv en clinique chaques jours. 

"""
 RDVclinique(arg1, arg2, arg3, arg4, arg5)

 Simule les visites à la clinique selon la stratégie de gestion adoptée, et vérifie les contraintes budgétaire pour chaques étapes du processus. 

 # Arguments 
 arg1 = la population 
 arg 2 : le budget restant qui se met a jour chaques jours, après chaque test ou vaccination
 arg 3 : le coût d'un test RAT
 arg 4 : le coût d'un vaccin 
 arg 5 : pourcentage de la population qui a un rdv en clinique chaques jours

 # Retour
 Le budget restant après les tests et vaccins de la journée, et le statut des agents qui ont un rdv a changer, selon les résultat des tests. 
 """

function RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)

    ##  vérifie que le budget restant est suffisant pour effectuer les tests des rdv de la journée 
    while budget_restant > 0
        untest = untested(population) ## Objet contenant les agents qui n'ont pas encore été testés ( qui n'ont pas eu de RDV )
        num_to_test = min(length(untest), round(Int, pourcent * length(untest))) 
        ## Fait un objet contentant les rdv de la journée, qui sont un échantillon de 1% de la population qui n'ont jamais été testés. 
    
        ## Vérifie que le budget restant couvre les côuts pour les tests des RDV de la journée 
        if num_to_test * cout_rat > budget_restant
            num_to_test = budget_restant ÷ cout_rat ## si le coût est trop élevé pour tester tout les indivius, tester le maximum possible avec le budget restant 
        end

        ## Mettre à jour le budget restant après le cout des tests du jour 
        budget_restant -= num_to_test * cout_rat

        ## Marque les agents qui ont un rdv comme testés, pour ne pas qu'ils puissent avoir un rdv à nouveau dans les jours suivants. 
        agent_test = shuffle(untest)[1:num_to_test]
        for agent in agent_test
            agent.tested = true
        end

        ## Pour le réalisme des test, inclu 5% de Faux négatifs
        infectueux_detecte = Agent[] # objet avec les agents infectueux détectés ( vide)
        for agent in agent_test
            if agent.infectious && rand() > 0.05  # 95% de chance de détecter un infecté
                push!(infectueux_detecte, agent)
            end
        end

        ## Vaccination des agents testés malade lors du RDV 
        # En raison des faux negatifs, ce ne sont pas  tout les agents infectés qui sont détectés ( 95% de chance de détecter un infectueux)
        num_to_vaccinate = length(infectueux_detecte) ## Nombre d'agents qui ont été testés et qui sont malade. Ce sont ceux qui vont être vacciné le jour même

        ## Vérifier si le budget restant couvre les coût pour vacciné tout les agents qui ont été testés malade lors du RDV  
        if num_to_vaccinate * cout_vaccin > budget_restant
            num_to_vaccinate = budget_restant ÷ cout_vaccin ## si le coût est trop élevé pour vacciner tout les indivius, tester le maximum possible avec le budget restant 
        end

        ## Mettre à jour le budget restant après le cout des vaccins du jour
        budget_restant -= num_to_vaccinate * cout_vaccin

        ## Vacciner les agents qui ont été testés malade lors du RDV, et les mettre en isolation pendant 2 jour 
        ##L'isolation est représenté par le statut "ispending" qui est également la période d'attente de l'efficacité du vaccin 
        for agent in infectueux_detecte[1:num_to_vaccinate]
            if agent.infectious
                administrer_vaccin!(agent) # Applique le vacin et débute le clock de 2 jour avant l'immunité 
                agent.pending = true # statut de l'agent quivient d'être vacciné change pour "pending", ce qui correspond au 2 jour avant l'immunité
            end
        end
    end
    return budget_restant
end
     


# # Initialisation de la simulation

# Paramètes initiaux du modèle
# Population initiale :

function Population(L::Landscape, n::Integer)
    return rand(Agent, L, n)
end

Base.show(io::IO, ::MIME"text/plain", p::Population) = print(io, "Une population avec $(length(p)) agents")

population = Population(L, 3750)      # 3750 étant la taille de la population (C2)


# Choisir au hasard dans la population un infecté (cas index) C5 :

rand(population).infectious = true

# Nous initialisons la simulation au temps 0, et nous allons la laisser se
# dérouler au plus 1000 pas de temps:

tick = 0
maxlength = 2000

# Pour étudier les résultats de la simulation, nous allons stocker la taille de
# populations à chaque pas de temps ( chaques jours):

S = zeros(Int64, maxlength);        # série temporelle sain
I = zeros(Int64, maxlength);        # série temporelle infectieux
V = zeros(Int64, maxlength);

# Événement d'infection : 
# Mais nous allons aussi stocker tous les évènements d'infection qui ont lieu
# pendant la simulation

struct InfectionEvent
    time::Int64
    from::UUIDs.UUID
    to::UUIDs.UUID
    x::Int64
    y::Int64
end

# Liste vide qui va se remplir durant la simulation pour "stocker"

events = InfectionEvent[]

# Notez qu'on a contraint notre vecteur `events` a ne contenir _que_ des valeurs
# du bon type, et que nos `InfectionEvent` sont immutables.

# ## Simulation 

# La boucle tourne tant qu'il y a des infectieux et que le temps max n'est pas atteint

while (length(infectious(population)) != 0) & (tick < maxlength)

    ## On spécifie que nous utilisons les variables définies plus haut
    global tick, population

    tick += 1 # changement dans les décompte de 1 jours à chaques itération

    budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent) # Résultat du budget restant selon ce les rdv de la journée

    ## Mettre a jour le statut des agents qui sont en attente de l'efficacité du vaccin et l'isolation de 2 jours
    ## Lorsque le décompte de " pending" de 2 jour est passé, l'agent change de statut pour "vacciné""
    for agent in Population
        if agent.pending && vaccin_clock != 0
            vaccin_clock -= 1
        elseif agent.pending && vaccin_clock == 0
            agent.vaccinated = true
            agent.pending = false
        end
    end

    ## Mouvement : les agents bougent d'une case
    ## Les agents qui sont en isolation bouge quand même, mais on considère qu'ils ont des mesures sanitaires ( ex : porte un masque)
    for agent in population
        move!(agent, L; torus=false)
    end

    ## Infection : les infectieux ont 40% d'infecter un voisin sain au hasard (C3)
    ## Les agents qui sont en isolation ( en attente de l'efficacité du vaccin) et les personnes vaccinés ne peuvent pas transmettre l'infection. 
    for agent in Random.shuffle(infectious(population))
        neighbors = healthy(incell(agent, population))
        for neighbor in neighbors
            if !neighbor.pending && !neighbor.vaccinated && rand() <= 0.4
                neighbor.infectious = true
                push!(events, InfectionEvent(tick, agent.id, neighbor.id, agent.x, agent.y))
            end
        end
    end

    ## Changement de la survie : -1 jour pour chaque infectieux
    for agent in infectious(population)
        agent.clock -= 1
    end

    ## Enlever les morts : on retire ceux qui n'ont plus de jours
    population = filter(x -> x.clock > 0, population)

    ## Enregistrement dans la série temporelle respective
    S[tick] = length(healthy(population))
    I[tick] = length(infectious(population))
    V[tick] = length(vaccinated(population))

end
# Quand clock = 0 changer le statut pour vacciner
# ## Analyse des résultats

# ### Série temporelle

# Avant toute chose, nous allons couper les séries temporelles au moment de la
# dernière génération:

S = S[1:tick];
I = I[1:tick];

# 

f = Figure()
ax = Axis(f[1, 1]; xlabel="Génération", ylabel="Population")
stairs!(ax, 1:tick, S, label="Susceptibles", color=:black)
stairs!(ax, 1:tick, I, label="Infectieux", color=:red)
axislegend(ax)
current_figure()

# ### Nombre de cas par individu infectieux

# Nous allons ensuite observer la distribution du nombre de cas créés par chaque
# individus. Pour ceci, nous devons prendre le contenu de `events`, et vérifier
# combien de fois chaque individu est représenté dans le champ `from`:

infxn_by_uuid = countmap([event.from for event in events]);

# La commande `countmap` renvoie un dictionnaire, qui associe chaque UUID au
# nombre de fois ou il apparaît:

# Notez que ceci nous indique combien d'individus ont été infectieux au total:

length(infxn_by_uuid)

# Pour savoir combien de fois chaque nombre d'infections apparaît, il faut
# utiliser `countmap` une deuxième fois:

nb_inxfn = countmap(values(infxn_by_uuid))

# On peut maintenant visualiser ces données:

f = Figure()
ax = Axis(f[1, 1]; xlabel="Nombre d'infections", ylabel="Nombre d'agents")
scatterlines!(ax, [get(nb_inxfn, i, 0) for i in Base.OneTo(maximum(keys(nb_inxfn)))], color=:black)
f

# ### Hotspots

# Nous allons enfin nous intéresser à la propagation spatio-temporelle de
# l'épidémie. Pour ceci, nous allons extraire l'information sur le temps et la
# position de chaque infection:

if length(events) > 0
 t = [event.time for event in events];
 pos = [(event.x, event.y) for event in events];
 
 f = Figure()
 ax = Axis(f[1, 1]; aspect=1, backgroundcolor=:grey97)
 hm = scatter!(ax, pos, color=t, colormap=:navia, strokecolor=:black, strokewidth=1, colorrange=(0, tick), markersize=6)
 Colorbar(f[1, 2], hm, label="Time of infection")
 hidedecorations!(ax)
 current_figure()
end 

# # Figures supplémentaires

# Visualisation des infections sur l'axe x

 scatter(t, first.(pos), color=:black, alpha=0.5)

# et y

 scatter(t, last.(pos), color=:black, alpha=0.5)

# Tous les fichiers dans le dossier `code` peuvent être ajoutés au travail final. C'est par exemple utile pour déclarer l'ensemble des fonctions du
# modèle hors du document principal.

# Le contenu des fichiers est inclus avec `include("code/nom_fichier.jl")`.

# Attention! Il faut que le code soit inclus au bon endroit (avant que les fonctions déclarées soient appellées).

include("code/01_test.jl")

# ## Une autre section

# # Présentation des résultats

# # Discussion

# revenir sur éléments de l'intro
# stratégie de vaccination : en effet, efficacité... cohérent avec littérature
# discuter des résultats

# durée totale de l'épidémie, nombre infections, taille pop début vs fin, budget fin. comparer avec sans campagne de vaccination/dépistage?
# modèle stochastique reflète réalité biologique lors de vraie épidémie = vrai hasard cas propagation

# limites : 
# Les individus infectés sont asymptomatique, alors nous pouvons seulement détecté l'infection avec un test de détection antigénique rapide 
# (RAT). Cependant, les tests de détections ne sont pas parfait et ont un 5% de faux négatifs. En effet, il est commun de ne pas 
# avoir de tests 100% efficaces (...article)

# Pour la prévention, il y a des vaccins 100% efficaces, seulement après 2 jours. Ce n'est pas très réaliste de la 
# vraie vie (...article)

# zones géographiques denses vs non (peu d'agents), 

# réplication : durée, infection (moyenne et écart type)
# plusieurs schénarios possibles donc intéressant car vs grosse explosion vs lente
# une personne sur 3750 infecté sur une grille de 10000 cases = peu de prob et plusieurs générations peuvent se passer

# modélisé comme binaire : infecté ou non (pas durée et intensité)
# pas hétérogénéité de contact : ici juste contact vs zone, goutelettes...

# modèle fatale... médecine d'aujourdhui pas vraiment le cas, rare fatale, science progresse

# structure de la population : age, sexe, susceptibilité, comportement adaptatif (siolement volontaire)

# simplification avec déplacement aléatoire sur grille vide (maison, lieu travail, hopital)

# "timing" plus commence tôt...


# On ne considere pas l'immigration et émigration

# Les personne qui sont en " isolation " et ne peuvent pas transmettre l'infection bougent quand même à chaques generation, ce qui enleve du realiste. on peut considrer que'elles utilise des mesures sanitaire(ex : porte un masque )

# Notre vaccin agit plus comme un "antidote" que une maniere de protéger les individus sains

# limite de l'isolation 

# puisque 1% de la population peut avoir un rdv en clinique chaques jours, et on donne des rdv seulement à ceux qui sont
# jamais été testé, il y a donc de moins en moins de personnes qui sont vaccinés et testés par jours mais on peut tester et vacciner plus longtemps. 

# dans une vrai pandémie, il y a beacuoup de cas diagnostiquer au debut car tout le monde devient au courant de la maladie d'un coup et se fait tester 


# On peut aussi citer des références dans le document `references.bib`, qui doit
# être au format BibTeX. Les références peuvent être citées dans le texte avec
# `@` suivi de la clé de citation. Par exemple: @ermentrout1993cellular -- la
# bibliographie sera ajoutée automatiquement à la fin du document.

# Le format de la bibliographie est American Physics Society, et les références
# seront correctement présentées dans ce format. Vous ne devez/pouvez pas éditer
# la bibliographie à la main.

