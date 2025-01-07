#localized string data for verbose messaging, errors, and warnings.

ConvertFrom-StringData @"
    addProperty = Ajout de la propriété {0}
    appendTasks = Ajout de tâches
    RemoteRepositoryInfo = Création des informations du dépôt distant
    DetectedParameterSet = Ensemble de paramètres détecté {0}
    Ending = Fin de la commande du module PSProjectStatus
    ExistingWarning = $([char]27)[91mUn fichier de statut de projet existant a été trouvé. Vous devez soit supprimer le fichier, soit relancer cette commande avec -Force.$([char]27)[0m
    FailPDF = Échec de l'ouverture du fichier d'aide. {0}. Vous pouvez essayer d'ouvrir l'aide en markdown.
    FilterNewer = Filtrage des projets mis à jour au cours des {0} derniers jours
    FilterOlder = Filtrage des projets mis à jour il y a plus de {0} jours
    FilterStatus = Filtrage par statut {0}
    FilterTag = Filtrage par tag {0}
    FoundGit = Branche git détectée {0}
    FoundProjects = {0} projets trouvés
    FoundTasks = {0} tâches trouvées
    GetGitBranch = Obtention des informations de la branche git
    GetGitRemote = Obtention des informations du dépôt git distant
    GetStatus = Obtention du statut du projet depuis {0}
    GetTaskID = Obtention du numéro de tâche {0}
    gitWarning = Vous devez exécuter cette commande depuis la racine d'un dépôt git
    missingJson = $([char]27)[91mImpossible de trouver psproject.json à l'emplacement spécifié {0}$([char]27)[0m
    NewInstance = Création d'une nouvelle instance de la classe PSProject
    NoGit = Aucune branche git détectée
    NoGitFolder = Impossible de trouver le dossier .git à l'emplacement actuel
    NoGitRemote = Aucun dépôt git distant détecté
    NoTasks = Aucune tâche trouvée pour ce projet
    NoTaskID = $([char]27)[91mImpossible de trouver une tâche avec un ID de {0} $([char]27)[0m
    OpenMarkdownHelp = Ouverture du fichier d'aide en markdown
    OpenPDFHelp = Tentative d'ouverture de {0} avec le visualiseur PDF par défaut
    ProcessPath = Traitement du chemin PSProject {0}
    ProcessProjects = Traitement des PSProjects sous {0}
    ProcessTasks = Traitement des tâches dans {0}
    PSVersion = Exécution sous la version PowerShell {0}
    ReplaceTasks = Remplacement des tâches
    RemoveTask = Suppression de la tâche {0} [{1}]
    SetProperty = Définition de la propriété : {0}
    Starting = Démarrage de la commande du module PSProjectStatus
    TestGit = Test pour .git
    Updating = Mise à jour de PSProject {0}
    UpdateProperty = Mise à jour de la propriété {0}
    UsingHost = Utilisation de l'hôte PowerShell {0}
    UsingModule = Utilisation du module PSProjectStatus version {0}
    UsingOS = Exécution sous le système d'exploitation {0}
    UsingPath = Utilisation du chemin du système de fichiers {0}
    UsingSchema = Utilisation du chemin du schéma {0}
"@
