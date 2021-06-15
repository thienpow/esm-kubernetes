--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-06-11 22:12:21 +08

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 16769)
-- Name: checker_log; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.checker_log (
    id bigint NOT NULL,
    current_game_checked_on timestamp without time zone DEFAULT now(),
    current_game_time_spent bigint DEFAULT 0,
    leaderboard_checked_on timestamp without time zone DEFAULT now(),
    leaderboard_time_spent bigint DEFAULT 0,
    subscriber_checked_on timestamp without time zone DEFAULT now(),
    subscriber_time_spent bigint DEFAULT 0,
    unclaim_checked_on timestamp without time zone DEFAULT now(),
    unclaim_time_spent bigint DEFAULT 0
);


ALTER TABLE public.checker_log OWNER TO doadmin;

--
-- TOC entry 201 (class 1259 OID 16780)
-- Name: checker_log_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.checker_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checker_log_id_seq OWNER TO doadmin;

--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 201
-- Name: checker_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.checker_log_id_seq OWNED BY public.checker_log.id;


--
-- TOC entry 202 (class 1259 OID 16782)
-- Name: config; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.config (
    id integer NOT NULL,
    invites integer,
    games_per_ad integer,
    days_to_claim integer,
    game_loader_template character varying(5000),
    freespin_per_day integer,
    gems_per_spins_1 integer,
    ads_per_spins_1 integer,
    gems_per_spins_2 integer,
    ads_per_spins_2 integer
);


ALTER TABLE public.config OWNER TO doadmin;

--
-- TOC entry 203 (class 1259 OID 16788)
-- Name: current_game; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.current_game (
    id bigint NOT NULL,
    prize_id bigint,
    tour_id bigint,
    set_id bigint,
    tsg_id bigint,
    game_id bigint,
    start_timestamp timestamp without time zone,
    end_timestamp timestamp without time zone,
    is_closed boolean DEFAULT false,
    tickets_collected bigint DEFAULT 0
);


ALTER TABLE public.current_game OWNER TO doadmin;

--
-- TOC entry 204 (class 1259 OID 16793)
-- Name: current_game_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.current_game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.current_game_id_seq OWNER TO doadmin;

--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 204
-- Name: current_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.current_game_id_seq OWNED BY public.current_game.id;


--
-- TOC entry 205 (class 1259 OID 16795)
-- Name: error_log; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.error_log (
    id bigint NOT NULL,
    module_id integer,
    detail character varying(200),
    created_on timestamp without time zone DEFAULT now()
);


ALTER TABLE public.error_log OWNER TO doadmin;

--
-- TOC entry 206 (class 1259 OID 16799)
-- Name: error_log_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.error_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.error_log_id_seq OWNER TO doadmin;

--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 206
-- Name: error_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.error_log_id_seq OWNED BY public.error_log.id;


--
-- TOC entry 207 (class 1259 OID 16801)
-- Name: game; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.game (
    id bigint NOT NULL,
    title character varying(50),
    subtitle character varying(150),
    img_url character varying(350),
    content character varying(2000),
    type_id integer,
    game_code text,
    engine_id integer,
    version integer,
    status integer,
    score_rule integer,
    watch_ad_get_tickets integer,
    watch_ad_get_exp integer,
    use_gem_get_tickets integer,
    use_gem_get_exp integer,
    use_how_many_gems integer
);


ALTER TABLE public.game OWNER TO doadmin;

--
-- TOC entry 208 (class 1259 OID 16807)
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_id_seq OWNER TO doadmin;

--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 208
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- TOC entry 209 (class 1259 OID 16809)
-- Name: game_leader_rule; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.game_leader_rule (
    game_id bigint,
    tickets integer,
    exp integer,
    rank_from integer,
    rank_to integer
);


ALTER TABLE public.game_leader_rule OWNER TO doadmin;

