from flask import Blueprint, Response, request, jsonify
from . import led_strip

bp = Blueprint('api', __name__)

@bp.route('/lamp', methods=['POST'])
def update_lamp():
 body = request.get_json()
 return body, 200

@bp.route('/lamp', methods=['GET'])
def lamp():
 return jsonify({"state": "N/A"})

@bp.route('/lamp/brightness', methods=['POST'])
def lamp_on():
 brightness = request.json['brightness']
 print(brightness)
 led_strip.update_brightness(brightness)
 return jsonify({"state": "on"})
