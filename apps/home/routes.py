# -*- encoding: utf-8 -*-
from apps.home import blueprint
from apps import db
from apps.home.models import (
    Personnel, 
    PersonnelPhone, 
    Patient, 
    Medication, 
    MedicationEffect, 
    PatientComorbidity, 
    PatientPhone,
    TestingInformation,
    TestConductor
)
from sqlalchemy import func
from flask import render_template, request
from flask_login import login_required
from jinja2 import TemplateNotFound


def personnelSerializer(joinedQuery):
    res1, res2 = joinedQuery
    if res2 is None:
        res2Return = {
            'phone_no': ''
        }
        return {**res1.to_dict(), **res2Return}
    else:
        phoneNumbers = res2.split(",")
        separator = ", "
        res2Dict = {
            'phone_no': separator.join(phoneNumbers)
        }

        #res2Dict = {**res2Dict, **phoneKeyValue}
        return {**res1.to_dict(), **res2Dict}


def unpackMedication(joinedQuery):
    _, effects = joinedQuery
    separator = ", "
    return separator.join(effects.split(","))


@blueprint.route('/index')
@login_required
def index():

    return render_template('home/index.html', segment='index')


@blueprint.route('/<template>')
@login_required
def route_template(template):

    try:

        if not template.endswith('.html'):
            template += '.html'

        # Detect the current page
        segment = get_segment(request)

        # Serve the file (if exists) from app/templates/home/FILE.html
        return render_template("home/" + template, segment=segment)

    except TemplateNotFound:
        return render_template('home/page-404.html'), 404

    except:
        return render_template('home/page-500.html'), 500


# Helper - Extract current page name from request
def get_segment(request):

    try:

        segment = request.path.split('/')[-1]

        if segment == '':
            segment = 'index'

        return segment

    except:
        return None

@blueprint.route('api/personnel_data')
def personnelData():
    query = db.session.query(Personnel, func.group_concat(PersonnelPhone.phone_no,)).join(PersonnelPhone, PersonnelPhone.id==Personnel.id, isouter=True).group_by(Personnel.id)
    # search filter
    search = request.args.get('search[value]')
    if search:
        query = query.filter(db.or_(
            Personnel.first_name.like(f'%{search}%'),
            Personnel.last_name.like(f'%{search}%'),
            PersonnelPhone.phone_no.like(f'%{search}%')
        ))
    total_filtered = query.count()
    # pagination
    start = request.args.get('start', type=int)
    length = request.args.get('length', type=int)
    query = query.offset(start).limit(length)

    # response
    return {
        # query is a list of tuples, we convert each elem into a dictionary and pass it back (json)
        'data': [
            personnelSerializer(joinedQuery=joinedTuple) for joinedTuple in query
        ],
        'recordsFiltered': total_filtered,
        'recordsTotal': query.count(),
        'draw': request.args.get('draw', type=int),
    }


@blueprint.route('api/patient_data')
def patientData():
    query = db.session.query(Patient)
    #query = db.session.query(Patient, PatientPhone, PatientComorbidity).where(Patient.id==PatientPhone.patient_id and Patient.id==PatientPhone.patient_id).group_by(Patient.id)
    # search filter
    print(query[0].to_dict())
    search = request.args.get('search[value]')
    if search:
        query = query.filter(db.or_(
            Patient.id.like(f'%{search}%'),
            Patient.first_name.like(f'%{search}%'),
            Patient.last_name.like(f'%{search}%')
        ))
    total_filtered = query.count()
    # pagination
    start = request.args.get('start', type=int)
    length = request.args.get('length', type=int)
    query = query.offset(start).limit(length)

    # response
    return {
        # query is a list of tuples, we convert each elem into a dictionary and pass it back (json)
        'data': [
           pat.to_dict() for pat in query
        ],
        'recordsFiltered': total_filtered,
        'recordsTotal': query.count(),
        'draw': request.args.get('draw', type=int),
    }


@blueprint.route('api/medication_data')
def medicationData():
    query = db.session.query(Medication)
    # search filter
    search = request.args.get('search[value]')
    if search:
        query = query.filter(db.or_(
            Medication.med_name.like(f'%{search}%'),
            Medication.exp_date.like(f'%{search}%')
        ))
    total_filtered = query.count()
    # pagination
    start = request.args.get('start', type=int)
    length = request.args.get('length', type=int)
    query = query.offset(start).limit(length)

    # response
    return {
        # query is a list of tuples, we convert each elem into a dictionary and pass it back (json)
        'data': [
           med.to_dict() for med in query
        ],
        'recordsFiltered': total_filtered,
        'recordsTotal': query.count(),
        'draw': request.args.get('draw', type=int),
    }


@blueprint.route('api/index_data')
def indexData():
    personnelQuery = db.session.query(Personnel)
    personnelCount = personnelQuery.count()
    patientQuery = db.session.query(Patient)
    patientCount = patientQuery.count()
    medicationQuery = db.session.query(Medication)
    medicationCount = medicationQuery.count()
    return {
        'personnelCount': personnelCount,
        'patientCount': patientCount, # tutu them sau
        'medicationCount': medicationCount
    }


@blueprint.route('api/medication_detailed_data', methods=['POST', 'GET'])
def detailedMedicationData():
    if request.method == 'POST':
        request_data = request.get_data()
        query = db.session.query(Medication, func.group_concat(MedicationEffect.effect)).join(MedicationEffect, MedicationEffect.id==Medication.id, isouter=True).where(Medication.id==request_data.decode()).group_by(Medication.id)
        return {
            'effect': unpackMedication(query[0])
            #'hehe': 'hehe'
        }

@blueprint.route('api/patient_detailed_data', methods=['POST', 'GET'])
def detailedPatientData():
    if request.method == 'POST':
        request_data = request.get_data()
        
        patientPhoneQuery = db.session.query(Patient, func.group_concat(PatientPhone.phone_no)).join(PatientPhone, PatientPhone.patient_id==Patient.id, isouter=True).where(Patient.id==request_data.decode()).group_by(Patient.id)
        patientComorbidityQuery = db.session.query(Patient, func.group_concat(PatientComorbidity.comorbidity)).join(PatientComorbidity, PatientComorbidity.patient_id==Patient.id, isouter=True).where(Patient.id==request_data.decode()).group_by(Patient.id)
        
        separator = ", "

        _, resultPhoneNum = patientPhoneQuery[0]
        _, resultComorbidity = patientComorbidityQuery[0]
        return {
            #'effect': unpackMedication(query[0])
            'patientPhone': separator.join(resultPhoneNum.split(",")),
            'comorbidity': resultComorbidity if resultComorbidity is None else separator.join(resultComorbidity.split(","))
        }

@blueprint.route('api/patient_testing_data', methods=['POST', 'GET'])
def patientTestingData():
    request_data = request.get_data()
    testingInfoQuery = db.session.query(TestingInformation).where(TestingInformation.patient_id==request_data.decode()).group_by(TestingInformation.test_date)
    
    for info in testingInfoQuery:
        print(info.to_dict())
    total_filtered = testingInfoQuery.count()
    # pagination
    #start = request.args.get('start', type=int)
    #length = request.args.get('length', type=int)
    #testingInfoQuery = testingInfoQuery.offset(start).limit(length)

    return {
        # query is a list of tuples, we convert each elem into a dictionary and pass it back (json)
        'data': [
           info.to_dict() for info in testingInfoQuery
        ],
        'recordsFiltered': total_filtered,
        'recordsTotal': testingInfoQuery.count(),
        'draw': request.args.get('draw', type=int),
    }