--
-- TOC entry 210 (class 1259 OID 16812)
-- Name: gplayer; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.gplayer (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    prize_id bigint,
    game_id bigint NOT NULL,
    enter_timestamp timestamp without time zone,
    leave_timestamp timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    game_score integer DEFAULT 0,
    is_watched_ad boolean DEFAULT false,
    is_used_gem boolean DEFAULT false,
    is_logged_leave boolean DEFAULT false,
    is_closed boolean DEFAULT false,
    closed_timestamp timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone
);


ALTER TABLE public.gplayer OWNER TO doadmin;

--
-- TOC entry 211 (class 1259 OID 16822)
-- Name: gplayer_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.gplayer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gplayer_id_seq OWNER TO doadmin;

--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 211
-- Name: gplayer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.gplayer_id_seq OWNED BY public.gplayer.id;


--
-- TOC entry 212 (class 1259 OID 16824)
-- Name: item; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.item (
    id bigint NOT NULL,
    title character varying(50),
    subtitle character varying(150),
    img_url character varying(350),
    content character varying(2000),
    type_id integer DEFAULT 0,
    price double precision DEFAULT 0,
    quantity integer DEFAULT 0,
    status integer DEFAULT 0
);


ALTER TABLE public.item OWNER TO doadmin;

--
-- TOC entry 213 (class 1259 OID 16834)
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_id_seq OWNER TO doadmin;

--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 213
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.item_id_seq OWNED BY public.item.id;


--
-- TOC entry 214 (class 1259 OID 16836)
-- Name: item_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.item_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.item_type OWNER TO doadmin;

--
-- TOC entry 215 (class 1259 OID 16839)
-- Name: prize; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.prize (
    id bigint NOT NULL,
    title character varying(50),
    subtitle character varying(150),
    img_url character varying(350),
    content character varying(2000),
    type_id integer,
    tickets_required bigint,
    duration_days integer DEFAULT 0,
    duration_hours integer DEFAULT 0,
    timezone double precision DEFAULT 0,
    scheduled_on timestamp without time zone,
    is_repeat boolean,
    repeated_on integer[] DEFAULT '{}'::integer[],
    status integer,
    status_progress integer DEFAULT 0,
    tickets_collected bigint DEFAULT 0,
    scheduled_off timestamp without time zone,
    tickets_collected_on timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone
);


ALTER TABLE public.prize OWNER TO doadmin;

--
-- TOC entry 216 (class 1259 OID 16852)
-- Name: prize_closed; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.prize_closed (
    id bigint NOT NULL,
    prize_id bigint,
    tickets_collected bigint,
    batch bigint,
    status integer DEFAULT 1,
    created_on timestamp without time zone DEFAULT now()
);


ALTER TABLE public.prize_closed OWNER TO doadmin;

--
-- TOC entry 217 (class 1259 OID 16857)
-- Name: prize_closed_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.prize_closed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prize_closed_id_seq OWNER TO doadmin;

--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 217
-- Name: prize_closed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_closed_id_seq OWNED BY public.prize_closed.id;


--
-- TOC entry 218 (class 1259 OID 16859)
-- Name: prize_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.prize_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prize_id_seq OWNER TO doadmin;

--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 218
-- Name: prize_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_id_seq OWNED BY public.prize.id;


--
-- TOC entry 219 (class 1259 OID 16861)
-- Name: prize_pool; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.prize_pool (
    id bigint NOT NULL,
    prize_id bigint,
    user_id bigint,
    game_id bigint,
    win_from integer DEFAULT 0,
    tickets integer DEFAULT 0,
    created_on timestamp without time zone DEFAULT now(),
    is_closed boolean DEFAULT false,
    closed_on timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone
);


ALTER TABLE public.prize_pool OWNER TO doadmin;

--
-- TOC entry 220 (class 1259 OID 16869)
-- Name: prize_pool_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.prize_pool_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prize_pool_id_seq OWNER TO doadmin;

--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 220
-- Name: prize_pool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_pool_id_seq OWNED BY public.prize_pool.id;


--
-- TOC entry 221 (class 1259 OID 16871)
-- Name: prize_tour; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.prize_tour (
    id bigint NOT NULL,
    prize_id bigint,
    tour_id bigint,
    status integer
);


ALTER TABLE public.prize_tour OWNER TO doadmin;

