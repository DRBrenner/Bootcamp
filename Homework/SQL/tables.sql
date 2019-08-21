CREATE TABLE "departments" (
	"dept_no" varchar(10) NOT NULL,
	"dept_name" varchar(255) NOT NULL,
	CONSTRAINT "departments_pk" PRIMARY KEY ("dept_no")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "dept_emp" (
	"emp_no" int NOT NULL,
	"dept_no" varchar(10) NOT NULL,
	"from_date" DATE NOT NULL,
	"to_date" DATE NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "dept_manager" (
	"dept_no" varchar(10) NOT NULL,
	"emp_no" int NOT NULL,
	"from_date" DATE NOT NULL,
	"to_date" DATE NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "employees" (
	"emp_no" int NOT NULL,
	"birth_date" DATE NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_name" varchar(255) NOT NULL,
	"gender" varchar(5) NOT NULL,
	"hire_date" DATE NOT NULL,
	CONSTRAINT "employees_pk" PRIMARY KEY ("emp_no")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "salaries" (
	"emp_no" int NOT NULL,
	"salary" int NOT NULL,
	"from_date" DATE NOT NULL,
	"to_date" DATE NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "titles" (
	"emp_no" int NOT NULL,
	"title" varchar(255) NOT NULL,
	"from_date" DATE NOT NULL,
	"to_date" DATE NOT NULL
) WITH (
  OIDS=FALSE
);




ALTER TABLE "dept_emp" ADD CONSTRAINT "dept_emp_fk0" FOREIGN KEY ("dept_no") REFERENCES "departments"("dept_no");
ALTER TABLE "dept_emp" ADD CONSTRAINT "dept_emp_fk1" FOREIGN KEY ("emp_no") REFERENCES "departments"("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "dept_manager_fk0" FOREIGN KEY ("dept_no") REFERENCES "departments"("dept_no");
ALTER TABLE "dept_manager" ADD CONSTRAINT "dept_manager_fk1" FOREIGN KEY ("emp_no") REFERENCES "employees"("emp_no");


ALTER TABLE "salaries" ADD CONSTRAINT "salaries_fk0" FOREIGN KEY ("emp_no") REFERENCES "employees"("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "titles_fk0" FOREIGN KEY ("emp_no") REFERENCES "employees"("emp_no");
