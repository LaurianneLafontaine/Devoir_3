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

# Les maladies infectieuses sont l'une des principales menaces pour la santé
# publique mondiale . Malgré les progrès significatifs des systèmes de santé,
# des infections comme la Covid-19 ont montré à quel point ces maladies peuvent
# se propager rapidement, entraîner l'isolement social et provoquer de nombreux décès.
# (@cascella2026covid) La transmission de virus par goutelettes, contacte direct ou voyage
# facilite leur propagation dans une population, et leur nature invisible rend la précention
# difficile sans interventions ciblées. La vaccination est l'une des mesures les plus efficaces
# pour réduire les risques d'infection et protéger la population. En effet, elle a permis
# d'éviter plusieurs millions de décès chaque année grâce à la prévention de maladies graves
# comme la rougeole, le tétanos ou le polio (@ginglen2026immunization).

# Dans certaines situations épidémiologiques, les individus infectés peuvent
# demeurer asympotomatiques tout en étant capables de transmettre la maladie.
# Cette transmission silencieuse complique l'identification des cas infectieux
# et limite l'efficacité des approches reposant uniquement sur les symptômes.
# Les modèles épidémiologiques qui impliquent des individus asymptomatiques 
# montrent que ces derniers jouent un rôle clé dans la dynamique de propagation
# et doivent être pris en compte dans les stratégies de contrôle (@kuddus2025modelling).

# Dans ce contexte, le dépistage devient un outil essentiel pour détecter les individus infectieux.
# Toutefois, les tests diagnostiques présentent des limites de sensibilité, ce qui introduit
# une incertitude dans l'estimation de la prévalence réelle et dans la prise de décision en
# santé publique. Parallèlement, la vaccination demeure une intervention majeure pour réduire
# la transmission et la mortalité, en particulier lorsqu'elle est utilisée de manière
# ciblée et optimisée (@yakob2025age).

# Afin d'évaluer l'efficacité de différentes stratégies d'intervention, les modèles de
# simulation, notamment ls modèles agents, sont largement utilisés por reproduire la propagation
# des maladies infectieuses et teste l'impact combiné du dépistage, de l'isolement et de la vaccination.
# Ces approches permettent d'explorer différentes allocations de ressources et d'identifier des stratégies
# optimales de contrôle (@stephenson2020comparing).

# Dans ce travail, nous utilisons un modèle de simulation basé sur les agents
# pour représenter la propagation d'une maladie infectieuse dans une population qui
# est initialement saine. La maladie simulée possède une transmision par contact
# direct, une durée d'infection fixe et entraîne une mortalité complète en absence
# d'ntervention. Un vaccin entièrement efficace est disponible, mais il y a un
# délai de deux générations (jours) après son administration avant que l'immunité ne
# soit acquise. De plus, la gestion de l'épidémie doit être réalisée sous des
# contraintes budgétaires, où les ressources peuvent être allouées soit au
# dépistage par des tests antigéniques rapides, soit à la vaccination des individus.

# L'objectif de ce travail est donc de développer et d'évaluer une stratégie de
# vaccination permettant de réduire la mortalité associée à l'épidémie, tout en
# respectant les contraintes biologiques et budgétaires imposées par le modèle. 

# # Présentation du modèle

# La simulation modélise la propagation d’une maladie infectieuse très virulente, similaire à Ebola, causant la mort 21 jours après l’infection.
# La population initiale est entièrement naïve (ne possède aucune immunité) composée de 3750 individus, répartis aléatoirement sur une lattice
# bidimensionnelle de -50 à 50 sur chaque axe. Un individu est choisi au hasard pour être infecté au début de la simulation, représentant le premier cas.
# Les agents (individus) se déplacent quotidiennement sur la lattice configurée en torus, de sorte que ceux qui atteignent les bords réapparaissent de l’autre côté.
# Les individus infectieux ont une probabilité de 0,4 de transmettre l’infection à leurs voisins dans la même cellule, représentant le contact direct dans la même
# case de la lattice.Les individus infectieux sont asymptomatiques et ne peuvent être détectés qu’à partir d’un test antigénique rapide (RAT). Ce test possède une
# précision de 95 %, ce qui implique un taux de faux négatifs de 5 %, et il ne permet pas de connaître depuis combien de temps un individu est infectieux.
# La prévalence réelle de la maladie ne peut donc être estimée que par des tests. Chaque jour, un maximum de 1 % des individus non testés est sélectionné pour un
# rendez-vous (RDV) à la clinique, pour tenir compte des contraintes logistiques d’accueil. Les rendez-vous sont interrompus dès que le budget total de 21 000 $
# est épuisé, avec un coût de 4 $ par test et 17 $ par dose de vaccin. Le modèle intègre une stratégie de vaccination ciblée, d'abord, les individus testés positifs
# au RAT sont immédiatement vaccinés si le budget le permet. Ensuite, la vaccination déclenche une période transitoire de 2 générations, durant laquelle les agents
# sont considérés en quarantaine/isolation pour réduire leur contribution à la transmission. Après cette période, les individus deviennent complètement immunisés,
# protégés contre l’infection, la transmission et la mortalité. Cette approche permet d’évaluer l’efficacité de la campagne de vaccination en comparant la mortalité
# totale avec intervention à celle observée en absence de contrôle, ainsi que le coût total des tests et vaccinations.