--
-- TOC entry 222 (class 1259 OID 16874)
-- Name: prize_tour_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.prize_tour_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prize_tour_id_seq OWNER TO doadmin;

--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 222
-- Name: prize_tour_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_tour_id_seq OWNED BY public.prize_tour.id;


--
-- TOC entry 223 (class 1259 OID 16876)
-- Name: prize_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.prize_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.prize_type OWNER TO doadmin;

--
-- TOC entry 224 (class 1259 OID 16884)
-- Name: rank; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.rank (
    id bigint NOT NULL,
    title character varying(50),
    exp integer,
    gem integer,
    multiplier double precision
);


ALTER TABLE public.rank OWNER TO doadmin;

--
-- TOC entry 225 (class 1259 OID 16887)
-- Name: shop_buy; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.shop_buy (
    id bigint NOT NULL,
    item_type_id integer,
    item_id bigint,
    user_id bigint,
    payment_id character varying(50),
    sub_id character varying(50),
    price double precision DEFAULT 0,
    created_on timestamp without time zone DEFAULT now()
);


ALTER TABLE public.shop_buy OWNER TO doadmin;

--
-- TOC entry 226 (class 1259 OID 16892)
-- Name: shop_buy_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.shop_buy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_buy_id_seq OWNER TO doadmin;

--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 226
-- Name: shop_buy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.shop_buy_id_seq OWNED BY public.shop_buy.id;


--
-- TOC entry 227 (class 1259 OID 16894)
-- Name: spinner_extra_log; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.spinner_extra_log (
    id bigint NOT NULL,
    free_spins integer,
    created_on timestamp without time zone DEFAULT now(),
    user_id bigint
);


ALTER TABLE public.spinner_extra_log OWNER TO doadmin;

--
-- TOC entry 228 (class 1259 OID 16898)
-- Name: spinner_extra_log_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.spinner_extra_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spinner_extra_log_id_seq OWNER TO doadmin;

--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 228
-- Name: spinner_extra_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.spinner_extra_log_id_seq OWNED BY public.spinner_extra_log.id;


--
-- TOC entry 229 (class 1259 OID 16900)
-- Name: spinner_log; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.spinner_log (
    id bigint NOT NULL,
    user_id bigint,
    prize_id bigint,
    win_type integer DEFAULT 1,
    win_amount integer DEFAULT 0,
    enter_timestamp timestamp without time zone,
    leave_timestamp timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    is_logged_leave boolean DEFAULT false,
    is_watched_ad boolean DEFAULT false,
    is_used_gem boolean DEFAULT false
);


ALTER TABLE public.spinner_log OWNER TO doadmin;

--
-- TOC entry 230 (class 1259 OID 16909)
-- Name: spinner_log_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.spinner_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spinner_log_id_seq OWNER TO doadmin;

--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 230
-- Name: spinner_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.spinner_log_id_seq OWNED BY public.spinner_log.id;


--
-- TOC entry 231 (class 1259 OID 16911)
-- Name: spinner_rule; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.spinner_rule (
    id integer NOT NULL,
    probability double precision,
    win double precision,
    type_id integer
);


ALTER TABLE public.spinner_rule OWNER TO doadmin;

--
-- TOC entry 232 (class 1259 OID 16914)
-- Name: spinner_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.spinner_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spinner_rule_id_seq OWNER TO doadmin;

--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 232
-- Name: spinner_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.spinner_rule_id_seq OWNED BY public.spinner_rule.id;


--
-- TOC entry 233 (class 1259 OID 16916)
-- Name: spinner_win_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.spinner_win_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.spinner_win_type OWNER TO doadmin;

--
-- TOC entry 234 (class 1259 OID 16919)
-- Name: status_progress_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.status_progress_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.status_progress_type OWNER TO doadmin;

--
-- TOC entry 235 (class 1259 OID 16922)
-- Name: status_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.status_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.status_type OWNER TO doadmin;

