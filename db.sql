--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2023-05-11 13:23:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 24587)
-- Name: general; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA general;


ALTER SCHEMA general OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 24588)
-- Name: adolf_the_hitler(); Type: PROCEDURE; Schema: general; Owner: postgres
--

CREATE PROCEDURE general.adolf_the_hitler()
    LANGUAGE sql
    AS $$ 
UPDATE general.users 
SET first_name = 'Adolf' 
WHERE last_name = 'Hitler'; 
$$;


ALTER PROCEDURE general.adolf_the_hitler() OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 24589)
-- Name: calc_coupon(integer); Type: FUNCTION; Schema: general; Owner: postgres
--

CREATE FUNCTION general.calc_coupon(perc integer) RETURNS integer
    LANGUAGE sql
    AS $$
SELECT (MAX(price)/100) * perc
FROM general.dishes;
$$;


ALTER FUNCTION general.calc_coupon(perc integer) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 24590)
-- Name: deactivate_blocked(); Type: FUNCTION; Schema: general; Owner: postgres
--

CREATE FUNCTION general.deactivate_blocked() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN
	IF NEW.last_name IN (SELECT last_name FROM general.blocked_names) AND NEW.first_name IN (SELECT first_name FROM general.blocked_names) THEN
		CALL general.deactivate_user(NEW.id);
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION general.deactivate_blocked() OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 24591)
-- Name: deactivate_user(bigint); Type: PROCEDURE; Schema: general; Owner: postgres
--

CREATE PROCEDURE general.deactivate_user(IN u_id bigint)
    LANGUAGE sql
    AS $$
	UPDATE general.credentials
	SET active = false
	WHERE user_id = u_id;
	UPDATE general.users
	SET active = false
	WHERE id = u_id;
$$;


ALTER PROCEDURE general.deactivate_user(IN u_id bigint) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 24592)
-- Name: delete_order(integer); Type: PROCEDURE; Schema: general; Owner: postgres
--

CREATE PROCEDURE general.delete_order(IN o_id integer)
    LANGUAGE sql
    AS $$
DELETE FROM general.orders_dishes
WHERE order_id = o_id;
DELETE FROM general.orders
WHERE id = o_id;
$$;


ALTER PROCEDURE general.delete_order(IN o_id integer) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 24593)
-- Name: generate_coupon(); Type: FUNCTION; Schema: general; Owner: postgres
--

CREATE FUNCTION general.generate_coupon() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE b bigint;
	BEGIN
		IF NEW.id = (SELECT MAX(id) FROM general.dishes) THEN
			SELECT MAX(id) FROM general.coupons INTO b;
			b := b + 1;
			INSERT INTO general.coupons VALUES (
				b,
				CONCAT(NEW.name, '_NEW'),
				10,
				Now() + interval '48 hours'
			);
			INSERT INTO general.coupons_dishes VALUES (b, NEW.id);
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION general.generate_coupon() OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 24594)
-- Name: get_order_dishes(integer); Type: FUNCTION; Schema: general; Owner: postgres
--

CREATE FUNCTION general.get_order_dishes(o_id integer) RETURNS TABLE(id integer, name text, price numeric)
    LANGUAGE sql
    AS $$
SELECT d.id, d.name, d.price 
FROM general.dishes AS d
WHERE d.id IN (SELECT od.dish_id FROM general.orders_dishes AS od WHERE od.order_id = o_id);
$$;


ALTER FUNCTION general.get_order_dishes(o_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 24595)
-- Name: addresses; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.addresses (
    id bigint NOT NULL,
    country character varying(64) NOT NULL,
    city character varying(86) NOT NULL,
    state_province character varying(128),
    apartment character varying(32),
    address character varying(128) NOT NULL,
    zip_postal character varying(32),
    user_id bigint NOT NULL
);


ALTER TABLE general.addresses OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24598)
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: general; Owner: postgres
--

CREATE SEQUENCE general.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.addresses_id_seq OWNER TO postgres;

--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 210
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: postgres
--

ALTER SEQUENCE general.addresses_id_seq OWNED BY general.addresses.id;


--
-- TOC entry 211 (class 1259 OID 24599)
-- Name: blocked_names; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.blocked_names (
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL
);


ALTER TABLE general.blocked_names OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24604)
-- Name: coupons; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.coupons (
    id bigint NOT NULL,
    coupon character varying(32) NOT NULL,
    discount integer NOT NULL,
    valid_until timestamp with time zone NOT NULL
);


