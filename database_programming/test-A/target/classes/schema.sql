
DROP TABLE GroupMember CASCADE CONSTRAINTS PURGE;



DROP TABLE ApplyList CASCADE CONSTRAINTS PURGE;



DROP TABLE Commt CASCADE CONSTRAINTS PURGE;



DROP TABLE Post CASCADE CONSTRAINTS PURGE;



DROP TABLE TRAVELGROUP CASCADE CONSTRAINTS PURGE;



DROP TABLE Member CASCADE CONSTRAINTS PURGE;

DROP SEQUENCE SEQUENCE_USER;
DROP SEQUENCE SEQUENCE_GROUP;
DROP SEQUENCE SEQUENCE_POST;
DROP SEQUENCE SEQUENCE_COMMT;


CREATE TABLE ApplyList
(
	apply_date           DATE NULL ,
	isApproved           CHAR(1) NULL ,
	approved_date        DATE NULL ,
	commt                VARCHAR2(1024) NULL ,
	group_id             NUMBER(8) NOT NULL ,
	user_id              NUMBER(8) NOT NULL 
);



CREATE UNIQUE INDEX XPKApplyList ON ApplyList
(group_id   ASC,user_id   ASC);



ALTER TABLE ApplyList
	ADD CONSTRAINT  XPKApplyList PRIMARY KEY (group_id,user_id);



CREATE TABLE Commt
(
	comment_id           NUMBER(8) NOT NULL ,
	created_date         DATE NULL ,
	modified_date        DATE NULL ,
	content              VARCHAR2(500) NULL ,
	writer_id            NUMBER(8) NULL ,
	post_id              NUMBER(8) NOT NULL ,
	group_id             NUMBER(8) NULL 
);



CREATE UNIQUE INDEX XPKComment ON Commt
(comment_id   ASC,post_id   ASC);



ALTER TABLE Commt
	ADD CONSTRAINT  XPKComment PRIMARY KEY (comment_id,post_id);



CREATE TABLE GroupMember
(
	isLeader             CHAR(1) NULL ,
	user_id              NUMBER(8) NOT NULL ,
	group_id             NUMBER(8) NOT NULL 
);



CREATE UNIQUE INDEX XPKGroupMember ON GroupMember
(user_id   ASC,group_id   ASC);



ALTER TABLE GroupMember
	ADD CONSTRAINT  XPKGroupMember PRIMARY KEY (user_id,group_id);



CREATE TABLE Member
(
	user_id              NUMBER(8) NOT NULL ,
	email                VARCHAR2(40) NULL ,
	password             VARCHAR2(15) NULL ,
	name                 VARCHAR2(20) NULL ,
	phone                VARCHAR2(20) NULL ,
	gender               INTEGER NULL ,	
	age					 INTEGER NULL
);



CREATE UNIQUE INDEX XPKMember ON Member
(user_id   ASC);



ALTER TABLE Member
	ADD CONSTRAINT  XPKMember PRIMARY KEY (user_id);



CREATE TABLE Post
(
	post_id              NUMBER(8) NOT NULL ,
	title                VARCHAR2(50) NULL ,
	content              VARCHAR2(4000) NULL ,
	created_date         DATE NULL ,
	modified_date        DATE NULL ,
	writer_id            NUMBER(8) NULL ,
	group_id             NUMBER(8) NULL 
);



CREATE UNIQUE INDEX XPKPost ON Post
(post_id   ASC);



ALTER TABLE Post
	ADD CONSTRAINT  XPKPost PRIMARY KEY (post_id);



CREATE TABLE TRAVELGROUP
(
	created_date          DATE NULL ,
	number_of_member     INTEGER NULL ,
	name                 VARCHAR2(20) NULL ,
	term                 INTEGER NULL ,
	gender_type          CHAR(1) NULL ,
	age                  INTEGER NULL ,
	description          VARCHAR2(2048) NULL ,
	traffic              VARCHAR2(20) NULL ,
	place                VARCHAR2(20) NULL ,
	leader_id            NUMBER(8) NULL ,
	group_id             NUMBER(8) NOT NULL 
);

CREATE SEQUENCE SEQUENCE_USER
	START WITH 1
	INCREMENT BY 1; 
	
CREATE SEQUENCE SEQUENCE_GROUP
	START WITH 1
	INCREMENT BY 1; 
	
CREATE SEQUENCE SEQUENCE_POST
	START WITH 1
	INCREMENT BY 1; 
	
CREATE SEQUENCE SEQUENCE_COMMT
	START WITH 1
	INCREMENT BY 1; 

CREATE UNIQUE INDEX XPKTravelGroup ON TRAVELGROUP
(group_id   ASC);



ALTER TABLE TRAVELGROUP
	ADD CONSTRAINT  XPKTravelGroup PRIMARY KEY (group_id);



ALTER TABLE ApplyList
	ADD (CONSTRAINT R_5 FOREIGN KEY (group_id) REFERENCES TRAVELGROUP (group_id));



ALTER TABLE ApplyList
	ADD (CONSTRAINT R_14 FOREIGN KEY (user_id) REFERENCES Member (user_id));



ALTER TABLE Commt
	ADD (CONSTRAINT R_6 FOREIGN KEY (writer_id) REFERENCES Member (user_id) ON DELETE SET NULL);



ALTER TABLE Commt
	ADD (CONSTRAINT R_8 FOREIGN KEY (post_id) REFERENCES Post (post_id));



ALTER TABLE Commt
	ADD (CONSTRAINT R_9 FOREIGN KEY (group_id) REFERENCES TRAVELGROUP (group_id) ON DELETE SET NULL);



ALTER TABLE GroupMember
	ADD (CONSTRAINT R_1 FOREIGN KEY (user_id) REFERENCES Member (user_id));



ALTER TABLE GroupMember
	ADD (CONSTRAINT R_4 FOREIGN KEY (group_id) REFERENCES TRAVELGROUP (group_id));



ALTER TABLE Post
	ADD (CONSTRAINT R_7 FOREIGN KEY (writer_id) REFERENCES Member (user_id) ON DELETE SET NULL);



ALTER TABLE Post
	ADD (CONSTRAINT R_10 FOREIGN KEY (group_id) REFERENCES TRAVELGROUP (group_id) ON DELETE SET NULL);



ALTER TABLE TRAVELGROUP
	ADD (CONSTRAINT R_3 FOREIGN KEY (leader_id) REFERENCES Member (user_id) ON DELETE SET NULL);



