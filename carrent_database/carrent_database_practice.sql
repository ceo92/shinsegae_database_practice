create database CARRENT;

create user carmanager@localhost identified by 'carmanager';


grant all privileges on CARRENT.* to carmanager@localhost with grant option;


flush privileges;

use CARRENT;

CREATE TABLE campingcar_rent_company (
  company_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  company_name VARCHAR(30) NOT NULL,
  company_address VARCHAR(50) NOT NULL,
  company_phone_number CHAR(13) NOT NULL,
  manager_name VARCHAR(30) NOT NULL,
  manager_email VARCHAR(30),
  PRIMARY KEY (company_id)
);

CREATE TABLE customer (
  drive_license_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_name VARCHAR(30) NOT NULL,
  customer_address VARCHAR(50) NOT NULL,
  customer_phone_number CHAR(13) NOT NULL,
  customer_email VARCHAR(30),
  previous_rent_campingcar_date DATE,
  previous_rent_campingcar_type VARCHAR(20),
  PRIMARY KEY (drive_license_id)
);



CREATE TABLE shop (
  shop_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  shop_name VARCHAR(30) NOT NULL,
  shop_address VARCHAR(50) NOT NULL,
  shop_phone_number CHAR(13) NOT NULL,
  manager_name VARCHAR(30) NOT NULL,
  manager_email VARCHAR(30),
  PRIMARY KEY (shop_id)
);


CREATE TABLE campingcar (
  campingcar_register_id BIGINT UNSIGNED NOT NULL,
  company_id BIGINT UNSIGNED NOT NULL,
  campingcar_name VARCHAR(30) NOT NULL,
  campingcar_number VARCHAR(15) NOT NULL,
  campingcar_ride_count INT NOT NULL,
  campingcar_image VARCHAR(1000) NOT NULL,
  campingcar_detail_info VARCHAR(500) NOT NULL,
  campingcar_rent_cost INT NOT NULL,
  campingcar_register_date DATE,
  PRIMARY KEY (campingcar_register_id, company_id),
  FOREIGN KEY (company_id) REFERENCES campingcar_rent_company (company_id)
);




CREATE TABLE campingcar_maintain_info (
  maintain_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  campingcar_register_id BIGINT UNSIGNED NOT NULL,
  shop_id BIGINT UNSIGNED NOT NULL,
  company_id BIGINT UNSIGNED NOT NULL,
  drive_license_id BIGINT UNSIGNED NOT NULL,
  maintain_content VARCHAR(1000) NOT NULL,
  maintain_date DATE NOT NULL,
  maintain_cost INT NOT NULL,
  pay_limit_date DATE NOT NULL,
  other_maintain_content VARCHAR(1000),
  PRIMARY KEY (maintain_id),
  FOREIGN KEY (campingcar_register_id, company_id) REFERENCES campingcar (campingcar_register_id, company_id),
  FOREIGN KEY (shop_id) REFERENCES shop (shop_id),
  FOREIGN KEY (company_id) REFERENCES campingcar_rent_company (company_id),
  FOREIGN KEY (drive_license_id) REFERENCES customer (drive_license_id)
);

CREATE TABLE rent_campingcar (
  rent_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  campingcar_register_id BIGINT UNSIGNED NOT NULL,
  drive_license_id BIGINT UNSIGNED NOT NULL,
  company_id BIGINT UNSIGNED NOT NULL,
  rent_start_date DATE NOT NULL,
  rent_period INT NOT NULL,
  charge INT NOT NULL,
  pay_limit_date DATE NOT NULL,
  other_billing_details VARCHAR(100),
  other_billing_cost INT,
  PRIMARY KEY (rent_id, campingcar_register_id, drive_license_id, company_id),
  FOREIGN KEY (campingcar_register_id) REFERENCES campingcar (campingcar_register_id),
  FOREIGN KEY (drive_license_id) REFERENCES customer (drive_license_id),
  FOREIGN KEY (company_id) REFERENCES campingcar_rent_company (company_id)
);