ALTER TABLE general.coupons OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24607)
-- Name: coupons_dishes; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.coupons_dishes (
    coupon_id bigint NOT NULL,
    dish_id bigint NOT NULL
);


ALTER TABLE general.coupons_dishes OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24610)
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: general; Owner: postgres
--

CREATE SEQUENCE general.coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.coupons_id_seq OWNER TO postgres;

--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 214
-- Name: coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: postgres
--

ALTER SEQUENCE general.coupons_id_seq OWNED BY general.coupons.id;


--
-- TOC entry 216 (class 1259 OID 24614)
-- Name: credentials_id_seq; Type: SEQUENCE; Schema: general; Owner: postgres
--

CREATE SEQUENCE general.credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.credentials_id_seq OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24611)
-- Name: credentials; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.credentials (
    id bigint DEFAULT nextval('general.credentials_id_seq'::regclass) NOT NULL,
    email character varying(150) NOT NULL,
    password character varying(256) NOT NULL,
    user_id bigint NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE general.credentials OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24615)
-- Name: dishes; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.dishes (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(512),
    price numeric NOT NULL
);


ALTER TABLE general.dishes OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24620)
-- Name: dishes_id_seq; Type: SEQUENCE; Schema: general; Owner: postgres
--

CREATE SEQUENCE general.dishes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.dishes_id_seq OWNER TO postgres;

--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 218
-- Name: dishes_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: postgres
--

ALTER SEQUENCE general.dishes_id_seq OWNED BY general.dishes.id;


--
-- TOC entry 219 (class 1259 OID 24621)
-- Name: dishes_images; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.dishes_images (
    dish_id integer NOT NULL,
    image_id bigint NOT NULL
);


ALTER TABLE general.dishes_images OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24624)
-- Name: orders; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.orders (
    id bigint NOT NULL,
    "time" timestamp without time zone NOT NULL,
    price numeric NOT NULL,
    user_id integer NOT NULL,
    address_id bigint NOT NULL
);


ALTER TABLE general.orders OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24629)
-- Name: orders_dishes; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.orders_dishes (
    order_id bigint NOT NULL,
    dish_id integer NOT NULL,
    quantity integer
);


ALTER TABLE general.orders_dishes OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24632)
-- Name: get_orders_with_dish2; Type: VIEW; Schema: general; Owner: postgres
--

CREATE VIEW general.get_orders_with_dish2 AS
 SELECT o.id,
    o."time",
    o.price,
    o.user_id,
    o.address_id
   FROM general.orders o
  WHERE (o.id IN ( SELECT od.order_id
           FROM general.orders_dishes od
          WHERE (od.dish_id = 2)))
  WITH CASCADED CHECK OPTION;


ALTER TABLE general.get_orders_with_dish2 OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24636)
-- Name: images; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.images (
    id integer NOT NULL,
    image_name character varying(255) NOT NULL,
    image_url character varying(255) NOT NULL
);


ALTER TABLE general.images OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24641)
-- Name: images_id_seq; Type: SEQUENCE; Schema: general; Owner: postgres
--

CREATE SEQUENCE general.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.images_id_seq OWNER TO postgres;

--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 224
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: postgres
--

ALTER SEQUENCE general.images_id_seq OWNED BY general.images.id;


--
-- TOC entry 225 (class 1259 OID 24642)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: general; Owner: postgres
--

CREATE SEQUENCE general.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.orders_id_seq OWNER TO postgres;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 225
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: general; Owner: postgres
--

ALTER SEQUENCE general.orders_id_seq OWNED BY general.orders.id;


--
-- TOC entry 226 (class 1259 OID 24643)
-- Name: orders_to_address3; Type: VIEW; Schema: general; Owner: postgres
--

CREATE VIEW general.orders_to_address3 AS
 SELECT o.id,
    o."time",
    o.price,
    o.user_id,
    o.address_id
   FROM general.orders o
  WHERE (o.address_id = 3)
  WITH CASCADED CHECK OPTION;


ALTER TABLE general.orders_to_address3 OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24647)
-- Name: user_orders_count; Type: VIEW; Schema: general; Owner: postgres
--

CREATE VIEW general.user_orders_count AS
 SELECT orders.user_id,
    count(*) AS count
   FROM general.orders
  GROUP BY orders.user_id
 HAVING (orders.user_id IS NOT NULL);


ALTER TABLE general.user_orders_count OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24654)
-- Name: users_id_seq; Type: SEQUENCE; Schema: general; Owner: postgres
--

