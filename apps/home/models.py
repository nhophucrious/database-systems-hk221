from apps import db


class Personnel(db.Model):
    __tablename__ = "personnel"
    id = db.Column(db.String(6), primary_key=True)
    first_name = db.Column(db.String(30), nullable=False)
    last_name = db.Column(db.String(30))
    gender = db.Column(db.String(1))

    def to_dict(self):
        return {
            'id': self.id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'gender': self.gender
        }


class Doctor(db.Model):
    __tablename__ = "doctor"
    id = db.Column(db.String(6), primary_key=True)


class PersonnelPhone(db.Model):
    __tablename__ = "personnel_phone"
    id = db.Column(db.String(6), primary_key=True)
    phone_no = db.Column(db.String(10), primary_key=True)

    def to_dict(self):
        return {
            'id': self.id,
            'phone_no': self.phone_no
        }

class Patient(db.Model):
    __tablename__ = "patient"
    id = db.Column(db.String(6), primary_key=True)
    first_name = db.Column(db.String(30), nullable=False)
    last_name = db.Column(db.String(30))
    id_number = db.Column(db.String(12))
    gender = db.Column(db.String(1))
    caretaker_id = db.Column(db.String(6))
    administrator_id = db.Column(db.String(6))
    is_warning = db.Column(db.String(1))
    is_high_risk = db.Column(db.String(1))

    def getID(self):
        return self.id
    
    def __init__(self, id, firstName, lastName, nationalID, gender, caretaker, administer, isWarning, isHighRisk):
        self.id = id
        self.first_name = firstName
        self.last_name = lastName
        self.id_number = nationalID
        self.gender = gender
        self. caretaker_id = caretaker
        self.administrator_id = administer
        self.is_warning = isWarning
        self.is_high_risk = isHighRisk

    def to_dict(self):
        return {
            'id': self.id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'id_number': self.id_number,
            'gender': self.gender,
            'caretaker_id': self.caretaker_id,
            'administrator_id': self.administrator_id,
            'is_warning': self.is_warning,
            'is_high_risk': self.is_high_risk
        }


class PatientAddress(db.Model):
    __tablename__ = 'patient_address'

    patient_id = db.Column(db.String(6), primary_key=True)
    p_address = db.Column(db.String(60), primary_key=True, nullable=False)
    def __init__(self, patient_id, p_address):
        self.patient_id = patient_id
        self.p_address = p_address


class PatientPhone(db.Model):
    __tablename__ = "patient_phone"    
    patient_id = db.Column(db.String(6), primary_key=True)
    phone_no = db.Column(db.String(10), primary_key=True)
    def __init__(self, patient_id, phone_no):
        self.patient_id = patient_id
        self.phone_no = phone_no


class PatientComorbidity(db.Model):
    __tablename__ = "patient_comorbidity"  
    patient_id = db.Column(db.String(6), primary_key=True)
    comorbidity = db.Column(db.String(30), primary_key=True, nullable=False)


class PatientSymptom(db.Model):
    __tablename__ = "patient_symptom"
    patient_id = db.Column(db.String(6), primary_key=True)
    s_date = db.Column(db.Date, primary_key=True, nullable=False)
    symptom = db.Column(db.String(50), primary_key=True, nullable=False)


class PatientPrevLocation(db.Model):
    __tablename__ = 'patient_prev_location'

    patient_id = db.Column(db.String(6), primary_key=True)
    prev_location = db.Column(db.String(60), primary_key=True, nullable=False)
    def __init__(self, patient_id, prev_location):
        self.patient_id = patient_id
        self.prev_location = prev_location


class PatientAdmissionDate(db.Model):
    __tablename__ = 'patient_admission_date'

    patient_id = db.Column(db.String(6), primary_key=True)
    a_date = db.Column(db.Date, primary_key=True, nullable=False)


class PatientDischargeDate(db.Model):
    __tablename__ = 'patient_discharge_date'
    patient_id = db.Column(db.String(6), primary_key=True)
    d_date = db.Column(db.Date, primary_key=True, nullable=False)




class Medication(db.Model):
    __tablename__ = "medication"
    id = db.Column(db.String(6), primary_key=True)
    med_name = db.Column(db.String(30))
    price = db.Column(db.Integer)
    exp_date = db.Column(db.Date)
    def to_dict(self):
        return {
            'id': self.id,
            'med_name': self.med_name,
            'price': self.price,
            'exp_date': self.exp_date.strftime('%Y-%m-%d')
        }

class MedicationEffect(db.Model):
    __tablename__ = 'medication_effect'

    id = db.Column(db.ForeignKey('medication.id', ondelete='CASCADE'), primary_key=True, nullable=False)
    effect = db.Column(db.String(200), primary_key=True, nullable=False)


class TestConductor(db.Model):
    __tablename__ = 'test_conductor'

    id = db.Column(db.String(6), primary_key=True)



class TestingInformation(db.Model):
    __tablename__ = 'test_info'
    test_conductor_id = db.Column(db.ForeignKey('test_conductor.id'), primary_key=True, nullable=False)
    patient_id = db.Column(db.ForeignKey('patient.id'), primary_key=True, nullable=False, index=True)
    test_date = db.Column(db.Date, primary_key=True, nullable=False)
    Qtest_res = db.Column(db.String(1))
    Qtest_ct = db.Column(db.Integer)
    PCR_res = db.Column(db.String(1))
    PCR_ct = db.Column(db.Integer)
    Respiratory_rate = db.Column(db.Integer)
    SPO2 = db.Column(db.Numeric(5, 2))

    def to_dict(self):
        return {
            'test_conductor_id': self.test_conductor_id,
            'patient_id': self.patient_id,
            'test_date': self.test_date.strftime('%Y-%m-%d'),
            'quicktest_res': ("Negative ") if self.Qtest_res == "F" else ("Positive - CT: "  + str(self.Qtest_ct)),
            'pcr_res': "Negative" if self.PCR_res == "F" else ("Positive - CT: " + str(self.PCR_ct)),
            'respiratory_rate': self.Respiratory_rate,
            'spo2': str(self.SPO2)
        }


class Treats(db.Model):
    __tablename__ = 'treats'
    patient_id = db.Column(db.ForeignKey('patient.id'), primary_key=True, nullable=False)
    med_id = db.Column(db.ForeignKey('medication.id'), primary_key=True, nullable=False, index=True)
    doctor_id = db.Column(db.ForeignKey('doctor.id'), primary_key=True, nullable=False, index=True)
    result = db.Column(db.String(30))


class TreatmentPeriod(db.Model):
    __tablename__ = 'treatment_period'

    patient_id = db.Column(db.String(6), primary_key=True, nullable=False)
    med_id = db.Column(db.String(6), primary_key=True, nullable=False)
    doctor_id = db.Column(db.String(6), primary_key=True, nullable=False)
    begin_date = db.Column(db.Date, primary_key=True, nullable=False)
    end_date = db.Column(db.Date, primary_key=True, nullable=False)