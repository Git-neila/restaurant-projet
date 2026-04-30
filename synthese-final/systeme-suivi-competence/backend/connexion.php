<?php
$serveur   = "localhost";
$utilisateur = "root";
$motdepasse  = "";
$base      = "SuiviCompetencesEquipe";

$conn = new mysqli($serveur, $utilisateur, $motdepasse, $base);
if ($conn->connect_error) {
    // Si échec, renvoyer une réponse JSON d’erreur et terminer
    header('Content-Type: application/json; charset=UTF-8');
    http_response_code(500);
    echo json_encode(['error' => 'Échec de la connexion : ' . $conn->connect_error]);
    exit;
}
// **PLUS D’AFFICHAGE ICI** — la connexion est silencieuse
