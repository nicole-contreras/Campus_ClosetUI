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

@user.route('/<userIDFrom>/conversation/<userIDTo>', methods=['POST'])
def add_message_to_conversation(userIDFrom, userIDTo):
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    conversation_history = the_data

    query = 'INSERT INTO conversation (to_user_id, from_user_id, conversation_history) VALUES ("'
    query += str(userIDTo) + '", "'
    query += str(userIDFrom) + '", "'
    query += (conversation_history) + '")'

    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


@user.route('/<userIDFrom>/conversation', methods=['PUT'])
def start_new_con(userIDFrom):
    
    # Collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    userIDTo = the_data.get('to_user_id', '')
    conversation_history = the_data.get('conversation_history', '')

    # Checking if the conversation already exists, and if not, insert a new one
    cursor = db.get_db().cursor()
    cursor.execute(
        'SELECT * FROM conversation WHERE to_user_id = %s AND from_user_id = %s',
        (userIDTo, userIDFrom)
    )
    existing_conversation = cursor.fetchone()

    if existing_conversation:
        # Conversation already exists, update the history
        cursor.execute(
            'UPDATE conversation SET conversation_history = %s WHERE to_user_id = %s AND from_user_id = %s',
            (conversation_history, userIDTo, userIDFrom)
        )
    else:
        # Conversation doesn't exist, insert a new one
        cursor.execute(
            'INSERT INTO conversation (to_user_id, from_user_id, conversation_history) VALUES (%s, %s, %s)',
            (userIDTo, userIDFrom, conversation_history)
        )

    db.get_db().commit()

    return 'Success!'

@user.route('/<sellerID>/additem', methods=['POST'])
def user_sell_new_item(sellerID):
    
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
    query += str(sellerID) + '")'


    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@user.route('wishlist/<wishlistID>', methods=['GET'])
def view_wishlist(wishlistID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM wishlist WHERE wishlist_id = %s', (wishlistID,))

    # Fetching the result
    row_headers = [x[0] for x in cursor.description]  
    theData = cursor.fetchall()  

    json_data = []
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.mimetype = 'application/json'
    return the_response


@user.route('/wishlist/<wishlistId>/<itemID>/add_item', methods=['POST'])
def add_wishlist_item(wishlistId, itemID):
    # Extracting additional data from the request, if needed
    the_data = request.json

    title = the_data.get('title', '')
    description = the_data.get('description', '')

    # SQL query to insert the new item into the wishlist
    query = 'INSERT INTO wishlist_items (wishlist_id, item_id, title, description) VALUES (%s, %s, %s, %s)'

    # Execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query, (wishlistId, itemID, title, description))
    db.get_db().commit()

    # Preparing the response
    response_message = {'message': 'Item added to wishlist successfully'}
    the_response = make_response(jsonify(response_message))
    the_response.mimetype = 'application/json'
    return the_response

@user.route('/wishlist/<wishlistId>/<itemID>/remove_item', methods=['DELETE'])
def remove_wishlist_item(wishlistId, itemID):
    query = 'DELETE FROM wishlist_items WHERE wishlist_id = %s AND item_id = %s'

    # Execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query, (wishlistId, itemID))
    db.get_db().commit()

    if cursor.rowcount == 0:
        response_message = {'message': 'No item removed. Item or Wishlist may not exist'}
        the_response = make_response(jsonify(response_message))
    else:
        response_message = {'message': 'Item removed from wishlist successfully'}
        the_response = make_response(jsonify(response_message))

    the_response.mimetype = 'application/json'
    return the_response
