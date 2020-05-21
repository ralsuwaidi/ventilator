import redis
import logging


logging.basicConfig(filename='log.log', format='%(levelname)s:%(asctime)s - %(message)s',
                    datefmt='%H:%M:%S', level=logging.NOTSET)

useredis = False
r = redis.StrictRedis(
    host='172.16.30.185',
    port=6379,
    password='',
    decode_responses=True)

fullscreen = False

args = None
