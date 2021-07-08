--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-07-08 21:46:26 +08

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
-- TOC entry 200 (class 1259 OID 16384)
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
-- TOC entry 201 (class 1259 OID 16395)
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
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 201
-- Name: checker_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.checker_log_id_seq OWNED BY public.checker_log.id;


--
-- TOC entry 202 (class 1259 OID 16397)
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
-- TOC entry 203 (class 1259 OID 16403)
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
    tickets_collected bigint DEFAULT 0,
    index bigint DEFAULT 0,
    created_on timestamp without time zone DEFAULT now(),
    set_duration_countdown integer DEFAULT 0
);


ALTER TABLE public.current_game OWNER TO doadmin;

--
-- TOC entry 204 (class 1259 OID 16408)
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
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 204
-- Name: current_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.current_game_id_seq OWNED BY public.current_game.id;


--
-- TOC entry 205 (class 1259 OID 16410)
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
-- TOC entry 206 (class 1259 OID 16414)
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
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 206
-- Name: error_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.error_log_id_seq OWNED BY public.error_log.id;


--
-- TOC entry 207 (class 1259 OID 16416)
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
-- TOC entry 208 (class 1259 OID 16422)
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
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 208
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- TOC entry 209 (class 1259 OID 16424)
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
-- TOC entry 210 (class 1259 OID 16427)
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
    closed_timestamp timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    cg_id bigint DEFAULT 0
);


ALTER TABLE public.gplayer OWNER TO doadmin;

--
-- TOC entry 211 (class 1259 OID 16437)
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
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 211
-- Name: gplayer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.gplayer_id_seq OWNED BY public.gplayer.id;


--
-- TOC entry 212 (class 1259 OID 16439)
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
-- TOC entry 213 (class 1259 OID 16449)
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
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 213
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.item_id_seq OWNED BY public.item.id;


--
-- TOC entry 214 (class 1259 OID 16451)
-- Name: item_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.item_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.item_type OWNER TO doadmin;

--
-- TOC entry 262 (class 1259 OID 16806)
-- Name: leaderboard_history; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.leaderboard_history (
    id bigint NOT NULL,
    rank integer,
    prize_id bigint,
    user_id bigint,
    cg_id bigint,
    gplay_id bigint,
    game_score integer,
    prize_type_id integer,
    game_id bigint,
    reward_gem integer,
    reward_exp integer,
    tickets integer,
    created_on timestamp without time zone
);


ALTER TABLE public.leaderboard_history OWNER TO doadmin;

--
-- TOC entry 261 (class 1259 OID 16804)
-- Name: leaderboard_history_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.leaderboard_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leaderboard_history_id_seq OWNER TO doadmin;

--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 261
-- Name: leaderboard_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.leaderboard_history_id_seq OWNED BY public.leaderboard_history.id;


--
-- TOC entry 215 (class 1259 OID 16454)
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
-- TOC entry 216 (class 1259 OID 16467)
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
-- TOC entry 217 (class 1259 OID 16472)
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
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 217
-- Name: prize_closed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_closed_id_seq OWNED BY public.prize_closed.id;


--
-- TOC entry 218 (class 1259 OID 16474)
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
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 218
-- Name: prize_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_id_seq OWNED BY public.prize.id;


--
-- TOC entry 219 (class 1259 OID 16476)
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
    closed_on timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone,
    cg_id bigint DEFAULT 0
);


ALTER TABLE public.prize_pool OWNER TO doadmin;

--
-- TOC entry 220 (class 1259 OID 16484)
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
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 220
-- Name: prize_pool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_pool_id_seq OWNED BY public.prize_pool.id;


--
-- TOC entry 221 (class 1259 OID 16486)
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
-- TOC entry 222 (class 1259 OID 16489)
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
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 222
-- Name: prize_tour_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.prize_tour_id_seq OWNED BY public.prize_tour.id;


--
-- TOC entry 223 (class 1259 OID 16491)
-- Name: prize_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.prize_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.prize_type OWNER TO doadmin;

--
-- TOC entry 224 (class 1259 OID 16494)
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
-- TOC entry 225 (class 1259 OID 16497)
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
-- TOC entry 226 (class 1259 OID 16502)
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
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 226
-- Name: shop_buy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.shop_buy_id_seq OWNED BY public.shop_buy.id;