# # Stratégie de vaccination

# La stratégie de vaccination adoptée repose sur une approche ciblée combinant dépistage actif et intervention rapide, tout en respectant les contraintes budgétaires 
# et opérationnelles imposées par le modèle. Puisque les individus infectieux sont asymptomatiques et que la prévalence réelle de la maladie ne peut être connue sans 
# dépistage, une clinique simulée reçoit quotidiennement un nombre limité d’individus correspondant à 1 % de la population non testée. Cette sélection aléatoire vise
# à reproduire une capacité de santé publique réaliste où les ressources diagnostiques sont limitées, tout en permettant une estimation indirecte de la circulation de
# l’infection dans la population. Lors de leur visite, les individus sont d’abord soumis à un test antigénique rapide (RAT), possédant une sensibilité de 95 %.
# Les individus détectés comme infectieux sont immédiatement vaccinés si le budget disponible le permet. La vaccination déclenche une période transitoire de deux
# générations durant laquelle les agents sont considérés en attente d’immunité et placés en isolation fonctionnelle, réduisant ainsi leur contribution à la transmission
# pendant que la protection vaccinale s’établit. Une fois que ce délai soit écoulé, les individus deviennent complètement immunisés. Ainsi, ils ne peuvent plus être
# infectés, transmettre la maladie ni mourir de l’infection. Cette stratégie vise à interrompre précocement les chaînes de transmission en identifiant et immunisant
# prioritairement les individus déjà infectieux plutôt qu’en vaccinant massivement la population au hasard. Le choix d’allouer les ressources d’abord au dépistage
# permet d’optimiser l’utilisation du budget disponible en dirigeant les doses vaccinales vers les individus ayant la plus forte probabilité de propager l’épidémie.
# L’efficacité de la campagne est ensuite évaluée en comparant la mortalité totale obtenue avec l'intervention à celle observée en absence de contrôle, tout en
# considérant le coût total engagé pour les tests et la vaccination.

# A AJOUTER : DEPLACEMENT DES INDIVIDUS, STRATEGIE DE VACCINATION (IMPOTANT),
#ISOLATION DES MALADES VACCINE TEST ALEATOIRE CAR ASYMPTOMATIQUE, LATTICE TORUS,
# QUARENTAINE, ON ARRETE LES RDV QD IL N'AS PLUS DE BUDGET MAXIMUM DE 1% PAR
# JOUR CAR IL Y A DES CONTRAINTES LOGISTIQUE POUR ACCEUILLIR LES AGENTS EN
# CLINIQUE 

# # Implémentation

# La simulation a été réalisée en utilisant un modèle agent basé, où chaque agent représente un individu de la population. La population initiale de 3750 individus est 
# répartie sur une lattice bidimensionnelle configurée en torus, ce qui permet aux agents de se déplacer continuellement sans rencontrer de bords. Chaque agent possède
# des attributs décrivant son état de santé, son statut vaccinal et le temps depuis infection ou vaccination. La boucle principale de la simulation est exécutée génération
# par génération. À chaque pas :

# 1. Les agents se déplacent aléatoirement sur la lattice.

# 2. Les interactions locales sont évaluées, donc chaque agent infectieux a une probabilité de 0,4 de transmettre la maladie à ses voisins immédiats.

# 3. Le dépistage est effectué selon la capacité clinique maximale (1 % des individus non testés par jour), en respectant le budget restant. Les agents sélectionnés passent
# le test antigénique rapide (RAT), et les résultats sont simulés avec une précision de 95 %.

