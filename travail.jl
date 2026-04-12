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
#      matricule: 20275756
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
# # Implémentation : code pour le modèle

# ## Packages nécessaires

# ### Pour les graphiques

using CairoMakie
CairoMakie.activate!(px_per_unit=6.0)
using StatsBase
using Random

# ### Initialisation de nombre aléatoire   

# Utilisé seulement pour les figures présentés lors de la présentation orale, pour que les résultats soit reproductibles

# Random.seed!(2045)

# ### Pour donner un identifiant unique aux agents

import UUIDs
UUIDs.uuid4()

# ## Création des types

# ### Type d'agents

# Les agents se déplacent dans un environnement en deux dimension représenté par une lattice, 
# et on doit donc suivre leur position et leur état : 
# 1) s'ils sont vaccinés, et si l'effet protecteur du vaccin est effectif (soit 2 jours après l'injection).
# 2) s'ils sont infectieux, et dans ce cas, combien de jours ils leurs restent.

Base.@kwdef mutable struct Agent        ## création de valeurs par défaut pouvant changer pendant la simulation
    x::Int64 = 0
    y::Int64 = 0
    clock::Int64 = 21                   ## nombre de jours avant la mort si infecté
    infectious::Bool = false            ## Savoir si agent est infectueux 
    vaccin_clock::Int64 = 2             ## Nombre de jour avant l'immunité une fois le vaccin administé
    vaccinated::Bool = false            ## savoir si agent immunisé par vaccin
    id::UUIDs.UUID = UUIDs.uuid4()      ## identifiant unique généré automatiquement
    tested::Bool = false                ## Savoir si agent est testé 
    pending::Bool = false               ## Savoir si l'agent est en attente de l'efficacité du vaccin, et en isolation
end

# ### Type paysage

# Définit les limites de la grille où les agents se déplacent Ici, c'est une
# grille de -50 à 50 dans les deux directions, donc 100x100 = 10 000 cases au
# total. Les agents qui se trouvent dans la même cases sont considérés très
# proches, donc en contact direct et à risque de contamination. 

Base.@kwdef mutable struct Landscape
    xmin::Int64 = -25
    xmax::Int64 = 25
    ymin::Int64 = -25
    ymax::Int64 = 25
end

# Nous allons maintenant créer un paysage de départ :

L = Landscape(xmin=-50, xmax=50, ymin=-50, ymax=50)

# ## Création de nouvelles fonctions

# ### Création d'agents aléatoires

# On génère une fonction pour créer des agents au hasard. Il
# existe une fonction pour faire ceci dans _Julia_: `rand`. Pour que notre code
# soit facile a comprendre, nous allons donc ajouter une méthode à cette fonction:

"""
Random.rand(arg1, arg2, arg3)
 Génère des agents avec des position aléatoires dans le paysage, qui est une lattice dont la dimention se trouve entre x, y min etx, y max

## Arguments 
arg1 : Le type d'agent généré
arg2 : paysage où les agent sont générés,  qui se trouve dans la lattice L 
arg3 : (facultatif) nombre d'agents générés

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

# ### Fonction du déplacement des agents dans le paysage

# Puisque la position de l'agent va changer, notre fonction se termine par `!`:
# La lattice est de type torus. Ainsi, si un agent atteint la limite de la lattice, il réapparait de l'autre côté.
# Les déplacements sont aléatoires et peuvent être de -1, 0 ou 1 sur l'axe des x entraîne y.  
"""
    move!(arg1, arg2, arg3)

Permet le déplacement aléatoire des agents sur la lattice dans les cases adjacentes chaques jours, ou de rester sur place.

## Arguments 
arg1 : L'agent qui se déplace
arg2 : Paysage où les agents qui se déplacent
arg3 : Si la lattice est torridale ou pas (TRUE or FALSE)

## Retour
La fonction retourne l'agent A, avec sa nouvelle position. 
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

