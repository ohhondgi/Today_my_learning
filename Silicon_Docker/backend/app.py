import os

# from flask_mongoengine import MongoEngine
from flask import Flask, flash, request, jsonify, redirect, url_for
from flask_cors import CORS
from werkzeug.utils import secure_filename
from worker import celery
import boto3
import celery.states as states
import mysql.connector

access_id = 'AKIAVJ6H6FLESCGV4BOO'
access_secret = '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'

client = boto3.client('s3',
                      aws_access_key_id=access_id,
                      aws_secret_access_key=access_secret,
                      region_name='ap-northeast-2'  # 서울 위치
                      )

Upload_URL = "./video"
# Flask 인스턴스 생성
app = Flask(__name__)
CORS(app)
app.config['UPLOAD_FOLDER'] = Upload_URL

# CORS(app, origins="http://localhost:3000", supports_credentials=True)


# mongodb 연동 방법
# app.config['MONGODB_SETTINGS'] = {
#     'host': os.environ['MONGODB_HOST'],
#     'port': 27017,
#     'username': os.environ['MONGODB_USERNAME'],
#     'password': os.environ['MONGODB_PASSWORD'],
#     'db': 'webapp',
#     'authentication_source': 'admin'
# }
# app.config['MONGO_AUTH_SOURCE'] = 'admin'
# db = MongoEngine()
# db.init_app(app)

# mysql 연동을 위한 config 정보들


def getMysqlConnection():
    config = {
        'user': 'tester',
        'host': 'db',
        'port': '3306',
        'password': 'test',
        'database': 'test',
        'auth_plugin': 'mysql_native_password'  # default는 sha256으로 오류 발생
    }
    return mysql.connector.connect(**config)


@app.route('/test', methods=['GET'])
def get_test():
    db = getMysqlConnection()
    # print(db)
    try:
        sql = "SELECT * FROM testtb"
        cur = db.cursor()
        cur.execute(sql)
        output_json = cur.fetchall()
        return jsonify(output_json)
    except Exception as e:
        print("Error in SQL: /n", e)
    finally:
        db.close()


@app.route('/add/<int:param1>/<int:param2>')
def add(param1: int, param2: int) -> str:
    task = celery.send_task('tasks.add', args=[param1, param2], kwargs={})
    response = f"<a href='{url_for('check_task', task_id=task.id, external=True)}'>check status of {task.id} </a>"
    return response


@app.route('/check/<string:task_id>')
def check_task(task_id: str) -> str:
    res = celery.AsyncResult(task_id)
    # res = celery.AsynchronousResult(task_id)
    if res.state == states.PENDING:
        return res.state
    else:
        return str(res.result)


@app.route('/fileUpload', methods=['GET', 'POST'])
def get_video():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('no file part')
            return redirect(request.rul)
        video_file = request.files['file']
        if video_file == '':
            flash('No selected file')
            return redirect(request.url)
        filename = secure_filename(video_file.filename)
        path = os.path.join(Upload_URL, filename)
        # 해당 경로 파일이 존재하지 않을 경우
        if not (os.path.exists(Upload_URL)):
            os.mkdir(Upload_URL)
        video_file.save(path)
        return jsonify({'success': True, 'file': 'Received', 'name': filename})
    if request.method == 'GET':
        return "flask test"


# mongodb를 활용한 예제
# class Todo(db.Document):
#     title = db.StringField(max_length=60)
#     text = db.StringField()
#     done = db.BooleanField(default=False)

#     def to_json(self):
#         return {"title": self.title,
#                 "email": self.text,
#                 "done": self.done}


# @app.route("/api", methods={'GET'})
# def index():
#     Todo.objects().delete()
#     Todo(title="Simple todo A", text="12345678910").save()
#     Todo(title="Simple todo B", text="12345678910").save()
#     Todo.objects(title__contains="B").update(set__text="Hello world")
#     todos = Todo.objects().to_json()
#     return Response(todos, mimetype="application/json", status=200)


# debug=true를 통해 무엇이 오류인지 알려준다.
if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True, port=5000)