# 4. Les agents testés positifs sont vaccinés si le budget le permet, et entrent en quarantaine fonctionnelle pendant la période transitoire de 2 générations.

# 5. Les statistiques sont mises à jour à chaque génération : nombre d’infections, de décès, de vaccinations, tests effectués, et coût cumulé.

# La simulation s’arrête soit lorsque tous les agents ont été infectés ou immunisés, soit lorsque le budget est épuisé. Les résultats finaux sont collectés pour comparer
# la mortalité avec et sans intervention, et pour évaluer l’efficacité et le coût total de la campagne de vaccination.
# # Code pour le modèle

# ## Packages nécessaires (mettre dans project)

# Pour les graphiques

using CairoMakie
CairoMakie.activate!(px_per_unit=6.0)
using StatsBase
using Random

# Initialisation de nombre aléatoire       

#Random.seed!(2045)

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
    vaccin_clock::Int64 = 2            ## Nombre de jour avant l'immunité une fois le vaccin administé
    vaccinated::Bool = false            ## savoir si agent immunisé par vaccin (C6)
    id::UUIDs.UUID = UUIDs.uuid4()      ## identifiant unique généré automatiquement
    tested::Bool = false                ## Savoir si agent est testé 
    pending::Bool = false               ## Savoir si l'agent est en attente de l'efficacité du vaccin, et en isolation
end

# Type paysage

# Définit les limites de la grille où les agents se déplacent Ici, c'est une
# grille de -50 à 50 dans les deux directions, donc 100x100 = 10 000 cases au
# total (C1) Les agents se trouvant dans la même cases sont considérés très
# proches, donc en contact direct 

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

## Arguments 
arg1 : Le type d'agent généré
arg 2: paysage ou les agent sont généré,  qui se trouve dans la lattice L 
arg 3 : ( facultatif ) nombre d'agents généré

## Retour
La fonction retourne un agent ou un tableau d'agent, selon l'argument 3

## Exemple 
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

## Arguments 
arg1 : L'agent qui se déplace
arg 2: paysage ou les agents se déplacent
arg 3 : Si la lattice est torridale ou pas ( TRUE or FALSE)

## Retour
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

## Arguments 
arg1 : un agent

## Retour
True si infecté 
"""

isinfectious(agent::Agent) = agent.infectious

# Vérifier si un agent est sain
"""
 ishealthy(arg1)

 Vérifie si L'agent est sain

## Arguments 
 arg1 L: un agent

## Retour
 True si sain
 
 """
ishealthy(agent::Agent) = !isinfectious(agent)

# Vérifier si un agent est vacciné

"""
 isvaccinated(arg1)

 Vérifie si L'agent est vacciné

## Arguments 
 arg1 : un agent

## Retour
 True si vacciné
 """
isvaccinated(agent::Agent) = agent.vaccinated ## État vacciné
vaccinated(pop::Vector{Agent}) = filter(isvaccinated, pop) ## Sous - groupe de la population qui est vacciné

# Vérifier si un agent est testé
"""
 istested(arg1)

 Vérifie si L'agent est testé

## Arguments 
 arg1 : un agent

## Retour
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

## Arguments 
 arg1 : un agent

## Retour
 True si vacciné mais pas encore efficace
 """
ispending(agent::Agent) = agent.vaccin_clock


# On peut maintenant définir une fonction pour prendre uniquement les agents qui
# sont infectieux dans une population. Pour que ce soit clair, nous allons créer
# un _alias_, `Population`, qui voudra dire `Vector{Agent}`:

const Population = Vector{Agent}

## Retourne les agents malades

"""
 infectious(arg1)

 Créer un vecteur qui contient la un sous-groupe de la population totale avec tout les individu infectueux

## Arguments 
 arg1 : la population

## Retour
 Tout les individus infectueux
 """
infectious(pop::Population) = filter(isinfectious, pop)

## Retourne les agents sains 

"""
 Healthy(arg1)

 Créer un vecteur qui contient la un sous-groupe de la population totale avec tout les individu sains

## Arguments 
 arg1 : la population

## Retour
 Tout les individus sains
 """
healthy(pop::Population) = filter(ishealthy, pop)

## Retourne les agents non testés, qui seront ceux qui ont des RDV à la clinique 
"""
 untested(arg1)

 Créer un vecteur qui contient la un sous-groupe de la population totale avec tout les individu non-testés

## Arguments 
 arg1 : la population

## Retour
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

