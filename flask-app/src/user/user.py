from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

user = Blueprint('user', __name__)

@user.route('/u/<user_id>', methods=['GET'])
def getUserInfo(userID):
    query = '''
        SELECT *
        FROM user
        WHERE (user_id = user_id);
    '''
    cursor = db.get_db.cursor()
    cursor.execute(query) # store results in cursor

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@user.route('/<userIDFrom>/conversation/<userIDTo>', methods=['GET'])
def get_conversation(userIDFrom, userIDTo):
    query = '''
        SELECT conversation_history
        FROM conversation
        WHERE (to_user_id = {} AND from_user_id = {})
        OR (to_user_id = {} AND from_user_id = {});
    '''.format(userIDTo, userIDFrom, userIDFrom, userIDTo)
    
    cursor = db.get_db().cursor()
    cursor.execute(query) # store results in cursor

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@user.route('/<userIDFrom>/conversation/<userIDTo>', methods=['GET'])
def get_conversation(userIDFrom, userIDTo):
    query = '''
        SELECT conversation_history
        FROM conversation
        WHERE (to_user_id = {} AND from_user_id = {})
        OR (to_user_id = {} AND from_user_id = {});
    '''.format(userIDTo, userIDFrom, userIDFrom, userIDTo)
    
    cursor = db.get_db().cursor()
    cursor.execute(query) # store results in cursor

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@user.route('/<userIDFrom>/conversation/<userIDTo>', methods=['POST'])
def add_message_to_conversation(userIDFrom, userIDTo):

    message_data = request.json  

    # Add the new message to the conversation
    query = '''
        INSERT INTO conversation (from_user_id, to_user_id, message)
        VALUES (%s, %s, %s);
    '''
    values = (userIDFrom, userIDTo, message_data['message'])  

    cursor = db.get_db().cursor()
    cursor.execute(query, values)
    db.get_db().commit()

    return jsonify({"message": "Message added successfully"})

@user.route('/additem', methods=['POST'])
def user_sell_new_item():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    category = the_data['category']
    price = the_data['price']
    size = the_data['size']

    query = 'INSERT INTO item (category, price, size, seller_id) VALUES ("'
    query += category + '", "'
    query += str(price) + '", "'
    query += size + '", "'
    query += str(1) + '")'


    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'