--
-- TOC entry 236 (class 1259 OID 16925)
-- Name: subscription; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.subscription (
    id bigint NOT NULL,
    title character varying(50),
    subtitle character varying(150),
    img_url character varying(350),
    content character varying(2000),
    type_id integer,
    price double precision DEFAULT 0,
    quantity integer DEFAULT 0,
    status integer,
    one_time_gem integer,
    one_time_multiplier double precision,
    daily_gem integer,
    daily_multiplier double precision,
    one_time_is_firstonly boolean
);


ALTER TABLE public.subscription OWNER TO doadmin;

--
-- TOC entry 237 (class 1259 OID 16933)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_id_seq OWNER TO doadmin;

--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 237
-- Name: subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.subscription_id_seq OWNED BY public.subscription.id;


--
-- TOC entry 238 (class 1259 OID 16935)
-- Name: subscription_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.subscription_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.subscription_type OWNER TO doadmin;

--
-- TOC entry 239 (class 1259 OID 16938)
-- Name: timezones; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.timezones (
    id integer NOT NULL,
    "offset" double precision,
    stext character varying(10),
    ltext character varying(100)
);


ALTER TABLE public.timezones OWNER TO doadmin;

--
-- TOC entry 240 (class 1259 OID 16941)
-- Name: timezones_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.timezones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.timezones_id_seq OWNER TO doadmin;

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 240
-- Name: timezones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.timezones_id_seq OWNED BY public.timezones.id;


--
-- TOC entry 241 (class 1259 OID 16943)
-- Name: tour_set; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.tour_set (
    id bigint NOT NULL,
    tour_id bigint,
    set_id bigint,
    status integer
);


ALTER TABLE public.tour_set OWNER TO doadmin;

--
-- TOC entry 242 (class 1259 OID 16946)
-- Name: tour_set_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.tour_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tour_set_id_seq OWNER TO doadmin;

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 242
-- Name: tour_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tour_set_id_seq OWNED BY public.tour_set.id;


--
-- TOC entry 243 (class 1259 OID 16948)
-- Name: tournament; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.tournament (
    id bigint NOT NULL,
    title character varying(150),
    status integer
);


ALTER TABLE public.tournament OWNER TO doadmin;

--
-- TOC entry 244 (class 1259 OID 16951)
-- Name: tournament_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.tournament_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_id_seq OWNER TO doadmin;

--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 244
-- Name: tournament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tournament_id_seq OWNED BY public.tournament.id;


--
-- TOC entry 245 (class 1259 OID 16953)
-- Name: tournament_set; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.tournament_set (
    id bigint NOT NULL,
    title character varying(150),
    duration_days integer DEFAULT 0,
    duration_hours integer,
    is_group boolean
);


ALTER TABLE public.tournament_set OWNER TO doadmin;

--
-- TOC entry 246 (class 1259 OID 16957)
-- Name: tournament_set_game_rule; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.tournament_set_game_rule (
    id bigint NOT NULL,
    set_id bigint NOT NULL,
    game_id bigint NOT NULL,
    duration_days integer NOT NULL,
    duration_hours integer NOT NULL,
    duration_minutes integer NOT NULL,
    group_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tournament_set_game_rule OWNER TO doadmin;

--
-- TOC entry 247 (class 1259 OID 16961)
-- Name: tournament_set_game_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.tournament_set_game_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_set_game_rule_id_seq OWNER TO doadmin;

--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 247
-- Name: tournament_set_game_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tournament_set_game_rule_id_seq OWNED BY public.tournament_set_game_rule.id;


--
-- TOC entry 248 (class 1259 OID 16963)
-- Name: tournament_set_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.tournament_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_set_id_seq OWNER TO doadmin;

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 248
-- Name: tournament_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tournament_set_id_seq OWNED BY public.tournament_set.id;


--
-- TOC entry 249 (class 1259 OID 16965)
-- Name: user; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    username character varying(128) NOT NULL,
    passhash character varying(2000) NOT NULL,
    email character varying(355) NOT NULL,
    phone character varying(20) NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    last_login timestamp without time zone NOT NULL,
    role_id integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    gem_balance integer DEFAULT 0,
    social_link_fb character varying(355) DEFAULT ''::character varying,
    social_link_google character varying(355) DEFAULT ''::character varying,
    avatar_url character varying(355) DEFAULT ''::character varying,
    exp integer DEFAULT 0,
    full_name character varying(355) DEFAULT ''::character varying,
    country_code integer DEFAULT 0,
    address character varying(1000) DEFAULT ''::character varying,
    city character varying(355) DEFAULT ''::character varying,
    state character varying(355) DEFAULT ''::character varying,
    zip_code character varying(20) DEFAULT ''::character varying,
    country character varying(355) DEFAULT ''::character varying,
    is_email_confirmed boolean DEFAULT false,
    is_notify_allowed boolean DEFAULT true,
    is_notify_new_reward boolean DEFAULT true,
    is_notify_new_tournament boolean DEFAULT true,
    is_notify_tour_ending boolean DEFAULT true,
    nick_name character varying(50) DEFAULT ''::character varying,
    rank integer DEFAULT 0,
    msg_token character varying(512) DEFAULT ''::character varying,
    subscription_id bigint DEFAULT 0,
    one_time_multiplier double precision DEFAULT 0,
    daily_gem integer DEFAULT 0,
    daily_multiplier double precision DEFAULT 0,
    one_time_is_firstonly boolean DEFAULT false,
    sub_daily_timestamp timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    exp_timestamp timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    msg_token_timestamp timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    sub_id character varying(50) DEFAULT ''::character varying
);


