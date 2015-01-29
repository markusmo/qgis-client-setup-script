--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: analyzedtrip; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE analyzedtrip (
    id_analyzedtrip integer NOT NULL,
    id_startwaypoint integer NOT NULL,
    id_endwaypoint integer NOT NULL,
    id_transportline integer,
    id_transporttype integer NOT NULL
);


ALTER TABLE public.analyzedtrip OWNER TO bigdata;

--
-- Name: analyzedtrip_id_analyzedtrip_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE analyzedtrip_id_analyzedtrip_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analyzedtrip_id_analyzedtrip_seq OWNER TO bigdata;

--
-- Name: analyzedtrip_id_analyzedtrip_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE analyzedtrip_id_analyzedtrip_seq OWNED BY analyzedtrip.id_analyzedtrip;


--
-- Name: searchtable; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE searchtable (
    searchstring text,
    displaytext text NOT NULL,
    search_category text,
    the_geom geometry,
    geometry_type text,
    searchstring_tsvector tsvector,
    showlayer character varying(256)
);


ALTER TABLE public.searchtable OWNER TO bigdata;

--
-- Name: track; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE track (
    id_track integer NOT NULL,
    name character varying(60) NOT NULL,
    id_user integer NOT NULL
);


ALTER TABLE public.track OWNER TO bigdata;

--
-- Name: track_id_track_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE track_id_track_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.track_id_track_seq OWNER TO bigdata;

--
-- Name: track_id_track_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE track_id_track_seq OWNED BY track.id_track;


--
-- Name: transportline; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE transportline (
    id_transportline bigint NOT NULL,
    name character varying(255) NOT NULL,
    id_type integer NOT NULL,
    ref character varying(255)
);


ALTER TABLE public.transportline OWNER TO bigdata;

--
-- Name: transportline_id_transportline_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE transportline_id_transportline_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transportline_id_transportline_seq OWNER TO bigdata;

--
-- Name: transportline_id_transportline_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE transportline_id_transportline_seq OWNED BY transportline.id_transportline;


--
-- Name: transportline_station; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE transportline_station (
    id_transportline_station integer NOT NULL,
    id_transportline bigint NOT NULL,
    id_transportstation bigint NOT NULL,
    sequence integer
);


ALTER TABLE public.transportline_station OWNER TO bigdata;

--
-- Name: transportline_station_id_transportline_station_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE transportline_station_id_transportline_station_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transportline_station_id_transportline_station_seq OWNER TO bigdata;

--
-- Name: transportline_station_id_transportline_station_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE transportline_station_id_transportline_station_seq OWNED BY transportline_station.id_transportline_station;


--
-- Name: transportstation; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE transportstation (
    id_transportstation bigint NOT NULL,
    name character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    bench boolean,
    shelter boolean,
    point geometry
);


ALTER TABLE public.transportstation OWNER TO bigdata;

--
-- Name: transportstation_id_transportstation_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE transportstation_id_transportstation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transportstation_id_transportstation_seq OWNER TO bigdata;

--
-- Name: transportstation_id_transportstation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE transportstation_id_transportstation_seq OWNED BY transportstation.id_transportstation;