# Nous pouvons maintenant définir des fonctions qui vont nous permettre de simplifier la rédaction du code

# ### Vérifier si un agent est infectieux

"""
    isinfectious(arg1)

Vérifie si L'agent est infecté 

## Arguments 
arg1 : un agent

## Retour
True si infecté 
"""

isinfectious(agent::Agent) = agent.infectious

# ### Vérifier si un agent est sain
"""
 ishealthy(arg1)

 Vérifie si l'agent est sain

## Arguments 
 arg1 : un agent

## Retour
 True si sain
 
 """
ishealthy(agent::Agent) = !isinfectious(agent)

# ### Vérifier si un agent est vacciné

"""
 isvaccinated(arg1)

 Vérifie si l'agent est vacciné

## Arguments 
 arg1 : un agent

## Retour
 True si vacciné
 """
isvaccinated(agent::Agent) = agent.vaccinated ## État vacciné
vaccinated(pop::Vector{Agent}) = filter(isvaccinated, pop) ## Sous - groupe de la population qui est vacciné

# ### Vérifier si un agent est testé
"""
 istested(arg1)

 Vérifie si l'agent est testé

## Arguments 
 arg1 : un agent

## Retour
 True si testé
 """
istested(agent::Agent) = agent.tested

# Sous groupe de la population qui n'est pas testé et qui est testé 

untested(pop::Vector{Agent}) = filter(!istested, pop)
tested(pop::Vector{Agent}) = filter(istested, pop)

# ### Vérifier si un agent est en attente de l'efficacité du vaccin 
# Après avoir été en contact avec le pathogène dans le vaccin, le corps prend un délais de 2 jours pour développer l'immunité

"""
 ispending(arg1)

 Vérifie si l'agent est vacciné, mais il n'a pas encore l'immunité, car la période de 2 jours n'est pas passée. 
 Cela correspond également à la période d'isolation des agents infectueux qui viennent d'être vaccinés. 

## Arguments 
 arg1 : un agent

## Retour
 True si vacciné, mais pas encore efficace
 """
ispending(agent::Agent) = agent.vaccin_clock


# ### Fonction pour prendre uniquement les agents qui sont infectieux dans une population
# Pour que ce soit clair, nous allons créer un _alias_, `Population`, qui voudra dire `Vector{Agent}`:

const Population = Vector{Agent}

## Retourne les agents malades

"""
 infectious(arg1)

 Créer un vecteur qui contient un sous-groupe de la population totale avec tous les individu infectueux.

## Arguments 
 arg1 : la population

## Retour
 Tous les individus infectueux
 """
infectious(pop::Population) = filter(isinfectious, pop)

## Retourne les agents sains 

"""
 Healthy(arg1)

 Créer un vecteur qui contient un sous-groupe de la population totale avec tous les individu sains.

## Arguments 
 arg1 : la population

## Retour
 Tous les individus sains
 """
healthy(pop::Population) = filter(ishealthy, pop)

## Retourne les agents non testés, alors ceux qui ont des RDV à la clinique 
"""
 untested(arg1)

 Créer un vecteur qui contient un sous-groupe de la population totale avec tous les individu non-testés

## Arguments 
 arg1 : la population

## Retour
 Tous les individus non testés
 """
untested(pop::Population) = filter(!istested, pop)

# ### Fonction pour trouver l'ensemble des agents d'une population qui sont dans la même cellule qu'un agent
# Elle va retourner les agents qui ont exactement les mêmes coordonées que l'agent cible (contatcs potentiels).
# Cela permet d'intégré la propagation spatiale de la pandémie en fonction des contacts directes entre individus, qui sont dans la même case de la lattice

"""
 incell(arg1, arg2 )

 Identifie tous les agents d'une population qui sont en contact direct, avec un agent. 
 Ils ont les mêmes coordonnés sur la lattice .

## Arguments 
 arg1 : l'agent dont l'ont veut connaitre les contacts directs
 arg2 : la population 

## Retour
 Tous les agents de la population qui sont dans la même case qu'un agent 
 
 """
