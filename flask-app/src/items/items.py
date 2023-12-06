from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

items = Blueprint('items', __name__)

@items.route('/items', methods=['GET'])
def getItems():
    query = '''
        SELECT *
        FROM item;
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query) # store results in cursor

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