CREATE SEQUENCE general.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE general.users_id_seq OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24651)
-- Name: users; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.users (
    id bigint DEFAULT nextval('general.users_id_seq'::regclass) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    phone_num bigint,
    active boolean NOT NULL
);


ALTER TABLE general.users OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 24750)
-- Name: users_coupons; Type: TABLE; Schema: general; Owner: postgres
--

CREATE TABLE general.users_coupons (
    user_id bigint NOT NULL,
    coupon_id bigint NOT NULL
);


ALTER TABLE general.users_coupons OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24655)
-- Name: usr_info_part; Type: VIEW; Schema: general; Owner: postgres
--

CREATE VIEW general.usr_info_part AS
 SELECT u.first_name,
    u.last_name,
    oc.count
   FROM (general.user_orders_count oc
     RIGHT JOIN general.users u ON ((oc.user_id = u.id)));


ALTER TABLE general.usr_info_part OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24659)
-- Name: verified_users; Type: VIEW; Schema: general; Owner: postgres
--

CREATE VIEW general.verified_users AS
 SELECT users.first_name,
    users.last_name
   FROM general.users
  WHERE (users.id IN ( SELECT orders.user_id
           FROM general.orders
          WHERE (orders.price > (15)::numeric)));


ALTER TABLE general.verified_users OWNER TO postgres;

