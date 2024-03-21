from flask import Flask, request, jsonify
import json
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

JSON_DATA_FILE = 'data_test_01.json'

def load_data_from_json():
    with open(JSON_DATA_FILE, 'r') as file:
        data = json.load(file)
    return data

def find_user_data(nom, num_client):
    data = load_data_from_json()
    utilisateur_data = [item for item in data if item["type"] == "table" and item["name"] == "utilisateur"][0]["data"]
    utilisateur = next((user for user in utilisateur_data if user["Nom"] == nom and user["NumClient"] == num_client), None)

    if utilisateur:
        id_utilisateur = utilisateur["IdUtilisateur"]
        donnees_data = [item for item in data if item["type"] == "table" and item["name"] == "donnees"][0]["data"]
        position_data = [item for item in data if item["type"] == "table" and item["name"] == "position"][0]["data"]
        
        donnees_utilisateur = next((donnee for donnee in donnees_data if donnee["FKIdPosition"] == id_utilisateur), None)
        position_utilisateur = next((position for position in position_data if position["FKIdUtilisateur"] == id_utilisateur), None)

        return utilisateur, donnees_utilisateur, position_utilisateur
    return None, None, None

@app.route('/login', methods=['POST'])
def login():
    nom = request.json.get('Nom')
    num_client = request.json.get('numClient')
    utilisateur, donnees, position = find_user_data(nom, num_client)

    if utilisateur and donnees and position:
        response_data = {
            "Nom": utilisateur["Nom"],
            "Prenom": utilisateur["Prenom"],
            "NumClient": utilisateur["NumClient"],
            "DCE": donnees["DCE"],
            "TCEAM": donnees["TCEAM"],
            "TCEAMB": donnees["TCEAMB"],
            "TCEAV": donnees["TCEAV"],
            "ENS": donnees["ENS"],
            "EEC": donnees["EEC"],
            "Position": position
        }
        return jsonify({"message": "Utilisateur trouvé", "status": True, "data": response_data})

    return jsonify({"message": "Utilisateur non trouvé", "status": False})

@app.route('/data', methods=['GET'])
def get_data():
    nom = request.args.get('Nom')
    num_client = request.args.get('numClient')
    _, donnees, _ = find_user_data(nom, num_client)

    if donnees:
        return jsonify({"status": True, "data": donnees})
    return jsonify({"message": "Données non trouvées", "status": False})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