--
-- TOC entry 227 (class 1259 OID 16504)
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
-- TOC entry 228 (class 1259 OID 16508)
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
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 228
-- Name: spinner_extra_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.spinner_extra_log_id_seq OWNED BY public.spinner_extra_log.id;


--
-- TOC entry 229 (class 1259 OID 16510)
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
-- TOC entry 230 (class 1259 OID 16519)
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
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 230
-- Name: spinner_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.spinner_log_id_seq OWNED BY public.spinner_log.id;


--
-- TOC entry 231 (class 1259 OID 16521)
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
-- TOC entry 232 (class 1259 OID 16524)
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
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 232
-- Name: spinner_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.spinner_rule_id_seq OWNED BY public.spinner_rule.id;


--
-- TOC entry 233 (class 1259 OID 16526)
-- Name: spinner_win_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.spinner_win_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.spinner_win_type OWNER TO doadmin;

--
-- TOC entry 234 (class 1259 OID 16529)
-- Name: status_progress_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.status_progress_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.status_progress_type OWNER TO doadmin;

--
-- TOC entry 235 (class 1259 OID 16532)
-- Name: status_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.status_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.status_type OWNER TO doadmin;

--
-- TOC entry 236 (class 1259 OID 16535)
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
    one_time_gem integer DEFAULT 0,
    one_time_multiplier double precision DEFAULT 0,
    daily_gem integer DEFAULT 0,
    daily_multiplier double precision,
    one_time_is_firstonly boolean DEFAULT false
);


ALTER TABLE public.subscription OWNER TO doadmin;

--
-- TOC entry 237 (class 1259 OID 16543)
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
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 237
-- Name: subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.subscription_id_seq OWNED BY public.subscription.id;


--
-- TOC entry 238 (class 1259 OID 16545)
-- Name: subscription_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.subscription_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.subscription_type OWNER TO doadmin;

--
-- TOC entry 239 (class 1259 OID 16548)
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
-- TOC entry 240 (class 1259 OID 16551)
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
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 240
-- Name: timezones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.timezones_id_seq OWNED BY public.timezones.id;


--
-- TOC entry 241 (class 1259 OID 16553)
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
-- TOC entry 242 (class 1259 OID 16556)
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
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 242
-- Name: tour_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tour_set_id_seq OWNED BY public.tour_set.id;


--
-- TOC entry 243 (class 1259 OID 16558)
-- Name: tournament; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.tournament (
    id bigint NOT NULL,
    title character varying(150),
    status integer
);


ALTER TABLE public.tournament OWNER TO doadmin;

--
-- TOC entry 244 (class 1259 OID 16561)
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
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 244
-- Name: tournament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tournament_id_seq OWNED BY public.tournament.id;


--
-- TOC entry 245 (class 1259 OID 16563)
-- Name: tournament_set; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.tournament_set (
    id bigint NOT NULL,
    title character varying(150),
    duration_days integer DEFAULT 0,
    duration_hours integer,
    is_group boolean,
    status integer DEFAULT 0
);


ALTER TABLE public.tournament_set OWNER TO doadmin;

--
-- TOC entry 246 (class 1259 OID 16567)
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
-- TOC entry 247 (class 1259 OID 16571)
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
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 247
-- Name: tournament_set_game_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tournament_set_game_rule_id_seq OWNED BY public.tournament_set_game_rule.id;


--
-- TOC entry 248 (class 1259 OID 16573)
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
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 248
-- Name: tournament_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.tournament_set_id_seq OWNED BY public.tournament_set.id;


--
-- TOC entry 249 (class 1259 OID 16575)
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
-- TOC entry 250 (class 1259 OID 16611)
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
-- TOC entry 251 (class 1259 OID 16614)
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
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 251
-- Name: user_admin_change_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.user_admin_change_log_id_seq OWNED BY public.user_admin_change_log.id;


--
-- TOC entry 252 (class 1259 OID 16616)
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
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 252
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 253 (class 1259 OID 16618)
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
-- TOC entry 254 (class 1259 OID 16621)
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
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 254
-- Name: user_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.user_invites_id_seq OWNED BY public.user_invites.id;


--
-- TOC entry 255 (class 1259 OID 16623)
-- Name: user_status_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.user_status_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.user_status_type OWNER TO doadmin;