incell(target::Agent, pop::Population) = filter(ag -> (ag.x, ag.y) == (target.x, target.y), pop)


# ## Gestion des vaccins

# ### Délai de 2 jours d'efficacité après administration du vaccin

"""
 administrer_vaccin!(arg1)

 Initie un compte à rebourd de 2 jours (2 générations) lorsqu'un agent devient vacciné (changement de statut)

## Arguments 
 arg1 : un agent 

## Retour
 L'agent obtient le statut de "ispending" et un compte a rebour de 2 jours avant l'immunité est débuté
 
 """
function administrer_vaccin!(agent::Agent)
    agent.vaccin_clock = 2
    return agent
end

# ### Fonction qui simule les visites à la clinique selon la stratégie de gestion que nous avons adopté 

# Notre stratégie de gestion permet à 1% de la population d'obtenir un rdv en clinique chaques jours, dans le groupe de la population qui n'as 
# pas été testé. Lors du rendez-vous, on effectue d'abord un test RAT pour déterminer si la personne est saine ou infectée. La simulation prévoit 
# un taux de faux négatifs de 5% lors du test RAT. Si la personne est infectée, on lui administre le vaccin directement et la place en isolation pendant 2 jours.
# Le vaccin est une antidote, donc il va sauver l'agent de l'infection. 

# Contraintes budégtaires

# Lorsque le budget est dépassé, on ne peut plus tester ou vacciner les agens qui sont présentement dans leur visite à la clinique.
# Le budget est vérifié avant de tester et vacciner. Certains individus de la dernière génération qui avait un rdv seront testés, mais jamais vaccinés. 
# Le pourcentage d'individus qui ont un rdv en clinique chaques jours est de 1%. Cela représente la capacité d'accueil et de gestion limité d'un village avec 3750 habitants.


budget_restant = 21000      ## Au départ, le budget restant est le budget total de 21 000$ 
cout_vaccin = 17            ## Coût du vaccin
cout_rat = 4                ## Coût du test RAT 
pourcent = 0.01             ## Pourcentage de la population qui se présente au rdv en clinique chaques jours 