## Arguments 
 arg1 : l'agent dont l'ont veut connaitre les contacts directs
 arg 2 : la population 

## Retour
 Tout les agents de la population qui sont dans la même case qu'un agent 
 
 """
incell(target::Agent, pop::Population) = filter(ag -> (ag.x, ag.y) == (target.x, target.y), pop)


# ## Gestion vaccins


# Lorsque l'on administre un vaccin, il y a un délais de 2 jours avant que celui-ci devienne efficace.

"""
 administrer_vaccin!(arg1)

 Initie un compte à rebourd de 2 jours ( 2 générations ) lorsqu'un agent devient vacciné ( changement de statut)

## Arguments 
 arg1 : un agent 

## Retour
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
cout_vaccin = 17 ## Cout du vaccin
cout_rat = 4 ## Cout du test RAT 
pourcent = 0.01 ## pourcentage de la population qui se présente au rdv en clinique chaques jours. 

"""
 RDVclinique(arg1, arg2, arg3, arg4, arg5)

 Simule les visites à la clinique selon la stratégie de gestion adoptée, et vérifie les contraintes budgétaire pour chaques étapes du processus. 

## Arguments 
 arg1 : la population 
 arg 2 : le budget restant qui se met a jour chaques jours, après chaque test ou vaccination
 arg 3 : le coût d'un test RAT
 arg 4 : le coût d'un vaccin 
 arg 5 : pourcentage de la population qui a un rdv en clinique chaques jours

## Retour
 Le budget restant après les tests et vaccins de la journée, et le statut des agents qui ont un rdv a changer, selon les résultat des tests. 
"""
function RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)

    ##  vérifie que le budget restant est suffisant pour effectuer les tests des rdv de la journée 
    if budget_restant > 0
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
        ## En raison des faux negatifs, ce ne sont pas  tout les agents infectés qui sont détectés ( 95% de chance de détecter un infectueux)
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
                administrer_vaccin!(agent) ## Applique le vacin et débute le clock de 2 jour avant l'immunité 
                agent.pending = true ## statut de l'agent quivient d'être vacciné change pour "pending", ce qui correspond au 2 jour avant l'immunité
            end
        end
    end
    return budget_restant
end



# # Initialisation de la simulation

# Paramètes initiaux du modèle
# Population initiale :

"""
 Population(arg1, arg2)

 Génère la populaition unitiale d'agent dans le paysage 

## Arguments 
 arg1 :  Le paysage, donc la lattice 
 arg 2 : Nombre d'agents souhaité dans la population

## Retour
Retourne une population avec un nombre d'agent distribués aléatoirement dans le paysage  

"""
function Population(L::Landscape, n::Integer)
    return rand(Agent, L, n)
end

# Afficher les informations sur la population initiale 

Base.show(io::IO, ::MIME"text/plain", p::Population) = print(io, "Une population avec $(length(p)) agents")

# Taille de la population à l'origine de la simulation, c'est-à-dire lorsqu'il y a le premier décès.

population = Population(L, 3750)      ## 3750 étant la taille de la population (C2)


# Choisir au hasard dans la population un infecté (cas index) C5 :

rand(population).infectious = true

# Nous initialisons la simulation au temps 0, et nous allons la laisser se
# dérouler au plus 2000 pas de temps:

tick = 0
maxlength = 2000


# Objet pour stocker le nombre de morts à chaques générations 
morts = zeros(Int64, maxlength) 



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

# La boucle tourne tant qu'il y a des infectieux et que le temps max n'est pas atteint. 
# Lorsqu'il n'y a plus de budget, les efforts de de gestion cesse, mais la contamination peut continuer jusqu'a 2000 générations 
# L'argument mont clé vaccination permet de faire la simulaiton avec ou sans vaccination  
# On fait la simulation 4 fois et stock les résultats du nombre de morts 

resultat_morts = Vector{Vector{Int64}}()

