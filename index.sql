BEGIN;


CREATE TABLE IF NOT EXISTS account."user"
(
    id integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    age integer,
    gender character varying(1) COLLATE pg_catalog."default",
    email character varying COLLATE pg_catalog."default",
    phone_number character varying COLLATE pg_catalog."default",
    blog_subscription boolean,
    CONSTRAINT user_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS assessement.option
(
    id integer NOT NULL,
    option character varying COLLATE pg_catalog."default" NOT NULL,
    value integer NOT NULL,
    CONSTRAINT option_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS assessement.question
(
    id integer NOT NULL,
    "Question" character varying COLLATE pg_catalog."default",
    CONSTRAINT question_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS assessement.question_option
(
    question_id integer NOT NULL,
    option_id integer NOT NULL,
    CONSTRAINT pk_question_option PRIMARY KEY (option_id, question_id)
);

CREATE TABLE IF NOT EXISTS assessement.result
(
    id integer NOT NULL,
    result character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT result_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS assessement.user_result
(
    user_id integer NOT NULL,
    result_id integer NOT NULL,
    "timestamp" time with time zone NOT NULL,
    date date NOT NULL,
    CONSTRAINT pk_user_result PRIMARY KEY (user_id, result_id, "timestamp", date)
);

CREATE TABLE IF NOT EXISTS center.booking
(
    user_id integer NOT NULL,
    center_id integer NOT NULL,
    "timestamp" time with time zone NOT NULL,
    preferred_date date NOT NULL,
    preferred_time time with time zone NOT NULL,
    CONSTRAINT pk_booking PRIMARY KEY (user_id, center_id)
);

CREATE TABLE IF NOT EXISTS center.center
(
    id integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    latitude integer NOT NULL,
    longtiude integer NOT NULL,
    phone_number character varying COLLATE pg_catalog."default" NOT NULL,
    "Type" character varying COLLATE pg_catalog."default" NOT NULL,
    email character varying COLLATE pg_catalog."default" NOT NULL,
    pobox character varying COLLATE pg_catalog."default",
    ceo_id character varying COLLATE pg_catalog."default",
    manager_id character varying COLLATE pg_catalog."default",
    director_id character varying COLLATE pg_catalog."default",
    CONSTRAINT "Center_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS center.center_pro
(
    center_id integer NOT NULL,
    professional_id integer NOT NULL,
    CONSTRAINT pk_center_pro PRIMARY KEY (center_id, professional_id)
);

CREATE TABLE IF NOT EXISTS center.pro_role
(
    professional_id integer NOT NULL,
    role_id integer NOT NULL,
    CONSTRAINT pk_pro_role PRIMARY KEY (professional_id, role_id)
);

CREATE TABLE IF NOT EXISTS center.professional
(
    id integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    phone_number character varying COLLATE pg_catalog."default",
    email character varying COLLATE pg_catalog."default",
    role name COLLATE pg_catalog."C",
    CONSTRAINT professional_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS center.role
(
    id integer NOT NULL,
    role character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT role_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS chat.message
(
    id integer NOT NULL,
    content character varying COLLATE pg_catalog."default",
    CONSTRAINT message_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS chat.sent_message
(
    sender_id integer NOT NULL,
    professional_id integer NOT NULL,
    message_id integer NOT NULL,
    "timestamp" time with time zone,
    date date,
    CONSTRAINT pk_sent_message PRIMARY KEY (sender_id, professional_id, message_id)
);

CREATE TABLE IF NOT EXISTS vent.comment
(
    id integer NOT NULL,
    comment character varying COLLATE pg_catalog."default" NOT NULL,
    date date NOT NULL,
    "time" time with time zone NOT NULL,
    CONSTRAINT comment_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS vent.vent
(
    id integer NOT NULL,
    vent character varying COLLATE pg_catalog."default" NOT NULL,
    date date NOT NULL,
    "time" time with time zone NOT NULL,
    CONSTRAINT vent_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS vent.vent_comment
(
    vent_id integer NOT NULL,
    comment_id integer NOT NULL,
    comment_by integer NOT NULL,
    CONSTRAINT pk_vent_comment PRIMARY KEY (comment_by, comment_id, vent_id)
);

CREATE TABLE IF NOT EXISTS vent.vent_user
(
    user_id integer NOT NULL,
    vent_id integer NOT NULL,
    CONSTRAINT vent_user_pkey PRIMARY KEY (user_id, vent_id)
);

ALTER TABLE IF EXISTS assessement.question_option
    ADD CONSTRAINT "FK_question_option_option_id" FOREIGN KEY (option_id)
    REFERENCES assessement.option (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS assessement.question_option
    ADD CONSTRAINT "FK_question_option_question_id" FOREIGN KEY (question_id)
    REFERENCES assessement.question (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS assessement.user_result
    ADD CONSTRAINT "FK_user_result_result_id" FOREIGN KEY (result_id)
    REFERENCES assessement.result (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS assessement.user_result
    ADD CONSTRAINT "FK_user_result_user_id" FOREIGN KEY (user_id)
    REFERENCES account."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS center.booking
    ADD CONSTRAINT "FK_booking_center_id" FOREIGN KEY (center_id)
    REFERENCES center.center (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS center.booking
    ADD CONSTRAINT "FK_booking_user_id" FOREIGN KEY (user_id)
    REFERENCES account."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS center.center_pro
    ADD CONSTRAINT "FK_center_center_id" FOREIGN KEY (center_id)
    REFERENCES center.center (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS center.center_pro
    ADD CONSTRAINT "FK_pro_pro_id" FOREIGN KEY (professional_id)
    REFERENCES center.professional (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS center.pro_role
    ADD CONSTRAINT "FK_pro_role_pro_id" FOREIGN KEY (professional_id)
    REFERENCES center.professional (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS center.pro_role
    ADD CONSTRAINT "FK_pro_role_role_id" FOREIGN KEY (role_id)
    REFERENCES center.role (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS chat.sent_message
    ADD CONSTRAINT "FK_sent_message_message_id" FOREIGN KEY (message_id)
    REFERENCES chat.message (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS chat.sent_message
    ADD CONSTRAINT "FK_sent_message_professional" FOREIGN KEY (professional_id)
    REFERENCES center.professional (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS chat.sent_message
    ADD CONSTRAINT "FK_sent_message_sender" FOREIGN KEY (sender_id)
    REFERENCES account."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS vent.vent_comment
    ADD CONSTRAINT "FK_vent_comment_comment" FOREIGN KEY (comment_id)
    REFERENCES vent.comment (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS vent.vent_comment
    ADD CONSTRAINT "FK_vent_comment_user" FOREIGN KEY (comment_by)
    REFERENCES account."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS vent.vent_comment
    ADD CONSTRAINT "FK_vent_comment_vent" FOREIGN KEY (vent_id)
    REFERENCES vent.vent (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

END;