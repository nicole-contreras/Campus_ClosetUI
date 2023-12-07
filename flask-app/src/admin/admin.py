from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

admin = Blueprint('admin', __name__)

@admin.route('/getAdmin', methods=['GET'])
def get_admin():
    cursor = db.get_db().cursor()
    query = '''
        SELECT *
        FROM admin;
    '''

    cursor.execute(query) # store results in cursor

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)




@admin.route('/updateUser', methods=['PUT'])
def update_user(user_id):
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting Variables
    email = the_data.get('emial')
    password = the_data.get('password')
    avg_rating = the_data.get('avg_rating')

    # Constructing the update query
    query = '''
        UPDATE user
        SET email = %s, password = %s, avg_rating = %s;
        WHERE user_id = %s;
    '''

    # Execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query, (email, password, avg_rating, user_id))
    db.get_db().commit()

    return 'Success!'