--
-- TOC entry 256 (class 1259 OID 16626)
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
-- TOC entry 257 (class 1259 OID 16633)
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
-- TOC entry 258 (class 1259 OID 16639)
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
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 258
-- Name: winner_change_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.winner_change_log_id_seq OWNED BY public.winner_change_log.id;


--
-- TOC entry 259 (class 1259 OID 16641)
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
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 259
-- Name: winner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.winner_id_seq OWNED BY public.winner.id;


--
-- TOC entry 260 (class 1259 OID 16643)
-- Name: winner_status_type; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.winner_status_type (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.winner_status_type OWNER TO doadmin;

--
-- TOC entry 3059 (class 2604 OID 16646)
-- Name: checker_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.checker_log ALTER COLUMN id SET DEFAULT nextval('public.checker_log_id_seq'::regclass);


--
-- TOC entry 3062 (class 2604 OID 16647)
-- Name: current_game id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.current_game ALTER COLUMN id SET DEFAULT nextval('public.current_game_id_seq'::regclass);


--
-- TOC entry 3067 (class 2604 OID 16648)
-- Name: error_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.error_log ALTER COLUMN id SET DEFAULT nextval('public.error_log_id_seq'::regclass);


--
-- TOC entry 3068 (class 2604 OID 16649)
-- Name: game id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- TOC entry 3076 (class 2604 OID 16650)
-- Name: gplayer id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.gplayer ALTER COLUMN id SET DEFAULT nextval('public.gplayer_id_seq'::regclass);


--
-- TOC entry 3082 (class 2604 OID 16651)
-- Name: item id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.item ALTER COLUMN id SET DEFAULT nextval('public.item_id_seq'::regclass);


--
-- TOC entry 3169 (class 2604 OID 16809)
-- Name: leaderboard_history id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.leaderboard_history ALTER COLUMN id SET DEFAULT nextval('public.leaderboard_history_id_seq'::regclass);


--
-- TOC entry 3090 (class 2604 OID 16652)
-- Name: prize id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize ALTER COLUMN id SET DEFAULT nextval('public.prize_id_seq'::regclass);


--
-- TOC entry 3093 (class 2604 OID 16653)
-- Name: prize_closed id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_closed ALTER COLUMN id SET DEFAULT nextval('public.prize_closed_id_seq'::regclass);


--
-- TOC entry 3099 (class 2604 OID 16654)
-- Name: prize_pool id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_pool ALTER COLUMN id SET DEFAULT nextval('public.prize_pool_id_seq'::regclass);


--
-- TOC entry 3101 (class 2604 OID 16655)
-- Name: prize_tour id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_tour ALTER COLUMN id SET DEFAULT nextval('public.prize_tour_id_seq'::regclass);


--
-- TOC entry 3104 (class 2604 OID 16656)
-- Name: shop_buy id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.shop_buy ALTER COLUMN id SET DEFAULT nextval('public.shop_buy_id_seq'::regclass);


--
-- TOC entry 3106 (class 2604 OID 16657)
-- Name: spinner_extra_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_extra_log ALTER COLUMN id SET DEFAULT nextval('public.spinner_extra_log_id_seq'::regclass);


--
-- TOC entry 3113 (class 2604 OID 16658)
-- Name: spinner_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_log ALTER COLUMN id SET DEFAULT nextval('public.spinner_log_id_seq'::regclass);


--
-- TOC entry 3114 (class 2604 OID 16659)
-- Name: spinner_rule id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_rule ALTER COLUMN id SET DEFAULT nextval('public.spinner_rule_id_seq'::regclass);


--
-- TOC entry 3117 (class 2604 OID 16660)
-- Name: subscription id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.subscription ALTER COLUMN id SET DEFAULT nextval('public.subscription_id_seq'::regclass);


--
-- TOC entry 3122 (class 2604 OID 16661)
-- Name: timezones id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.timezones ALTER COLUMN id SET DEFAULT nextval('public.timezones_id_seq'::regclass);


--
-- TOC entry 3123 (class 2604 OID 16662)
-- Name: tour_set id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tour_set ALTER COLUMN id SET DEFAULT nextval('public.tour_set_id_seq'::regclass);


--
-- TOC entry 3124 (class 2604 OID 16663)
-- Name: tournament id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament ALTER COLUMN id SET DEFAULT nextval('public.tournament_id_seq'::regclass);


--
-- TOC entry 3126 (class 2604 OID 16664)
-- Name: tournament_set id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set ALTER COLUMN id SET DEFAULT nextval('public.tournament_set_id_seq'::regclass);


--
-- TOC entry 3129 (class 2604 OID 16665)
-- Name: tournament_set_game_rule id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set_game_rule ALTER COLUMN id SET DEFAULT nextval('public.tournament_set_game_rule_id_seq'::regclass);


--
-- TOC entry 3160 (class 2604 OID 16666)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3161 (class 2604 OID 16667)
-- Name: user_admin_change_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_admin_change_log ALTER COLUMN id SET DEFAULT nextval('public.user_admin_change_log_id_seq'::regclass);


--
-- TOC entry 3162 (class 2604 OID 16668)
-- Name: user_invites id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_invites ALTER COLUMN id SET DEFAULT nextval('public.user_invites_id_seq'::regclass);


--
-- TOC entry 3167 (class 2604 OID 16669)
-- Name: winner id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner ALTER COLUMN id SET DEFAULT nextval('public.winner_id_seq'::regclass);


--
-- TOC entry 3168 (class 2604 OID 16670)
-- Name: winner_change_log id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner_change_log ALTER COLUMN id SET DEFAULT nextval('public.winner_change_log_id_seq'::regclass);


--
-- TOC entry 3171 (class 2606 OID 16672)
-- Name: checker_log checker_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.checker_log
    ADD CONSTRAINT checker_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3173 (class 2606 OID 16674)
-- Name: config config_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


--
-- TOC entry 3175 (class 2606 OID 16676)
-- Name: current_game current_game_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.current_game
    ADD CONSTRAINT current_game_pkey PRIMARY KEY (id);


--
-- TOC entry 3177 (class 2606 OID 16678)
-- Name: error_log error_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.error_log
    ADD CONSTRAINT error_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3180 (class 2606 OID 16680)
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- TOC entry 3182 (class 2606 OID 16682)
-- Name: gplayer gplayer_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.gplayer
    ADD CONSTRAINT gplayer_pkey PRIMARY KEY (id);


--
-- TOC entry 3185 (class 2606 OID 16684)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- TOC entry 3187 (class 2606 OID 16686)
-- Name: item_type item_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.item_type
    ADD CONSTRAINT item_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 16811)