ALTER TABLE public."user" OWNER TO doadmin;

--
-- TOC entry 250 (class 1259 OID 17001)
-- Name: user_admin_change_log; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.user_admin_change_log (
    id bigint NOT NULL,
    user_id bigint,
    old_status integer,
    new_status integer,
    old_gem_balance integer,
    new_gem_balance integer,
    created_on timestamp with time zone,
    changed_by bigint
);


ALTER TABLE public.user_admin_change_log OWNER TO doadmin;

--
-- TOC entry 251 (class 1259 OID 17004)
-- Name: user_admin_change_log_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.user_admin_change_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_admin_change_log_id_seq OWNER TO doadmin;

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 251
-- Name: user_admin_change_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.user_admin_change_log_id_seq OWNED BY public.user_admin_change_log.id;


--
-- TOC entry 252 (class 1259 OID 17006)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO doadmin;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 252
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 253 (class 1259 OID 17008)
-- Name: user_invites; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.user_invites (
    id bigint NOT NULL,
    user_id bigint,
    invited_by bigint,
    invited_date timestamp without time zone
);


ALTER TABLE public.user_invites OWNER TO doadmin;

--
-- TOC entry 254 (class 1259 OID 17011)
-- Name: user_invites_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.user_invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_invites_id_seq OWNER TO doadmin;

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 254
-- Name: user_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.user_invites_id_seq OWNED BY public.user_invites.id;


--
-- TOC entry 255 (class 1259 OID 17013)
-- Name: user_status_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.user_status_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.user_status_type OWNER TO doadmin;

--
-- TOC entry 256 (class 1259 OID 17016)
-- Name: winner; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.winner (
    id bigint NOT NULL,
    prize_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_on timestamp without time zone DEFAULT now(),
    status integer DEFAULT 1,
    ship_tracking character varying(255) DEFAULT ''::character varying,
    claimed_on timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone
);


ALTER TABLE public.winner OWNER TO doadmin;

--
-- TOC entry 257 (class 1259 OID 17023)
-- Name: winner_change_log; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.winner_change_log (
    id bigint NOT NULL,
    winner_id bigint,
    old_status integer,
    new_status integer,
    old_ship_tracking character varying(255),
    new_ship_tracking character varying(255),
    created_on timestamp with time zone,
    changed_by bigint
);


ALTER TABLE public.winner_change_log OWNER TO doadmin;

--
-- TOC entry 258 (class 1259 OID 17029)
-- Name: winner_change_log_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.winner_change_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.winner_change_log_id_seq OWNER TO doadmin;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 258
-- Name: winner_change_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.winner_change_log_id_seq OWNED BY public.winner_change_log.id;