for _ in 1:4

    ## Paramètres initiaux de la simulation
    population = Population(L, 3750) ## population initiale de 3750 individus sur le paysage
    rand(population).infectious=true ## un agent choisit au hasard pour être malade
    tick=0 ## temps remis a 0
    budget_restant=21000 ## budget remis a 21000$
    morts = zeros(Int64, maxlength) ## objet pour stocker le nombre de morts 
   

  # Objets pour stocker les séries temporelles de la simulation

   S = zeros(Int64, maxlength); ## Série temporelle des agents sains
   I = zeros(Int64, maxlength); ## Série temporelle des agents infectieux 
   V = zeros(Int64, maxlength);

    
   while (length(infectious(population)) != 0) & (tick < maxlength)

    ## On spécifie que nous utilisons les variables définies plus haut
    global tick, population, budget_restant

    tick += 1 # changement dans les décompte de 1 jours à chaques itération

    budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent) # Résultat du budget restant selon ce les rdv de la journée

    ## Mettre a jour le statut des agents qui sont en attente de l'efficacité du vaccin et l'isolation de 2 jours
    ## Lorsque le décompte de " pending" de 2 jour est passé, l'agent change de statut pour "vacciné""
    ## Les agents vaccinés ne sont plus malades et ne transmettent pas l'infection.
    for agent in population
        if agent.pending && agent.vaccin_clock != 0
            agent.vaccin_clock -= 1
        elseif agent.pending && agent.vaccin_clock == 0
            agent.vaccinated = true
            agent.pending = false

            ## L'agent guérit quand le vaccin est efficace
            agent.infectious = false


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

    ## Changement de la survie : -1 jour pour chaque infectieux, sauf ceux qu sont en isolation
    for agent in infectious(population)
        if !agent.pending
        agent.clock -= 1
        end
    end

    ## Stocker les morts a chaques generation 
    morts[tick] = (tick > 1 ? morts[tick-1] : 0) + count(x -> x.clock <= 0, population)

    ## Enlever les morts : on retire ceux qui n'ont plus de jours
    population = filter(x -> x.clock > 0, population)

    ## Enregistrement dans la série temporelle respective
    S[tick] = length(healthy(population))
    I[tick] = length(infectious(population))
    V[tick] = length(vaccinated(population))
   end

  ## Stocker le nombre de morts à chaques générations pour chaqune des 4 simulaitons 
  push!(resultat_morts, morts[1:tick])

end



 
# ## Analyse des résultats

# ### Série temporelle

# Avant toute chose, nous allons couper les séries temporelles au moment de la
# dernière génération:

S = S[1:tick];
I = I[1:tick];

# Graphique du nombre d'agent seceptible et et infectieux au  fil des générations 

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
    t = [event.time for event in events]
    pos = [(event.x, event.y) for event in events]

    f = Figure()
    ax = Axis(f[1, 1]; aspect=1, backgroundcolor=:grey97)
    hm = scatter!(ax, pos, color=t, colormap=:navia, strokecolor=:black, strokewidth=1, colorrange=(0, tick), markersize=6)
    Colorbar(f[1, 2], hm, label="Time of infection")
    hidedecorations!(ax)
    current_figure()
end


# ### Nombre de tests et nombre de vaccination par jour au cours du temps 

# ### Budget restant par jours au cours du temps 

# ### Comparer avec l'absence de de vaccination pour le nombre de infectueux et sain au fil du temps

# Nous avons désactivé la ligne : "budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)"
# dans la boucle de la simulation afin d'obtenir un graphique ou il n'y aurait jamais eu d'intervention de dépistage et vaccination 
# ### Comparer avec l'absence de vaccination pour le nombre de personne infecté par agent infectueux 

# Nous avons désactivé la ligne : "budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)"
# dans la boucle de la simulation afin d'obtenir un graphique ou il n'y aurait jamais eu d'intervention de dépistage et vaccination 
# ### Nombre de mort pour chaque simulation
#Graphique qui supperpositionne le nombre de morts a chaques generations pour les 4 simulations
# Random seed est désactivé pour obersver la variabililité 
plot(resultat_morts[1])
plot!(resultat_morts[2])
plot!(resultat_morts[3])
plot!(resultat_morts[4])


# # Figures supplémentaires

# Visualisation des infections sur l'axe x

scatter(t, first.(pos), color=:black, alpha=0.5)

# et y

scatter(t, last.(pos), color=:black, alpha=0.5)

# Tous les fichiers dans le dossier `code` peuvent être ajoutés au travail final. C'est par exemple utile pour déclarer l'ensemble des fonctions du
# modèle hors du document principal.

# Le contenu des fichiers est inclus avec `include("code/nom_fichier.jl")`.

# Attention! Il faut que le code soit inclus au bon endroit (avant que les fonctions déclarées soient appellées).

# include("code/01_test.jl")

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

# Grosse supposition quand meme que le masque et la distanciation empechherait 100% des contamination ( pas tout le monde qui respecte)

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