"""
 RDVclinique(arg1, arg2, arg3, arg4, arg5)

 Simule les visites à la clinique selon la stratégie de gestion adoptée et vérifie les contraintes budgétaire pour chaques étapes du processus. 

## Arguments 
 arg1 : la population 
 arg2 : le budget restant qui se met a jour chaques jours, après chaque test ou vaccination
 arg3 : le coût d'un test RAT
 arg4 : le coût d'un vaccin 
 arg5 : pourcentage de la population qui a un rdv en clinique chaques jours

## Retour
 Le budget restant après les tests et vaccins de la journée.
 Retourne aussi le statut changé des agents qui ont eu un rdv, selon les résultats des tests. 
"""
function RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)

    ##  Vérifie que le budget restant est suffisant pour effectuer les tests des RDV de la journée 
    if budget_restant > 0
        untest = untested(population) ## Objet contenant les agents qui n'ont pas encore été testés (qui n'ont pas eu de RDV)
        num_to_test = min(length(untest), round(Int, pourcent * length(untest))) ## Fait un objet contentant les RDV de la journée, qui sont un échantillon de 1% de la population qui n'a jamais été testé. 

        ## Vérifie que le budget restant couvre les coûts pour les tests des RDV de la journée 
        if num_to_test * cout_rat > budget_restant
            num_to_test = budget_restant ÷ cout_rat ## si le coût est trop élevé pour tester tout les indivius, on teste le maximum possible avec le budget restant 
        end

        ## Mettre à jour le budget restant après le coût des tests du jour 
        budget_restant -= num_to_test * cout_rat

        ## Marque les agents qui ont un RDV comme testés, afin qu'ils puissent avoir un nouveau RDV dans les jours suivants
        agent_test = shuffle(untest)[1:num_to_test]
        for agent in agent_test
            agent.tested = true
        end

        ## Le test possède 95% d'efficacité, donc 5% de faux négatifs
        infectueux_detecte = Agent[] ## objet avec les agents infectueux détectés (vide)
        for agent in agent_test
            if agent.infectious && rand() > 0.05  ## 95% de chance de détecter un infecté
                push!(infectueux_detecte, agent)
            end
        end

        ## Vaccination des agents testés malade lors du RDV 
        ## En raison des faux negatifs, ce ne sont pas tous les agents infectés qui sont détectés
        num_to_vaccinate = length(infectueux_detecte) ## Nombre d'agents qui ont été testés et qui sont malades. Ce sont ceux qui seront vaccinés le jour même

        ## Vérifier si le budget restant couvre les coûts pour vacciner tous les agents qui ont testé infecté lors du RDV  
        if num_to_vaccinate * cout_vaccin > budget_restant
            num_to_vaccinate = budget_restant ÷ cout_vaccin ## Si le coût est trop élevé pour vacciner tous les indivius, on teste le maximum possible avec le budget restant 
        end

        ## Mettre à jour le budget restant après le coût des vaccins du jour
        budget_restant -= num_to_vaccinate * cout_vaccin

        ## Vacciner les agents qui ont été testés malade lors du RDV et les mettre en "isolation" pendant 2 jour 
        ## L'isolation est représentée par le statut "ispending" qui est également la période d'attente de l'efficacité du vaccin
        for agent in infectueux_detecte[1:num_to_vaccinate]
            if agent.infectious
                administrer_vaccin!(agent) ## Applique le vacin et débute le clock de 2 jours avant l'immunité 
                agent.pending = true ## Le statut de l'agent qui vient d'être vacciné change pour "pending" (2 jour avant l'immunité)
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

 Génère la populaition initiale d'agents dans le paysage 

## Arguments 
 arg1 :  Le paysage, donc la lattice 
 arg2 : Nombre d'agents souhaités dans la population

## Retour
Retourne une population avec un nombre d'agent distribués aléatoirement dans le paysage  