--
-- TOC entry 259 (class 1259 OID 17031)
-- Name: winner_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.winner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.winner_id_seq OWNER TO doadmin;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 259
-- Name: winner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.winner_id_seq OWNED BY public.winner.id;


--
-- TOC entry 260 (class 1259 OID 17033)
-- Name: winner_status_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.winner_status_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.winner_status_type OWNER TO doadmin;

--
-- TOC entry 3053 (class 2604 OID 17036)
-- Name: checker_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.checker_log ALTER COLUMN id SET DEFAULT nextval('public.checker_log_id_seq'::regclass);


--
-- TOC entry 3056 (class 2604 OID 17037)
-- Name: current_game id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.current_game ALTER COLUMN id SET DEFAULT nextval('public.current_game_id_seq'::regclass);


--
-- TOC entry 3058 (class 2604 OID 17038)
-- Name: error_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.error_log ALTER COLUMN id SET DEFAULT nextval('public.error_log_id_seq'::regclass);


--
-- TOC entry 3059 (class 2604 OID 17039)
-- Name: game id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- TOC entry 3067 (class 2604 OID 17040)
-- Name: gplayer id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.gplayer ALTER COLUMN id SET DEFAULT nextval('public.gplayer_id_seq'::regclass);


--
-- TOC entry 3072 (class 2604 OID 17041)
-- Name: item id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.item ALTER COLUMN id SET DEFAULT nextval('public.item_id_seq'::regclass);


--
-- TOC entry 3080 (class 2604 OID 17042)
-- Name: prize id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize ALTER COLUMN id SET DEFAULT nextval('public.prize_id_seq'::regclass);


--
-- TOC entry 3083 (class 2604 OID 17043)
-- Name: prize_closed id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_closed ALTER COLUMN id SET DEFAULT nextval('public.prize_closed_id_seq'::regclass);


--
-- TOC entry 3089 (class 2604 OID 17044)
-- Name: prize_pool id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_pool ALTER COLUMN id SET DEFAULT nextval('public.prize_pool_id_seq'::regclass);


--
-- TOC entry 3090 (class 2604 OID 17045)
-- Name: prize_tour id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_tour ALTER COLUMN id SET DEFAULT nextval('public.prize_tour_id_seq'::regclass);


--
-- TOC entry 3093 (class 2604 OID 17047)
-- Name: shop_buy id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.shop_buy ALTER COLUMN id SET DEFAULT nextval('public.shop_buy_id_seq'::regclass);


--
-- TOC entry 3095 (class 2604 OID 17048)
-- Name: spinner_extra_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_extra_log ALTER COLUMN id SET DEFAULT nextval('public.spinner_extra_log_id_seq'::regclass);


--
-- TOC entry 3102 (class 2604 OID 17049)
-- Name: spinner_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_log ALTER COLUMN id SET DEFAULT nextval('public.spinner_log_id_seq'::regclass);


--
-- TOC entry 3103 (class 2604 OID 17050)
-- Name: spinner_rule id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_rule ALTER COLUMN id SET DEFAULT nextval('public.spinner_rule_id_seq'::regclass);


--
-- TOC entry 3106 (class 2604 OID 17051)
-- Name: subscription id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.subscription ALTER COLUMN id SET DEFAULT nextval('public.subscription_id_seq'::regclass);


--
-- TOC entry 3107 (class 2604 OID 17052)
-- Name: timezones id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.timezones ALTER COLUMN id SET DEFAULT nextval('public.timezones_id_seq'::regclass);


--
-- TOC entry 3108 (class 2604 OID 17053)
-- Name: tour_set id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tour_set ALTER COLUMN id SET DEFAULT nextval('public.tour_set_id_seq'::regclass);


--
-- TOC entry 3109 (class 2604 OID 17054)
-- Name: tournament id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament ALTER COLUMN id SET DEFAULT nextval('public.tournament_id_seq'::regclass);


--
-- TOC entry 3111 (class 2604 OID 17055)
-- Name: tournament_set id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set ALTER COLUMN id SET DEFAULT nextval('public.tournament_set_id_seq'::regclass);