--
-- TOC entry 3241 (class 2604 OID 24663)
-- Name: addresses id; Type: DEFAULT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.addresses ALTER COLUMN id SET DEFAULT nextval('general.addresses_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 24664)
-- Name: coupons id; Type: DEFAULT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.coupons ALTER COLUMN id SET DEFAULT nextval('general.coupons_id_seq'::regclass);


--
-- TOC entry 3244 (class 2604 OID 24666)
-- Name: dishes id; Type: DEFAULT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.dishes ALTER COLUMN id SET DEFAULT nextval('general.dishes_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 24667)
-- Name: images id; Type: DEFAULT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.images ALTER COLUMN id SET DEFAULT nextval('general.images_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 24668)
-- Name: orders id; Type: DEFAULT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.orders ALTER COLUMN id SET DEFAULT nextval('general.orders_id_seq'::regclass);


--
-- TOC entry 3431 (class 0 OID 24595)
-- Dependencies: 209
-- Data for Name: addresses; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.addresses (id, country, city, state_province, apartment, address, zip_postal, user_id) FROM stdin;
1	USA	Albuquerque	\N	\N	308 Negra Arroyo Lane	\N	1
2	USA	Albuquerque	\N	\N	322 16th St SW	\N	3
3	USA	Kansas City	\N	\N	3200 N 63RD TER	\N	2
4	USA	Walla Walla	Washington		604 Juniper St	99362	1
5	USA	Arlington	Washington		Po Box 384	98223	1
6	USA	Camp Point	Illinois		302 E Prairie St	62320	2
7	USA	Manassas	Virginia		14135 Baneberry Cir	20112	2
8	USA	Brookeville	Maryland		2936 Vandever St	20883	3
9	USA	1184 Fraizer Rd	Missouri		1184 Fraizer Rd	65631	3
10	Ukraine	Kyiv	Kyivska Oblast	5	Zoolohichna St, 4A	 04119	6
11	Ukraine	Lvyv	Lviv Oblast	186	Marii Zan'kovets'koi St, 1	79000	6
\.


--
-- TOC entry 3433 (class 0 OID 24599)
-- Dependencies: 211
-- Data for Name: blocked_names; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.blocked_names (first_name, last_name) FROM stdin;
Adolf	Hitler
\.


--
-- TOC entry 3434 (class 0 OID 24604)
-- Dependencies: 212
-- Data for Name: coupons; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.coupons (id, coupon, discount, valid_until) FROM stdin;
1	ADMINONLY	100	2023-05-05 15:09:03.198053+00
2	Springtrap_NEW	10	2023-05-07 15:35:24.348733+00
\.


--
-- TOC entry 3435 (class 0 OID 24607)
-- Dependencies: 213
-- Data for Name: coupons_dishes; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.coupons_dishes (coupon_id, dish_id) FROM stdin;
1	1
1	2
1	3
1	4
2	6
\.


--
-- TOC entry 3437 (class 0 OID 24611)
-- Dependencies: 215
-- Data for Name: credentials; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.credentials (id, email, password, user_id, active) FROM stdin;
2	walterHW@gmail.com	a4bcfb42dd5cca32cc36f56e1e8b6d8e	1	f
3	johndoe@email.com	296fbe2a41f0cde8770190e4164a5b34	2	t
4	yo@yo.yo	049a0911489c247198a9f57b1ca47636	3	t
5	johnNotWeak@hotmail.com	0388d1388491608d4f742b12a1328219	4	t
7	n4zz1@edu.surgu.ru	a4bcfb42dd5cca32cc36f56e1e8b6d8e	5	f
8	admin@ffpzza.com	e64b78fc3bc91bcbc7dc232ba8ec59e0	6	t
12	fleng@gmail.com	2af9b1ba42dc5eb01743e6b3759b6e4b	10	t
13	dgordon@gmail.com	2af9b1ba42dc5eb01743e6b3759b6e4b	11	t
19	pparker4@gmail.com	2af9b1ba42dc5eb01743e6b3759b6e4b	12	f
20	pparker5@gmail.com	2af9b1ba42dc5eb01743e6b3759b6e4b	12	f
21	pparker@gmail.comm	2af9b1ba42dc5eb01743e6b3759b6e4b	12	t
6	walterhw@gmail.com	2af9b1ba42dc5eb01743e6b3759b6e4b	1	f
22	wwhite@gmail.com	2af9b1ba42dc5eb01743e6b3759b6e4b	1	t
\.


--
-- TOC entry 3439 (class 0 OID 24615)
-- Dependencies: 217
-- Data for Name: dishes; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.dishes (id, name, description, price) FROM stdin;
1	Mozzarella Pizza	Mozzarella pizza is a classic dish that never fails to satisfy. The creamy, stretchy mozzarella cheese is the perfect complement to the savory tomato sauce and crispy crust. This combination of textures and flavors makes for a delicious and satisfying meal that is loved by people of all ages.	9.99
2	Chicas Cupcake	The most delicious cupcake in the universe!	4.99
3	Pepperoni Pizza	Some dough, some cheese, some pepperoni. Perfect balance.	9.99
4	Bacon Egg	Huh	99.99
5	Golden Freddy	Who even added this to the menu?	69.69
6	Springtrap	I always come back	69.69
\.


--
-- TOC entry 3441 (class 0 OID 24621)
-- Dependencies: 219
-- Data for Name: dishes_images; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.dishes_images (dish_id, image_id) FROM stdin;
1	1
1	10
1	11
2	4
2	5
2	6
3	7
3	8
3	9
4	12
\.


--
-- TOC entry 3444 (class 0 OID 24636)
-- Dependencies: 223
-- Data for Name: images; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.images (id, image_name, image_url) FROM stdin;
1	mozzarella_pizza.png	https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flickr.com%2Fphotos%2Favlxyz%2F49733356306&psig=AOvVaw0V4qfgA6V4Ep0qN81YQrSo&ust=1676285508674000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCOCHtKToj_0CFQAAAAAdAAAAABAE
4	chicas_cupcake1.png	https://www.google.com/url?sa=i&url=https%3A%2F%2Ffnaf-the.fandom.com%2Fwiki%2FCupcake&psig=AOvVaw1apXueve-Dd92h8EwoIqpP&ust=1677569823729000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNi5192Ytf0CFQAAAAAdAAAAABAE
5	chicas_cupcake2.jpg	https://cdna.artstation.com/p/assets/images/images/045/247/064/large/tristian-giles-cakerender.jpg?1642270480
6	chicas_cupcake3.png	https://static.wikia.nocookie.net/freddy-fazbears-pizza/images/9/9d/MrCupcake-Icon.png/revision/latest/smart/width/400/height/225?cb=20210219004155
7	pepperoni_pizza1.jpeg	https://i.imgur.com/xiYfMWO.jpeg
8	pepperoni_pizza2.jpeg	https://i.imgur.com/eMiW4RT.jpeg
9	pepperoni_pizza3.jpeg	https://i.imgur.com/3ttusXM.jpeg
10	mozzarella_pizza2.gif	https://i.imgur.com/BL7WlP6.gif
11	mozzarella_pizza3.jpeg	https://i.imgur.com/9vqAhmv.jpeg
12	baconegg.png	https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flickr.com%2Fphotos%2Favlxyz%2F49733356306&psig=AOvVaw0V4qfgA6V4Ep0qN81YQrSo&ust=1676285508674000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCOCHtKToj_0CFQAAAAAdAAAAABAE
\.


--
-- TOC entry 3442 (class 0 OID 24624)
-- Dependencies: 220
-- Data for Name: orders; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.orders (id, "time", price, user_id, address_id) FROM stdin;
2	2023-02-12 06:01:09.499158	9.99	1	1
3	2023-03-04 05:43:40.469114	4.99	1	1
5	2023-03-04 05:44:06.508029	14.98	2	3
6	2023-03-04 05:44:14.076695	4.99	2	3
7	2023-03-04 05:44:26.132622	19.98	2	3
4	2023-03-04 05:43:53.192276	14.98	1	4
8	2023-03-04 05:46:45.893747	19.98	3	8
9	2023-03-04 05:46:56.042206	4.99	3	9
10	2023-03-04 05:47:04.839891	9.99	3	9
11	2023-03-25 10:30:13.755497	9.99	1	1
12	2023-04-28 16:57:47.690296	9.98	2	3
13	2023-04-28 16:59:46.315196	14.98	3	5
14	2023-05-06 10:02:39.301588	4.99	2	3
15	2023-05-06 10:03:10.349537	9.99	2	3
16	2023-05-08 17:30:42.12823	9.99	6	10
17	2023-05-08 17:50:47.707106	9.99	6	11
\.


--
-- TOC entry 3443 (class 0 OID 24629)
-- Dependencies: 221
-- Data for Name: orders_dishes; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.orders_dishes (order_id, dish_id, quantity) FROM stdin;
2	1	1
3	2	1
4	1	1
4	3	1
5	3	1
5	2	1
6	2	1
7	1	1
7	3	1
8	1	1
8	3	1
9	2	1
10	1	1
11	1	3
14	2	1
15	1	1
16	1	1
17	1	1
\.


--
-- TOC entry 3447 (class 0 OID 24651)
-- Dependencies: 228
-- Data for Name: users; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.users (id, first_name, last_name, phone_num, active) FROM stdin;
2	John	Doe	\N	t
3	Jesse	Pinkman	\N	t
4	John	Wick	1234567891	t
5	Adolf	Hitler	\N	f
6	Admin	Admin	123456789	t
7	Dmitry	Gordon	\N	t
8	Mark	Feygin	\N	t
10	Felix	Lengyel	\N	t
11	Dmitry	Gordon	\N	t
12	Peter	Parker	\N	t
1	Walter	White	\N	t
\.


--
-- TOC entry 3449 (class 0 OID 24750)
-- Dependencies: 232
-- Data for Name: users_coupons; Type: TABLE DATA; Schema: general; Owner: postgres
--

COPY general.users_coupons (user_id, coupon_id) FROM stdin;
\.


--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 210
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: general; Owner: postgres
--

SELECT pg_catalog.setval('general.addresses_id_seq', 9, true);


--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 214
-- Name: coupons_id_seq; Type: SEQUENCE SET; Schema: general; Owner: postgres
--

SELECT pg_catalog.setval('general.coupons_id_seq', 1, true);


--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 216
-- Name: credentials_id_seq; Type: SEQUENCE SET; Schema: general; Owner: postgres
--

SELECT pg_catalog.setval('general.credentials_id_seq', 22, true);


--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 218
-- Name: dishes_id_seq; Type: SEQUENCE SET; Schema: general; Owner: postgres
--

SELECT pg_catalog.setval('general.dishes_id_seq', 4, true);


--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 224
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: general; Owner: postgres
--

SELECT pg_catalog.setval('general.images_id_seq', 12, true);


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 225
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: general; Owner: postgres
--

SELECT pg_catalog.setval('general.orders_id_seq', 10, true);


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: general; Owner: postgres
--

SELECT pg_catalog.setval('general.users_id_seq', 12, true);


--
-- TOC entry 3249 (class 2606 OID 24671)
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 24673)
-- Name: coupons coupon_unique; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.coupons
    ADD CONSTRAINT coupon_unique UNIQUE (coupon);


--
-- TOC entry 3255 (class 2606 OID 24675)
-- Name: coupons_dishes coupons_dishes_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.coupons_dishes
    ADD CONSTRAINT coupons_dishes_pkey PRIMARY KEY (coupon_id, dish_id);


--
-- TOC entry 3253 (class 2606 OID 24677)
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- TOC entry 3257 (class 2606 OID 24679)
-- Name: credentials credentials_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.credentials
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (id);


--
-- TOC entry 3261 (class 2606 OID 24681)
-- Name: dishes_images dishes_images_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.dishes_images
    ADD CONSTRAINT dishes_images_pkey PRIMARY KEY (dish_id, image_id);


--
-- TOC entry 3259 (class 2606 OID 24683)
-- Name: dishes dishes_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.dishes
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (id);


--
-- TOC entry 3267 (class 2606 OID 24685)
-- Name: images images_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- TOC entry 3265 (class 2606 OID 24687)
-- Name: orders_dishes orders_dishes_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.orders_dishes
    ADD CONSTRAINT orders_dishes_pkey PRIMARY KEY (order_id, dish_id);


--
-- TOC entry 3263 (class 2606 OID 24689)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3271 (class 2606 OID 24754)
-- Name: users_coupons users_coupons_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.users_coupons
    ADD CONSTRAINT users_coupons_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3269 (class 2606 OID 24691)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2620 OID 24692)
-- Name: users deactivate_blocked; Type: TRIGGER; Schema: general; Owner: postgres
--

CREATE TRIGGER deactivate_blocked BEFORE INSERT OR UPDATE ON general.users FOR EACH ROW EXECUTE FUNCTION general.deactivate_blocked();


--
-- TOC entry 3286 (class 2620 OID 24693)
-- Name: users deactivate_hitler; Type: TRIGGER; Schema: general; Owner: postgres
--

CREATE TRIGGER deactivate_hitler BEFORE INSERT ON general.users FOR EACH ROW EXECUTE FUNCTION general.deactivate_blocked();


--
-- TOC entry 3284 (class 2620 OID 24694)
-- Name: dishes generate_coupon; Type: TRIGGER; Schema: general; Owner: postgres
--

CREATE TRIGGER generate_coupon AFTER INSERT ON general.dishes FOR EACH ROW EXECUTE FUNCTION general.generate_coupon();


--
-- TOC entry 3278 (class 2606 OID 24695)
-- Name: orders address_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.orders
    ADD CONSTRAINT address_fkey FOREIGN KEY (address_id) REFERENCES general.addresses(id);


--
-- TOC entry 3273 (class 2606 OID 24700)
-- Name: coupons_dishes coupon_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.coupons_dishes
    ADD CONSTRAINT coupon_fkey FOREIGN KEY (coupon_id) REFERENCES general.coupons(id);


--
-- TOC entry 3283 (class 2606 OID 24760)
-- Name: users_coupons coupon_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.users_coupons
    ADD CONSTRAINT coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES general.coupons(id);


--
-- TOC entry 3274 (class 2606 OID 24710)
-- Name: coupons_dishes dish_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.coupons_dishes
    ADD CONSTRAINT dish_fkey FOREIGN KEY (dish_id) REFERENCES general.dishes(id);


--
-- TOC entry 3280 (class 2606 OID 24715)
-- Name: orders_dishes dish_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.orders_dishes
    ADD CONSTRAINT dish_id_fkey FOREIGN KEY (dish_id) REFERENCES general.dishes(id) NOT VALID;


--
-- TOC entry 3276 (class 2606 OID 24720)
-- Name: dishes_images dish_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.dishes_images
    ADD CONSTRAINT dish_id_fkey FOREIGN KEY (dish_id) REFERENCES general.dishes(id) NOT VALID;


--
-- TOC entry 3277 (class 2606 OID 24725)
-- Name: dishes_images image_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.dishes_images
    ADD CONSTRAINT image_id_fkey FOREIGN KEY (image_id) REFERENCES general.images(id) NOT VALID;


--
-- TOC entry 3281 (class 2606 OID 24730)
-- Name: orders_dishes order_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.orders_dishes
    ADD CONSTRAINT order_id_fkey FOREIGN KEY (order_id) REFERENCES general.orders(id) NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 24735)
-- Name: orders orders_orderer_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.orders
    ADD CONSTRAINT orders_orderer_fkey FOREIGN KEY (user_id) REFERENCES general.users(id);


--
-- TOC entry 3272 (class 2606 OID 24740)
-- Name: addresses user_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.addresses
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES general.users(id);


--
-- TOC entry 3275 (class 2606 OID 24745)
-- Name: credentials user_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.credentials
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES general.users(id);


--
-- TOC entry 3282 (class 2606 OID 24755)
-- Name: users_coupons user_id_fkey; Type: FK CONSTRAINT; Schema: general; Owner: postgres
--

ALTER TABLE ONLY general.users_coupons
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES general.users(id);


-- Completed on 2023-05-11 13:23:44

--
-- PostgreSQL database dump complete
--