-- Name: leaderboard_history leaderboard_history_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.leaderboard_history
    ADD CONSTRAINT leaderboard_history_pkey PRIMARY KEY (id);


--
-- TOC entry 3192 (class 2606 OID 16688)
-- Name: prize_closed prize_closed_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_closed
    ADD CONSTRAINT prize_closed_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3190 (class 2606 OID 16690)
-- Name: prize prize_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize
    ADD CONSTRAINT prize_pkey PRIMARY KEY (id);


--
-- TOC entry 3194 (class 2606 OID 16692)
-- Name: prize_pool prize_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_pool
    ADD CONSTRAINT prize_pool_pkey PRIMARY KEY (id);


--
-- TOC entry 3196 (class 2606 OID 16694)
-- Name: prize_tour prize_tour_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_tour
    ADD CONSTRAINT prize_tour_pkey PRIMARY KEY (id);


--
-- TOC entry 3198 (class 2606 OID 16696)
-- Name: prize_type prize_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.prize_type
    ADD CONSTRAINT prize_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3200 (class 2606 OID 16698)
-- Name: rank rank_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.rank
    ADD CONSTRAINT rank_pkey PRIMARY KEY (id);


--
-- TOC entry 3202 (class 2606 OID 16765)
-- Name: shop_buy shop_buy_payment_id_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.shop_buy
    ADD CONSTRAINT shop_buy_payment_id_key UNIQUE (payment_id, sub_id);


--
-- TOC entry 3204 (class 2606 OID 16700)
-- Name: shop_buy shop_buy_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.shop_buy
    ADD CONSTRAINT shop_buy_pkey PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 16702)
-- Name: spinner_extra_log spinner_extra_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_extra_log
    ADD CONSTRAINT spinner_extra_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3208 (class 2606 OID 16704)
-- Name: spinner_log spinner_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_log
    ADD CONSTRAINT spinner_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3210 (class 2606 OID 16706)