--
-- TOC entry 3113 (class 2604 OID 17056)
-- Name: tournament_set_game_rule id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set_game_rule ALTER COLUMN id SET DEFAULT nextval('public.tournament_set_game_rule_id_seq'::regclass);


--
-- TOC entry 3144 (class 2604 OID 17057)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3145 (class 2604 OID 17058)
-- Name: user_admin_change_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_admin_change_log ALTER COLUMN id SET DEFAULT nextval('public.user_admin_change_log_id_seq'::regclass);


--
-- TOC entry 3146 (class 2604 OID 17059)
-- Name: user_invites id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_invites ALTER COLUMN id SET DEFAULT nextval('public.user_invites_id_seq'::regclass);


--
-- TOC entry 3151 (class 2604 OID 17060)
-- Name: winner id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner ALTER COLUMN id SET DEFAULT nextval('public.winner_id_seq'::regclass);


--
-- TOC entry 3152 (class 2604 OID 17061)
-- Name: winner_change_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner_change_log ALTER COLUMN id SET DEFAULT nextval('public.winner_change_log_id_seq'::regclass);


--
-- TOC entry 3154 (class 2606 OID 17064)
-- Name: checker_log checker_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.checker_log
    ADD CONSTRAINT checker_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3156 (class 2606 OID 17066)
-- Name: config config_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


--
-- TOC entry 3158 (class 2606 OID 17068)
-- Name: current_game current_game_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.current_game
    ADD CONSTRAINT current_game_pkey PRIMARY KEY (id);


--
-- TOC entry 3160 (class 2606 OID 17070)
-- Name: error_log error_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.error_log
    ADD CONSTRAINT error_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3163 (class 2606 OID 17072)
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- TOC entry 3165 (class 2606 OID 17074)
-- Name: gplayer gplayer_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.gplayer
    ADD CONSTRAINT gplayer_pkey PRIMARY KEY (id);


--
-- TOC entry 3168 (class 2606 OID 17076)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- TOC entry 3170 (class 2606 OID 17078)
-- Name: item_type item_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.item_type
    ADD CONSTRAINT item_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3175 (class 2606 OID 17080)
-- Name: prize_closed prize_closed_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_closed
    ADD CONSTRAINT prize_closed_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3173 (class 2606 OID 17082)
-- Name: prize prize_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize
    ADD CONSTRAINT prize_pkey PRIMARY KEY (id);


--
-- TOC entry 3177 (class 2606 OID 17084)
-- Name: prize_pool prize_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_pool
    ADD CONSTRAINT prize_pool_pkey PRIMARY KEY (id);


--
-- TOC entry 3179 (class 2606 OID 17086)
-- Name: prize_tour prize_tour_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_tour
    ADD CONSTRAINT prize_tour_pkey PRIMARY KEY (id);


--
-- TOC entry 3181 (class 2606 OID 17088)
-- Name: prize_type prize_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_type
    ADD CONSTRAINT prize_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3183 (class 2606 OID 17092)
-- Name: rank rank_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.rank
    ADD CONSTRAINT rank_pkey PRIMARY KEY (id);


--
-- TOC entry 3185 (class 2606 OID 17094)
-- Name: shop_buy shop_buy_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.shop_buy
    ADD CONSTRAINT shop_buy_pkey PRIMARY KEY (id);


--
-- TOC entry 3187 (class 2606 OID 17096)
-- Name: spinner_extra_log spinner_extra_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_extra_log
    ADD CONSTRAINT spinner_extra_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3189 (class 2606 OID 17098)
-- Name: spinner_log spinner_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_log
    ADD CONSTRAINT spinner_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3191 (class 2606 OID 17100)
-- Name: spinner_rule spinner_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_rule
    ADD CONSTRAINT spinner_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3193 (class 2606 OID 17102)
-- Name: spinner_win_type spinner_win_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_win_type
    ADD CONSTRAINT spinner_win_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3195 (class 2606 OID 17104)
-- Name: status_progress_type status_progress_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.status_progress_type
    ADD CONSTRAINT status_progress_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3197 (class 2606 OID 17106)
