CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INTEGER REFERENCES patients(id) ON DELETE CASCADE ON UPDATE CASCADE,
    status VARCHAR(255) NOT NULL
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE medical_histories_treatments (
    medical_histories_id INTEGER REFERENCES medical_histories(id) ON DELETE CASCADE ON UPDATE CASCADE,
    treatments_id INTEGER REFERENCES treatments(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE invoices(
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP NOT NULL,
    medical_history_id INT REFERENCES medical_histories(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE invoice_items(
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INT REFERENCES invoices(id) ON DELETE CASCADE ON UPDATE CASCADE,
    treatment_id INT REFERENCES treatments(id) ON DELETE CASCADE ON UPDATE CASCADE
);