-- Name: spinner_rule spinner_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_rule
    ADD CONSTRAINT spinner_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3212 (class 2606 OID 16708)
-- Name: spinner_win_type spinner_win_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.spinner_win_type
    ADD CONSTRAINT spinner_win_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3214 (class 2606 OID 16710)
-- Name: status_progress_type status_progress_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.status_progress_type
    ADD CONSTRAINT status_progress_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3216 (class 2606 OID 16712)
-- Name: status_type status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3219 (class 2606 OID 16714)
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 16716)
-- Name: subscription_type subscription_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.subscription_type
    ADD CONSTRAINT subscription_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3223 (class 2606 OID 16718)
-- Name: timezones timezones_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.timezones
    ADD CONSTRAINT timezones_pkey PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 16720)
-- Name: tour_set tour_set_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tour_set
    ADD CONSTRAINT tour_set_pkey PRIMARY KEY (id);


--
-- TOC entry 3228 (class 2606 OID 16722)
-- Name: tournament tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 2606 OID 16724)
-- Name: tournament_set_game_rule tournament_set_game_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set_game_rule
    ADD CONSTRAINT tournament_set_game_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3231 (class 2606 OID 16726)
-- Name: tournament_set tournament_set_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.tournament_set
    ADD CONSTRAINT tournament_set_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 16728)
-- Name: user_admin_change_log user_admin_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_admin_change_log
    ADD CONSTRAINT user_admin_change_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16730)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3248 (class 2606 OID 16732)
-- Name: user_invites user_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_invites
    ADD CONSTRAINT user_invites_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 16734)
-- Name: user_invites user_invites_user_id_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_invites
    ADD CONSTRAINT user_invites_user_id_key UNIQUE (user_id);


--
-- TOC entry 3242 (class 2606 OID 16736)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3252 (class 2606 OID 16738)
-- Name: user_status_type user_status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.user_status_type
    ADD CONSTRAINT user_status_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3244 (class 2606 OID 16740)
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- TOC entry 3256 (class 2606 OID 16742)
-- Name: winner_change_log winner_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner_change_log
    ADD CONSTRAINT winner_change_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 16744)
-- Name: winner winner_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner
    ADD CONSTRAINT winner_pkey PRIMARY KEY (id);


--
-- TOC entry 3258 (class 2606 OID 16746)
-- Name: winner_status_type winner_status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.winner_status_type
    ADD CONSTRAINT winner_status_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3178 (class 1259 OID 16747)
-- Name: game_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX game_lower_idx ON public.game USING btree (lower((title)::text));


--
-- TOC entry 3234 (class 1259 OID 16748)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_email ON public."user" USING btree (email);


--
-- TOC entry 3235 (class 1259 OID 16749)
-- Name: idx_user_firstname; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_firstname ON public."user" USING btree (firstname);


--
-- TOC entry 3236 (class 1259 OID 16750)
-- Name: idx_user_lastname; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_lastname ON public."user" USING btree (lastname);


--
-- TOC entry 3237 (class 1259 OID 16751)
-- Name: idx_user_phone; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_phone ON public."user" USING btree (phone);


--
-- TOC entry 3238 (class 1259 OID 16752)
-- Name: idx_user_username; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX idx_user_username ON public."user" USING btree (username);


--
-- TOC entry 3183 (class 1259 OID 16753)
-- Name: item_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX item_lower_idx ON public.item USING btree (lower((title)::text));


--
-- TOC entry 3188 (class 1259 OID 16754)
-- Name: prize_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX prize_lower_idx ON public.prize USING btree (lower((title)::text));


--
-- TOC entry 3217 (class 1259 OID 16755)
-- Name: subscription_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX subscription_lower_idx ON public.subscription USING btree (lower((title)::text));


--
-- TOC entry 3226 (class 1259 OID 16756)
-- Name: tournament_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX tournament_lower_idx ON public.tournament USING btree (lower((title)::text));


--
-- TOC entry 3229 (class 1259 OID 16757)
-- Name: tournament_set_lower_idx; Type: INDEX; Schema: public; Owner: doadmin
--

CREATE INDEX tournament_set_lower_idx ON public.tournament_set USING btree (lower((title)::text));


-- Completed on 2021-07-08 21:46:33 +08

--
-- PostgreSQL database dump complete
--

