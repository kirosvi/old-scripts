#!/usr/bin/env python

# Import necessary libs
# Dont forget install from yum "mysql-connector-python"
import os, mysql.connector, socket
from jinja2 import Environment, FileSystemLoader

# Define variables
#PATH = os.path.dirname(os.path.abspath(__file__))
PATH = '/home/systemsupport/ansible/genlist/'
TEMPLATE_ENVIRONMENT = Environment(
    autoescape=False,
    loader=FileSystemLoader(os.path.join(PATH, 'templates')),
    trim_blocks=False)


db = mysql.connector.connect(host="",    # your host, usually localhost
                     user="",         # your username
                     password="",  # your password
                     database="Network")        # name of the data base

msk_inside = []
msk_idmz = []
msk_rdmz = []
dbn_inside = []
dbn_idmz = []
dbn_rdmz = []
gor_inside = []
gor_idmz = []
gor_rdmz = []

# Define functions
def get_info(host_name):
    cur = db.cursor()
    ip_host = socket.gethostbyname(host_name)
    net = '.'.join(ip_host.split(".")[0:3])
    sql_query = ("SELECT `ip`, `area`,`seg` FROM `net` WHERE `ip` LIKE '%" + net + ".%';")
    sql_query2 = ("SELECT `ip`, `area`,`seg` FROM `net` WHERE `ip` LIKE '%" + net + "%';")
    cur.execute(sql_query)
    rows = cur.fetchone()
    #
    if rows is None:
        cur.execute(sql_query2)
        rows = cur.fetchone()
    #
    ip_net = rows[0]
    area = rows[1]
    segment = rows[2]
    #
    if area == u'\u0414\u0443\u0431\u043d\u0430':
        area = 'Dunba'
    elif area == u'\u041c\u043e\u0441\u043a\u0432\u0430':
        area = 'Moscow'
    elif area == u'\u0413\u043e\u0440\u043e\u0434\u0435\u0446':
        area = 'Gorodets'
    #
    if segment == u'iDMZ':
        segment = 'iDMZ'
    elif segment == u'inside':
        segment = 'inside'
    elif segment == 'rDMZ':
        segment = 'rDMZ'
    #
    try:
        drop = cur.fetchall()
    except:
        pass
    #
    return net,area,segment


def gen_lists():
    with open('/home/systemsupport/ansible/genlist/list') as f:
        #lines = f.readlines()
        names = [row.strip() for row in f]
    #
    list = {}
    for i in names:
        #print i
        net,area,seg = get_info(i)
        #print net,area,seg
        list[i] = { 'net':net, 'area':area, 'seg':seg}
    #
    db.close()
    #print list
    #
    for i in list.keys():
        if list[i]['area'] == 'Moscow' and list[i]['seg'] == 'inside':
            msk_inside.append(i)
        elif list[i]['area'] == 'Moscow' and list[i]['seg'] == 'iDMZ':
            msk_idmz.append(i)
        elif list[i]['area'] == 'Moscow' and list[i]['seg'] == 'rDMZ':
            msk_rdmz.append(i)
        elif list[i]['area'] == 'Dunba' and list[i]['seg'] == 'inside':
            dbn_inside.append(i)
        elif list[i]['area'] == 'Dunba' and list[i]['seg'] == 'iDMZ':
            dbn_idmz.append(i)
        elif list[i]['area'] == 'Dunba' and list[i]['seg'] == 'rDMZ':
            dbn_rdmz.append(i)
        elif list[i]['area'] == 'Gorodets' and list[i]['seg'] == 'inside':
            gor_inside.append(i)
        elif list[i]['area'] == 'Gorodets' and list[i]['seg'] == 'iDMZ':
            gor_idmz.append(i)
        elif list[i]['area'] == 'Gorodets' and list[i]['seg'] == 'rDMZ':
            gor_rdmz.append(i)
    

def render_template(template_filename, context):
    return TEMPLATE_ENVIRONMENT.get_template(template_filename).render(context)


def create_small_template(msk_inside, msk_idmz, msk_rdmz, dbn_inside, dbn_idmz, dbn_rdmz, gor_inside, gor_idmz, gor_rdmz):
    fname = "/home/systemsupport/ansible/genlist/small_inv.yml"
    context = {
        'msk_inside': msk_inside,
        'msk_rdmz': msk_rdmz,
        'msk_idmz': msk_idmz ,
        'dbn_inside': dbn_inside,
        'dbn_rdmz': dbn_rdmz,
        'dbn_idmz': dbn_idmz,
        'gor_inside': gor_inside,
        'gor_rdmz': gor_rdmz,
        'gor_idmz': gor_idmz
    }
    #
    with open(fname, 'w') as f:
        tmpl = render_template('small_inv.j2', context)
        f.write(tmpl)

def main():
    gen_lists()
    print 'msk_inside ',msk_inside
    print 'msk_rdmz ',msk_rdmz
    print 'msk_idmz ',msk_idmz 
    print 'dbn_inside ',dbn_inside
    print 'dbn_rdmz ',dbn_rdmz
    print 'dbn_idmz ',dbn_idmz
    print 'gor_inside ',gor_inside
    print 'gor_rdmz ',gor_rdmz
    print 'gor_idmz ',gor_idmz
    create_small_template(msk_inside, msk_idmz, msk_rdmz, dbn_inside, dbn_idmz, dbn_rdmz, gor_inside, gor_idmz, gor_rdmz)

# Runs script
if __name__ == "__main__":
    main()






