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
    TestConductor,
    PatientSymptom,
    PatientAdmissionDate,
    PatientDischargeDate,
    PatientAddress,
    PatientPrevLocation,
    Treats,
    TreatmentPeriod,
    Doctor,
    PatientAddress
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

def serializeSymptom(joinedQuery):
    _, symptomDate, symptomName = joinedQuery
    separator = ", "
    return{
        'symptomDate': symptomDate if symptomDate is None else symptomDate.strftime('%Y-%m-%d'),
        'symptomName': symptomName if symptomName is None else separator.join(symptomName.split(","))
    }

def serializeTreatment(joinedQuery):
    treatmentBegin, treatmentEnd, docFirstName, docLastName, treatMed, treatResult = joinedQuery
    return {
        'treatmentPeriod': str(treatmentBegin) + ' to ' + str(treatmentEnd),
        'docFullName': docFirstName + ' ' + docLastName,
        'treatmentMedication': treatMed,
        'treatResult': treatResult
    }

def getNewPatientID(oldID):
    x = len(oldID)
    patientPostfix = int(oldID[(slice(x//2, x))])
    patientPostfix += 1
    patientPostfixReturn = str(patientPostfix)
    if (len(patientPostfixReturn) == 1):
        patientPostfixReturn = '00' + patientPostfixReturn
    elif (len(patientPostfixReturn) == 2):
        patientPostfixReturn = '0' + patientPostfixReturn
    return oldID[(slice(0, x//2))] + patientPostfixReturn
    


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
            Patient.last_name.like(f'%{search}%'),
            Patient.gender.like(f'%{search}%')
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
        patientSymptomQuery = db.session.query(Patient, PatientSymptom.s_date, func.group_concat(PatientSymptom.symptom)).join(PatientSymptom, PatientSymptom.patient_id==Patient.id, isouter=True).where(Patient.id==request_data.decode()).group_by(PatientSymptom.s_date)
        patientAdmissionDateQuery = db.session.query(Patient, func.group_concat(PatientAdmissionDate.a_date)).join(PatientAdmissionDate, PatientAdmissionDate.patient_id==Patient.id, isouter=True).where(Patient.id==request_data.decode()).group_by(Patient.id)
        patientDischargeDateQuery = db.session.query(Patient, func.group_concat(PatientDischargeDate.d_date)).join(PatientDischargeDate, PatientDischargeDate.patient_id==Patient.id, isouter=True).where(Patient.id==request_data.decode()).group_by(Patient.id)
        patientAddressQuery = db.session.query(Patient, func.group_concat(PatientAddress.p_address)).join(PatientAddress, PatientAddress.patient_id==Patient.id, isouter=True).where(Patient.id==request_data.decode()).group_by(Patient.id)
        patientPrevLocationQuery = db.session.query(Patient, func.group_concat(PatientPrevLocation.prev_location)).join(PatientPrevLocation, PatientPrevLocation.patient_id==Patient.id, isouter=True).where(Patient.id==request_data.decode()).group_by(Patient.id)  
        treatmentQuery = db.session.query(TreatmentPeriod.begin_date, TreatmentPeriod.end_date, Personnel.first_name, Personnel.last_name, Medication.med_name, Treats.result
        ).where(Treats.med_id==Medication.id).where(Treats.doctor_id==Doctor.id).where(Doctor.id==Personnel.id).where(Treats.patient_id ==request_data.decode()).group_by(Treats.patient_id)

        separator = ", "

        _, resultPhoneNum = patientPhoneQuery[0]
        _, resultComorbidity = patientComorbidityQuery[0]
        _, resultAdmissionDate = patientAdmissionDateQuery[0]
        _, resultDischargeDate = patientDischargeDateQuery[0]
        _, resultAddress = patientAddressQuery[0]
        _, resultPrevLocation = patientPrevLocationQuery[0]

        return {
            'treatmentData': [
                serializeTreatment(treat) for treat in treatmentQuery
            ],
            'symptomData': [
                serializeSymptom(sym) for sym in patientSymptomQuery
            ],
            'patientPhone': separator.join(resultPhoneNum.split(",")),
            'comorbidity': resultComorbidity if resultComorbidity is None else separator.join(resultComorbidity.split(",")),
            'admissionDates': separator.join(str(resultAdmissionDate).split(",")),
            'dischargeDates': separator.join(str(resultDischargeDate).split(",")),
            'address': separator.join(resultAddress.split(",")),
            'prev_location': separator.join(resultPrevLocation.split(","))
        }

@blueprint.route('api/patient_testing_data', methods=['POST', 'GET'])
def patientTestingData():
    request_data = request.get_data()
    testingInfoQuery = db.session.query(TestingInformation).where(TestingInformation.patient_id==request_data.decode()).group_by(TestingInformation.test_date)
    
    total_filtered = testingInfoQuery.count()

    return {
        # query is a list of tuples, we convert each elem into a dictionary and pass it back (json)
        'data': [
           info.to_dict() for info in testingInfoQuery
        ],
        'recordsFiltered': total_filtered,
        'recordsTotal': testingInfoQuery.count(),
        'draw': request.args.get('draw', type=int),
    }

@blueprint.route('api/patient_add', methods=['POST'])
def patientAdd():
    if request.method == 'POST':
        referencePatientQuery = db.session.query(Patient)
        id = referencePatientQuery[-1].getID()
        newID = getNewPatientID(id)
        print(newID)
        firstName = request.form.get("firstName")
        lastName = request.form.get("lastName")
        gender = request.form.get("gender")
        phoneNumber = request.form.get("phoneNumber")
        nationalID = request.form.get("nationalID")
        address = request.form.get("address")
        prevLocation = request.form.get("prevLocation")
        print(newID, firstName, lastName, nationalID, gender, 'NUR001', 'STA001', 'F', 'F')
    return {
        'heh': 'hhhehe'
    }