-- Name: status_type status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3200 (class 2606 OID 17108)
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- TOC entry 3202 (class 2606 OID 17110)
-- Name: subscription_type subscription_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.subscription_type
    ADD CONSTRAINT subscription_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3204 (class 2606 OID 17112)
-- Name: timezones timezones_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.timezones
    ADD CONSTRAINT timezones_pkey PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 17114)
-- Name: tour_set tour_set_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tour_set
    ADD CONSTRAINT tour_set_pkey PRIMARY KEY (id);


--
-- TOC entry 3209 (class 2606 OID 17116)
-- Name: tournament tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_pkey PRIMARY KEY (id);


--
-- TOC entry 3214 (class 2606 OID 17118)
-- Name: tournament_set_game_rule tournament_set_game_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set_game_rule
    ADD CONSTRAINT tournament_set_game_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3212 (class 2606 OID 17120)
-- Name: tournament_set tournament_set_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set
    ADD CONSTRAINT tournament_set_pkey PRIMARY KEY (id);


--
-- TOC entry 3227 (class 2606 OID 17122)
-- Name: user_admin_change_log user_admin_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_admin_change_log
    ADD CONSTRAINT user_admin_change_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 17124)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3229 (class 2606 OID 17126)
-- Name: user_invites user_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_invites
    ADD CONSTRAINT user_invites_pkey PRIMARY KEY (id);


--
-- TOC entry 3231 (class 2606 OID 17128)
-- Name: user_invites user_invites_user_id_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_invites
    ADD CONSTRAINT user_invites_user_id_key UNIQUE (user_id);


--
-- TOC entry 3223 (class 2606 OID 17130)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 2606 OID 17132)
-- Name: user_status_type user_status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_status_type
    ADD CONSTRAINT user_status_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 17134)
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- TOC entry 3237 (class 2606 OID 17136)
-- Name: winner_change_log winner_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner_change_log
    ADD CONSTRAINT winner_change_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3235 (class 2606 OID 17138)
-- Name: winner winner_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner
    ADD CONSTRAINT winner_pkey PRIMARY KEY (id);


--
-- TOC entry 3239 (class 2606 OID 17140)
-- Name: winner_status_type winner_status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner_status_type
    ADD CONSTRAINT winner_status_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3161 (class 1259 OID 17141)
-- Name: game_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX game_lower_idx ON public.game USING btree (lower((title)::text));


--
-- TOC entry 3215 (class 1259 OID 17142)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_email ON public."user" USING btree (email);


--
-- TOC entry 3216 (class 1259 OID 17143)
-- Name: idx_user_firstname; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_firstname ON public."user" USING btree (firstname);


--
-- TOC entry 3217 (class 1259 OID 17144)
-- Name: idx_user_lastname; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_lastname ON public."user" USING btree (lastname);


--
-- TOC entry 3218 (class 1259 OID 17145)
-- Name: idx_user_phone; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_phone ON public."user" USING btree (phone);


--
-- TOC entry 3219 (class 1259 OID 17146)
-- Name: idx_user_username; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_username ON public."user" USING btree (username);


--
-- TOC entry 3166 (class 1259 OID 17147)
-- Name: item_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX item_lower_idx ON public.item USING btree (lower((title)::text));


--
-- TOC entry 3171 (class 1259 OID 17148)
-- Name: prize_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX prize_lower_idx ON public.prize USING btree (lower((title)::text));


--
-- TOC entry 3198 (class 1259 OID 17149)
-- Name: subscription_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX subscription_lower_idx ON public.subscription USING btree (lower((title)::text));


--
-- TOC entry 3207 (class 1259 OID 17150)
-- Name: tournament_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX tournament_lower_idx ON public.tournament USING btree (lower((title)::text));


--
-- TOC entry 3210 (class 1259 OID 17151)
-- Name: tournament_set_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX tournament_set_lower_idx ON public.tournament_set USING btree (lower((title)::text));


-- Completed on 2021-06-11 22:12:28 +08

--
-- PostgreSQL database dump complete
--

