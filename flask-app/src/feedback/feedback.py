from flask import Blueprint, request, jsonify, make_response, current_app
import json
from campusCloset import db

feedback = Blueprint('feedback', __name__, url_prefix='/feedback')

@feedback.route('/<userId>/feedback', methods=['GET'])
def get_feedback(userId):
    query = '''
        SELECT AVG(rating) as avg_rating
        FROM user_feedback
        WHERE user_id = %s;
    '''

    cursor = db.get_db().cursor()
    cursor.execute(query, (userId,))

    result = cursor.fetchone()
    avg_rating = result['avg_rating'] if result['avg_rating'] is not None else 0.0

    the_response = make_response(jsonify({'avg_rating': avg_rating}))
    the_response.mimetype = 'application/json'
    return the_response

@feedback.route('/<userId>/feedback', methods=['POST'])
def submit_feedback(userId):
    # Collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting variables
    feedback_text = the_data.get('feedback_text')
    rating = the_data.get('rating')

    # Constructing the insert query
    query = '''
        INSERT INTO user_feedback (user_id, feedback_text, rating)
        VALUES (%s, %s, %s);
    '''

    # Execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query, (userId, feedback_text, rating))
    db.get_db().commit()

    return jsonify({'feedback_number': rating})

@feedback.route('/<userId>/feedback', methods=['PUT'])
def update_avg_rating(userId):
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting variables
    new_rating = the_data.get('new_rating')

    # Retrieve existing ratings
    query_select = '''
        SELECT AVG(rating) as avg_rating
        FROM user_feedback
        WHERE user_id = %s;
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query_select, (userId,))
    result = cursor.fetchone()
    existing_avg_rating = result['avg_rating'] if result['avg_rating'] is not None else 0.0

    # Calculate new average rating out of 10
    total_ratings = cursor.rowcount
    new_avg_rating = ((existing_avg_rating * total_ratings) + new_rating) / (total_ratings + 1)

    # Ensure the new average rating is capped at 10
    new_avg_rating = min(new_avg_rating, 10.0)

    # Constructing the update query
    query_update = '''
        UPDATE user
        SET avg_rating = %s
        WHERE user_id = %s;
    '''

    # Execute the update query
    cursor.execute(query_update, (new_avg_rating, userId))
    db.get_db().commit()

    return jsonify({'avg_rating': new_avg_rating})