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

@items.route('/items/<itemID>', methods=['GET'])
def get_one_item():
    query = '''
        SELECT *
        FROM item
        WHERE item_id = itemID;
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query) # store results in cursor

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@items.route('/items/<itemID>', methods=['PUT'])
def update_item(itemID):
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting Variables
    category = the_data.get('category')
    price = the_data.get('price')
    size = the_data.get('size')
    seller_id = the_data.get('seller_id')
    buyer_id = the_data.get('buyer_id')
    bundle_id = the_data.get('bundle_id')

    # Constructing the update query
    query = '''
        UPDATE item
        SET category = %s, price = %s, size = %s, seller_id = %s, buyer_id = %s, bundle_id = %s
        WHERE item_id = %s;
    '''

    # Execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query, (category, price, size, itemID))
    db.get_db().commit()

    return 'Success!'

@items.route('/items/<itemID>', methods=['DELETE'])
def delete_item(itemID):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM item WHERE item_id = %s', (itemID,))
    db.get_db().commit()

    json_data = []

    operation_status = {
        'item_id': itemID,
        'deleted': cursor.rowcount > 0
    }
    json_data.append(operation_status)

    the_response = make_response(jsonify(json_data))
    the_response.mimetype = 'application/json'
    return the_response

@items.route('/items/<itemID>', methods=['GET'])
def item_details():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM item WHERE item_id = %s', (itemID,))

    # Fetching the result
    row_headers = [x[0] for x in cursor.description]  # Extract column headers
    theData = cursor.fetchone()  # Fetch the single row

    json_data = []
    if theData:
        json_data.append(dict(zip(row_headers, theData)))

    the_response = make_response(jsonify(json_data))
    the_response.mimetype = 'application/json'
    return the_response