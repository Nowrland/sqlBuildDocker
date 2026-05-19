--
-- PostgreSQL database dump
--

\restrict O0eQhU46TH7Xv8zLkQnffMVmC1DnA0yApfy3FXkdQdI7ae5aQNYqu5n2Hi8vUg8

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: Arcanautadb
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO "Arcanautadb";

--
-- Name: update_updated_at_economy_column(); Type: FUNCTION; Schema: public; Owner: Arcanautadb
--

CREATE FUNCTION public.update_updated_at_economy_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.economy_updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_economy_column() OWNER TO "Arcanautadb";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    activity_type_id integer,
    category_id integer,
    starting_location_id integer,
    total_payment_uec bigint,
    individual_payment_ac integer
);


ALTER TABLE public.activities OWNER TO "Arcanautadb";

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activities_id_seq OWNER TO "Arcanautadb";

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: activity_types; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.activity_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.activity_types OWNER TO "Arcanautadb";

--
-- Name: activity_types_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.activity_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_types_id_seq OWNER TO "Arcanautadb";

--
-- Name: activity_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.activity_types_id_seq OWNED BY public.activity_types.id;


--
-- Name: atividade_modelos; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.atividade_modelos (
    id character varying(64) NOT NULL,
    tipo character varying(10) NOT NULL,
    departamento character varying(100) NOT NULL,
    titulo character varying(255) NOT NULL,
    descricao text NOT NULL,
    canal_id character varying(32) NOT NULL,
    imagem_url text,
    criado_por character varying(32) NOT NULL,
    criado_em timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT atividade_modelos_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['Aula'::character varying, 'Evento'::character varying])::text[])))
);


ALTER TABLE public.atividade_modelos OWNER TO "Arcanautadb";

--
-- Name: TABLE atividade_modelos; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.atividade_modelos IS 'Modelos base de atividades (aulas e eventos)';


--
-- Name: awards_link; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.awards_link (
    link_id character varying(255) NOT NULL,
    link character varying(255)
);


ALTER TABLE public.awards_link OWNER TO "Arcanautadb";

--
-- Name: categories; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.categories OWNER TO "Arcanautadb";

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO "Arcanautadb";

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: eventos_agendados; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.eventos_agendados (
    id character varying(64) NOT NULL,
    modelo_id character varying(64) NOT NULL,
    guild_id character varying(32) NOT NULL,
    guild_event_id character varying(32),
    tipo character varying(16) NOT NULL,
    titulo character varying(255) NOT NULL,
    descricao text NOT NULL,
    departamento character varying(128) NOT NULL,
    data_evento timestamp with time zone NOT NULL,
    canal_id character varying(32) NOT NULL,
    imagem_url text,
    criado_por character varying(32) NOT NULL,
    criado_em timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    alerta_meio_dia boolean DEFAULT false NOT NULL,
    alerta_trinta_min boolean DEFAULT false NOT NULL,
    status character varying(16) DEFAULT 'agendado'::character varying NOT NULL
);


ALTER TABLE public.eventos_agendados OWNER TO "Arcanautadb";

--
-- Name: TABLE eventos_agendados; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.eventos_agendados IS 'Eventos e aulas agendados';


--
-- Name: historico_atividades; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.historico_atividades (
    id character varying(64) NOT NULL,
    modelo_id character varying(64) NOT NULL,
    tipo character varying(10) NOT NULL,
    titulo character varying(255) NOT NULL,
    departamento character varying(100) NOT NULL,
    data_evento timestamp with time zone NOT NULL,
    criado_por character varying(32) NOT NULL,
    concluido_em timestamp with time zone NOT NULL,
    participantes integer,
    CONSTRAINT historico_atividades_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['Aula'::character varying, 'Evento'::character varying])::text[])))
);


ALTER TABLE public.historico_atividades OWNER TO "Arcanautadb";

--
-- Name: TABLE historico_atividades; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.historico_atividades IS 'Histórico de atividades concluídas';


--
-- Name: locations; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.locations OWNER TO "Arcanautadb";

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO "Arcanautadb";

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: obs; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.obs (
    id integer NOT NULL,
    discord_id bigint,
    item_obs character varying(255),
    data timestamp without time zone,
    exec_id bigint
);


ALTER TABLE public.obs OWNER TO "Arcanautadb";

--
-- Name: obs_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.obs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.obs_id_seq OWNER TO "Arcanautadb";

--
-- Name: obs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.obs_id_seq OWNED BY public.obs.id;


--
-- Name: player_tasks; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.player_tasks (
    id integer NOT NULL,
    name character varying(200) NOT NULL
);


ALTER TABLE public.player_tasks OWNER TO "Arcanautadb";

--
-- Name: player_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.player_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.player_tasks_id_seq OWNER TO "Arcanautadb";