--
-- Name: transporttype; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE transporttype (
    id_transporttype integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.transporttype OWNER TO bigdata;

--
-- Name: transporttype_id_transporttype_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE transporttype_id_transporttype_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transporttype_id_transporttype_seq OWNER TO bigdata;

--
-- Name: transporttype_id_transporttype_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE transporttype_id_transporttype_seq OWNED BY transporttype.id_transporttype;


--
-- Name: user_account; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE user_account (
    id_user integer NOT NULL,
    prename character varying(80) NOT NULL,
    lastname character varying(80) NOT NULL
);


ALTER TABLE public.user_account OWNER TO bigdata;

--
-- Name: user_account_id_user_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE user_account_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_account_id_user_seq OWNER TO bigdata;

--
-- Name: user_account_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE user_account_id_user_seq OWNED BY user_account.id_user;


--
-- Name: waypoint; Type: TABLE; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE TABLE waypoint (
    id_waypoint integer NOT NULL,
    time_stamp timestamp with time zone NOT NULL,
    pnt geometry NOT NULL,
    speed double precision,
    accuracy double precision,
    altitude smallint,
    satelittes smallint,
    sequence_no integer NOT NULL,
    id_track integer NOT NULL
);


ALTER TABLE public.waypoint OWNER TO bigdata;

--
-- Name: waypoint_id_waypoint_seq; Type: SEQUENCE; Schema: public; Owner: bigdata
--

CREATE SEQUENCE waypoint_id_waypoint_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.waypoint_id_waypoint_seq OWNER TO bigdata;

--
-- Name: waypoint_id_waypoint_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigdata
--

ALTER SEQUENCE waypoint_id_waypoint_seq OWNED BY waypoint.id_waypoint;


--
-- Name: id_analyzedtrip; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY analyzedtrip ALTER COLUMN id_analyzedtrip SET DEFAULT nextval('analyzedtrip_id_analyzedtrip_seq'::regclass);


--
-- Name: id_track; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY track ALTER COLUMN id_track SET DEFAULT nextval('track_id_track_seq'::regclass);


--
-- Name: id_transportline; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY transportline ALTER COLUMN id_transportline SET DEFAULT nextval('transportline_id_transportline_seq'::regclass);


--
-- Name: id_transportline_station; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY transportline_station ALTER COLUMN id_transportline_station SET DEFAULT nextval('transportline_station_id_transportline_station_seq'::regclass);


--
-- Name: id_transportstation; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY transportstation ALTER COLUMN id_transportstation SET DEFAULT nextval('transportstation_id_transportstation_seq'::regclass);


--
-- Name: id_transporttype; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY transporttype ALTER COLUMN id_transporttype SET DEFAULT nextval('transporttype_id_transporttype_seq'::regclass);


--
-- Name: id_user; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY user_account ALTER COLUMN id_user SET DEFAULT nextval('user_account_id_user_seq'::regclass);


--
-- Name: id_waypoint; Type: DEFAULT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY waypoint ALTER COLUMN id_waypoint SET DEFAULT nextval('waypoint_id_waypoint_seq'::regclass);


--
-- Name: analyzedtrip_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY analyzedtrip
    ADD CONSTRAINT analyzedtrip_pkey PRIMARY KEY (id_analyzedtrip);


--
-- Name: searchtable_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY searchtable
    ADD CONSTRAINT searchtable_pkey PRIMARY KEY (displaytext);


--
-- Name: track_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY track
    ADD CONSTRAINT track_pkey PRIMARY KEY (id_track);


--
-- Name: transportline_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY transportline
    ADD CONSTRAINT transportline_pkey PRIMARY KEY (id_transportline);


--
-- Name: transportline_station_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY transportline_station
    ADD CONSTRAINT transportline_station_pkey PRIMARY KEY (id_transportline_station);


--
-- Name: transportstation_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY transportstation
    ADD CONSTRAINT transportstation_pkey PRIMARY KEY (id_transportstation);


--
-- Name: transporttype_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY transporttype
    ADD CONSTRAINT transporttype_pkey PRIMARY KEY (id_transporttype);


--
-- Name: user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id_user);


--
-- Name: waypoint_pkey; Type: CONSTRAINT; Schema: public; Owner: bigdata; Tablespace: 
--

ALTER TABLE ONLY waypoint
    ADD CONSTRAINT waypoint_pkey PRIMARY KEY (id_waypoint);


--
-- Name: fki_transporttype_fk; Type: INDEX; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE INDEX fki_transporttype_fk ON analyzedtrip USING btree (id_transporttype);


--
-- Name: in_searchstring_tsvector_gin; Type: INDEX; Schema: public; Owner: bigdata; Tablespace: 
--

CREATE INDEX in_searchstring_tsvector_gin ON searchtable USING gin (searchstring_tsvector);


--
-- Name: end_point_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY analyzedtrip
    ADD CONSTRAINT end_point_fk FOREIGN KEY (id_endwaypoint) REFERENCES waypoint(id_waypoint);


--
-- Name: start_point_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY analyzedtrip
    ADD CONSTRAINT start_point_fk FOREIGN KEY (id_startwaypoint) REFERENCES waypoint(id_waypoint);


--
-- Name: track_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY waypoint
    ADD CONSTRAINT track_fk FOREIGN KEY (id_track) REFERENCES track(id_track) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: transportline_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY analyzedtrip
    ADD CONSTRAINT transportline_fk FOREIGN KEY (id_transportline) REFERENCES transportline(id_transportline);


--
-- Name: transportline_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY transportline_station
    ADD CONSTRAINT transportline_fk FOREIGN KEY (id_transportline) REFERENCES transportline(id_transportline);


--
-- Name: transportstation_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY transportline_station
    ADD CONSTRAINT transportstation_fk FOREIGN KEY (id_transportstation) REFERENCES transportstation(id_transportstation);


--
-- Name: transporttype_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY analyzedtrip
    ADD CONSTRAINT transporttype_fk FOREIGN KEY (id_transporttype) REFERENCES transporttype(id_transporttype);


--
-- Name: type_transportline_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY transportline
    ADD CONSTRAINT type_transportline_fk FOREIGN KEY (id_type) REFERENCES transporttype(id_transporttype);


--
-- Name: user_fk; Type: FK CONSTRAINT; Schema: public; Owner: bigdata
--

ALTER TABLE ONLY track
    ADD CONSTRAINT user_fk FOREIGN KEY (id_user) REFERENCES user_account(id_user) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: searchtable; Type: ACL; Schema: public; Owner: bigdata
--

REVOKE ALL ON TABLE searchtable FROM PUBLIC;
REVOKE ALL ON TABLE searchtable FROM bigdata;
GRANT ALL ON TABLE searchtable TO bigdata;


--
-- PostgreSQL database dump complete
--

