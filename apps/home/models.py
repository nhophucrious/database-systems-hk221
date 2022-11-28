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



class PatientPhone(db.Model):
    __tablename__ = "patient_phone"    
    patient_id = db.Column(db.String(6), primary_key=True)
    phone_no = db.Column(db.String(10), primary_key=True)


class PatientComorbidity(db.Model):
    __tablename__ = "patient_comorbidity"  
    patient_id = db.Column(db.String(6), primary_key=True)
    comorbidity = db.Column(db.String(30), primary_key=True, nullable=False)

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