--
-- Name: player_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.player_tasks_id_seq OWNED BY public.player_tasks.id;


--
-- Name: raffle_participants; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.raffle_participants (
    id integer NOT NULL,
    raffle_id uuid NOT NULL,
    user_id character varying(32) NOT NULL,
    ticket_count integer DEFAULT 0 NOT NULL,
    total_spent bigint DEFAULT 0 NOT NULL,
    join_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.raffle_participants OWNER TO "Arcanautadb";

--
-- Name: TABLE raffle_participants; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.raffle_participants IS 'Participantes dos sorteios';


--
-- Name: raffle_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.raffle_participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.raffle_participants_id_seq OWNER TO "Arcanautadb";

--
-- Name: raffle_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.raffle_participants_id_seq OWNED BY public.raffle_participants.id;


--
-- Name: raffles; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.raffles (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    creator_id character varying(32) NOT NULL,
    channel_id character varying(32) NOT NULL,
    message_id character varying(32),
    first_ticket_price integer NOT NULL,
    status character varying(20) DEFAULT 'active'::character varying NOT NULL,
    image_url text,
    scheduled_at timestamp with time zone,
    winner_id character varying(32),
    total_prize bigint,
    auto_drawn boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    ended_at timestamp with time zone
);


ALTER TABLE public.raffles OWNER TO "Arcanautadb";

--
-- Name: TABLE raffles; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.raffles IS 'Sorteios criados no bot';


--
-- Name: referencies; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.referencies (
    referral_discord_id bigint NOT NULL,
    discord_id bigint,
    verificar boolean
);


ALTER TABLE public.referencies OWNER TO "Arcanautadb";

--
-- Name: roles; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.roles OWNER TO "Arcanautadb";

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO "Arcanautadb";

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: star_systems; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.star_systems (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.star_systems OWNER TO "Arcanautadb";

--
-- Name: star_systems_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.star_systems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.star_systems_id_seq OWNER TO "Arcanautadb";

--
-- Name: star_systems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.star_systems_id_seq OWNED BY public.star_systems.id;


--
-- Name: unit_types; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.unit_types (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.unit_types OWNER TO "Arcanautadb";

--
-- Name: unit_types_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.unit_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unit_types_id_seq OWNER TO "Arcanautadb";

--
-- Name: unit_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.unit_types_id_seq OWNED BY public.unit_types.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.units (
    id integer NOT NULL,
    code character varying(50),
    designation_location_id integer,
    star_system_id integer,
    unit_type_id integer,
    role_id integer,
    player_task_id integer,
    vehicle_id integer,
    activity_id integer
);


ALTER TABLE public.units OWNER TO "Arcanautadb";

--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_id_seq OWNER TO "Arcanautadb";

--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- Name: user_awards; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.user_awards (
    discord_id character varying(255) NOT NULL,
    medalha_do_ar boolean DEFAULT false,
    matador_de_vermes boolean DEFAULT false,
    insignia_de_combate_bronze boolean DEFAULT false,
    duas_estrelas_de_servico_bronze boolean DEFAULT false,
    estrela_de_servico_bronze boolean DEFAULT false
);


ALTER TABLE public.user_awards OWNER TO "Arcanautadb";

--
-- Name: users; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.users (
    discord_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    rsi_handle character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    celular character varying(255) NOT NULL,
    main_org character varying(255),
    role character varying(255),
    recruitment timestamp without time zone,
    org_anterior character varying(255),
    referred bigint,
    recrutador bigint,
    function character varying(255),
    balance bigint DEFAULT 0 NOT NULL,
    last_daily timestamp with time zone,
    total_earned bigint DEFAULT 0 NOT NULL,
    total_spent bigint DEFAULT 0 NOT NULL,
    message_count integer DEFAULT 0 NOT NULL,
    last_message_reward timestamp with time zone,
    economy_updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO "Arcanautadb";

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.users IS 'Dados dos membros cadastrados + economia (colunas de AC mescladas)';


--
-- Name: vehicles; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.vehicles (
    id integer NOT NULL,
    name character varying(200) NOT NULL
);


ALTER TABLE public.vehicles OWNER TO "Arcanautadb";

--
-- Name: vehicles_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.vehicles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicles_id_seq OWNER TO "Arcanautadb";

--
-- Name: vehicles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.vehicles_id_seq OWNED BY public.vehicles.id;


--
-- Name: voice_absent_users; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.voice_absent_users (
    user_id character varying(32) NOT NULL,
    channel_id character varying(32) NOT NULL,
    channel_name character varying(255) NOT NULL,
    guild_id character varying(32) NOT NULL,
    absence_start timestamp with time zone NOT NULL,
    original_start_time timestamp with time zone NOT NULL,
    total_minutes_before_absence integer DEFAULT 0 NOT NULL,
    ac_earned_before_absence integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.voice_absent_users OWNER TO "Arcanautadb";

--
-- Name: TABLE voice_absent_users; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.voice_absent_users IS 'Usuários ausentes para recuperação de sessão';


--
-- Name: voice_channel_status; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.voice_channel_status (
    channel_id character varying(32) NOT NULL,
    message_id character varying(32),
    last_update timestamp with time zone NOT NULL,
    active_users text[] DEFAULT '{}'::text[]
);


ALTER TABLE public.voice_channel_status OWNER TO "Arcanautadb";

--
-- Name: TABLE voice_channel_status; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.voice_channel_status IS 'Status das mensagens de canais de voz';


--
-- Name: voice_daily_summaries; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.voice_daily_summaries (
    user_id character varying(32) NOT NULL,
    date date NOT NULL,
    total_minutes integer DEFAULT 0 NOT NULL,
    total_ac_earned integer DEFAULT 0 NOT NULL,
    sessions integer DEFAULT 0 NOT NULL,
    last_session_end timestamp with time zone
);


ALTER TABLE public.voice_daily_summaries OWNER TO "Arcanautadb";

--
-- Name: TABLE voice_daily_summaries; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.voice_daily_summaries IS 'Resumos diários de sessões de voz por usuário';


--
-- Name: voice_history; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.voice_history (
    id integer NOT NULL,
    user_id character varying(32) NOT NULL,
    channel_id character varying(32) NOT NULL,
    channel_name character varying(255) NOT NULL,
    guild_id character varying(32) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    total_minutes integer NOT NULL,
    ac_earned integer NOT NULL,
    total_paused_minutes integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.voice_history OWNER TO "Arcanautadb";

--
-- Name: TABLE voice_history; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.voice_history IS 'Histórico de sessões de voz finalizadas';


--
-- Name: voice_history_id_seq; Type: SEQUENCE; Schema: public; Owner: Arcanautadb
--

CREATE SEQUENCE public.voice_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.voice_history_id_seq OWNER TO "Arcanautadb";

--
-- Name: voice_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Arcanautadb
--

ALTER SEQUENCE public.voice_history_id_seq OWNED BY public.voice_history.id;


--
-- Name: voice_sessions; Type: TABLE; Schema: public; Owner: Arcanautadb
--

CREATE TABLE public.voice_sessions (
    user_id character varying(32) NOT NULL,
    channel_id character varying(32) NOT NULL,
    channel_name character varying(255) NOT NULL,
    guild_id character varying(32) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    last_activity timestamp with time zone NOT NULL,
    total_minutes integer DEFAULT 0 NOT NULL,
    ac_earned integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_paused boolean DEFAULT false NOT NULL,
    paused_at timestamp with time zone,
    total_paused_minutes integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.voice_sessions OWNER TO "Arcanautadb";

--
-- Name: TABLE voice_sessions; Type: COMMENT; Schema: public; Owner: Arcanautadb
--

COMMENT ON TABLE public.voice_sessions IS 'Sessões de voz ativas';


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- Name: activity_types id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activity_types ALTER COLUMN id SET DEFAULT nextval('public.activity_types_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: obs id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.obs ALTER COLUMN id SET DEFAULT nextval('public.obs_id_seq'::regclass);


--
-- Name: player_tasks id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.player_tasks ALTER COLUMN id SET DEFAULT nextval('public.player_tasks_id_seq'::regclass);


--
-- Name: raffle_participants id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.raffle_participants ALTER COLUMN id SET DEFAULT nextval('public.raffle_participants_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: star_systems id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.star_systems ALTER COLUMN id SET DEFAULT nextval('public.star_systems_id_seq'::regclass);


--
-- Name: unit_types id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.unit_types ALTER COLUMN id SET DEFAULT nextval('public.unit_types_id_seq'::regclass);


--
-- Name: units id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- Name: vehicles id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.vehicles ALTER COLUMN id SET DEFAULT nextval('public.vehicles_id_seq'::regclass);


--
-- Name: voice_history id; Type: DEFAULT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.voice_history ALTER COLUMN id SET DEFAULT nextval('public.voice_history_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.activities (id, name, activity_type_id, category_id, starting_location_id, total_payment_uec, individual_payment_ac) FROM stdin;
1	Território Escuro	1	1	1	\N	40
2	Stormbreaker	1	1	2	60000000	40
3	Inimigos Jurados	1	1	3	\N	40
4	Hangar Executivo	1	1	2	\N	40
5	CT.I	2	1	2	\N	40
6	CT.II	2	1	4	\N	40
7	TV.I	2	1	5	\N	40
8	NAV.I	2	1	2	\N	40
9	REG.I	2	1	4	\N	40
\.


--
-- Data for Name: activity_types; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.activity_types (id, name) FROM stdin;
1	Missão
2	Aula
3	Torneio
4	Contrato
5	Treinamento
6	Stratops
\.


--
-- Data for Name: atividade_modelos; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.atividade_modelos (id, tipo, departamento, titulo, descricao, canal_id, imagem_url, criado_por, criado_em) FROM stdin;
45e95b5f	Evento	Alto Comando	Teste se ta funcionando	amém funcino	1395206018153058384	\N	306978576929128460	2026-02-18 16:16:42.24+00
8dbf89da	Aula	CDA|WIP	Teste CDA	aaaaa	1395206018153058384	\N	306978576929128460	2026-02-18 16:23:47.398+00
\.


--
-- Data for Name: awards_link; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.awards_link (link_id, link) FROM stdin;
medalha_do_ar	https://arca-app-conquistas.s3.us-east-1.amazonaws.com/Medalha+do+Ar.jpg
matador_de_vermes	https://arca-app-conquistas.s3.us-east-1.amazonaws.com/Insignia+de+Matador+de+Vermes.webp
insignia_de_combate_bronze	https://arca-app-conquistas.s3.us-east-1.amazonaws.com/Insignia+de+Combate+Bronze.jpg
duas_estrelas_de_servico_bronze	https://arca-app-conquistas.s3.us-east-1.amazonaws.com/Duas+Estrelas+de+Servico+Bronze.png
estrela_de_servico_bronze	https://arca-app-conquistas.s3.us-east-1.amazonaws.com/Estrela+de+Servico+Bronze.png
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.categories (id, name) FROM stdin;
1	Defesa
2	Competição
3	Indústria
4	Exploração & Ciência
5	Suporte
6	Logística & Comércio
\.


--
-- Data for Name: eventos_agendados; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.eventos_agendados (id, modelo_id, guild_id, guild_event_id, tipo, titulo, descricao, departamento, data_evento, canal_id, imagem_url, criado_por, criado_em, alerta_meio_dia, alerta_trinta_min, status) FROM stdin;
a80d5cb5	45e95b5f	142665303891902464	1473714935396831242	Evento	Teste se ta funcionando	amém funcino	Alto Comando	2026-02-18 16:20:00+00	1395206018153058384	\N	306978576929128460	2026-02-18 16:17:01.381+00	t	f	concluido
5ae4cca4	45e95b5f	142665303891902464	1473716488144818282	Evento	Teste se ta funcionando	amém funcino	Alto Comando	2026-02-18 16:30:00+00	1395206018153058384	\N	304413269194702849	2026-02-18 16:23:11.513+00	t	t	agendado
\.


--
-- Data for Name: historico_atividades; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.historico_atividades (id, modelo_id, tipo, titulo, departamento, data_evento, criado_por, concluido_em, participantes) FROM stdin;
a80d5cb5	45e95b5f	Evento	Teste se ta funcionando	Alto Comando	2026-02-18 16:20:00+00	306978576929128460	2026-02-18 16:25:35.727+00	\N
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.locations (id, name) FROM stdin;
1	Baijini Point
2	Orbituary
3	Nyx - Pyro Gateway
4	Gaslight
5	Port Tressler
6	Everus Harbor
7	Seraphim
8	Checkmate
9	Endgame
10	Pyro Gateway
11	Stanton Gateway
12	Nyx Gateway
13	Terra
14	Stanton
15	Nyx
16	Castra
\.


--
-- Data for Name: obs; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.obs (id, discord_id, item_obs, data, exec_id) FROM stdin;
1	209164697402998785	teste	2026-01-04 21:42:09.736	209164697402998785
2	209164697402998785	obs 2	2026-01-04 22:11:16.197	209164697402998785
3	209164697402998785	waka	2026-01-04 23:16:01.738	124885660510322688
\.


--
-- Data for Name: player_tasks; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.player_tasks (id, name) FROM stdin;
1	Superioridade Aérea
2	Suporte Aéreo de Proximidade (CAS)
3	Alerta e Vigilância (AWACS)
4	Reconhecimento Aéreo
5	Guerra Eletrônica (EW)
6	Busca e Resgate em Combate (CSAR)
7	Controle de Danos
8	AAA
9	ASA
10	Escolta Aérea
11	Escolta Pessoal
12	Escolta Mecanizada
13	Mineração
14	Sondagem
15	Refino
16	Perfuração/Extração
\.


--
-- Data for Name: raffle_participants; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.raffle_participants (id, raffle_id, user_id, ticket_count, total_spent, join_time) FROM stdin;
1	7dc0efc6-2268-4349-a761-3a9758763dd4	306978576929128460	6	77	2026-02-18 15:56:38.761633+00
7	7b6fafdf-4e9f-41fb-a410-7514ce71cc4b	306978576929128460	3	33	2026-02-18 15:57:06.411333+00
\.


--
-- Data for Name: raffles; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.raffles (id, title, creator_id, channel_id, message_id, first_ticket_price, status, image_url, scheduled_at, winner_id, total_prize, auto_drawn, created_at, ended_at) FROM stdin;
7b6fafdf-4e9f-41fb-a410-7514ce71cc4b	teste	306978576929128460	1398758918590828614	1473709908779335681	10	ended	\N	\N	306978576929128460	33	f	2026-02-18 15:57:02.349545+00	2026-02-18 15:58:03.340157+00
7dc0efc6-2268-4349-a761-3a9758763dd4	Teste agendamento	306978576929128460	1398758918590828614	1473709758103027722	10	ended	\N	2026-02-18 15:59:00+00	306978576929128460	77	t	2026-02-18 15:56:26.394084+00	2026-02-18 15:59:52.883824+00
\.


--
-- Data for Name: referencies; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.referencies (referral_discord_id, discord_id, verificar) FROM stdin;
209164697402998785	209164697402998785	t
124885660510322688	300486585852493824	f
306978576929128460	1445161350937706560	f
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.roles (id, name) FROM stdin;
1	Piloto
2	Navegador
3	Artilheiro
4	Engenheiro
5	Mecânico
6	Capitão
7	Operador
8	Médico
9	Líder de Esquadrilha
10	Oficial Executivo
11	Minerador
\.


--
-- Data for Name: star_systems; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.star_systems (id, name) FROM stdin;
1	Pyro
2	Stanton
3	Nyx
4	Castra
5	Terra
\.


--
-- Data for Name: unit_types; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.unit_types (id, name) FROM stdin;
1	Grupo de Combate
2	Pelotão
3	Pelotão Mecanizado
4	Nave Multicrew
5	Esquadrilha
6	Esquadrão
7	Grupo de Voo
8	Elemento Tarefa
9	Unidade Tarefa
10	Grupo Tarefa
11	Força Tarefa
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.units (id, code, designation_location_id, star_system_id, unit_type_id, role_id, player_task_id, vehicle_id, activity_id) FROM stdin;
\.


--
-- Data for Name: user_awards; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.user_awards (discord_id, medalha_do_ar, matador_de_vermes, insignia_de_combate_bronze, duas_estrelas_de_servico_bronze, estrela_de_servico_bronze) FROM stdin;
306978576929128460	f	f	f	f	f
209164697402998785	f	t	f	f	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.users (discord_id, name, rsi_handle, email, celular, main_org, role, recruitment, org_anterior, referred, recrutador, function, balance, last_daily, total_earned, total_spent, message_count, last_message_reward, economy_updated_at) FROM stdin;
209164697402998785	Novaes	Novaes	novaes@novaeses.com	 	Arca	Inscrito	2026-02-16 13:48:03.102	nao	209164697402998785	1445161350937706560	Administração	100039	2026-02-18 15:50:08.137+00	100044	5	0	\N	2026-02-18 15:45:58.76337+00
306978576929128460	TSES	yGoes	HG@GH.CONM	1898128128	Arca	Inscrito	2026-02-18 16:20:17.742	N	209164697402998785	1445161350937706560	Comando	28	\N	28	0	0	\N	2026-02-18 16:20:17.763972+00
124885660510322688	Harumeida	wawa	wawa@gmail.com.br	3214967864856.4	Arca	Inscrito	2026-02-15 20:36:11.918	nah	300486585852493824	124885660510322688	Membro	0	\N	0	0	0	\N	2026-02-18 15:45:58.76337+00
\.


--
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.vehicles (id, name) FROM stdin;
1	100i
2	125A
3	135C
4	300i
5	315P
6	325A
7	350R
8	400i
9	600i
10	85X
11	890 Jump
12	A1 Spirit
13	A2 Hercules
14	Apollo Medivac
15	Apollo Triage
16	Ares Inferno
17	Ares Ion
18	Arrastra
19	Arrow
20	ATLS
21	ATLS GEO
22	Aurora CL
23	Aurora ES
24	Aurora LN
25	Aurora LX
26	Aurora MR
27	Avenger Stalker
28	Avenger Titan
29	Avenger Warlock
30	Ballista
31	Blade
32	Buccaneer
33	C1 Spirit
34	C2 Hercules
35	C8R Pisces
36	C8X Pisces
37	Carrack
38	Caterpillar
39	Centurion
40	Clipper
41	Constellation Andromeda
42	Constellation Aquila
43	Constellation Phoenix
44	Constellation Taurus
45	Corsair
46	Crucible
47	CSV-SM
48	Cutter
49	Cutter Rambler
50	Cutter Scout
51	Cutlass Black
52	Cutlass Blue
53	Cutlass Red
54	Cutlass Steel
55	Cyclone
56	Cyclone AA
57	Cyclone MT
58	Cyclone RC
59	Cyclone RN
60	Cyclone TR
61	Defender
62	Drangonfly
63	E1 Spirit
64	Eclipse
65	Endeavor
66	Expanse
67	F7C Hornet MK I
68	F7C Hornet MK II
69	F7C-M Super Hornet MK I
70	F7C-M Super Hornet MK II
71	F7C-R Hornet Tracker MK I
72	F7C-R Hornet Tracker MK II
73	F7C-S Hornet MK I
74	F7C-S Hornet Ghost MK II
75	Fortune
76	Freelancer
77	Freelancer DUR
78	Freelancer MAX
79	Freelancer MIS
80	Fury
81	Fury LX
82	Fury MX
83	Galaxy
84	Genesis
85	G12
86	G12A
87	G12R
88	Glaive
89	Gladiator
90	Gladius
91	Golem
92	Golem OX
93	Guardian
94	Guardian MX
95	Guardian QI
96	Hammerhead
97	Hawk
98	Herald
99	Hoverquad
100	Hull A
101	Hull B
102	Hull C
103	Hull D
104	Hull E
105	Hurricane
106	Idris-M
107	Idris-P
108	Intrepid
109	Ironclad
110	Ironclad Assault
111	Javelin
112	Khartu-Al
113	L-21 Wolf
114	L-22 Alpha Wolf
115	Legionnaire
116	Liberator
117	Lynx
118	M2 Hercules
119	M50
120	Mantis
121	Merchantman
122	Mercury
123	Meteor
124	MDC
125	Mole
126	MPUV Cargo
127	MPUV Personnel
128	MPUV Tractor
129	MTC
130	Mule
131	Mustang Alpha
132	Mustang Beta
133	Mustang Delta
134	Mustang Gamma
135	Mustang Omega
136	Nautilus
137	Nomad
138	Nova
139	Nox
140	Odyssey
141	Orion
142	P-52 Merlin
143	P-72 Archimedes
144	Paladin
145	Perseus
146	Pioneer
147	Polaris
148	Prospector
149	Prowler
150	Prowler Utility
151	Pulse
152	Pulse LX
153	Raft
154	Railen
155	Ranger CV
156	Ranger RC
157	Ranger TR
158	Reclaimer
159	Redeemer
160	Reliant Kore
161	Reliant Mako
162	Reliant Sem
163	Reliant Tana
164	Retaliator
165	Razor
166	Razor EX
167	Razor LX
168	ROC
169	ROC-DS
170	Sabre
171	Sabre Firebird
172	Sabre Peregrine
173	Salvation
174	San'tok.Yai
175	Scorpius
176	Scorpius Antares
177	Shiv
178	Spartan
179	SRV
180	Starfarer
181	Starfarer Gemini
182	Starlancer MAX
183	Starlancer TAC
184	STV
185	Stinger
186	Storm
187	Storm AA
188	Syulen
189	Talon
190	Talon Shrike
191	Terrapin
192	Terrapin Medic
193	Ursa
194	Ursa Medivac
195	Valkyrie
196	Vanguard Harbinger
197	Vanguard Hoplite
198	Vanguard Sentinel
199	Vanguard Warden
200	Vulture
201	Vulcan
202	X1
203	X1 Force
204	X1 Velocity
205	Zeus MK II CL
206	Zeus MK II ES
207	Zeus MK II MR
\.


--
-- Data for Name: voice_absent_users; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.voice_absent_users (user_id, channel_id, channel_name, guild_id, absence_start, original_start_time, total_minutes_before_absence, ac_earned_before_absence) FROM stdin;
\.


--
-- Data for Name: voice_channel_status; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.voice_channel_status (channel_id, message_id, last_update, active_users) FROM stdin;
1398769719842181263	1473715597551341622	2026-02-18 16:19:38.816315+00	{209164697402998785,306978576929128460}
\.


--
-- Data for Name: voice_daily_summaries; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.voice_daily_summaries (user_id, date, total_minutes, total_ac_earned, sessions, last_session_end) FROM stdin;
\.


--
-- Data for Name: voice_history; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.voice_history (id, user_id, channel_id, channel_name, guild_id, start_time, end_time, total_minutes, ac_earned, total_paused_minutes, created_at) FROM stdin;
1	306978576929128460	1395206018153058384	TESTE	142665303891902464	2026-02-18 15:51:53.357+00	2026-02-18 15:52:15.852+00	0	0	0	2026-02-18 15:52:15.875157+00
\.


--
-- Data for Name: voice_sessions; Type: TABLE DATA; Schema: public; Owner: Arcanautadb
--

COPY public.voice_sessions (user_id, channel_id, channel_name, guild_id, start_time, last_activity, total_minutes, ac_earned, is_active, is_paused, paused_at, total_paused_minutes) FROM stdin;
306978576929128460	1398769719842181263	teste2	142665303891902464	2026-02-18 15:59:23.692+00	2026-02-18 16:27:38.366307+00	0	28	t	f	\N	0
209164697402998785	1398769719842181263	teste2	142665303891902464	2026-02-18 15:59:31.185+00	2026-02-18 16:27:38.391972+00	0	28	t	f	\N	0
\.


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.activities_id_seq', 9, true);


--
-- Name: activity_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.activity_types_id_seq', 6, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.categories_id_seq', 6, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.locations_id_seq', 16, true);


--
-- Name: obs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.obs_id_seq', 3, true);


--
-- Name: player_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.player_tasks_id_seq', 16, true);


--
-- Name: raffle_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.raffle_participants_id_seq', 9, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.roles_id_seq', 11, true);


--
-- Name: star_systems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.star_systems_id_seq', 5, true);


--
-- Name: unit_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.unit_types_id_seq', 11, true);


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.units_id_seq', 1, false);


--
-- Name: vehicles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.vehicles_id_seq', 207, true);


--
-- Name: voice_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Arcanautadb
--

SELECT pg_catalog.setval('public.voice_history_id_seq', 1, true);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: activity_types activity_types_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activity_types
    ADD CONSTRAINT activity_types_name_key UNIQUE (name);


--
-- Name: activity_types activity_types_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activity_types
    ADD CONSTRAINT activity_types_pkey PRIMARY KEY (id);


--
-- Name: atividade_modelos atividade_modelos_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.atividade_modelos
    ADD CONSTRAINT atividade_modelos_pkey PRIMARY KEY (id);


--
-- Name: awards_link awards_link_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.awards_link
    ADD CONSTRAINT awards_link_pkey PRIMARY KEY (link_id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: eventos_agendados eventos_agendados_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.eventos_agendados
    ADD CONSTRAINT eventos_agendados_pkey PRIMARY KEY (id);


--
-- Name: historico_atividades historico_atividades_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.historico_atividades
    ADD CONSTRAINT historico_atividades_pkey PRIMARY KEY (id);


--
-- Name: locations locations_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_name_key UNIQUE (name);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: obs obs_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.obs
    ADD CONSTRAINT obs_pkey PRIMARY KEY (id);


--
-- Name: player_tasks player_tasks_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.player_tasks
    ADD CONSTRAINT player_tasks_name_key UNIQUE (name);


--
-- Name: player_tasks player_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.player_tasks
    ADD CONSTRAINT player_tasks_pkey PRIMARY KEY (id);


--
-- Name: raffle_participants raffle_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.raffle_participants
    ADD CONSTRAINT raffle_participants_pkey PRIMARY KEY (id);


--
-- Name: raffle_participants raffle_participants_raffle_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.raffle_participants
    ADD CONSTRAINT raffle_participants_raffle_id_user_id_key UNIQUE (raffle_id, user_id);


--
-- Name: raffles raffles_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.raffles
    ADD CONSTRAINT raffles_pkey PRIMARY KEY (id);


--
-- Name: referencies referrencies_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.referencies
    ADD CONSTRAINT referrencies_pkey PRIMARY KEY (referral_discord_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: star_systems star_systems_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.star_systems
    ADD CONSTRAINT star_systems_name_key UNIQUE (name);


--
-- Name: star_systems star_systems_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.star_systems
    ADD CONSTRAINT star_systems_pkey PRIMARY KEY (id);


--
-- Name: unit_types unit_types_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_name_key UNIQUE (name);


--
-- Name: unit_types unit_types_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_pkey PRIMARY KEY (id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: user_awards user_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.user_awards
    ADD CONSTRAINT user_awards_pkey PRIMARY KEY (discord_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (discord_id);


--
-- Name: vehicles vehicles_name_key; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_name_key UNIQUE (name);


--
-- Name: vehicles vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (id);


--
-- Name: voice_absent_users voice_absent_users_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.voice_absent_users
    ADD CONSTRAINT voice_absent_users_pkey PRIMARY KEY (user_id);


--
-- Name: voice_channel_status voice_channel_status_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.voice_channel_status
    ADD CONSTRAINT voice_channel_status_pkey PRIMARY KEY (channel_id);


--
-- Name: voice_daily_summaries voice_daily_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.voice_daily_summaries
    ADD CONSTRAINT voice_daily_summaries_pkey PRIMARY KEY (user_id, date);


--
-- Name: voice_history voice_history_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.voice_history
    ADD CONSTRAINT voice_history_pkey PRIMARY KEY (id);


--
-- Name: voice_sessions voice_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.voice_sessions
    ADD CONSTRAINT voice_sessions_pkey PRIMARY KEY (user_id);


--
-- Name: idx_atividade_modelos_departamento; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_atividade_modelos_departamento ON public.atividade_modelos USING btree (departamento);


--
-- Name: idx_atividade_modelos_tipo; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_atividade_modelos_tipo ON public.atividade_modelos USING btree (tipo);


--
-- Name: idx_eventos_agendados_data; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_eventos_agendados_data ON public.eventos_agendados USING btree (data_evento);


--
-- Name: idx_eventos_agendados_modelo; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_eventos_agendados_modelo ON public.eventos_agendados USING btree (modelo_id);


--
-- Name: idx_eventos_agendados_status; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_eventos_agendados_status ON public.eventos_agendados USING btree (status);


--
-- Name: idx_eventos_data; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_eventos_data ON public.eventos_agendados USING btree (data_evento);


--
-- Name: idx_eventos_status; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_eventos_status ON public.eventos_agendados USING btree (status);


--
-- Name: idx_historico_atividades_concluido_em; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_historico_atividades_concluido_em ON public.historico_atividades USING btree (concluido_em DESC);


--
-- Name: idx_historico_atividades_departamento; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_historico_atividades_departamento ON public.historico_atividades USING btree (departamento);


--
-- Name: idx_historico_atividades_tipo; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_historico_atividades_tipo ON public.historico_atividades USING btree (tipo);


--
-- Name: idx_historico_dept; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_historico_dept ON public.historico_atividades USING btree (departamento);


--
-- Name: idx_historico_tipo; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_historico_tipo ON public.historico_atividades USING btree (tipo);


--
-- Name: idx_raffle_participants_raffle_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_raffle_participants_raffle_id ON public.raffle_participants USING btree (raffle_id);


--
-- Name: idx_raffle_participants_user_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_raffle_participants_user_id ON public.raffle_participants USING btree (user_id);


--
-- Name: idx_raffles_channel_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_raffles_channel_id ON public.raffles USING btree (channel_id);


--
-- Name: idx_raffles_creator_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_raffles_creator_id ON public.raffles USING btree (creator_id);


--
-- Name: idx_raffles_scheduled_at; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_raffles_scheduled_at ON public.raffles USING btree (scheduled_at) WHERE ((status)::text = 'active'::text);


--
-- Name: idx_raffles_status; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_raffles_status ON public.raffles USING btree (status);


--
-- Name: idx_users_balance; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_users_balance ON public.users USING btree (balance DESC);


--
-- Name: idx_users_total_earned; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_users_total_earned ON public.users USING btree (total_earned DESC);


--
-- Name: idx_voice_daily_summaries_date; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_voice_daily_summaries_date ON public.voice_daily_summaries USING btree (date);


--
-- Name: idx_voice_history_channel_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_voice_history_channel_id ON public.voice_history USING btree (channel_id);


--
-- Name: idx_voice_history_start_time; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_voice_history_start_time ON public.voice_history USING btree (start_time DESC);


--
-- Name: idx_voice_history_user_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_voice_history_user_id ON public.voice_history USING btree (user_id);


--
-- Name: idx_voice_sessions_channel_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_voice_sessions_channel_id ON public.voice_sessions USING btree (channel_id);


--
-- Name: idx_voice_sessions_guild_id; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_voice_sessions_guild_id ON public.voice_sessions USING btree (guild_id);


--
-- Name: idx_voice_sessions_is_active; Type: INDEX; Schema: public; Owner: Arcanautadb
--

CREATE INDEX idx_voice_sessions_is_active ON public.voice_sessions USING btree (is_active) WHERE (is_active = true);


--
-- Name: activities activities_activity_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_activity_type_id_fkey FOREIGN KEY (activity_type_id) REFERENCES public.activity_types(id);


--
-- Name: activities activities_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: activities activities_starting_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_starting_location_id_fkey FOREIGN KEY (starting_location_id) REFERENCES public.locations(id);


--
-- Name: raffle_participants raffle_participants_raffle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.raffle_participants
    ADD CONSTRAINT raffle_participants_raffle_id_fkey FOREIGN KEY (raffle_id) REFERENCES public.raffles(id) ON DELETE CASCADE;


--
-- Name: units units_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id);


--
-- Name: units units_designation_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_designation_location_id_fkey FOREIGN KEY (designation_location_id) REFERENCES public.locations(id);


--
-- Name: units units_player_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_player_task_id_fkey FOREIGN KEY (player_task_id) REFERENCES public.player_tasks(id);


--
-- Name: units units_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: units units_star_system_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_star_system_id_fkey FOREIGN KEY (star_system_id) REFERENCES public.star_systems(id);


--
-- Name: units units_unit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_unit_type_id_fkey FOREIGN KEY (unit_type_id) REFERENCES public.unit_types(id);


--
-- Name: units units_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Arcanautadb
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict O0eQhU46TH7Xv8zLkQnffMVmC1DnA0yApfy3FXkdQdI7ae5aQNYqu5n2Hi8vUg8

