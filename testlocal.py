from flask import Flask, request, jsonify
import json
from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)


JSON_DATA_FILE = 'GAIESA.json'

def dfjson():
    with open(JSON_DATA_FILE, 'r') as file:
        data = json.load(file)
    return data

@app.route('/login', methods=['POST'])
def login():
    data = dfjson()
    utilisateurs = next(item for item in data if item["type"] == "table" and item["name"] == "utilisateur")["data"]
    positions = next(item for item in data if item["type"] == "table" and item["name"] == "position")["data"]
    donnees = next(item for item in data if item["type"] == "table" and item["name"] == "donnees")["data"]

    nom_utilisateur = request.json.get('Nom')
    num_client = request.json.get('numClient')
    print(f"Nom: {nom_utilisateur}, num_client: {num_client}")

    utilisateur = next((user for user in utilisateurs if user["Nom"] == nom_utilisateur and user["NumClient"] == num_client), None)

    if utilisateur:
        fk_id_donnees = utilisateur["FKIddonnees"]
        donnee = next((don for don in donnees if don["IdDonnees"] == fk_id_donnees), None)

        if donnee:
            fk_id_position = donnee["FKIdPosition"]
            position = next((pos for pos in positions if pos["IdPosition"] == fk_id_position), None)

            if position:
                response_data = {
                    "Nom": utilisateur["Nom"],
                    "Prenom": utilisateur["Prenom"],
                    "NumClient": utilisateur["NumClient"],
                    "TCEAM": donnee["TCEAM"],
                    "ENS": donnee["ENS"],
                    "EEC": donnee["EEC"]
                }

                return jsonify({"message": "Utilisateur trouvé", "status": True, "data": response_data})
    
    return jsonify({"message": "Utilisateur non trouvé", "status": False})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