"""
function Population(L::Landscape, n::Integer)
    return rand(Agent, L, n)
end

# Afficher les informations sur la population initiale 

Base.show(io::IO, ::MIME"text/plain", p::Population) = print(io, "Une population avec $(length(p)) agents")

# Taille de la population à l'origine de la simulation, c'est-à-dire lorsqu'il y a le premier décès : 

population = Population(L, 3750)      ## 3750 étant la taille de la population

# Choisir au hasard dans la population un infecté (cas index) :

rand(population).infectious = true

# Nous initialisons la simulation au temps 0, et nous allons la laisser se dérouler au plus 2000 pas de temps:

tick = 0
maxlength = 2000

# Vecteur pour stocker le nombre de morts à chaques générations d'une simulation

morts = zeros(Int64, maxlength) ;

# Liste des résultats des vecteurs de morts pour les 4 simulations 

resultat_morts = Vector{Vector{Int64}}()

# Pour stocker le nombre de test et vaccin a chaques generations 

nb_tests = zeros(Int64, maxlength);     ## objet pour stoker le nombre de tests effectués 
nb_vaccins = zeros(Int64, maxlength);   ## objet pour stocker le nomre de vaccin 

# Pour stocker les séries temporelles de la simulation
S = zeros(Int64, maxlength); ## Série temporelle des agents sains
I = zeros(Int64, maxlength); ## Série temporelle des agents infectieux 
V = zeros(Int64, maxlength); ## Série temporelle des vaccins

# Pour stocker le budget au fil des jours

budget_par_jour = zeros(Int64, maxlength); 

# Événements d'infections : 

# Nous allons aussi stocker tous les évènements d'infection qui ont lieu pendant la simulation

struct InfectionEvent
    time::Int64
    from::UUIDs.UUID
    to::UUIDs.UUID
    x::Int64
    y::Int64
end

# Liste vide qui va se remplir durant la simulation pour "stocker"
# Notez que l'on a contraint notre vecteur `events` à ne contenir _que_ des valeurs du bon type, et que nos `InfectionEvent` sont immutables.

events = InfectionEvent[]

# # Simulation 

# La boucle tourne tant qu'il y a des infectés et que le temps maximale n'est pas atteint. 
# Lorsqu'il n'y a plus de budget, les efforts de gestion cesse, mais la contamination peut continuer jusqu'à 2000 générations. 

# Pour faire la simulation sans vaccination :  mettre un # devant la ligne _budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)_
# On fait la simulation 10 fois et on stock les résultats du nombre de morts 

for _ in 1:10

    ## Paramètres initiaux de la simulation
    population = Population(L, 3750)    ## population initiale de 3750 individus sur le paysage
    rand(population).infectious=true    ## agent choisit au hasard pour être infecté
    tick=0                              ## temps remit à 0
    morts = zeros(Int64, maxlength)     ## objet pour stocker le nombre de morts 
    
    nb_tests = zeros(Int64, maxlength);     ## objet pour stoker le nombre de tests effectués 
    nb_vaccins = zeros(Int64, maxlength);   ## objet pour stocker le nomre de vaccin 
    S = zeros(Int64, maxlength);            ## Série temporelle des agents sains
    I = zeros(Int64, maxlength);            ## Série temporelle des agents infectieux 
    V = zeros(Int64, maxlength);
    budget_par_jour = zeros(Int64, maxlength); 
    budget_restant = 21000                  ## Budget restant au debut est le budget total
    
    while (length(infectious(population)) != 0) & (tick < maxlength)

    tick += 1 ## changement dans les décompte de 1 jours à chaques itération

    ## Mettre un # devant la ligne suivante pour faire la simulation sans vaccination 
    budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent) ## Résultat du budget restant selon ce les rdv de la journée

    ## Mettre à jour le statut des agents qui sont en attente de l'efficacité du vaccin et l'isolation de 2 jours.
    ## Lorsque le décompte de " pending" de 2 jours est passé, l'agent change de statut pour "vacciné""
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

    ## Mouvement : les agents bougent d'une case à chaque génération. 
    ## Les agents qui sont en isolation bougent quand même, mais on considère qu'ils font des mesures sanitaires (ex : port du masque)

    for agent in population
        move!(agent, L; torus= true)
    end

    ## Infection : les infectieux ont 40% d'infecter un voisin sain au hasard.
    ## Les agents qui sont en isolation (en attente de l'efficacité du vaccin) et les personnes vaccinées ne peuvent pas transmettre l'infection. 
    for agent in Random.shuffle(infectious(population))
        neighbors = healthy(incell(agent, population))
        for neighbor in neighbors
            if !neighbor.pending && !neighbor.vaccinated && rand() <= 0.4
                neighbor.infectious = true
                push!(events, InfectionEvent(tick, agent.id, neighbor.id, agent.x, agent.y))
            end
        end
    end

    ## Changement de la survie : -1 jour pour chaque infectés, sauf ceux qui sont en isolation
    for agent in infectious(population)
        if !agent.pending
        agent.clock -= 1
        end
    end

    ## Stocker les morts à chaques générations 
    morts[tick] = (tick > 1 ? morts[tick-1] : 0) + count(x -> x.clock <= 0, population)

    ## Enlever les morts : on retire ceux qui n'ont plus de jours
    population = filter(x -> x.clock > 0, population)

    ## Enregistrement dans la série temporelle respective
    S[tick] = length(healthy(population))
    I[tick] = length(infectious(population))
    V[tick] = length(vaccinated(population))

    ## Stocker 
    budget_par_jour[tick] = budget_restant

    end    
    
   ## Stocker le nombre de morts à chaques générations pour les 10 simulations 
   push!(resultat_morts, morts[1:tick])

end

# Nombre de morts final pour les 10 itérations de simulation

for (i, morts) in enumerate(resultat_morts)
    println("Sim $i : $(morts[end]) morts en $(length(morts)) jours")
end
 
# ## Analyse des résultats

# ### Figure 1
# Avant toute chose, nous allons couper les séries temporelles au moment de la dernière génération:

S = S[1:tick];
I = I[1:tick];

f = Figure()
ax = Axis(f[1, 1]; xlabel="Génération", ylabel="Population")
stairs!(ax, 1:tick, S, label="Susceptibles", color=:black)
stairs!(ax, 1:tick, I, label="Infectieux", color=:red)
axislegend(ax)
current_figure()

# Figure 1. Évolution des agents infectés et sains au cours des générations jusqu’à épuisement des infectés avec vaccination

# Ici, on observe qu’une bonne partie de la population est saine contrairement aux infectés. On observe une diminution rapide de la population et qu’elle se stabilise environ après 400 jours.

# ### Nombre de cas par individu infectieux

# Nous allons ensuite observer la distribution du nombre de cas créés par chaque individus. Pour ceci, nous devons prendre le contenu de `events`, et vérifier
# combien de fois chaque individu est représenté dans le champ `from`:

infxn_by_uuid = countmap([event.from for event in events]);

# La commande `countmap` renvoie un dictionnaire, qui associe chaque UUID au nombre de fois ou il apparait :

# Notez que ceci nous indique combien d'individus ont été infectieux au total :

length(infxn_by_uuid)

# Pour savoir combien de fois chaque nombre d'infections apparaît, il faut utiliser `countmap` une deuxième fois :

nb_inxfn = countmap(values(infxn_by_uuid))

# On peut maintenant visualiser ces données:

f = Figure()
ax = Axis(f[1, 1]; xlabel="Nombre d'infections", ylabel="Nombre d'agents")
scatterlines!(ax, [get(nb_inxfn, i, 0) for i in Base.OneTo(maximum(keys(nb_inxfn)))], color=:black)
f

# ### Nombre de tests et nombre de vaccination par jour au cours du temps 

f = Figure()
ax = Axis(f[1, 1]; xlabel="Génération", ylabel="Nombre")
stairs!(ax, 1:tick, nb_tests[1:tick], label="Tests", color=:black)
stairs!(ax, 1:tick, nb_vaccins[1:tick], label="Vaccins", color=:red)
axislegend(ax)
current_figure()

# ### Budget restant par jours au cours du temps

f = Figure()
ax = Axis(f[1, 1]; xlabel="Génération", ylabel="Budget restant ")
stairs!(ax, 1:tick, budget_par_jour[1:tick], color=:black)
current_figure()

# ### Comparer avec l'absence de de vaccination pour le nombre de infectueux et sain au fil du temps

# Nous avons désactivé la ligne : "budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)"
# dans la boucle de la simulation afin d'obtenir un graphique ou il n'y aurait jamais eu d'intervention de dépistage et vaccination 

# ### Comparer avec l'absence de vaccination pour le nombre de personne infecté par agent infectueux 

# Nous avons désactivé la ligne : "budget_restant = RDVclinique(population, budget_restant, cout_rat, cout_vaccin, pourcent)"
# dans la boucle de la simulation afin d'obtenir un graphique ou il n'y aurait jamais eu d'intervention de dépistage et vaccination 

# ### Nombre de mort pour chaque simulation
# Graphique qui supperpositionne le nombre de morts a chaques generations pour les 4 simulations
# Random seed est désactivé pour obersver la variabilité 

f = Figure()
ax = Axis(f[1, 1]; xlabel=" jours", ylabel="morts")

for (i, D) in enumerate(resultat_morts)
    lines!(ax, 1:length(D), D, color=:steelblue, alpha=0.4)
end

current_figure()

# # Discussion

# Notre stratégie de vaccination ciblé testait 1% des individus non-testés à chaque jours au test RAT et ceux étant positifs 
# étaient vaccinés. La population était testée au hasard pour représenter les ressources limités de la santé publique d’un 
# petit village. En revanche, le choix de vacciner les individus positifs était pour les guérir et limiter la propagation de 
# l’infection. Nous avons choisit de mettre nos agents vaccinés en « isolation », pour éviter de continuer la propagation le 
# temps que le vaccin fasse effet. Les agents peuvent encore bouger sur la lattice à chaque génération, mais on considère qu’ils
# ont un masque et respecte une distance sociale (mesures de sécurités).

# Cette stratégie ne serait surment pas la plus efficace dans la vraie vie, mais comme nous sommes dans une simulation fictive
# avec peu de moyens, c’était la meilleure option. Cependant, pour améliorer le modèle, il aurait été pertinent de vacciner les
# agents à un certain diamètre d’un individu ayant testé positif au RAT. Aussi, il aurait aussi intéressant de voir un modèle où 
# on vaccine le plus de monde possible et voir comment ça évolue, de voir comment l’infection aurait persisté dans le temps.

# ## Résultats

# ## Variabilité

# ## Limites

# Les individus infectés sont asymptomatiques, alors nous pouvons seulement détecté l'infection avec un test de détection antigénique
# rapide (RAT). Cependant, les tests de détections ne sont pas parfait et ont un 5% de faux négatifs. En effet, il est commun de ne pas
# avoir de tests 100% efficaces et c’est réaliste. Par exemple, avec le test rapide de détection au Covid-19, on observe une sensibilité 
# entre 70 % et 90 % chez les agents symptomatiques, mais diminue à moins de moins de 50 % chez les asymptomatiques (@fouzas2021). Dans 
# notre simulation notre 5% de faux négatifs est considéré bon contrairement à celui présenté précédemment, voir un peu trop irréaliste.

# Pour la prévention, les vaccins 100% efficaces, seulement après 2 jours. Dans cette simulation c’est très utile, mais ce n'est pas très 
# réaliste de la vraie vie, où le système immunitaire des individus varient. Par exemple, avec le vaccins contre la Covid-19 l’efficacité
# variaient entre 50-100% selon la variante du vaccin et du virus (@higdon2022). Aussi, avec l’Ebola, l’immunisation était significative 
# qu’après 10 jours ou plus (@henao2017).

# Ici, l’infection est fatale sans vaccination. Par contre, dans la réalité et avec la médecine d’aujourd’hui, c’est très rare d’avoir 
# une maladie incurable provoquant la mort en 21 jours. En effet, en comparaison au VIH, dans les années 1980, la maladie était fatale 
# après 1 à 2 ans. Aujourd’hui, avec des traitements comme la thérapie antirétrovirale, les personnes infectés se rapproche d’une expérience 
# de vie normale (@trickey2023).

# De plus, dans la réalité, il y a des zones géographiques plus denses avec plus de gens au même endroit comme à l’hôpital, en ville, au 
# centre de dépistage, etc… Il y a d’autres zones géographiques où il y en a moins comme en campagne. Cela joue sur la transmission du 
# virus (@changruenngam2020). Dans notre simulation, nous avons une lattice avec des agents s’y déplaçant au hasard sans structure. 
# Cela ne représente pas vraiment la réalité, où les individus vont au travail, à l’épicerie, à la maison, etc. Augmentant de beaucoup les 
# zones où il est possible de transmettre une infection.

# d'autres à venir let me cook

# Comme la réalité est plus complexe qu’une simulation, c’est normal que la simulation ne prend pas en compte tous ces enjeux. En revanche, 
# c’est intéressant de voir combien il y a de facteurs pouvant influencer ce modèle.
