from flask import Flask, render_template, request
from flask_cors import CORS
from flask_restful import Resource, reqparse, Api
from tqdm import tqdm

import pymysql
import pandas as pd
import numpy as np
import random


app = Flask(__name__)
CORS(app)

conn = None
cur = None

@app.route('/')
def student():
    return render_template('student.html')

@app.route('/api/plus', methods = ['POST', 'GET'])
def result():
    try:
        # 요청받은거를 받아주자
        parser = reqparse.RequestParser()

        # add_argument 를 통해 입력 파라미터를 설정할 수 있다.
        parser.add_argument('x', required=True, type=int, help='x cannot be blank')
        parser.add_argument('y', required=True, type=int, help='y cannot be blank')
        args = parser.parse_args()
        result = args['x'] + args['y']
        print(result)
        return {'result': result} # 실제 돌려줄 값을 여기에 넣어준다.
    except Exception as e:
        return {'error': str(e)}

# 전체 여행지 중 추천 여행지
@app.route('/place/recommand', methods = ['POST', 'GET'])
def getRecommandPlace():
    try:
        parser = reqparse.RequestParser()
        sql = "select pId from placeInfo"
        cur.execute(sql)

        row = cur.fetchall()
        result = [i[0] for i in row]

        result = random.sample(result, 10)

        return {'result': result}
    except Exception as e:
        return {'error': str(e)}

# 전체 여행지 중 추천 여행지
@app.route('/search/tagStatistic', methods = ['POST', 'GET'])
def tagStatistic():
    try:
        parser = reqparse.RequestParser()
        parser.add_argument('hashTag_s', required=True, type=str)
        args = parser.parse_args()

        hashTag_li = args['hashTag_s'].split(",")

        sql = "select distinct(sId) from areaStatistic order by sId desc"
        cur.execute(sql)
        sId = cur.fetchone()[0] + 1
        print("sId : " + str(sId))

        row = cur.fetchall()
        result = [i[0] for i in row]

        df_statistic = pd.DataFrame(columns=['sId', "hashTag", "area", "countTag"])

        for hashTag in hashTag_li:
            sql = f"select h.hashTag, p.GUGUN_NM  \
                    from placeInfo p join hashTag h on p.pId = h.pId \
                    where h.hashTag = '{hashTag}'"
            cur.execute(sql)
            row = cur.fetchall()

            df_count = pd.DataFrame({"hashTag" : [i[0] for i in row], "GUGUN_NM" : [i[1] for i in row]}).groupby(['GUGUN_NM']).count()
            df_tmp = pd.DataFrame()
            df_tmp["area"] = df_count.index
            df_tmp["sId"] = sId
            df_tmp["hashTag"] = hashTag
            df_tmp["countTag"] = list(df_count['hashTag'])
            df_statistic = pd.concat([df_statistic, df_tmp])
            del df_count

        print(df_statistic)
            
        for idx, row in tqdm(df_statistic.iterrows()):
            try:
                sql = f"INSERT INTO areastatistic (sId, hashTag, area, countTag) \
                    VALUES ({row.sId}, '{row.hashTag}', '{row.area}', {row.countTag})"
                cur.execute(sql)

            except Exception as e:
                print("insert err : "+ str(e))

        conn.commit()

        return {'sId': sId}
    except Exception as e:
        print(e)
        return {'error': str(e)}

def recommand(type1, type2):
    group_li = ['부모','아이', '가족', '친구', '커플', '혼자']
    season_li = ['봄', '여름', '가을', '겨울']
    cl_li = ['산', '기타', '도시', '바다']
    iem_li = ['자연', '체험', '이색여행', '공원', '축제', '쇼핑', '역사', '문화', '걷기']

if __name__ == '__main__':
    conn = pymysql.connect(host="221.138.15.210", user='busan', password='busan', db='busan', charset='utf8')
    cur = conn.cursor()
    app.run(host='221.138.15.210', port=8081, debug = True)