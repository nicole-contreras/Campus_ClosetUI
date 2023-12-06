from flask import Blueprint, request, jsonify, make_response
import json
from src import db

user = Blueprint('user', __name__)

@user.route('/u/<userID>', methods=['GET'])
def getUserInfo(userID):
    query = '''
        SELECT *
        FROM user
        WHERE (userId = user_id);
    '''
    cursor = db.get_db.cursor()
    cursor.execute(query) # store results in cursor

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@user.route('/u/<userIDFrom>/conversation/<userIDTo>', methods=['GET'])
def get_conversation(userIDFrom, userIDTo):
    query = '''
        SELECT *
        FROM conversation
        WHERE (to_user_id = userIDTo AND from_user_id = userIDFrom)
        OR (to_user_id = userIDFrom AND from_user_id = userIDTo);
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

@user.route('/add/item', methods=['POST'])
def user_sell_new_item():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    category = the_data['category']
    price = the_data['price']
    size = the_data['size']
    sellerID = the_data['seller_id']

    # Constructing the query
    query = 'insert into item (category, price, size, seller_id) values ("'
    query += category + '", "'
    query += str(price) + '", "'
    query += size + '", '
    query += sellerID + ')'

    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'