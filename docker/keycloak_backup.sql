--
-- PostgreSQL database dump
--

\restrict 3yqR8ntpkJO6GZHTylWce8kC5SxPYefODAoDhacp4AdhcAldfcN5yhFpCDdQ78T

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO admin;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO admin;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO admin;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO admin;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config (
    id character varying(36) CONSTRAINT authenticator_id_not_null NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO admin;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) CONSTRAINT authenticator_config_authenticator_id_not_null NOT NULL,
    value text,
    name character varying(255) CONSTRAINT authenticator_config_name_not_null NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO admin;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO admin;

--
-- Name: client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO admin;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO admin;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO admin;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO admin;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) CONSTRAINT app_node_registrations_application_id_not_null NOT NULL,
    value integer,
    name character varying(255) CONSTRAINT app_node_registrations_name_not_null NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO admin;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope (
    id character varying(36) CONSTRAINT client_template_id_not_null NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO admin;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) CONSTRAINT client_template_attributes_template_id_not_null NOT NULL,
    value character varying(2048),
    name character varying(255) CONSTRAINT client_template_attributes_name_not_null NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO admin;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO admin;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) CONSTRAINT template_scope_mapping_template_id_not_null NOT NULL,
    role_id character varying(36) CONSTRAINT template_scope_mapping_role_id_not_null NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO admin;

--
-- Name: component; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO admin;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO admin;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO admin;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO admin;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO admin;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO admin;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO admin;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO admin;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO admin;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO admin;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO admin;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO admin;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO admin;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO admin;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO admin;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO admin;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO admin;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO admin;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO admin;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean,
    authenticate_by_default boolean,
    realm_id character varying(36),
    add_token_role boolean,
    trust_email boolean,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean,
    organization_id character varying(255),
    hide_on_login boolean
);


ALTER TABLE public.identity_provider OWNER TO admin;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO admin;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO admin;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO admin;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO admin;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255),
    org_id character varying(255),
    created_timestamp bigint,
    last_modified_timestamp bigint
);


ALTER TABLE public.keycloak_group OWNER TO admin;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false CONSTRAINT keycloak_role_application_role_not_null NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO admin;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO admin;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0,
    realm_id character varying(36)
);


ALTER TABLE public.offline_client_session OWNER TO admin;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0,
    remember_me boolean
);


ALTER TABLE public.offline_user_session OWNER TO admin;

--
-- Name: org; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO admin;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO admin;

--
-- Name: org_invitation; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org_invitation (
    id character varying(36) NOT NULL,
    organization_id character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    created_at integer NOT NULL,
    expires_at integer,
    invite_link character varying(2048)
);


ALTER TABLE public.org_invitation OWNER TO admin;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO admin;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO admin;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO admin;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO admin;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO admin;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO admin;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO admin;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO admin;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO admin;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO admin;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO admin;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO admin;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO admin;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO admin;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO admin;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO admin;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO admin;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO admin;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server (
    id character varying(36) CONSTRAINT resource_server_client_id_not_null NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO admin;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO admin;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) CONSTRAINT resource_server_policy_resource_server_client_id_not_null NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO admin;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) CONSTRAINT resource_server_resource_resource_server_client_id_not_null NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO admin;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) CONSTRAINT resource_server_scope_resource_server_client_id_not_null NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO admin;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO admin;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO admin;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO admin;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO admin;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO admin;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO admin;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO admin;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO admin;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO admin;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL,
    last_modified_timestamp bigint
);


ALTER TABLE public.user_entity OWNER TO admin;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO admin;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO admin;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) CONSTRAINT user_federation_mapper_confi_user_federation_mapper_id_not_null NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO admin;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO admin;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO admin;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO admin;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO admin;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO admin;

--
-- Name: workflow_state; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.workflow_state (
    execution_id character varying(255) NOT NULL,
    resource_id character varying(255) NOT NULL,
    workflow_id character varying(255) NOT NULL,
    resource_type character varying(255),
    scheduled_step_id character varying(255),
    scheduled_step_timestamp bigint
);


ALTER TABLE public.workflow_state OWNER TO admin;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
669c84d6-7fa9-419e-9854-0c2a4f69d919	\N	auth-cookie	64844e83-205d-4ee5-b5f1-c772a9c661f8	1ecb1b3d-6183-4f96-88f3-980b59df363f	2	10	f	\N	\N
eaca3cdc-37f4-40eb-b534-15946d4156f9	\N	auth-spnego	64844e83-205d-4ee5-b5f1-c772a9c661f8	1ecb1b3d-6183-4f96-88f3-980b59df363f	3	20	f	\N	\N
eb37d3c6-9891-42e5-bf37-26ad5e81541c	\N	identity-provider-redirector	64844e83-205d-4ee5-b5f1-c772a9c661f8	1ecb1b3d-6183-4f96-88f3-980b59df363f	2	25	f	\N	\N
a22a71ac-b995-431f-b434-0b26ce7c9e83	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	1ecb1b3d-6183-4f96-88f3-980b59df363f	2	30	t	1a5bcc14-f1f1-4eb8-86bd-b31c30148448	\N
1bd23afe-8cac-4860-8207-950d31301f90	\N	auth-username-password-form	64844e83-205d-4ee5-b5f1-c772a9c661f8	1a5bcc14-f1f1-4eb8-86bd-b31c30148448	0	10	f	\N	\N
fd9b2a9e-a507-49e4-9613-5cba2087a2c5	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	1a5bcc14-f1f1-4eb8-86bd-b31c30148448	1	20	t	832653a5-ddd1-4278-b6c5-23d487668583	\N
1aad7600-ee57-4ec1-92bd-cf75e1226acd	\N	conditional-user-configured	64844e83-205d-4ee5-b5f1-c772a9c661f8	832653a5-ddd1-4278-b6c5-23d487668583	0	10	f	\N	\N
79011156-2594-4007-9005-b84066e3ce5c	\N	conditional-credential	64844e83-205d-4ee5-b5f1-c772a9c661f8	832653a5-ddd1-4278-b6c5-23d487668583	0	20	f	\N	5bc9dd74-4f0c-4ad1-96d3-305b6e5c64b0
7ab2ce2e-e95d-4825-8cdb-5d4908b47641	\N	auth-otp-form	64844e83-205d-4ee5-b5f1-c772a9c661f8	832653a5-ddd1-4278-b6c5-23d487668583	2	30	f	\N	\N
321c664c-4d6f-405d-b782-98f28bd51cda	\N	webauthn-authenticator	64844e83-205d-4ee5-b5f1-c772a9c661f8	832653a5-ddd1-4278-b6c5-23d487668583	3	40	f	\N	\N
fe635d86-3d89-485c-967f-a79f66e426a1	\N	auth-recovery-authn-code-form	64844e83-205d-4ee5-b5f1-c772a9c661f8	832653a5-ddd1-4278-b6c5-23d487668583	3	50	f	\N	\N
9a55e52c-3137-4f82-b776-b07c96ff309a	\N	direct-grant-validate-username	64844e83-205d-4ee5-b5f1-c772a9c661f8	18ea931c-009b-426b-86bf-06e3455dfb3f	0	10	f	\N	\N
f945b126-81ed-41d5-bfff-87ca84c082f8	\N	direct-grant-validate-password	64844e83-205d-4ee5-b5f1-c772a9c661f8	18ea931c-009b-426b-86bf-06e3455dfb3f	0	20	f	\N	\N
19088ddf-b44c-4046-a618-4291e183ef5e	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	18ea931c-009b-426b-86bf-06e3455dfb3f	1	30	t	60dd9619-1ad4-4479-a58c-12d93b0bd71c	\N
253df211-ef81-4c24-9fa4-214f5ac1859f	\N	conditional-user-configured	64844e83-205d-4ee5-b5f1-c772a9c661f8	60dd9619-1ad4-4479-a58c-12d93b0bd71c	0	10	f	\N	\N
39603512-6a3d-4b5d-884e-1ff380e1309c	\N	direct-grant-validate-otp	64844e83-205d-4ee5-b5f1-c772a9c661f8	60dd9619-1ad4-4479-a58c-12d93b0bd71c	0	20	f	\N	\N
303e581b-836b-4790-8650-1c0dd8dfe716	\N	registration-page-form	64844e83-205d-4ee5-b5f1-c772a9c661f8	a9c05ddc-77a3-4550-bf6f-b714f572fb84	0	10	t	d233b063-cec8-49f3-a272-5ffb1d55d935	\N
76466473-6278-40af-a36f-e967156e7d2d	\N	registration-user-creation	64844e83-205d-4ee5-b5f1-c772a9c661f8	d233b063-cec8-49f3-a272-5ffb1d55d935	0	20	f	\N	\N
99b8c1da-f1d1-4243-97ac-f108c74e68db	\N	registration-password-action	64844e83-205d-4ee5-b5f1-c772a9c661f8	d233b063-cec8-49f3-a272-5ffb1d55d935	0	50	f	\N	\N
6fe61b93-5463-440a-aff8-53a139c6f57c	\N	registration-recaptcha-action	64844e83-205d-4ee5-b5f1-c772a9c661f8	d233b063-cec8-49f3-a272-5ffb1d55d935	3	60	f	\N	\N
5e50c999-d2dd-4fd3-97b7-ec1e95df65f9	\N	registration-terms-and-conditions	64844e83-205d-4ee5-b5f1-c772a9c661f8	d233b063-cec8-49f3-a272-5ffb1d55d935	3	70	f	\N	\N
9bb9f690-d4a7-4e82-9c25-2df4e98ed461	\N	reset-credentials-choose-user	64844e83-205d-4ee5-b5f1-c772a9c661f8	a224e319-ba24-4846-aafb-f8046c2641a7	0	10	f	\N	\N
2004de86-b6f4-40fd-a16a-ebfb85b3c3d3	\N	reset-credential-email	64844e83-205d-4ee5-b5f1-c772a9c661f8	a224e319-ba24-4846-aafb-f8046c2641a7	0	20	f	\N	\N
07be8f3c-77b7-4439-a0e1-b637c104ae6f	\N	reset-password	64844e83-205d-4ee5-b5f1-c772a9c661f8	a224e319-ba24-4846-aafb-f8046c2641a7	0	30	f	\N	\N
304026bc-037b-4ba9-b0f8-e740cae2ad81	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	a224e319-ba24-4846-aafb-f8046c2641a7	1	40	t	a80ebe37-f509-4ebb-9acf-fddbbdb90b11	\N
854f1251-6d91-42b5-8e68-671b779ed4ee	\N	conditional-user-configured	64844e83-205d-4ee5-b5f1-c772a9c661f8	a80ebe37-f509-4ebb-9acf-fddbbdb90b11	0	10	f	\N	\N
eeba9334-3e80-4a72-9d20-3b3679083b33	\N	reset-otp	64844e83-205d-4ee5-b5f1-c772a9c661f8	a80ebe37-f509-4ebb-9acf-fddbbdb90b11	0	20	f	\N	\N
9e1060e5-a17e-4a96-aa92-acae35449aa8	\N	client-secret	64844e83-205d-4ee5-b5f1-c772a9c661f8	37308016-27d7-4420-af7f-07ac858c623a	2	10	f	\N	\N
acdb24d4-f7df-4f2e-9730-fe2ac9e22a04	\N	client-jwt	64844e83-205d-4ee5-b5f1-c772a9c661f8	37308016-27d7-4420-af7f-07ac858c623a	2	20	f	\N	\N
8e2ebde6-b8c9-4b99-9216-295f4d82f4c9	\N	client-secret-jwt	64844e83-205d-4ee5-b5f1-c772a9c661f8	37308016-27d7-4420-af7f-07ac858c623a	2	30	f	\N	\N
7209268a-7e3c-4462-8b77-a59a5fc8cf54	\N	client-x509	64844e83-205d-4ee5-b5f1-c772a9c661f8	37308016-27d7-4420-af7f-07ac858c623a	2	40	f	\N	\N
151abcfb-f316-4fb1-b094-51759f2e9af4	\N	federated-jwt	64844e83-205d-4ee5-b5f1-c772a9c661f8	37308016-27d7-4420-af7f-07ac858c623a	2	50	f	\N	\N
00923185-11d7-481c-9548-b60f3c69c8f6	\N	idp-review-profile	64844e83-205d-4ee5-b5f1-c772a9c661f8	e031183b-f857-4e8d-aac3-52622076fdd3	0	10	f	\N	e876a038-ce5a-4aee-8e71-024fdad56f26
c04f84b2-0f4b-4421-8a2f-48d4cb884dab	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	e031183b-f857-4e8d-aac3-52622076fdd3	0	20	t	21cec375-136f-456c-b1b4-54b0e75d9d2d	\N
a55a3158-9150-42d9-9fdc-49edef647d80	\N	idp-create-user-if-unique	64844e83-205d-4ee5-b5f1-c772a9c661f8	21cec375-136f-456c-b1b4-54b0e75d9d2d	2	10	f	\N	e9c2d912-cd4d-49d1-9f8c-b1a493fd601a
0fa4bb3a-3139-4d99-b9bf-5978d742ca5b	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	21cec375-136f-456c-b1b4-54b0e75d9d2d	2	20	t	2f6fd1a3-9d81-49ef-ad47-ad4c5eac4d56	\N
0cbce09c-49bf-4f54-a8d8-0a0fa4308d0e	\N	idp-confirm-link	64844e83-205d-4ee5-b5f1-c772a9c661f8	2f6fd1a3-9d81-49ef-ad47-ad4c5eac4d56	0	10	f	\N	\N
f39a71fa-3277-4902-9f67-fc3edbbb0174	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	2f6fd1a3-9d81-49ef-ad47-ad4c5eac4d56	0	20	t	ff33d089-8a2b-49e4-9c48-0ba280e127f3	\N
591b0b46-3e84-435d-92e3-655a2d1ab580	\N	idp-email-verification	64844e83-205d-4ee5-b5f1-c772a9c661f8	ff33d089-8a2b-49e4-9c48-0ba280e127f3	2	10	f	\N	\N
68bd2fad-ac50-41a6-9126-413a67d8c900	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	ff33d089-8a2b-49e4-9c48-0ba280e127f3	2	20	t	678c3af3-b6b1-4dd8-aead-06135bdddc59	\N
9e38756d-ddd7-437b-9972-91d75d3a9b9a	\N	idp-username-password-form	64844e83-205d-4ee5-b5f1-c772a9c661f8	678c3af3-b6b1-4dd8-aead-06135bdddc59	0	10	f	\N	\N
4499bb4a-67ad-41fb-86b2-f12fd9401b50	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	678c3af3-b6b1-4dd8-aead-06135bdddc59	1	20	t	36eb324d-8621-4305-ac61-a656c450c208	\N
aac50ce7-151d-4c01-952c-c5a27c524e32	\N	conditional-user-configured	64844e83-205d-4ee5-b5f1-c772a9c661f8	36eb324d-8621-4305-ac61-a656c450c208	0	10	f	\N	\N
b1610312-a8d7-4fe1-a8a0-93c31cc92cf4	\N	conditional-credential	64844e83-205d-4ee5-b5f1-c772a9c661f8	36eb324d-8621-4305-ac61-a656c450c208	0	20	f	\N	c42e82ea-ae1a-4fad-bfa7-aea832099e57
2798bb08-58dc-486c-9eb8-ff657a21ebe2	\N	auth-otp-form	64844e83-205d-4ee5-b5f1-c772a9c661f8	36eb324d-8621-4305-ac61-a656c450c208	2	30	f	\N	\N
9d248eaf-6e02-4d42-9eb3-a5abad830ada	\N	webauthn-authenticator	64844e83-205d-4ee5-b5f1-c772a9c661f8	36eb324d-8621-4305-ac61-a656c450c208	3	40	f	\N	\N
713d0be3-6f57-4fd2-9564-0adc2e9029aa	\N	auth-recovery-authn-code-form	64844e83-205d-4ee5-b5f1-c772a9c661f8	36eb324d-8621-4305-ac61-a656c450c208	3	50	f	\N	\N
3c03f1fe-08c9-4dd3-9191-b11e0c04cda9	\N	http-basic-authenticator	64844e83-205d-4ee5-b5f1-c772a9c661f8	14c40962-c8a5-4a82-8c68-09d07726c475	0	10	f	\N	\N
9b6af5f6-5b14-44a7-99c8-3e95a5ea22a7	\N	docker-http-basic-authenticator	64844e83-205d-4ee5-b5f1-c772a9c661f8	588388d0-48fa-4dbf-bdfb-da51eedbbceb	0	10	f	\N	\N
76367802-532b-41fe-b053-d1f177c4ed97	\N	auth-cookie	79297412-b299-4def-8f42-bd61d963bfcc	eb7b4bfd-2066-42ff-a40d-010a2312d7aa	2	10	f	\N	\N
b4bcb69b-a0b2-437b-a60c-97f7e8c562a1	\N	auth-spnego	79297412-b299-4def-8f42-bd61d963bfcc	eb7b4bfd-2066-42ff-a40d-010a2312d7aa	3	20	f	\N	\N
0bfe0fbe-75c8-47d8-856e-38a722024d36	\N	identity-provider-redirector	79297412-b299-4def-8f42-bd61d963bfcc	eb7b4bfd-2066-42ff-a40d-010a2312d7aa	2	25	f	\N	\N
81c995e2-df1f-4f90-8ed3-fb2555397b2a	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	eb7b4bfd-2066-42ff-a40d-010a2312d7aa	2	30	t	ec28e03c-35de-457c-aff4-b28945f923de	\N
6e53b7b2-d641-46cb-8cde-5c44c3e0ea7d	\N	auth-username-password-form	79297412-b299-4def-8f42-bd61d963bfcc	ec28e03c-35de-457c-aff4-b28945f923de	0	10	f	\N	\N
517f9368-2fe4-43a0-9ee2-11f7e06d9f53	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	ec28e03c-35de-457c-aff4-b28945f923de	1	20	t	b90cf296-009f-4365-9726-d58c0ddb5671	\N
1ed85389-0fce-40b0-baeb-3bd0db39dc43	\N	conditional-user-configured	79297412-b299-4def-8f42-bd61d963bfcc	b90cf296-009f-4365-9726-d58c0ddb5671	0	10	f	\N	\N
2a6a83c7-77f3-4672-8b50-52719fcc30d9	\N	conditional-credential	79297412-b299-4def-8f42-bd61d963bfcc	b90cf296-009f-4365-9726-d58c0ddb5671	0	20	f	\N	727836d2-8653-4114-9dd6-2e89e6aa529e
1df7d873-08cf-42d5-97ae-c6f148be0f61	\N	auth-otp-form	79297412-b299-4def-8f42-bd61d963bfcc	b90cf296-009f-4365-9726-d58c0ddb5671	2	30	f	\N	\N
d6fe442a-f9ea-4d85-943a-a49270c9bd93	\N	webauthn-authenticator	79297412-b299-4def-8f42-bd61d963bfcc	b90cf296-009f-4365-9726-d58c0ddb5671	3	40	f	\N	\N
b8208bc8-c784-4aa4-a7c0-b76be90bd560	\N	auth-recovery-authn-code-form	79297412-b299-4def-8f42-bd61d963bfcc	b90cf296-009f-4365-9726-d58c0ddb5671	3	50	f	\N	\N
42152514-5983-446e-af03-25e1f4d54a33	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	eb7b4bfd-2066-42ff-a40d-010a2312d7aa	2	26	t	c93b2a01-0090-4a28-b278-836f152b647b	\N
e8fe35ef-b4b4-42c3-8412-bb7cc13f03bc	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	c93b2a01-0090-4a28-b278-836f152b647b	1	10	t	58c0efb2-9345-4dfd-95fd-5fe743013841	\N
334f3354-820d-4e6d-a161-83f9391ca8ee	\N	conditional-user-configured	79297412-b299-4def-8f42-bd61d963bfcc	58c0efb2-9345-4dfd-95fd-5fe743013841	0	10	f	\N	\N
f03eb30f-6f39-4b88-9ce6-012626ca6ee4	\N	organization	79297412-b299-4def-8f42-bd61d963bfcc	58c0efb2-9345-4dfd-95fd-5fe743013841	2	20	f	\N	\N
a5fd9d08-919b-4b5e-b40a-200c03e61293	\N	direct-grant-validate-username	79297412-b299-4def-8f42-bd61d963bfcc	fc8f640d-11d5-4d3b-86b3-eff8b08f5633	0	10	f	\N	\N
0a271801-9eee-4561-9c88-114a57eb3a57	\N	direct-grant-validate-password	79297412-b299-4def-8f42-bd61d963bfcc	fc8f640d-11d5-4d3b-86b3-eff8b08f5633	0	20	f	\N	\N
5e416c40-f217-4dbc-a567-69f71e2c0054	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	fc8f640d-11d5-4d3b-86b3-eff8b08f5633	1	30	t	7a278cbe-e8f4-4832-a605-33e7ae671f8f	\N
3d40163d-b2b6-426a-8925-9e253a75545b	\N	conditional-user-configured	79297412-b299-4def-8f42-bd61d963bfcc	7a278cbe-e8f4-4832-a605-33e7ae671f8f	0	10	f	\N	\N
cd49ffea-12ee-470e-b9ae-70cb3ba339f2	\N	direct-grant-validate-otp	79297412-b299-4def-8f42-bd61d963bfcc	7a278cbe-e8f4-4832-a605-33e7ae671f8f	0	20	f	\N	\N
888f880b-f06c-4227-8879-3aaaa48f4fcc	\N	registration-page-form	79297412-b299-4def-8f42-bd61d963bfcc	e243ec36-cd15-459a-964c-b78150cd29e0	0	10	t	120b5872-fab2-474f-afb9-78f4eaaacb00	\N
fd766732-9049-44a1-8180-d1b76a445727	\N	registration-user-creation	79297412-b299-4def-8f42-bd61d963bfcc	120b5872-fab2-474f-afb9-78f4eaaacb00	0	20	f	\N	\N
1f82783f-b632-4ab9-b46b-55088ffe283c	\N	registration-password-action	79297412-b299-4def-8f42-bd61d963bfcc	120b5872-fab2-474f-afb9-78f4eaaacb00	0	50	f	\N	\N
15df83a8-f342-40f4-bd01-5ca1e9431647	\N	registration-recaptcha-action	79297412-b299-4def-8f42-bd61d963bfcc	120b5872-fab2-474f-afb9-78f4eaaacb00	3	60	f	\N	\N
c0a59130-1c4a-444c-ae9d-215c368173dd	\N	registration-terms-and-conditions	79297412-b299-4def-8f42-bd61d963bfcc	120b5872-fab2-474f-afb9-78f4eaaacb00	3	70	f	\N	\N
bc000fb3-d1b8-42a9-b1c0-580af7c60bab	\N	reset-credentials-choose-user	79297412-b299-4def-8f42-bd61d963bfcc	506f1e42-51da-4a63-8920-f42ed9ede67d	0	10	f	\N	\N
ccae42c9-cad9-4ab1-8ec4-c53c5950b9ae	\N	reset-credential-email	79297412-b299-4def-8f42-bd61d963bfcc	506f1e42-51da-4a63-8920-f42ed9ede67d	0	20	f	\N	\N
97244693-0868-472f-8433-4e78ec01b02f	\N	reset-password	79297412-b299-4def-8f42-bd61d963bfcc	506f1e42-51da-4a63-8920-f42ed9ede67d	0	30	f	\N	\N
25bd50da-72e2-40a9-befd-9a07e5db4845	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	506f1e42-51da-4a63-8920-f42ed9ede67d	1	40	t	62b907a7-81c1-4222-851f-84c29e247b5c	\N
678ca2d6-d4ef-4abd-8221-f54324300501	\N	conditional-user-configured	79297412-b299-4def-8f42-bd61d963bfcc	62b907a7-81c1-4222-851f-84c29e247b5c	0	10	f	\N	\N
541f847f-e0b7-4da8-9ace-d804993a82fb	\N	reset-otp	79297412-b299-4def-8f42-bd61d963bfcc	62b907a7-81c1-4222-851f-84c29e247b5c	0	20	f	\N	\N
e0d3f2f0-0c67-4a5e-99c6-e68b1ae48f76	\N	client-secret	79297412-b299-4def-8f42-bd61d963bfcc	34abf6f3-63f3-4bfe-bfb4-e935984e2a71	2	10	f	\N	\N
d48e235d-c8e4-4985-aec4-af7a73a24936	\N	client-jwt	79297412-b299-4def-8f42-bd61d963bfcc	34abf6f3-63f3-4bfe-bfb4-e935984e2a71	2	20	f	\N	\N
8defdab2-ad0b-4b04-a539-13fd979a8953	\N	client-secret-jwt	79297412-b299-4def-8f42-bd61d963bfcc	34abf6f3-63f3-4bfe-bfb4-e935984e2a71	2	30	f	\N	\N
b8ea983c-f4b9-4c25-85cf-486053188ee5	\N	client-x509	79297412-b299-4def-8f42-bd61d963bfcc	34abf6f3-63f3-4bfe-bfb4-e935984e2a71	2	40	f	\N	\N
66b4ed04-9486-4df6-a25b-f5621563fcb0	\N	federated-jwt	79297412-b299-4def-8f42-bd61d963bfcc	34abf6f3-63f3-4bfe-bfb4-e935984e2a71	2	50	f	\N	\N
e1c61bc4-a8ba-49d3-9217-2553ad646e63	\N	idp-review-profile	79297412-b299-4def-8f42-bd61d963bfcc	d9fcb579-c355-4658-87e4-fc20edf9a9bc	0	10	f	\N	fdbb504f-e5c5-4b21-a1f3-dfc4232e1f61
d164b98d-c86b-474f-bf52-3342090ed9a5	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	d9fcb579-c355-4658-87e4-fc20edf9a9bc	0	20	t	98296a6d-60ed-4dc5-a7f9-e4da39587739	\N
a948692e-bc95-41e1-b0d9-009c92fe4899	\N	idp-create-user-if-unique	79297412-b299-4def-8f42-bd61d963bfcc	98296a6d-60ed-4dc5-a7f9-e4da39587739	2	10	f	\N	0920930f-f89b-4d90-b6d9-6ae129be6c03
649865f3-ee89-4a62-b2d3-039bb5fde8bd	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	98296a6d-60ed-4dc5-a7f9-e4da39587739	2	20	t	61ee0790-fb9f-4278-b4f2-c7f0c3a1d53c	\N
1a2adb99-1c0b-451a-8057-4d996be5494d	\N	idp-confirm-link	79297412-b299-4def-8f42-bd61d963bfcc	61ee0790-fb9f-4278-b4f2-c7f0c3a1d53c	0	10	f	\N	\N
c1116096-8cc4-43d5-8d7d-2905858a4cc4	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	61ee0790-fb9f-4278-b4f2-c7f0c3a1d53c	0	20	t	cd88fbf1-0d8a-475c-b0e3-ac372631fb51	\N
8eb4e509-30d0-4a9e-b40b-97b963fa50b5	\N	idp-email-verification	79297412-b299-4def-8f42-bd61d963bfcc	cd88fbf1-0d8a-475c-b0e3-ac372631fb51	2	10	f	\N	\N
61132aa3-860f-41e6-9f27-26187e5fe7fb	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	cd88fbf1-0d8a-475c-b0e3-ac372631fb51	2	20	t	e361a0b9-b65d-4305-875c-2de4e1fe0b39	\N
b1f5b594-804e-4288-b893-a2e3d730f6dc	\N	idp-username-password-form	79297412-b299-4def-8f42-bd61d963bfcc	e361a0b9-b65d-4305-875c-2de4e1fe0b39	0	10	f	\N	\N
0dfaf009-96f5-42c0-940a-7d180d9e4a05	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	e361a0b9-b65d-4305-875c-2de4e1fe0b39	1	20	t	18992432-b48b-4992-9d63-c104890025d5	\N
d66b531f-230d-4ecb-ae1a-0c38e4218059	\N	conditional-user-configured	79297412-b299-4def-8f42-bd61d963bfcc	18992432-b48b-4992-9d63-c104890025d5	0	10	f	\N	\N
bc0659b6-6be8-4d2e-865b-629840356a39	\N	conditional-credential	79297412-b299-4def-8f42-bd61d963bfcc	18992432-b48b-4992-9d63-c104890025d5	0	20	f	\N	3d54ab1a-b2d0-449c-aad0-821e56c13f22
1039d3eb-0e8b-496f-ac5d-f760443c0fdf	\N	auth-otp-form	79297412-b299-4def-8f42-bd61d963bfcc	18992432-b48b-4992-9d63-c104890025d5	2	30	f	\N	\N
cd994f29-f0c5-4f08-b2d9-1e0492cb8d8d	\N	webauthn-authenticator	79297412-b299-4def-8f42-bd61d963bfcc	18992432-b48b-4992-9d63-c104890025d5	3	40	f	\N	\N
e3b015c8-be2a-4f68-ba17-a850181a5bd1	\N	auth-recovery-authn-code-form	79297412-b299-4def-8f42-bd61d963bfcc	18992432-b48b-4992-9d63-c104890025d5	3	50	f	\N	\N
cd63ccec-ed77-492c-80fa-bfeb1ed3b212	\N	\N	79297412-b299-4def-8f42-bd61d963bfcc	d9fcb579-c355-4658-87e4-fc20edf9a9bc	1	60	t	524fcf4a-0a24-415f-b557-f846d7322850	\N
c5117cb9-fc86-4305-b489-7b92cf8f356c	\N	conditional-user-configured	79297412-b299-4def-8f42-bd61d963bfcc	524fcf4a-0a24-415f-b557-f846d7322850	0	10	f	\N	\N
679290f2-1371-4551-9252-5caba55af3ac	\N	idp-add-organization-member	79297412-b299-4def-8f42-bd61d963bfcc	524fcf4a-0a24-415f-b557-f846d7322850	0	20	f	\N	\N
3d77fe51-15a2-4028-906a-5c80b74a9252	\N	http-basic-authenticator	79297412-b299-4def-8f42-bd61d963bfcc	5222ffaa-3216-43b3-8b3a-4a390b740b65	0	10	f	\N	\N
855322e4-c383-432d-8b8b-e0516e1942db	\N	docker-http-basic-authenticator	79297412-b299-4def-8f42-bd61d963bfcc	108eb994-100d-4ecb-8c34-938aead25692	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
1ecb1b3d-6183-4f96-88f3-980b59df363f	browser	Browser based authentication	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	t	t
1a5bcc14-f1f1-4eb8-86bd-b31c30148448	forms	Username, password, otp and other auth forms.	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
832653a5-ddd1-4278-b6c5-23d487668583	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
18ea931c-009b-426b-86bf-06e3455dfb3f	direct grant	OpenID Connect Resource Owner Grant	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	t	t
60dd9619-1ad4-4479-a58c-12d93b0bd71c	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
a9c05ddc-77a3-4550-bf6f-b714f572fb84	registration	Registration flow	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	t	t
d233b063-cec8-49f3-a272-5ffb1d55d935	registration form	Registration form	64844e83-205d-4ee5-b5f1-c772a9c661f8	form-flow	f	t
a224e319-ba24-4846-aafb-f8046c2641a7	reset credentials	Reset credentials for a user if they forgot their password or something	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	t	t
a80ebe37-f509-4ebb-9acf-fddbbdb90b11	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
37308016-27d7-4420-af7f-07ac858c623a	clients	Base authentication for clients	64844e83-205d-4ee5-b5f1-c772a9c661f8	client-flow	t	t
e031183b-f857-4e8d-aac3-52622076fdd3	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	t	t
21cec375-136f-456c-b1b4-54b0e75d9d2d	User creation or linking	Flow for the existing/non-existing user alternatives	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
2f6fd1a3-9d81-49ef-ad47-ad4c5eac4d56	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
ff33d089-8a2b-49e4-9c48-0ba280e127f3	Account verification options	Method with which to verify the existing account	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
678c3af3-b6b1-4dd8-aead-06135bdddc59	Verify Existing Account by Re-authentication	Reauthentication of existing account	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
36eb324d-8621-4305-ac61-a656c450c208	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	f	t
14c40962-c8a5-4a82-8c68-09d07726c475	saml ecp	SAML ECP Profile Authentication Flow	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	t	t
588388d0-48fa-4dbf-bdfb-da51eedbbceb	docker auth	Used by Docker clients to authenticate against the IDP	64844e83-205d-4ee5-b5f1-c772a9c661f8	basic-flow	t	t
eb7b4bfd-2066-42ff-a40d-010a2312d7aa	browser	Browser based authentication	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	t	t
ec28e03c-35de-457c-aff4-b28945f923de	forms	Username, password, otp and other auth forms.	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
b90cf296-009f-4365-9726-d58c0ddb5671	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
c93b2a01-0090-4a28-b278-836f152b647b	Organization	\N	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
58c0efb2-9345-4dfd-95fd-5fe743013841	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
fc8f640d-11d5-4d3b-86b3-eff8b08f5633	direct grant	OpenID Connect Resource Owner Grant	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	t	t
7a278cbe-e8f4-4832-a605-33e7ae671f8f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
e243ec36-cd15-459a-964c-b78150cd29e0	registration	Registration flow	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	t	t
120b5872-fab2-474f-afb9-78f4eaaacb00	registration form	Registration form	79297412-b299-4def-8f42-bd61d963bfcc	form-flow	f	t
506f1e42-51da-4a63-8920-f42ed9ede67d	reset credentials	Reset credentials for a user if they forgot their password or something	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	t	t
62b907a7-81c1-4222-851f-84c29e247b5c	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
34abf6f3-63f3-4bfe-bfb4-e935984e2a71	clients	Base authentication for clients	79297412-b299-4def-8f42-bd61d963bfcc	client-flow	t	t
d9fcb579-c355-4658-87e4-fc20edf9a9bc	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	t	t
98296a6d-60ed-4dc5-a7f9-e4da39587739	User creation or linking	Flow for the existing/non-existing user alternatives	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
61ee0790-fb9f-4278-b4f2-c7f0c3a1d53c	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
cd88fbf1-0d8a-475c-b0e3-ac372631fb51	Account verification options	Method with which to verify the existing account	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
e361a0b9-b65d-4305-875c-2de4e1fe0b39	Verify Existing Account by Re-authentication	Reauthentication of existing account	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
18992432-b48b-4992-9d63-c104890025d5	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
524fcf4a-0a24-415f-b557-f846d7322850	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	f	t
5222ffaa-3216-43b3-8b3a-4a390b740b65	saml ecp	SAML ECP Profile Authentication Flow	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	t	t
108eb994-100d-4ecb-8c34-938aead25692	docker auth	Used by Docker clients to authenticate against the IDP	79297412-b299-4def-8f42-bd61d963bfcc	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
5bc9dd74-4f0c-4ad1-96d3-305b6e5c64b0	browser-conditional-credential	64844e83-205d-4ee5-b5f1-c772a9c661f8
e876a038-ce5a-4aee-8e71-024fdad56f26	review profile config	64844e83-205d-4ee5-b5f1-c772a9c661f8
e9c2d912-cd4d-49d1-9f8c-b1a493fd601a	create unique user config	64844e83-205d-4ee5-b5f1-c772a9c661f8
c42e82ea-ae1a-4fad-bfa7-aea832099e57	first-broker-login-conditional-credential	64844e83-205d-4ee5-b5f1-c772a9c661f8
727836d2-8653-4114-9dd6-2e89e6aa529e	browser-conditional-credential	79297412-b299-4def-8f42-bd61d963bfcc
fdbb504f-e5c5-4b21-a1f3-dfc4232e1f61	review profile config	79297412-b299-4def-8f42-bd61d963bfcc
0920930f-f89b-4d90-b6d9-6ae129be6c03	create unique user config	79297412-b299-4def-8f42-bd61d963bfcc
3d54ab1a-b2d0-449c-aad0-821e56c13f22	first-broker-login-conditional-credential	79297412-b299-4def-8f42-bd61d963bfcc
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
5bc9dd74-4f0c-4ad1-96d3-305b6e5c64b0	webauthn-passwordless	credentials
c42e82ea-ae1a-4fad-bfa7-aea832099e57	webauthn-passwordless	credentials
e876a038-ce5a-4aee-8e71-024fdad56f26	missing	update.profile.on.first.login
e9c2d912-cd4d-49d1-9f8c-b1a493fd601a	false	require.password.update.after.registration
0920930f-f89b-4d90-b6d9-6ae129be6c03	false	require.password.update.after.registration
3d54ab1a-b2d0-449c-aad0-821e56c13f22	webauthn-passwordless	credentials
727836d2-8653-4114-9dd6-2e89e6aa529e	webauthn-passwordless	credentials
fdbb504f-e5c5-4b21-a1f3-dfc4232e1f61	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	f	master-realm	0	f	\N	\N	t	\N	f	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
47781dd4-1c7c-46c6-a72e-4085b615aa52	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	64844e83-205d-4ee5-b5f1-c772a9c661f8	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a9cb6269-7671-47ec-a87f-a1380eaa284a	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	64844e83-205d-4ee5-b5f1-c772a9c661f8	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4305df09-58f6-496d-a903-b1ed8ba220a5	t	f	broker	0	f	\N	\N	t	\N	f	64844e83-205d-4ee5-b5f1-c772a9c661f8	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
78d20a38-d3ed-4288-aadd-603f9573972d	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	64844e83-205d-4ee5-b5f1-c772a9c661f8	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
2857071c-28d6-4b38-91f8-43abf5387ee7	t	t	admin-cli	0	t	\N	\N	f	\N	f	64844e83-205d-4ee5-b5f1-c772a9c661f8	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
ca7d86ad-b054-407e-8555-e983242f27a4	t	f	ERP Docs-realm	0	f	\N	\N	t	\N	f	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N	0	f	f	ERP Docs Realm	f	client-secret	\N	\N	\N	t	f	f	f
a6c42ac8-f0cd-429e-972d-99424a49c65a	t	f	realm-management	0	f	\N	\N	t	\N	f	79297412-b299-4def-8f42-bd61d963bfcc	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	f	account	0	t	\N	/realms/ERP%20Docs/account/	f	\N	f	79297412-b299-4def-8f42-bd61d963bfcc	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ee333356-91c4-47f1-97b3-6481a7351eba	t	f	account-console	0	t	\N	/realms/ERP%20Docs/account/	f	\N	f	79297412-b299-4def-8f42-bd61d963bfcc	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	t	f	broker	0	f	\N	\N	t	\N	f	79297412-b299-4def-8f42-bd61d963bfcc	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	t	t	security-admin-console	0	t	\N	/admin/ERP%20Docs/console/	f	\N	f	79297412-b299-4def-8f42-bd61d963bfcc	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
38e5a98c-9aef-4cce-bd63-71cab2d444db	t	t	admin-cli	0	t	\N	\N	f	\N	f	79297412-b299-4def-8f42-bd61d963bfcc	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	t	t	nextjs-app	0	f	zPzdWXo0N7OE4JYg6PFrPGUADtKTafnN		f		f	79297412-b299-4def-8f42-bd61d963bfcc	openid-connect	-1	t	f	docs	f	client-secret			\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
47781dd4-1c7c-46c6-a72e-4085b615aa52	post.logout.redirect.uris	+
a9cb6269-7671-47ec-a87f-a1380eaa284a	post.logout.redirect.uris	+
a9cb6269-7671-47ec-a87f-a1380eaa284a	pkce.code.challenge.method	S256
78d20a38-d3ed-4288-aadd-603f9573972d	post.logout.redirect.uris	+
78d20a38-d3ed-4288-aadd-603f9573972d	pkce.code.challenge.method	S256
78d20a38-d3ed-4288-aadd-603f9573972d	client.use.lightweight.access.token.enabled	true
2857071c-28d6-4b38-91f8-43abf5387ee7	client.use.lightweight.access.token.enabled	true
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	post.logout.redirect.uris	+
ee333356-91c4-47f1-97b3-6481a7351eba	post.logout.redirect.uris	+
ee333356-91c4-47f1-97b3-6481a7351eba	pkce.code.challenge.method	S256
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	post.logout.redirect.uris	+
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	pkce.code.challenge.method	S256
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	client.use.lightweight.access.token.enabled	true
38e5a98c-9aef-4cce-bd63-71cab2d444db	client.use.lightweight.access.token.enabled	true
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	client.secret.creation.time	1778091929
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	standard.token.exchange.enabled	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	oauth2.jwt.authorization.grant.enabled	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	oauth2.device.authorization.grant.enabled	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	oidc.ciba.grant.enabled	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	dpop.bound.access.tokens	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	backchannel.logout.session.required	true
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	backchannel.logout.revoke.offline.tokens	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	realm_client	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	display.on.consent.screen	false
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	frontchannel.logout.session.required	true
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	logout.confirmation.enabled	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
27e920bc-af53-4c09-a025-49dd85a50b14	offline_access	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect built-in scope: offline_access	openid-connect
7ee13054-4969-4dcd-ab30-84e6cdbf2902	role_list	64844e83-205d-4ee5-b5f1-c772a9c661f8	SAML role list	saml
01af7c6b-dbc7-46b7-989a-e6798382d99e	saml_organization	64844e83-205d-4ee5-b5f1-c772a9c661f8	Organization Membership	saml
7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	profile	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect built-in scope: profile	openid-connect
41f2aded-a5c1-4719-89f0-8ea93c11bcad	email	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect built-in scope: email	openid-connect
c225ec8c-ba10-4cbd-8049-46b77fe6cd63	address	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect built-in scope: address	openid-connect
c86e7f25-09ec-4d99-8c8c-533acbb19a35	phone	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect built-in scope: phone	openid-connect
d68c7a69-91db-4046-b9e2-72b9bcdaa797	roles	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect scope for add user roles to the access token	openid-connect
78e66a1e-2847-49cc-871c-d15bb8de84ac	web-origins	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect scope for add allowed web origins to the access token	openid-connect
ed999954-01f1-447d-b6a7-bdb76c76d3e8	microprofile-jwt	64844e83-205d-4ee5-b5f1-c772a9c661f8	Microprofile - JWT built-in scope	openid-connect
cb42a537-e158-42ed-b65b-b5464139507b	acr	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ac27bead-1410-449f-a23a-fa1cb0b56fe6	basic	64844e83-205d-4ee5-b5f1-c772a9c661f8	OpenID Connect scope for add all basic claims to the token	openid-connect
f3f394ff-9ecd-457d-ab77-950eddadcc55	service_account	64844e83-205d-4ee5-b5f1-c772a9c661f8	Specific scope for a client enabled for service accounts	openid-connect
8613e35b-b0cc-47a7-b034-6c8bb56f5baa	organization	64844e83-205d-4ee5-b5f1-c772a9c661f8	Additional claims about the organization a subject belongs to	openid-connect
485c2050-95a1-43e3-803a-0f1264c0ea0f	offline_access	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect built-in scope: offline_access	openid-connect
c2455068-1470-4d72-836f-21fd26444b16	role_list	79297412-b299-4def-8f42-bd61d963bfcc	SAML role list	saml
b9064254-6342-4706-bfe2-970db58c9e6f	saml_organization	79297412-b299-4def-8f42-bd61d963bfcc	Organization Membership	saml
cd032659-64aa-4d04-b956-a84eee2acd04	profile	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect built-in scope: profile	openid-connect
cc28f67d-7f95-4d7c-8c4b-807bab00bbef	email	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect built-in scope: email	openid-connect
32b3b9a2-8950-4bda-ab9b-07e22cf11015	address	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect built-in scope: address	openid-connect
3818eb2b-f515-431a-857d-decfa1190c9d	phone	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect built-in scope: phone	openid-connect
81e1d7f0-701a-417d-9080-bdb3010ddbe6	roles	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect scope for add user roles to the access token	openid-connect
e3206a3f-df98-4b61-8620-95afabdae202	web-origins	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect scope for add allowed web origins to the access token	openid-connect
fc38610d-6445-44c5-a6cf-f1fc141b69c6	microprofile-jwt	79297412-b299-4def-8f42-bd61d963bfcc	Microprofile - JWT built-in scope	openid-connect
433e367b-5cc4-4861-af47-3cf6761a7f83	acr	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
76c794a6-a6b0-4944-829b-65a10c530dd9	basic	79297412-b299-4def-8f42-bd61d963bfcc	OpenID Connect scope for add all basic claims to the token	openid-connect
e42d94d3-4600-4208-b9f8-049f7394c433	service_account	79297412-b299-4def-8f42-bd61d963bfcc	Specific scope for a client enabled for service accounts	openid-connect
ecb664f7-89be-45fb-92f4-80ff7d307b48	organization	79297412-b299-4def-8f42-bd61d963bfcc	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
27e920bc-af53-4c09-a025-49dd85a50b14	true	display.on.consent.screen
27e920bc-af53-4c09-a025-49dd85a50b14	${offlineAccessScopeConsentText}	consent.screen.text
7ee13054-4969-4dcd-ab30-84e6cdbf2902	true	display.on.consent.screen
7ee13054-4969-4dcd-ab30-84e6cdbf2902	${samlRoleListScopeConsentText}	consent.screen.text
01af7c6b-dbc7-46b7-989a-e6798382d99e	false	display.on.consent.screen
7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	true	display.on.consent.screen
7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	${profileScopeConsentText}	consent.screen.text
7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	true	include.in.token.scope
41f2aded-a5c1-4719-89f0-8ea93c11bcad	true	display.on.consent.screen
41f2aded-a5c1-4719-89f0-8ea93c11bcad	${emailScopeConsentText}	consent.screen.text
41f2aded-a5c1-4719-89f0-8ea93c11bcad	true	include.in.token.scope
c225ec8c-ba10-4cbd-8049-46b77fe6cd63	true	display.on.consent.screen
c225ec8c-ba10-4cbd-8049-46b77fe6cd63	${addressScopeConsentText}	consent.screen.text
c225ec8c-ba10-4cbd-8049-46b77fe6cd63	true	include.in.token.scope
c86e7f25-09ec-4d99-8c8c-533acbb19a35	true	display.on.consent.screen
c86e7f25-09ec-4d99-8c8c-533acbb19a35	${phoneScopeConsentText}	consent.screen.text
c86e7f25-09ec-4d99-8c8c-533acbb19a35	true	include.in.token.scope
d68c7a69-91db-4046-b9e2-72b9bcdaa797	true	display.on.consent.screen
d68c7a69-91db-4046-b9e2-72b9bcdaa797	${rolesScopeConsentText}	consent.screen.text
d68c7a69-91db-4046-b9e2-72b9bcdaa797	false	include.in.token.scope
78e66a1e-2847-49cc-871c-d15bb8de84ac	false	display.on.consent.screen
78e66a1e-2847-49cc-871c-d15bb8de84ac		consent.screen.text
78e66a1e-2847-49cc-871c-d15bb8de84ac	false	include.in.token.scope
ed999954-01f1-447d-b6a7-bdb76c76d3e8	false	display.on.consent.screen
ed999954-01f1-447d-b6a7-bdb76c76d3e8	true	include.in.token.scope
cb42a537-e158-42ed-b65b-b5464139507b	false	display.on.consent.screen
cb42a537-e158-42ed-b65b-b5464139507b	false	include.in.token.scope
ac27bead-1410-449f-a23a-fa1cb0b56fe6	false	display.on.consent.screen
ac27bead-1410-449f-a23a-fa1cb0b56fe6	false	include.in.token.scope
f3f394ff-9ecd-457d-ab77-950eddadcc55	false	display.on.consent.screen
f3f394ff-9ecd-457d-ab77-950eddadcc55	false	include.in.token.scope
8613e35b-b0cc-47a7-b034-6c8bb56f5baa	true	display.on.consent.screen
8613e35b-b0cc-47a7-b034-6c8bb56f5baa	${organizationScopeConsentText}	consent.screen.text
8613e35b-b0cc-47a7-b034-6c8bb56f5baa	true	include.in.token.scope
485c2050-95a1-43e3-803a-0f1264c0ea0f	true	display.on.consent.screen
485c2050-95a1-43e3-803a-0f1264c0ea0f	${offlineAccessScopeConsentText}	consent.screen.text
c2455068-1470-4d72-836f-21fd26444b16	true	display.on.consent.screen
c2455068-1470-4d72-836f-21fd26444b16	${samlRoleListScopeConsentText}	consent.screen.text
b9064254-6342-4706-bfe2-970db58c9e6f	false	display.on.consent.screen
cd032659-64aa-4d04-b956-a84eee2acd04	true	display.on.consent.screen
cd032659-64aa-4d04-b956-a84eee2acd04	${profileScopeConsentText}	consent.screen.text
cd032659-64aa-4d04-b956-a84eee2acd04	true	include.in.token.scope
cc28f67d-7f95-4d7c-8c4b-807bab00bbef	true	display.on.consent.screen
cc28f67d-7f95-4d7c-8c4b-807bab00bbef	${emailScopeConsentText}	consent.screen.text
cc28f67d-7f95-4d7c-8c4b-807bab00bbef	true	include.in.token.scope
32b3b9a2-8950-4bda-ab9b-07e22cf11015	true	display.on.consent.screen
32b3b9a2-8950-4bda-ab9b-07e22cf11015	${addressScopeConsentText}	consent.screen.text
32b3b9a2-8950-4bda-ab9b-07e22cf11015	true	include.in.token.scope
3818eb2b-f515-431a-857d-decfa1190c9d	true	display.on.consent.screen
3818eb2b-f515-431a-857d-decfa1190c9d	${phoneScopeConsentText}	consent.screen.text
3818eb2b-f515-431a-857d-decfa1190c9d	true	include.in.token.scope
81e1d7f0-701a-417d-9080-bdb3010ddbe6	true	display.on.consent.screen
81e1d7f0-701a-417d-9080-bdb3010ddbe6	${rolesScopeConsentText}	consent.screen.text
81e1d7f0-701a-417d-9080-bdb3010ddbe6	false	include.in.token.scope
e3206a3f-df98-4b61-8620-95afabdae202	false	display.on.consent.screen
e3206a3f-df98-4b61-8620-95afabdae202		consent.screen.text
e3206a3f-df98-4b61-8620-95afabdae202	false	include.in.token.scope
fc38610d-6445-44c5-a6cf-f1fc141b69c6	false	display.on.consent.screen
fc38610d-6445-44c5-a6cf-f1fc141b69c6	true	include.in.token.scope
433e367b-5cc4-4861-af47-3cf6761a7f83	false	display.on.consent.screen
433e367b-5cc4-4861-af47-3cf6761a7f83	false	include.in.token.scope
76c794a6-a6b0-4944-829b-65a10c530dd9	false	display.on.consent.screen
76c794a6-a6b0-4944-829b-65a10c530dd9	false	include.in.token.scope
e42d94d3-4600-4208-b9f8-049f7394c433	false	display.on.consent.screen
e42d94d3-4600-4208-b9f8-049f7394c433	false	include.in.token.scope
ecb664f7-89be-45fb-92f4-80ff7d307b48	true	display.on.consent.screen
ecb664f7-89be-45fb-92f4-80ff7d307b48	${organizationScopeConsentText}	consent.screen.text
ecb664f7-89be-45fb-92f4-80ff7d307b48	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
47781dd4-1c7c-46c6-a72e-4085b615aa52	d68c7a69-91db-4046-b9e2-72b9bcdaa797	t
47781dd4-1c7c-46c6-a72e-4085b615aa52	78e66a1e-2847-49cc-871c-d15bb8de84ac	t
47781dd4-1c7c-46c6-a72e-4085b615aa52	cb42a537-e158-42ed-b65b-b5464139507b	t
47781dd4-1c7c-46c6-a72e-4085b615aa52	ac27bead-1410-449f-a23a-fa1cb0b56fe6	t
47781dd4-1c7c-46c6-a72e-4085b615aa52	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	t
47781dd4-1c7c-46c6-a72e-4085b615aa52	41f2aded-a5c1-4719-89f0-8ea93c11bcad	t
47781dd4-1c7c-46c6-a72e-4085b615aa52	c225ec8c-ba10-4cbd-8049-46b77fe6cd63	f
47781dd4-1c7c-46c6-a72e-4085b615aa52	c86e7f25-09ec-4d99-8c8c-533acbb19a35	f
47781dd4-1c7c-46c6-a72e-4085b615aa52	27e920bc-af53-4c09-a025-49dd85a50b14	f
47781dd4-1c7c-46c6-a72e-4085b615aa52	8613e35b-b0cc-47a7-b034-6c8bb56f5baa	f
47781dd4-1c7c-46c6-a72e-4085b615aa52	ed999954-01f1-447d-b6a7-bdb76c76d3e8	f
a9cb6269-7671-47ec-a87f-a1380eaa284a	d68c7a69-91db-4046-b9e2-72b9bcdaa797	t
a9cb6269-7671-47ec-a87f-a1380eaa284a	78e66a1e-2847-49cc-871c-d15bb8de84ac	t
a9cb6269-7671-47ec-a87f-a1380eaa284a	cb42a537-e158-42ed-b65b-b5464139507b	t
a9cb6269-7671-47ec-a87f-a1380eaa284a	ac27bead-1410-449f-a23a-fa1cb0b56fe6	t
a9cb6269-7671-47ec-a87f-a1380eaa284a	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	t
a9cb6269-7671-47ec-a87f-a1380eaa284a	41f2aded-a5c1-4719-89f0-8ea93c11bcad	t
a9cb6269-7671-47ec-a87f-a1380eaa284a	c225ec8c-ba10-4cbd-8049-46b77fe6cd63	f
a9cb6269-7671-47ec-a87f-a1380eaa284a	c86e7f25-09ec-4d99-8c8c-533acbb19a35	f
a9cb6269-7671-47ec-a87f-a1380eaa284a	27e920bc-af53-4c09-a025-49dd85a50b14	f
a9cb6269-7671-47ec-a87f-a1380eaa284a	8613e35b-b0cc-47a7-b034-6c8bb56f5baa	f
a9cb6269-7671-47ec-a87f-a1380eaa284a	ed999954-01f1-447d-b6a7-bdb76c76d3e8	f
2857071c-28d6-4b38-91f8-43abf5387ee7	d68c7a69-91db-4046-b9e2-72b9bcdaa797	t
2857071c-28d6-4b38-91f8-43abf5387ee7	78e66a1e-2847-49cc-871c-d15bb8de84ac	t
2857071c-28d6-4b38-91f8-43abf5387ee7	cb42a537-e158-42ed-b65b-b5464139507b	t
2857071c-28d6-4b38-91f8-43abf5387ee7	ac27bead-1410-449f-a23a-fa1cb0b56fe6	t
2857071c-28d6-4b38-91f8-43abf5387ee7	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	t
2857071c-28d6-4b38-91f8-43abf5387ee7	41f2aded-a5c1-4719-89f0-8ea93c11bcad	t
2857071c-28d6-4b38-91f8-43abf5387ee7	c225ec8c-ba10-4cbd-8049-46b77fe6cd63	f
2857071c-28d6-4b38-91f8-43abf5387ee7	c86e7f25-09ec-4d99-8c8c-533acbb19a35	f
2857071c-28d6-4b38-91f8-43abf5387ee7	27e920bc-af53-4c09-a025-49dd85a50b14	f
2857071c-28d6-4b38-91f8-43abf5387ee7	8613e35b-b0cc-47a7-b034-6c8bb56f5baa	f
2857071c-28d6-4b38-91f8-43abf5387ee7	ed999954-01f1-447d-b6a7-bdb76c76d3e8	f
4305df09-58f6-496d-a903-b1ed8ba220a5	d68c7a69-91db-4046-b9e2-72b9bcdaa797	t
4305df09-58f6-496d-a903-b1ed8ba220a5	78e66a1e-2847-49cc-871c-d15bb8de84ac	t
4305df09-58f6-496d-a903-b1ed8ba220a5	cb42a537-e158-42ed-b65b-b5464139507b	t
4305df09-58f6-496d-a903-b1ed8ba220a5	ac27bead-1410-449f-a23a-fa1cb0b56fe6	t
4305df09-58f6-496d-a903-b1ed8ba220a5	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	t
4305df09-58f6-496d-a903-b1ed8ba220a5	41f2aded-a5c1-4719-89f0-8ea93c11bcad	t
4305df09-58f6-496d-a903-b1ed8ba220a5	c225ec8c-ba10-4cbd-8049-46b77fe6cd63	f
4305df09-58f6-496d-a903-b1ed8ba220a5	c86e7f25-09ec-4d99-8c8c-533acbb19a35	f
4305df09-58f6-496d-a903-b1ed8ba220a5	27e920bc-af53-4c09-a025-49dd85a50b14	f
4305df09-58f6-496d-a903-b1ed8ba220a5	8613e35b-b0cc-47a7-b034-6c8bb56f5baa	f
4305df09-58f6-496d-a903-b1ed8ba220a5	ed999954-01f1-447d-b6a7-bdb76c76d3e8	f
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	d68c7a69-91db-4046-b9e2-72b9bcdaa797	t
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	78e66a1e-2847-49cc-871c-d15bb8de84ac	t
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	cb42a537-e158-42ed-b65b-b5464139507b	t
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	ac27bead-1410-449f-a23a-fa1cb0b56fe6	t
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	t
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	41f2aded-a5c1-4719-89f0-8ea93c11bcad	t
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	c225ec8c-ba10-4cbd-8049-46b77fe6cd63	f
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	c86e7f25-09ec-4d99-8c8c-533acbb19a35	f
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	27e920bc-af53-4c09-a025-49dd85a50b14	f
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	8613e35b-b0cc-47a7-b034-6c8bb56f5baa	f
3f22b2c3-f40d-43a4-8371-3ed918cea9c3	ed999954-01f1-447d-b6a7-bdb76c76d3e8	f
78d20a38-d3ed-4288-aadd-603f9573972d	d68c7a69-91db-4046-b9e2-72b9bcdaa797	t
78d20a38-d3ed-4288-aadd-603f9573972d	78e66a1e-2847-49cc-871c-d15bb8de84ac	t
78d20a38-d3ed-4288-aadd-603f9573972d	cb42a537-e158-42ed-b65b-b5464139507b	t
78d20a38-d3ed-4288-aadd-603f9573972d	ac27bead-1410-449f-a23a-fa1cb0b56fe6	t
78d20a38-d3ed-4288-aadd-603f9573972d	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	t
78d20a38-d3ed-4288-aadd-603f9573972d	41f2aded-a5c1-4719-89f0-8ea93c11bcad	t
78d20a38-d3ed-4288-aadd-603f9573972d	c225ec8c-ba10-4cbd-8049-46b77fe6cd63	f
78d20a38-d3ed-4288-aadd-603f9573972d	c86e7f25-09ec-4d99-8c8c-533acbb19a35	f
78d20a38-d3ed-4288-aadd-603f9573972d	27e920bc-af53-4c09-a025-49dd85a50b14	f
78d20a38-d3ed-4288-aadd-603f9573972d	8613e35b-b0cc-47a7-b034-6c8bb56f5baa	f
78d20a38-d3ed-4288-aadd-603f9573972d	ed999954-01f1-447d-b6a7-bdb76c76d3e8	f
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	e3206a3f-df98-4b61-8620-95afabdae202	t
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	76c794a6-a6b0-4944-829b-65a10c530dd9	t
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	cd032659-64aa-4d04-b956-a84eee2acd04	t
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	433e367b-5cc4-4861-af47-3cf6761a7f83	t
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	3818eb2b-f515-431a-857d-decfa1190c9d	f
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
ee333356-91c4-47f1-97b3-6481a7351eba	e3206a3f-df98-4b61-8620-95afabdae202	t
ee333356-91c4-47f1-97b3-6481a7351eba	76c794a6-a6b0-4944-829b-65a10c530dd9	t
ee333356-91c4-47f1-97b3-6481a7351eba	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
ee333356-91c4-47f1-97b3-6481a7351eba	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
ee333356-91c4-47f1-97b3-6481a7351eba	cd032659-64aa-4d04-b956-a84eee2acd04	t
ee333356-91c4-47f1-97b3-6481a7351eba	433e367b-5cc4-4861-af47-3cf6761a7f83	t
ee333356-91c4-47f1-97b3-6481a7351eba	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
ee333356-91c4-47f1-97b3-6481a7351eba	3818eb2b-f515-431a-857d-decfa1190c9d	f
ee333356-91c4-47f1-97b3-6481a7351eba	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
ee333356-91c4-47f1-97b3-6481a7351eba	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
ee333356-91c4-47f1-97b3-6481a7351eba	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
38e5a98c-9aef-4cce-bd63-71cab2d444db	e3206a3f-df98-4b61-8620-95afabdae202	t
38e5a98c-9aef-4cce-bd63-71cab2d444db	76c794a6-a6b0-4944-829b-65a10c530dd9	t
38e5a98c-9aef-4cce-bd63-71cab2d444db	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
38e5a98c-9aef-4cce-bd63-71cab2d444db	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
38e5a98c-9aef-4cce-bd63-71cab2d444db	cd032659-64aa-4d04-b956-a84eee2acd04	t
38e5a98c-9aef-4cce-bd63-71cab2d444db	433e367b-5cc4-4861-af47-3cf6761a7f83	t
38e5a98c-9aef-4cce-bd63-71cab2d444db	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
38e5a98c-9aef-4cce-bd63-71cab2d444db	3818eb2b-f515-431a-857d-decfa1190c9d	f
38e5a98c-9aef-4cce-bd63-71cab2d444db	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
38e5a98c-9aef-4cce-bd63-71cab2d444db	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
38e5a98c-9aef-4cce-bd63-71cab2d444db	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	e3206a3f-df98-4b61-8620-95afabdae202	t
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	76c794a6-a6b0-4944-829b-65a10c530dd9	t
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	cd032659-64aa-4d04-b956-a84eee2acd04	t
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	433e367b-5cc4-4861-af47-3cf6761a7f83	t
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	3818eb2b-f515-431a-857d-decfa1190c9d	f
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
b4c68130-8e0d-4cb7-88d4-8b187e2039e0	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
a6c42ac8-f0cd-429e-972d-99424a49c65a	e3206a3f-df98-4b61-8620-95afabdae202	t
a6c42ac8-f0cd-429e-972d-99424a49c65a	76c794a6-a6b0-4944-829b-65a10c530dd9	t
a6c42ac8-f0cd-429e-972d-99424a49c65a	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
a6c42ac8-f0cd-429e-972d-99424a49c65a	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
a6c42ac8-f0cd-429e-972d-99424a49c65a	cd032659-64aa-4d04-b956-a84eee2acd04	t
a6c42ac8-f0cd-429e-972d-99424a49c65a	433e367b-5cc4-4861-af47-3cf6761a7f83	t
a6c42ac8-f0cd-429e-972d-99424a49c65a	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
a6c42ac8-f0cd-429e-972d-99424a49c65a	3818eb2b-f515-431a-857d-decfa1190c9d	f
a6c42ac8-f0cd-429e-972d-99424a49c65a	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
a6c42ac8-f0cd-429e-972d-99424a49c65a	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
a6c42ac8-f0cd-429e-972d-99424a49c65a	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	e3206a3f-df98-4b61-8620-95afabdae202	t
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	76c794a6-a6b0-4944-829b-65a10c530dd9	t
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	cd032659-64aa-4d04-b956-a84eee2acd04	t
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	433e367b-5cc4-4861-af47-3cf6761a7f83	t
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	3818eb2b-f515-431a-857d-decfa1190c9d	f
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	e3206a3f-df98-4b61-8620-95afabdae202	t
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	76c794a6-a6b0-4944-829b-65a10c530dd9	t
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	cd032659-64aa-4d04-b956-a84eee2acd04	t
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	433e367b-5cc4-4861-af47-3cf6761a7f83	t
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	3818eb2b-f515-431a-857d-decfa1190c9d	f
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
27e920bc-af53-4c09-a025-49dd85a50b14	114d4082-15ee-4adc-af40-8579e85415ec
485c2050-95a1-43e3-803a-0f1264c0ea0f	195b1b2a-fb84-4b4b-a143-0cdf2d3f280d
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
cb7410fd-db20-4459-a09f-73e6021ded26	Trusted Hosts	64844e83-205d-4ee5-b5f1-c772a9c661f8	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	anonymous
daf7b2f5-0eb7-4862-b027-8a9a7c33f8be	Consent Required	64844e83-205d-4ee5-b5f1-c772a9c661f8	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	anonymous
6a356d63-617e-4f9f-9766-e3db0a4de235	Full Scope Disabled	64844e83-205d-4ee5-b5f1-c772a9c661f8	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	anonymous
f9a84bae-e42f-4c24-9738-15fcf8cd6be9	Max Clients Limit	64844e83-205d-4ee5-b5f1-c772a9c661f8	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	anonymous
682b8b8a-42ea-4818-9339-c8320c243f4e	Allowed Protocol Mapper Types	64844e83-205d-4ee5-b5f1-c772a9c661f8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	anonymous
bef7c33c-abad-4590-a32b-4f1f04b9b2d0	Allowed Client Scopes	64844e83-205d-4ee5-b5f1-c772a9c661f8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	anonymous
d4ef6407-eec9-4c3c-b477-c5e455c43bb7	Allowed Registration Web Origins	64844e83-205d-4ee5-b5f1-c772a9c661f8	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	anonymous
be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	Allowed Protocol Mapper Types	64844e83-205d-4ee5-b5f1-c772a9c661f8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	authenticated
15bf2d19-cfac-4e4c-9f5d-d953e36befa2	Allowed Client Scopes	64844e83-205d-4ee5-b5f1-c772a9c661f8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	authenticated
0ba3ab74-62cc-4077-8161-cbfaef31f282	Allowed Registration Web Origins	64844e83-205d-4ee5-b5f1-c772a9c661f8	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	authenticated
b68d3af4-65bd-4bc1-8fb0-23507bda03a3	rsa-generated	64844e83-205d-4ee5-b5f1-c772a9c661f8	rsa-generated	org.keycloak.keys.KeyProvider	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N
abe42efa-78b7-42e0-bb9a-f699d75478a7	rsa-enc-generated	64844e83-205d-4ee5-b5f1-c772a9c661f8	rsa-enc-generated	org.keycloak.keys.KeyProvider	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N
0ebe273e-0bc5-49a9-9b0d-d6dad69a032a	hmac-generated-hs512	64844e83-205d-4ee5-b5f1-c772a9c661f8	hmac-generated	org.keycloak.keys.KeyProvider	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N
92079c1b-362b-4072-9b9d-0513e85c113c	aes-generated	64844e83-205d-4ee5-b5f1-c772a9c661f8	aes-generated	org.keycloak.keys.KeyProvider	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N
a1201ef4-ee19-4911-9d18-e60ecdd7ee8d	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N
557aabd6-a5ca-4380-ba87-3978e09393ab	rsa-generated	79297412-b299-4def-8f42-bd61d963bfcc	rsa-generated	org.keycloak.keys.KeyProvider	79297412-b299-4def-8f42-bd61d963bfcc	\N
6ef92b93-29cf-4d1a-8af4-6b289160fa9b	rsa-enc-generated	79297412-b299-4def-8f42-bd61d963bfcc	rsa-enc-generated	org.keycloak.keys.KeyProvider	79297412-b299-4def-8f42-bd61d963bfcc	\N
ebc1d1f3-0f37-4b13-aed1-4c8329e8bec2	hmac-generated-hs512	79297412-b299-4def-8f42-bd61d963bfcc	hmac-generated	org.keycloak.keys.KeyProvider	79297412-b299-4def-8f42-bd61d963bfcc	\N
fbbe8f99-e4bd-4b4f-8b95-1a1d5b3b7da1	aes-generated	79297412-b299-4def-8f42-bd61d963bfcc	aes-generated	org.keycloak.keys.KeyProvider	79297412-b299-4def-8f42-bd61d963bfcc	\N
abcf7036-d4de-47c2-a02d-17dfcfefb836	Trusted Hosts	79297412-b299-4def-8f42-bd61d963bfcc	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	anonymous
c4d925e5-2950-439c-b75e-c481457daebf	Consent Required	79297412-b299-4def-8f42-bd61d963bfcc	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	anonymous
47d43a35-b0d4-472f-8b88-ea3cca64eeaf	Full Scope Disabled	79297412-b299-4def-8f42-bd61d963bfcc	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	anonymous
27fca1be-0c28-4c41-addd-428624a314dd	Max Clients Limit	79297412-b299-4def-8f42-bd61d963bfcc	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	anonymous
d27f66cc-0833-4bd1-80da-839ac03d29d4	Allowed Protocol Mapper Types	79297412-b299-4def-8f42-bd61d963bfcc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	anonymous
1022a080-45ea-4d57-b1cb-2ff062fb2166	Allowed Client Scopes	79297412-b299-4def-8f42-bd61d963bfcc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	anonymous
6d393b97-aa99-447b-8a2e-851de57728aa	Allowed Registration Web Origins	79297412-b299-4def-8f42-bd61d963bfcc	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	anonymous
21c1bbb7-7ae6-4eb9-8d27-867657e54041	Allowed Protocol Mapper Types	79297412-b299-4def-8f42-bd61d963bfcc	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	authenticated
5b14a803-fb55-4d95-a324-ad8d86ffb1a7	Allowed Client Scopes	79297412-b299-4def-8f42-bd61d963bfcc	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	authenticated
e0d192c6-6f9a-48d3-a1ad-c238348b8af4	Allowed Registration Web Origins	79297412-b299-4def-8f42-bd61d963bfcc	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	79297412-b299-4def-8f42-bd61d963bfcc	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
4022bdbe-2fa0-4b5e-bb58-83ffc5786de9	15bf2d19-cfac-4e4c-9f5d-d953e36befa2	allow-default-scopes	true
937b5358-eb09-419f-8f1c-55981783ff43	f9a84bae-e42f-4c24-9738-15fcf8cd6be9	max-clients	200
cbf403a7-3884-4fee-94eb-e3095dbe600d	cb7410fd-db20-4459-a09f-73e6021ded26	client-uris-must-match	true
aaee46f8-cee1-4f01-a234-ee6a73d9e776	cb7410fd-db20-4459-a09f-73e6021ded26	host-sending-registration-request-must-match	true
f0da647c-43fc-4dd4-881a-3ad148aa54f0	bef7c33c-abad-4590-a32b-4f1f04b9b2d0	allow-default-scopes	true
9434ad1e-43df-4132-a0d2-ff3dc7bff2ec	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8ea5dedf-5ddd-4f05-a6fe-d09cf6167834	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f7e11819-d282-44cd-8236-784d0530b3d1	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	saml-role-list-mapper
954be2b6-51ad-4879-ab39-d772984e7115	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	saml-user-attribute-mapper
0e607870-e5a7-492d-9944-270dce1281bb	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	saml-user-property-mapper
315baa1d-ef54-4592-8646-d7cf99c1d129	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	oidc-address-mapper
bdf23437-b84d-4767-9da6-e56fdb894473	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7dfbf11f-8c5e-41e4-91bf-da69a31ac82d	682b8b8a-42ea-4818-9339-c8320c243f4e	allowed-protocol-mapper-types	oidc-full-name-mapper
102f1194-e411-4757-bf24-d891b9d50c48	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9723a1e1-f1b8-4cc4-af21-3d10bb297109	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	saml-user-property-mapper
2b20524e-f3bd-46e3-a2e3-d1353096ceb2	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	oidc-full-name-mapper
961dc989-6a1c-4fff-b8d2-5e90b407d585	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
69073031-e392-4f40-838c-903c8b1b96ed	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	saml-role-list-mapper
fa380ea3-0289-4651-964e-3050e8eb68f9	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7ba12e82-a24f-46e1-953b-7ab27bf251a8	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	saml-user-attribute-mapper
c0fdd0db-1975-40fc-bfbc-b7bf9001f857	be9fb7f7-0ec8-4c09-92ba-322d6fcb6159	allowed-protocol-mapper-types	oidc-address-mapper
e136791a-71b0-4536-b14e-48b9aa2497ff	b68d3af4-65bd-4bc1-8fb0-23507bda03a3	keyUse	SIG
5f08b5e6-fc99-41a6-9335-840e75a8e8fc	b68d3af4-65bd-4bc1-8fb0-23507bda03a3	priority	100
38aa9f79-ff65-48c9-bba2-4b0641ae4651	b68d3af4-65bd-4bc1-8fb0-23507bda03a3	privateKey	MIIEowIBAAKCAQEA22JcW8avaogHk2Btu+QzafunhAijkb1TnIIfhjeHlmvrLC55c5ayYe3Y/F8NUSMcUlj/kRZ/2b9asfuiyprb/l6WYRFCFD4dDB+47eHv3sJ2CgeVhQWMw39BTjAk7qhk26BkA7996/D87hxO3PAS6etPwWJjvfIjDbvN9fZK/1ieOlddyF9QW5BvzsrqGMCLvQMKtUMkn5AvvanODYuWnpVM0fktepSl17RGub3nCAsQYQP6grKPhMjI9RBKon+Bwd4DpRzHViivPTC5u7S68cabahM/9g0kU2Cra7WdPbV5rtMvCatREEyAbRL8NJpSVQ/ToMqOUUxLEZ56HrTzdwIDAQABAoIBAAl9eMdTkfUGy2UZr8WH+p1kEHwKr6C3Uu2bR2fT8R6Vroervv88Dp1j35YTOo0++pOpW+zXz1IJEBBQ9VrUVh3r04+BYp1jjngeyy4nLuww91A5wcMOWWd/ksCiHobga/SAPLNYzkatlxNp0BOIoxjRYBLagbwOxGtsq10veVEQXM7Mvo4VbxAB8xgmmeOw+HYcFLff2JV9Gtua/v7sxjmN++vkeSFpSOTYo/sShPEefz1gg1bnLL1/1oViw3XA9sc7M2vRDbjzmnfur5G0OX4C46ke7+2VtyXBbdsfWThmAaoCl6UaCwMuhhOA0UsyQJW/1BEw4VtvXhbTI8twf6kCgYEA7yiYvEAl0oKBUMhf+x3TIaX+01sIABIWjL0Gkw624E/wI6CNM8/EBsB8cm8+AFmJRelcuin68xeHQjzi6MIFVk7J1oYxuf0PbwRIfaIBIJ7/Yfoxp1mr5QffoGC8Z62aE1sRg51mXiSBNXn6hVWgENA+QP/0HgKv6OwTg1/T150CgYEA6tVIwfcdH85P8n+JiqFz8oaT/TQS0+J5shvUwDHe/if6XGd5yf/XAVM4HaPxC6WeM/LvVhI8p6dEO8AZFCwcNbngMeezvW6mn1mU7tvdZNg09+Dh8/J3wY4X4QDuhdzASBNCYMXI3dxlDNIlTiUAPEgCcQj1RZEYrczwIk7hjSMCgYB1gEWiYAX1KmdskDYQA7RC2PKdVyFUH47ysMB1KgqRpNTAPFaDuTV/d7zs4FjfBR6bua70TEHeg5XR5mY5o3HJ2MXz31S5I2scyUbwatMQ+u1QbwNMTJNW4IpvmneWnMWRcvHk70VnRZox8u8x6ULOX/HmL5r5z6orzyk7J67GRQKBgQC+HG0KmkO5vAx9BUMUOCDl9o1YLxAO+QoMZvuVnMoqd7L3m828+qHVMMn9NPuvsiShacrYo2r3TzKuLJYg/pTX6eLWg/2/HhVGa/9mYBiby20WP7itBV5uE9rBDUAMnuoLb4wNTBGRixtDhd0tpkbKhoFzgQ0PhKe2DHNbUwDGgQKBgAvmldHzfohZTl26jQud37cq1jfNLR/SlI9sYNKu/YUK8OZ1SSm3BCGE059/R+UDWVy5/e7bjBEznsrfovfjYuG8flv3L9Hiow1+rRR3zlxFbhA+t5WocpOTHjJ4DR7aiQBnWc8lerK7QjWDw6U2lmsAMIq5yaoy+IoLC0VXf33v
aa5ab1eb-f626-4b6d-b74e-c5529c5a397a	b68d3af4-65bd-4bc1-8fb0-23507bda03a3	certificate	MIICmzCCAYMCBgGd/m/OnzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNTA2MTc1NTMzWhcNMzYwNTA2MTc1NzEzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDbYlxbxq9qiAeTYG275DNp+6eECKORvVOcgh+GN4eWa+ssLnlzlrJh7dj8Xw1RIxxSWP+RFn/Zv1qx+6LKmtv+XpZhEUIUPh0MH7jt4e/ewnYKB5WFBYzDf0FOMCTuqGTboGQDv33r8PzuHE7c8BLp60/BYmO98iMNu8319kr/WJ46V13IX1BbkG/OyuoYwIu9Awq1QySfkC+9qc4Ni5aelUzR+S16lKXXtEa5vecICxBhA/qCso+EyMj1EEqif4HB3gOlHMdWKK89MLm7tLrxxptqEz/2DSRTYKtrtZ09tXmu0y8Jq1EQTIBtEvw0mlJVD9Ogyo5RTEsRnnoetPN3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBANdRF+uErAd5EGkDzPYwpjjVoAGx68miKhqfyG9fL+v1O/NLqN790BWMWLVgYvpu37yOmKrhgMwGLrQyCnI2h+WTviEziehjnGZHOgrkLVLWlC+BDrkbfwX26mKZGbbUmGM8sNAV1hHoi94YbR+hr3cNYevJc++olxEZFuRplPw3Hs2YV85Gk98KSBqhkQLIv37Zmu4qIYeLSvNBespZnFY/eSIyyY/fq37ak4y/WyUL3zESyUSdJyR7QgQGtP5PZAtudaT8fwCHB/qhCBsgyxRrzhmHI6zZTLvcMlkDHF+S0agjPN8pIIz6q1gCsprk/md19cLbhH4r/6nGhJt2PoY=
b83743f6-449f-47b0-b925-aa256b8c5c52	0ebe273e-0bc5-49a9-9b0d-d6dad69a032a	kid	32cde14d-0881-4fe5-b475-8c511202ca78
c4ea4c0f-2d1d-47e4-89e2-8b583d997573	0ebe273e-0bc5-49a9-9b0d-d6dad69a032a	algorithm	HS512
965a880c-9bc7-4b83-bb63-f78c27479166	0ebe273e-0bc5-49a9-9b0d-d6dad69a032a	secret	sMzDHNv2DrrZeg-Xt8XDeZYw3L_hx36RxFIJp_tDMBNvKbypJocVitfS1hKaM-IfHomNVApgHYW2eOE6-2H7RbcQS30llrCHSCSNbe3BiLhbMz-Si7UwQBygJoLyBoHqVYT4giXewgmW61VUX1vgGbX5FZpTO-FH2HkvC-mqq3s
dae444a8-cc86-46b6-9d4f-977772ef6a3e	0ebe273e-0bc5-49a9-9b0d-d6dad69a032a	priority	100
407f2eb0-1c26-4d83-bdfb-a1b107f323a3	abe42efa-78b7-42e0-bb9a-f699d75478a7	certificate	MIICmzCCAYMCBgGd/m/S+jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNTA2MTc1NTM0WhcNMzYwNTA2MTc1NzE0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCuFHD5Y2zCsjsZtF/HbVvLUaO8Jv+5TK85TayzSLiz6Y5+Gq2IrI9TnHiJOzdEWsgaJIgtS1kiEdSr/JWwRPEeXI4InyU5gskaOgFQMLjgXM4kHN505AnCbFTa7KWm06Jo9nna6dwH+hqPnRXvCNJ+LwKCK3Les9ZJgzvsqGO6MnfKkbDQMK5RHRg0nVEzddcPqJaolG5mE3dNdJUp9LywwkJzEFGeRsxEdaS3SqxTWpmTsl3HAxDFx79s8ftuvVdJUR4B3MCGUJLlwLe+tI8jNmxtMcERpnaQ6AEaOKTEevWYQHX8Au9TBX/c7+FqJNbECM4SUYzFEYhD/mNFfLB7AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAOf71HiRikXmcMO3OWsanKG4YNUwY+Wm9TpE0AjGOKdNorOTr9UaUudUEEPo8hYfyT89sKYgeyPc0iCCH7XTzUZi/CQ3chehpBUy9tPS3s+Kq3w3mg4W5bRA6lva9BTa4+piIsRwnEZo1tDulsY29iEvl0nUwA+bEIE3WvGtD6nDzXMQ1zU6T/aPTGOemSWQK2ttwzcptRcB2ejWg91FVMiwj4z3UBaBx+MnVc8J1/2g8OHk77PtMMZQ0CJbTOI6sltjVxA9rScdSzduQpwZ08sDz6iJ6XO17lLBc3ID8Y4h4XFPdbOZreCDmttLhagpTOUZUsuGa2EcZYhlDgk9Og=
522058e9-dd17-483b-86b7-8ad09e624ad5	abe42efa-78b7-42e0-bb9a-f699d75478a7	priority	100
ee31102c-647f-45fc-ad07-29f112799c69	abe42efa-78b7-42e0-bb9a-f699d75478a7	privateKey	MIIEoQIBAAKCAQEArhRw+WNswrI7GbRfx21by1GjvCb/uUyvOU2ss0i4s+mOfhqtiKyPU5x4iTs3RFrIGiSILUtZIhHUq/yVsETxHlyOCJ8lOYLJGjoBUDC44FzOJBzedOQJwmxU2uylptOiaPZ52uncB/oaj50V7wjSfi8Cgity3rPWSYM77KhjujJ3ypGw0DCuUR0YNJ1RM3XXD6iWqJRuZhN3TXSVKfS8sMJCcxBRnkbMRHWkt0qsU1qZk7JdxwMQxce/bPH7br1XSVEeAdzAhlCS5cC3vrSPIzZsbTHBEaZ2kOgBGjikxHr1mEB1/ALvUwV/3O/haiTWxAjOElGMxRGIQ/5jRXywewIDAQABAoIBABYzHyZ+qnEN1QGgghJm/Nd/RXfff/8mgLYNv3dsT7m0kD++sTYGeOS7G0K3nYMHEhEGFaOzwd3ZaPC3Q8j4kciYbw3kaxUxe5SaTxk7OBMiDVvc8/WeMIHDL53CThcUqC07OYD/D9iolC3lD4Ct9FdehrMI+BuJ0vW0WbZYJxeogAKgGjSC7GlBNPJnf12ZDRIPAqnzLasNuMr6yuVWCnHpyIOndXSEGM3jv2I7NgWZn9PmpvIRlx/SWnJeOP0cXMXa7Xkdig4jM8vI0PzQPwqNBMK4UxOXqUdGlGTNDg4qCqaUWu/89Ogoi/nsLmLAJCGrSr2yNx7qmIwm+rPeC4kCgYEA4c1SkLrsxFrO8zPzS6UfL6cP0BoL2Ll3l1II/IJnTOulb6zECMJ/KbQNdmsfq4ReW3XpO4oG+GU6AQPvjv6ZHrqWcQL+7qxtCwv3eFkHI3otKJPeX/csN4HaJrysgMtS3Hl0yi2EBM9kzSiHKE6lFnjNtiUTBwSaKWfT+FkuCxUCgYEAxVxUohdLDZ7wLIy0IwenQ2garZgVu1UgU3/EaIerAxLgaCLf49G8jBJLVCW396p+p4p1WokYcWhW8pz6rvzwfU5nbAwZN6V41hTiZGEtgwRnws91xgDGvBrZ6edkQPQJ0gSYmBnEvI36J9TxsYiWxL25oD5IqBWrNCNa+1SXcU8Cfw7+k30I7LAdV6DO0lkznd6MOYCYOjEqH8bsq6wY/MMe4t2Hm3z5bXhXfI1gj7nUEHACZHqPr+bO0gs/N6lHPuPLgDIBAOzYhmU1ZjmXr+GrO1R2fU3iHA2TkekAnnPvDJGXfynt29Z17zuwdUk3776ORxrRW3Ib3CDjxC+5vFUCgYA8b8LHBEUKfcJkkg3TsFNLNAT/ZdQ50p6ck0KtE+aNgWlQ2mUfWanYZv3EXeyRHhe87Ix1VggzKlV95A5sKa7nYGwRTT8nqDdxr2GIha2vMlkn8enJ4ZD6J2rV0vMDZPfg5WFpKnLxnrSdH/uHdyFcTBEc/hW3yzLrO2xwDH53xwKBgQDSfnvhbODT8j4QIFrTwOETvy5O35wcTiMzgX2wknsSZOZjG7i4wISaGFUOyVOP6q5M1HQclaWBBjUEdR2DDEF7mck7ow32ir7JI/85n0DdlFknSjD4EB+8WUO5OIwOJXq3OXX82VlQ81Gv41Lnkt4u+H2+BTCRwys4nfnWl8me8Q==
4c044ce6-829b-4f22-87ea-2fee63217a8d	abe42efa-78b7-42e0-bb9a-f699d75478a7	algorithm	RSA-OAEP
fb38c884-021f-4ea6-87b8-3aeeb5864d88	abe42efa-78b7-42e0-bb9a-f699d75478a7	keyUse	ENC
befc82fa-f7f2-4de4-a924-d1f4b5df9812	92079c1b-362b-4072-9b9d-0513e85c113c	secret	ygcMi1i8UbfGTlk9MMjtPQ
56f75b3f-5955-4f8f-98c6-741b05b7f6ef	92079c1b-362b-4072-9b9d-0513e85c113c	priority	100
1cf2b8be-5d27-42b0-b624-c138d46fd0ae	92079c1b-362b-4072-9b9d-0513e85c113c	kid	4f81b1a4-c5f7-4ca7-87e3-f25530060a44
927b86ba-77c1-40d8-83f5-3b70477d8bd1	a1201ef4-ee19-4911-9d18-e60ecdd7ee8d	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
7ec51e6d-8455-4822-8bf0-a8d4d03ddb83	fbbe8f99-e4bd-4b4f-8b95-1a1d5b3b7da1	secret	GkaDplKdCdAdst3Q7cmfaw
8bfe0d9c-2b8f-4649-9633-411269976f55	fbbe8f99-e4bd-4b4f-8b95-1a1d5b3b7da1	kid	8b3e3d2e-5af4-4f78-b074-1ade234d0668
3c88ea0b-d63b-40f1-85be-2b0f9a71190d	fbbe8f99-e4bd-4b4f-8b95-1a1d5b3b7da1	priority	100
ace81950-e03f-4841-bc33-3f04f10fb6e4	6ef92b93-29cf-4d1a-8af4-6b289160fa9b	privateKey	MIIEpAIBAAKCAQEAxCVDJucNGrd/7dcIyfWtwLBrKyxUfjSVTYcvyMfYGCBOB6w2moO00PsKcTfb9Xz97vlvps4nUjrQPBG6gDfzDMsMucp5ZHzcBgvLz2kRxW5HwfXivJbAlWnfqhQRk3MEX3SAOVStrph9ZuEMgPl5w8rFd8yOZe38YHjYVKa3D1SWvrGAziEjIdESIznzYu+XaZ6EMRpLJCjan0aYVBh4iclhQdjB5ewBn8rUnxWnNyhwuM4n2fCXPySEbcneQpUtu09p21Owz1BrWJ82T//1W9QyKfQvv1Zl586ZfxhBuKY50EGpO/soWY2Gg5Nr/He9rNuPA9NboutUpkbzkWve5QIDAQABAoIBAAohhpNm0bV0juYA+lI8H0pZkl97fa27F48WkXBEajPszzr0OSnH7bnxjXuFkBXg69jBB3RNJ5jGsuS3YbOnsCUUA8dA3v5CuLaTO2auHZ3d8VTiV2C4RKAzBLtrJ/E+upYXlVvgtMvU0n1S2Gt89z4WphZm+V/oZ+WvuDS/G6tt8sHrlOrOeZcl4iHpyRUPn9HLeda5+tumH7Hk92Ve0dfvbawSX6266npAKJcRYmkIsqI88faHCWtaz9MqlhSrh5D71LSs7qIVU0NvfqThOCOjE0rfCaFqMNTuvwYZyoX3oMKyOiN6kI+t7xpBGPHiJsjDzIujIcYLxOqQBuiiuM0CgYEA+3eULB+5fIcend3Tp64SuO+InBfGBBr8EZfWYE2Fs+OIfjh6FBucMd49YWqcMaUOxM7keMc1crwbDHqeOmSwnEEDUu6GL6J7iwCTbfS1F20KdjCxMkj3wzLrI4ptG81FJJ6CEYvOQlIO7EuZj6CVGrmM155JJGM2FI12GO+kC8cCgYEAx65lffHVz3jHrzNUrL+fxVY3NeeUcPYxmXUzKk/Dwj90a0evA7IQ36ATs4wNp01YsdFKPs5JtHo/JpN4YjPV4Ox3EdHUvdPSIKVHv9ukoroihs+3kfYK+P0Rv42aFa2BGAst3szvtnDh17CWUc9v7zCFmUOIJI4rKCxoYF4Lx/MCgYBue7lUMZQTTGJ9RcsKbwa2zjcdLazIfPqm2ClOIoFN6fg8TKAGWaMkndomBOsfPL/iZGwpTI0FHfRcZTtDuJ2H6WCGfVnjb+YLynL76nnuEvB3wSj5SOnij2qUMOuDPYrVbfcDsoMqzFbWJtkPK6SXG1LwIRFNtXE7UnPCvPc8XQKBgQCBRYo3KyU8l/jOl/CtlbEd1F8R6sbTCs+5hYKGVfVqACKigVnwjosV+1BF4NnGAfD1zYS/fFWDHdFcbAR3rw87+lprkuijrEpREC+PKec/4jkQBdHWEO+xmkSvOkES36y/oB0mLI7UEehj9tKaTC0vML6NJocxA0k1TOqV2MzPuQKBgQDBQkdBaM+E1FLBc6ZYz5Msb/9ceDjTieNz5Io47nOABVMrdbSNjK3ItfrlqecXDbhZilmoqjfR7P1gRk3pB48ZpJpFTswpPuFmgNBjudV4nCUuyFXsgXbKuT8CXbdAqNdRxgYp5+VNjlOvAhIq2eRuAWi00XzhpJUHy+byKYguIA==
94effc6a-2eca-4752-bff4-852b1ddc7033	6ef92b93-29cf-4d1a-8af4-6b289160fa9b	keyUse	ENC
c0f359f3-dc37-48aa-88dc-4ba5568cafec	6ef92b93-29cf-4d1a-8af4-6b289160fa9b	certificate	MIICnzCCAYcCBgGd/odLfTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhFUlAgRG9jczAeFw0yNjA1MDYxODIxMTJaFw0zNjA1MDYxODIyNTJaMBMxETAPBgNVBAMMCEVSUCBEb2NzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxCVDJucNGrd/7dcIyfWtwLBrKyxUfjSVTYcvyMfYGCBOB6w2moO00PsKcTfb9Xz97vlvps4nUjrQPBG6gDfzDMsMucp5ZHzcBgvLz2kRxW5HwfXivJbAlWnfqhQRk3MEX3SAOVStrph9ZuEMgPl5w8rFd8yOZe38YHjYVKa3D1SWvrGAziEjIdESIznzYu+XaZ6EMRpLJCjan0aYVBh4iclhQdjB5ewBn8rUnxWnNyhwuM4n2fCXPySEbcneQpUtu09p21Owz1BrWJ82T//1W9QyKfQvv1Zl586ZfxhBuKY50EGpO/soWY2Gg5Nr/He9rNuPA9NboutUpkbzkWve5QIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQA4AuzAFgQoXK4M7dl2Z7csZ8lcEXWpiEYWu3tC4Ty5ytffyICyjSDz2/juea+eRywGNTmBMIfWnwyKmiW2DGC21udjkbTgdtfNA1NcfzZMo600WCtLtmlHivLs6+fUmdxfa0gwtkDWsGkgZ1ZmecIrnGRSVdSb+vdTxXTPdMsNG+C683Cj8HyFu1gj7gdDYpxpgKpdzrN75x71r2QaEkyUufeqrsKuyFZlL3qAfzDqWa/sqqLns53qRZE7twsSIefiptGoaOtilA/g3rOkKOIriOiISxxwjyHBW/y3xeV4OJb/3XnuATiHJq6lWUwEulGrfGkocANzmQdypYw/8KYo
cacb3498-510f-40fa-bcc3-a274035567db	6ef92b93-29cf-4d1a-8af4-6b289160fa9b	algorithm	RSA-OAEP
c4c657bb-bdaa-4382-af90-5f8c505d2b8a	6ef92b93-29cf-4d1a-8af4-6b289160fa9b	priority	100
942484d0-c9b7-402d-ac62-6dce7337d642	557aabd6-a5ca-4380-ba87-3978e09393ab	priority	100
9dc94ead-a715-495a-bba7-570ace3990be	557aabd6-a5ca-4380-ba87-3978e09393ab	keyUse	SIG
7f3b2db9-22d6-401f-9825-b6cc1eed49f3	557aabd6-a5ca-4380-ba87-3978e09393ab	privateKey	MIIEogIBAAKCAQEAw/bODULMkbL+FB2sycKd4eDeGjUl0EfZCVh80eY560iJyhj9NkEiKnLfyzN7w218Fu3mNCzSiaNwEWthBcTbPEyx4RISWunsio4Z4/CEsgeRjLLrunLTK+aovBe+cbwAySlAeIzDGzys2bQkYZOP++r8HG77TqprOoL/Ju795U7isClzQV3Mvv1X5TKXH7eavj7t4EVdQrB5GKjY975j6pAWgFZdLa/gUz8gS3SnP00BodJbnePgthO2m6po/7ZataiQqG1o4swpEVH0YcHJWauWWSz5g21o8RvzwObpep6pMrQn+j/cbOSCLbIooIBiixzm2h5c66D30SN4Joo+7QIDAQABAoIBAAzd5OgdKXTsltRdIXCq7mERJHbTOV0hsTgKScHMwc33eJKe4utVH1LrBtOJrm07FawkvoTQ/O7sHrTfbc1U6wcxyvZ/UFoMpMsb1Z/a4D+XPHY2SOuNqVy8e6TuqILBEx/M2APs9szlm5IndZcRkGE8VoWLFPBJ7hn3VXJUkVz6XEO5nMF6MTVnwBRF2v2y2ucaEDCWuew6CB1l83CLA3L/lcvJiWcn7FS51/jVIfzHVaeUOjWFH1coJZ9CABjrILZ63sEpu1wvm5Xd1rKcovXDNRZpfMF19761PaeArRZM+GkhpoZ/s1LGXSQoJqjKXE0IDDZUOIhxQZ6wYJ3HXAECgYEA8IHTkj+BtrUmx+PiFCOjQpj9AnACq6FOtm+15Lugf/v0Ix8n3+IlC4oD53gG+R/n4J+fAaWJpnRaMmxoYAHEcKLfpoBjefPYUA4Eg8/0OIgHeMVWQ592yUUOPDnl3gGV+71QbmBp0DL2LRFjfn3OtaCwg+zjPgiua+YCRUTTou0CgYEA0JZsp9rNG5cXCcO21R7SebYteMIaHpaXefbxw5DKtzpYf64Gl/IwvGe7p2bLWz7NejFM+HKZYwlzY17R1NydrjAjqTvJO/IukLTi57h1QAtdBXYO808zHrojo1hSm7fQif7A4q0nF3oMKbMphIZpaCOjnYx5zIjb5/OEq+JxjAECgYB9J5IpsNKXeX1M19F2GXWD2okPE6rQFYkYdtl4xgqnjz1kaXoej1gnwRJ3CYbXbTsFMQtVmAchj7rAMpm+HC1VT+yCgJ1DgRk3z5OZ5EV6hY8d0dMqLXlrE3xs6tQryzd5YPLR/WoS5fIlUb8su9stuQkiHcvDJFFf5LmZwk8/oQKBgGH757rKG8O0LAxYNdDTk8e8/otVkvN/hlSy3ksh/zgnXl9MHqjOCnrWt94hebG5RMj708559vgA/oVVi3hU0nV7A6WCAjv4vksXzedQTTPyopXoKYm+UKNEiW04FkY0CPBqDa3t7QkoOgJ0uTIZ+fYDl95wmN6uA69oQ5CC5RgBAoGAYvqcd2BNxP1CRAGVQqQZ4EbnQ/36hNohfSvKxxik4gLGgk9FeEGefXDxscs9HiYSTiSB4GsUx3Yr8JjqOyidiYrgxxNQvbYYjJbJgUzkDjmTRPm31qCsYoYKIVKjosj5OdYsv0ndUqzhWJqpfdcnmEF298iDL8RL+x4MzDbMt/E=
7bf8b59a-0e6b-4e8f-afd9-f30515aa6685	557aabd6-a5ca-4380-ba87-3978e09393ab	certificate	MIICnzCCAYcCBgGd/odJQTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhFUlAgRG9jczAeFw0yNjA1MDYxODIxMTJaFw0zNjA1MDYxODIyNTJaMBMxETAPBgNVBAMMCEVSUCBEb2NzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw/bODULMkbL+FB2sycKd4eDeGjUl0EfZCVh80eY560iJyhj9NkEiKnLfyzN7w218Fu3mNCzSiaNwEWthBcTbPEyx4RISWunsio4Z4/CEsgeRjLLrunLTK+aovBe+cbwAySlAeIzDGzys2bQkYZOP++r8HG77TqprOoL/Ju795U7isClzQV3Mvv1X5TKXH7eavj7t4EVdQrB5GKjY975j6pAWgFZdLa/gUz8gS3SnP00BodJbnePgthO2m6po/7ZataiQqG1o4swpEVH0YcHJWauWWSz5g21o8RvzwObpep6pMrQn+j/cbOSCLbIooIBiixzm2h5c66D30SN4Joo+7QIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBjH4s4sACrRFKevZemCWApmYgDE08Tdu+VZzp4IGbGoEw3FjA3B1Q9HbhlmPSSDKx4xCX28GZA+jT8HydAC7uXwsVuUGYz+HVUWzoXHnvfL3OKIVYkz9JjH21XVzSIdvg9OTNu5tfrcJWw2AxJ4CAWS0aKm6W9KSUjO81NWBmq0Dg6XYNJqQKIC7Q1hTD6rrH98jDvO9OZjeXbwbFomNwp3Qv6Xy4vidud+H8ltHJUkjPIUfy0sejCxQk3/ZjUDNmiGdJNCYhcDG9wtP0EyCOq4Xnq9af/2HImWZqj7W8i9BbfkIrsQlt1Jh/ggRHF+5n6Fo/qpv3gEXGTct/Eew2g
04fe6e27-12a7-4a30-95df-73cd845a4703	ebc1d1f3-0f37-4b13-aed1-4c8329e8bec2	secret	rpZPP5J5QTkluIhhUN5lVTIWBjjK8H1nBr5dPCXAmdYz7N34hUh4edPvYhm6RwCYDSYYsqHo_RKMHSssxdXqL6Dq3lgxzkQpPm4--2fO1mgVlQeFU8YqIhLA8nFgi8esRUGflAGEayxpqNmvRsj8GMA8czr6r1MYe421a-YHJ2k
d931e6c3-08c9-4f75-997c-a99f6e603ff9	ebc1d1f3-0f37-4b13-aed1-4c8329e8bec2	algorithm	HS512
5407f39b-2a27-4488-95b6-ca397ce8be86	ebc1d1f3-0f37-4b13-aed1-4c8329e8bec2	kid	b1643d92-fc0b-4cee-99da-0bd0cd9dad11
aa2cf7cc-800b-4aca-ade4-a666d33685e9	ebc1d1f3-0f37-4b13-aed1-4c8329e8bec2	priority	100
8fcec3a5-894d-4bf6-a210-fb3f4c00e63f	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5917254b-2bbb-4aa0-ace9-6f59f1b4dd33	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	oidc-address-mapper
f86269df-8a09-4ed1-9366-d1bb7be88025	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	oidc-full-name-mapper
767a0cfc-9b7f-4853-a642-f50d59eda0e6	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	saml-user-property-mapper
2de7a9bc-1332-44a2-91d3-fd178dc5b817	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c3ca9cd9-3a80-4b92-8f52-f0cc9565ad24	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	saml-role-list-mapper
f6a389e6-161d-4ef9-99e2-58b3fc01c94c	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0c75a8f3-7b91-4788-a534-5cc8a63f09ed	d27f66cc-0833-4bd1-80da-839ac03d29d4	allowed-protocol-mapper-types	saml-user-attribute-mapper
8c602893-fefa-40c4-8325-fd9baa823b05	abcf7036-d4de-47c2-a02d-17dfcfefb836	client-uris-must-match	true
b2e222c7-924e-48b8-b916-4c4dfd0bc1dd	abcf7036-d4de-47c2-a02d-17dfcfefb836	host-sending-registration-request-must-match	true
2f55091b-f8ff-4e99-949e-c031e21686c4	27fca1be-0c28-4c41-addd-428624a314dd	max-clients	200
ee08e92f-27bf-4bf7-9baa-05e83194a545	1022a080-45ea-4d57-b1cb-2ff062fb2166	allow-default-scopes	true
15be9199-3a54-4e34-b97c-6d3372af2f05	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	saml-user-attribute-mapper
4dae3fd3-e97c-4aaa-9da1-c63840ddd45b	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d223653c-fd98-4868-8ac8-c4127b395710	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f9c32991-61cb-4163-ae82-53af8ffc5103	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a3f9014d-1ec3-4381-879c-434a4464c096	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	oidc-full-name-mapper
93c0de2a-424f-4fa6-963c-32443e98c804	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	saml-role-list-mapper
f7a2a004-3c89-49d8-8fa8-59806c86ea86	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	saml-user-property-mapper
87733e08-af57-4434-9fcb-2753d09e8c6c	21c1bbb7-7ae6-4eb9-8d27-867657e54041	allowed-protocol-mapper-types	oidc-address-mapper
dd0e26da-6e80-4c39-b43c-663a7646a00b	5b14a803-fb55-4d95-a324-ad8d86ffb1a7	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
49739323-5cc5-4fac-8be5-7e554c3778bb	e90638cb-b2d7-401a-994f-7c5bbda6fc0c
49739323-5cc5-4fac-8be5-7e554c3778bb	44c9c1fe-7e62-4720-9c50-105d0c988cfc
49739323-5cc5-4fac-8be5-7e554c3778bb	8fab83ab-357e-4886-bd98-f100bf5cac08
49739323-5cc5-4fac-8be5-7e554c3778bb	52329c1b-50e2-45e7-925a-dcce6ef6081e
49739323-5cc5-4fac-8be5-7e554c3778bb	2f20778a-a924-4917-a4ee-9a4253969141
49739323-5cc5-4fac-8be5-7e554c3778bb	3fdebe14-24d0-4bb0-836b-2c88aec8e4ba
49739323-5cc5-4fac-8be5-7e554c3778bb	77d7cec1-5c22-4557-9285-b1137acf3669
49739323-5cc5-4fac-8be5-7e554c3778bb	8729e4f3-c688-40dd-a854-68e6a312cf16
49739323-5cc5-4fac-8be5-7e554c3778bb	36acf303-dc14-49cd-9e7d-04f0b62a763a
49739323-5cc5-4fac-8be5-7e554c3778bb	be24c5ca-b8bd-4cfa-9acf-a6c0e3d707e1
49739323-5cc5-4fac-8be5-7e554c3778bb	f4d193a3-c328-4157-94f1-9f52af0d8ec8
49739323-5cc5-4fac-8be5-7e554c3778bb	9940943b-b043-43d7-90d3-d059405c53d7
49739323-5cc5-4fac-8be5-7e554c3778bb	b1ec01ec-f1b3-4ee2-81f2-c4734cd1cbe1
49739323-5cc5-4fac-8be5-7e554c3778bb	6f5d1944-ef65-4ef6-a5f0-e1702c61eb53
49739323-5cc5-4fac-8be5-7e554c3778bb	537cdfaa-873f-4b12-a745-3837a112f1bf
49739323-5cc5-4fac-8be5-7e554c3778bb	aeb14708-76a0-498b-83e7-c45fde8790f2
49739323-5cc5-4fac-8be5-7e554c3778bb	a634b55d-c203-488c-bfd5-72f39b5e39a0
49739323-5cc5-4fac-8be5-7e554c3778bb	0403bb63-f2b8-4674-b1d5-953f8b3eaee0
2f20778a-a924-4917-a4ee-9a4253969141	aeb14708-76a0-498b-83e7-c45fde8790f2
52329c1b-50e2-45e7-925a-dcce6ef6081e	537cdfaa-873f-4b12-a745-3837a112f1bf
52329c1b-50e2-45e7-925a-dcce6ef6081e	0403bb63-f2b8-4674-b1d5-953f8b3eaee0
357d75aa-76ac-477f-a87d-be40056d7d5a	ed45a7af-95bd-418f-88e0-7f025794ac6c
357d75aa-76ac-477f-a87d-be40056d7d5a	63db14c7-5fcb-4fa8-b001-6dc6d4e8fbb4
63db14c7-5fcb-4fa8-b001-6dc6d4e8fbb4	07563990-f268-492d-87f7-7a9a2a8fa8c6
27914180-d217-4654-9006-aa08ca2e94be	0bf3e687-73b5-463f-b5bc-5970f5431d58
49739323-5cc5-4fac-8be5-7e554c3778bb	ec76ddc4-35b1-4ece-bf55-b71534bd9930
357d75aa-76ac-477f-a87d-be40056d7d5a	114d4082-15ee-4adc-af40-8579e85415ec
357d75aa-76ac-477f-a87d-be40056d7d5a	c32fc887-304b-4c25-9938-be3737b3fb09
49739323-5cc5-4fac-8be5-7e554c3778bb	4413aeab-012a-45ef-85ef-80a8bf6c71bc
49739323-5cc5-4fac-8be5-7e554c3778bb	1551f71c-311a-465f-837d-18573f329eae
49739323-5cc5-4fac-8be5-7e554c3778bb	33540733-74f0-49ec-892c-9f91cb588a03
49739323-5cc5-4fac-8be5-7e554c3778bb	5ecbbaa5-fcbd-4222-ba63-81c16b67275f
49739323-5cc5-4fac-8be5-7e554c3778bb	f8fc362d-2afe-41af-8400-e04dabe09a6e
49739323-5cc5-4fac-8be5-7e554c3778bb	b6d99a87-bf3e-478e-b2fe-5b47bf8b00ca
49739323-5cc5-4fac-8be5-7e554c3778bb	0d9bb9b5-bbfd-4c3a-8c4a-930b02c82a87
49739323-5cc5-4fac-8be5-7e554c3778bb	b2113623-bc1b-4c5c-a7d5-ef545b0bdfdf
49739323-5cc5-4fac-8be5-7e554c3778bb	7bd7d695-55ea-49e1-93a7-fcdb10c0666d
49739323-5cc5-4fac-8be5-7e554c3778bb	10ae3595-da12-44b8-b64a-e46365548ffb
49739323-5cc5-4fac-8be5-7e554c3778bb	74a611f3-98c3-4e4b-90f8-2b2e04710531
49739323-5cc5-4fac-8be5-7e554c3778bb	2b227f5a-7cd1-4add-a98f-1a9be8974048
49739323-5cc5-4fac-8be5-7e554c3778bb	47b66d5e-b3d6-4df7-8d2e-102bd1951d24
49739323-5cc5-4fac-8be5-7e554c3778bb	54b6a13d-933b-46ba-b49b-0b01256c5597
49739323-5cc5-4fac-8be5-7e554c3778bb	f5d81d30-6393-4c80-b721-7ba7b8c51b10
49739323-5cc5-4fac-8be5-7e554c3778bb	21a1b92e-6641-4bc1-a4b7-e65a1d615ea9
49739323-5cc5-4fac-8be5-7e554c3778bb	a122f522-610f-4761-b7f8-9fbe3c7c60a7
5ecbbaa5-fcbd-4222-ba63-81c16b67275f	f5d81d30-6393-4c80-b721-7ba7b8c51b10
33540733-74f0-49ec-892c-9f91cb588a03	54b6a13d-933b-46ba-b49b-0b01256c5597
33540733-74f0-49ec-892c-9f91cb588a03	a122f522-610f-4761-b7f8-9fbe3c7c60a7
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	96a38c98-6c33-4d16-9c83-d951c05e35a9
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	bcbddb35-f1d1-49dd-bfcb-a7097c13fdb3
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	18d29418-b9c0-4586-9a93-384354133ea5
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	952c44b0-7fbe-4a2d-a5b0-4b0e62bd78e8
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	aaf1eafd-e5df-4a78-af8d-c917b70e5297
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	0d3c8761-02fc-4721-b98b-2e01a19fa2bb
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	e0bc8a7f-0745-4138-82fe-17fec39fcd01
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	556ef25c-4da0-46e2-af67-2a410cda31e5
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	e776355c-b922-4f20-b110-3052f102fe80
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	73e50afd-8356-400c-b4da-b2251ebb5207
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	0fce3c74-eb08-4c43-9d17-fdac53e611f8
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	30f9f7dd-2604-458f-8ed3-a151e17c546b
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	828f4b8e-c5dd-4d31-8a73-679a356a39d6
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	f862221f-ac51-43ef-ad80-01db23d33d64
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	dd126a95-bf58-48ea-a55a-5c9a0d1e1201
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	b8ca8ada-09ff-4968-9f6e-878d1568375f
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	899fbe70-6997-492b-bfc4-a86612ae2974
952c44b0-7fbe-4a2d-a5b0-4b0e62bd78e8	dd126a95-bf58-48ea-a55a-5c9a0d1e1201
18d29418-b9c0-4586-9a93-384354133ea5	f862221f-ac51-43ef-ad80-01db23d33d64
18d29418-b9c0-4586-9a93-384354133ea5	899fbe70-6997-492b-bfc4-a86612ae2974
f084e403-d707-4a59-84b4-6ca6b024e4e2	d3696c80-2551-438d-bd13-373950d38800
f084e403-d707-4a59-84b4-6ca6b024e4e2	bbe21213-ba49-4592-ae98-61394376dd5c
bbe21213-ba49-4592-ae98-61394376dd5c	98d6327a-18dc-426c-8cf6-dbc99e575184
2b1f311b-2725-4340-921f-6fe9de7a6383	f540ccdf-eacc-4da1-8720-522dc54f6aef
49739323-5cc5-4fac-8be5-7e554c3778bb	d0973e7d-1376-411b-9a1c-0f35475e35f6
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	b7b076f7-2bae-48cb-935d-7aa325934d54
f084e403-d707-4a59-84b4-6ca6b024e4e2	195b1b2a-fb84-4b4b-a143-0cdf2d3f280d
f084e403-d707-4a59-84b4-6ca6b024e4e2	0c369ff5-569d-4fc1-a22f-98c4ccb939ee
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
4b1c5897-7f47-4124-81c8-acf947098e17	\N	password	66940bd6-e40f-4f51-92c7-a07f7651e845	1778090235642	\N	{"value":"j/POuu7/HaB0cLIB5Jl4dh2L19kZLtqZMk/yuAFc6hE=","salt":"8gd6FmHOeP/i68CKguXr8Q==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
6b69e302-0743-4c9c-a488-c2b29d5d48c3	\N	password	ece1ab8c-ef1d-480a-bf3e-d215596c3a32	1778095911762	My password	{"value":"dOnc2HlcufsUcnQZzfcEM56oyzdNJZYIk+Du18wbHbI=","salt":"2GcHZMTY+WgN41DM6VtIkA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	4
d06cfeeb-ad3d-4846-894c-a418cb6150e2	\N	password	843c15c5-60cf-4a86-9851-fb331bb9e6c9	1778099519201	My password	{"value":"J32dAyy/68RM7nQ/DqZ4Tb8aOktpFzTrdLc4kL5Fy5c=","salt":"BaSWW7BMQ59r4yR2hTy6Rg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-05-06 17:56:36.50848	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	8090179747
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-05-06 17:56:36.839295	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	8090179747
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-05-06 17:56:37.11698	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.33.0	\N	\N	8090179747
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-05-06 17:56:37.138837	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	8090179747
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-05-06 17:56:38.165128	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	8090179747
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-05-06 17:56:38.233483	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	8090179747
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-05-06 17:56:38.880117	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	8090179747
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-05-06 17:56:38.902498	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	8090179747
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-05-06 17:56:38.922397	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.33.0	\N	\N	8090179747
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-05-06 17:56:39.302752	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.33.0	\N	\N	8090179747
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-05-06 17:56:39.541581	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	8090179747
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-05-06 17:56:39.565233	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	8090179747
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-05-06 17:56:39.692758	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	8090179747
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-06 17:56:39.812744	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.33.0	\N	\N	8090179747
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-06 17:56:39.81913	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-06 17:56:39.829096	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.33.0	\N	\N	8090179747
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-06 17:56:39.842691	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.33.0	\N	\N	8090179747
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-05-06 17:56:40.065218	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.33.0	\N	\N	8090179747
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-05-06 17:56:40.256196	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	8090179747
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-05-06 17:56:40.273469	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	8090179747
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-05-06 17:56:52.985159	119	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.33.0	\N	\N	8090179747
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-05-06 17:56:40.286137	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	8090179747
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-05-06 17:56:40.29619	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	8090179747
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-05-06 17:56:40.636356	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.33.0	\N	\N	8090179747
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-05-06 17:56:40.66341	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	8090179747
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-05-06 17:56:40.668516	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	8090179747
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-05-06 17:56:41.983006	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.33.0	\N	\N	8090179747
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-05-06 17:56:42.294634	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.33.0	\N	\N	8090179747
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-05-06 17:56:42.309024	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	8090179747
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-05-06 17:56:42.484663	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.33.0	\N	\N	8090179747
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-05-06 17:56:42.530405	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.33.0	\N	\N	8090179747
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-05-06 17:56:42.607684	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.33.0	\N	\N	8090179747
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-05-06 17:56:42.624802	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.33.0	\N	\N	8090179747
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-06 17:56:42.672137	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-06 17:56:42.684291	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	8090179747
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-06 17:56:42.889793	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	8090179747
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-05-06 17:56:42.918498	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.33.0	\N	\N	8090179747
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-06 17:56:42.932129	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	8090179747
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-05-06 17:56:42.946012	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.33.0	\N	\N	8090179747
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-05-06 17:56:42.960512	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	8090179747
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-06 17:56:42.96612	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	8090179747
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-06 17:56:42.974433	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	8090179747
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-05-06 17:56:42.98679	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.33.0	\N	\N	8090179747
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-06 17:56:48.089006	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.33.0	\N	\N	8090179747
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-05-06 17:56:48.10407	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.33.0	\N	\N	8090179747
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-06 17:56:48.118655	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	8090179747
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-06 17:56:48.12884	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.33.0	\N	\N	8090179747
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-06 17:56:48.13211	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	8090179747
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-06 17:56:48.386004	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.33.0	\N	\N	8090179747
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-06 17:56:48.396695	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.33.0	\N	\N	8090179747
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-05-06 17:56:48.497094	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.33.0	\N	\N	8090179747
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-05-06 17:56:49.224357	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.33.0	\N	\N	8090179747
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-05-06 17:56:49.23689	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-05-06 17:56:49.246532	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.33.0	\N	\N	8090179747
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-05-06 17:56:49.253982	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.33.0	\N	\N	8090179747
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-06 17:56:49.270455	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.33.0	\N	\N	8090179747
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-06 17:56:49.296757	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.33.0	\N	\N	8090179747
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-06 17:56:49.417845	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.33.0	\N	\N	8090179747
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-06 17:56:50.31267	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.33.0	\N	\N	8090179747
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-05-06 17:56:50.432413	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.33.0	\N	\N	8090179747
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-05-06 17:56:50.468973	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	8090179747
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-05-06 17:56:50.506424	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.33.0	\N	\N	8090179747
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-05-06 17:56:50.523327	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.33.0	\N	\N	8090179747
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-05-06 17:56:50.536536	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	8090179747
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-05-06 17:56:50.549728	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	8090179747
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-05-06 17:56:50.563032	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.33.0	\N	\N	8090179747
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-05-06 17:56:50.683774	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.33.0	\N	\N	8090179747
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-05-06 17:56:50.767523	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.33.0	\N	\N	8090179747
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-05-06 17:56:50.798839	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.33.0	\N	\N	8090179747
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-05-06 17:56:50.910518	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.33.0	\N	\N	8090179747
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-05-06 17:56:50.941057	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.33.0	\N	\N	8090179747
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-05-06 17:56:50.957359	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	8090179747
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-06 17:56:50.98265	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	8090179747
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-06 17:56:51.012807	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	8090179747
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-06 17:56:51.019851	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	8090179747
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-06 17:56:51.104849	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.33.0	\N	\N	8090179747
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-06 17:56:51.171846	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	8090179747
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-06 17:56:51.192825	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.33.0	\N	\N	8090179747
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-06 17:56:51.195793	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.33.0	\N	\N	8090179747
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-06 17:56:51.2444	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.33.0	\N	\N	8090179747
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-06 17:56:51.247291	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.33.0	\N	\N	8090179747
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-06 17:56:51.318274	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.33.0	\N	\N	8090179747
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-06 17:56:51.332779	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	8090179747
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-06 17:56:51.345218	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	8090179747
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-06 17:56:51.348526	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	8090179747
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-06 17:56:51.440567	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	8090179747
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-05-06 17:56:51.471473	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.33.0	\N	\N	8090179747
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-05-06 17:56:51.507613	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.33.0	\N	\N	8090179747
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-05-06 17:56:51.527607	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.33.0	\N	\N	8090179747
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.543736	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.33.0	\N	\N	8090179747
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.577637	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.33.0	\N	\N	8090179747
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.668074	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.718022	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.33.0	\N	\N	8090179747
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.721665	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	8090179747
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.756165	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	8090179747
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.760273	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.33.0	\N	\N	8090179747
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-06 17:56:51.778076	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.33.0	\N	\N	8090179747
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-06 17:56:52.04989	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-06 17:56:52.053158	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-06 17:56:52.0793	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-06 17:56:52.206243	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-06 17:56:52.221092	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-06 17:56:52.319401	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.33.0	\N	\N	8090179747
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-06 17:56:52.339325	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.33.0	\N	\N	8090179747
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-05-06 17:56:52.356946	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.33.0	\N	\N	8090179747
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-05-06 17:56:52.472327	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.33.0	\N	\N	8090179747
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-05-06 17:56:52.564565	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	8090179747
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2026-05-06 17:56:52.681997	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.33.0	\N	\N	8090179747
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-05-06 17:56:52.699704	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.33.0	\N	\N	8090179747
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-06 17:56:52.768607	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	8090179747
20.0.0-12964-supported-dbs-edb-migration	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-06 17:56:52.866677	110	EXECUTED	9:a6b18a8e38062df5793edbe064f4aecd	dropIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE; createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	8090179747
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-06 17:56:52.884238	111	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	8090179747
client-attributes-string-accomodation-fixed-pre-drop-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-06 17:56:52.896049	112	EXECUTED	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-06 17:56:52.910821	113	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
client-attributes-string-accomodation-fixed-post-create-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-06 17:56:52.914151	114	MARK_RAN	9:bd2bd0fc7768cf0845ac96a8786fa735	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-05-06 17:56:52.925272	115	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.33.0	\N	\N	8090179747
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-05-06 17:56:52.961827	116	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	8090179747
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-05-06 17:56:52.96894	117	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.33.0	\N	\N	8090179747
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-05-06 17:56:52.982129	118	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.33.0	\N	\N	8090179747
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-05-06 17:56:52.99876	120	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.33.0	\N	\N	8090179747
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-05-06 17:56:53.007049	121	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	8090179747
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-05-06 17:56:53.289125	122	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.33.0	\N	\N	8090179747
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-05-06 17:56:53.295667	123	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.33.0	\N	\N	8090179747
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-05-06 17:56:53.309762	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-05-06 17:56:53.377367	125	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
24.0.0-26618-edb-migration	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-05-06 17:56:53.513413	126	EXECUTED	9:2f684b29d414cd47efe3a3599f390741	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES; createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-05-06 17:56:53.53111	127	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.33.0	\N	\N	8090179747
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-05-06 17:56:53.535462	128	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-05-06 17:56:53.540176	129	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.555039	130	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.633831	131	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.666164	132	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.683678	133	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.70009	134	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.719558	135	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.723511	136	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.825409	137	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.874495	138	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	8090179747
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.902457	139	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	8090179747
unique-consentuser-edb-migration	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.924453	140	MARK_RAN	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	8090179747
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:53.929925	141	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	8090179747
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-05-06 17:56:54.080785	142	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.33.0	\N	\N	8090179747
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.10687	143	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.33.0	\N	\N	8090179747
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.121569	144	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.33.0	\N	\N	8090179747
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.203796	145	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	8090179747
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.227411	146	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.33.0	\N	\N	8090179747
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.241616	147	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	8090179747
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.333279	148	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	8090179747
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.490204	149	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.33.0	\N	\N	8090179747
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.516651	150	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.618662	151	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.33.0	\N	\N	8090179747
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-05-06 17:56:54.631475	152	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.33.0	\N	\N	8090179747
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-05-06 17:56:54.654829	153	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.33.0	\N	\N	8090179747
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-05-06 17:56:54.673458	154	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	8090179747
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-05-06 17:56:54.694432	155	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.33.0	\N	\N	8090179747
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2026-05-06 17:56:54.718634	156	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.33.0	\N	\N	8090179747
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2026-05-06 17:56:54.733943	157	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.33.0	\N	\N	8090179747
26.2.6-39866-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-05-06 17:56:54.746407	158	EXECUTED	9:1dc67ccee24f30331db2cba4f372e40e	customChange		\N	4.33.0	\N	\N	8090179747
26.2.6-39866-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-05-06 17:56:54.758528	159	EXECUTED	9:b70b76f47210cf0a5f4ef0e219eac7cd	addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	8090179747
26.2.6-40088-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-05-06 17:56:54.766392	160	EXECUTED	9:cc7e02ed69ab31979afb1982f9670e8f	customChange		\N	4.33.0	\N	\N	8090179747
26.2.6-40088-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-05-06 17:56:54.775418	161	EXECUTED	9:5bb848128da7bc4595cc507383325241	addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	8090179747
26.3.0-groups-description	keycloak	META-INF/jpa-changelog-26.3.0.xml	2026-05-06 17:56:54.787377	162	EXECUTED	9:e1a3c05574326fb5b246b73b9a4c4d49	addColumn tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	8090179747
26.4.0-40933-saml-encryption-attributes	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-05-06 17:56:54.797105	163	EXECUTED	9:7e9eaba362ca105efdda202303a4fe49	customChange		\N	4.33.0	\N	\N	8090179747
26.4.0-51321	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-05-06 17:56:54.908596	164	EXECUTED	9:34bab2bc56f75ffd7e347c580874e306	createIndex indexName=IDX_EVENT_ENTITY_USER_ID_TYPE, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	8090179747
40343-workflow-state-table	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-05-06 17:56:55.156989	165	EXECUTED	9:ed3ab4723ceed210e5b5e60ac4562106	createTable tableName=WORKFLOW_STATE; addPrimaryKey constraintName=PK_WORKFLOW_STATE, tableName=WORKFLOW_STATE; addUniqueConstraint constraintName=UQ_WORKFLOW_RESOURCE, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_STEP, table...		\N	4.33.0	\N	\N	8090179747
26.5.0-index-offline-css-by-client	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.288672	166	EXECUTED	9:383e981ce95d16e32af757b7998820f7	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
26.5.0-index-offline-css-by-client-storage-provider	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.392138	167	EXECUTED	9:f5bc200e6fa7d7e483854dee535ca425	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT_STORAGE_PROVIDER, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
26.5.0-idp-config-allow-null-fixed-drop-mssql-index	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.406157	168	MARK_RAN	9:50c51d2c98cd1d624eb1c485c3cf1f75	dropIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	8090179747
26.5.0-idp-config-allow-null	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.429835	169	EXECUTED	9:b667fb087874303b324c1af7fae4f606	dropDefaultValue columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=STORE_TOKEN, tableName=IDENTITY_PROVIDER; dropDefaultValue columnName...		\N	4.33.0	\N	\N	8090179747
26.5.0-idp-config-allow-null-fixed-create-mssql-index	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.433831	170	MARK_RAN	9:dcbbb24c151c3b0b59f12fede23cc94d	createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	8090179747
26.5.0-remove-workflow-provider-id-column	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.514791	171	EXECUTED	9:d8eeb324484d45e946d03b953e168b21	dropIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; dropColumn columnName=WORKFLOW_PROVIDER_ID, tableName=WORKFLOW_STATE		\N	4.33.0	\N	\N	8090179747
26.5.0-add-remember-me	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.535101	172	EXECUTED	9:a7273ea8b21bd2f674c9c49141999f05	addColumn tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
26.5.0-add-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.626982	173	EXECUTED	9:ce49383d317ccbcd3434d1f21172b0b7	createIndex indexName=IDX_USER_SESSION_EXPIRATION_CREATED, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
26.5.0-add-sess-create-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.724652	174	EXECUTED	9:aaee09e23a4d8468fbc5c51b7b314c58	createIndex indexName=IDX_USER_SESSION_EXPIRATION_LAST_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
26.5.0-drop-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.752052	175	EXECUTED	9:f0082210b6ccbbaf81287c27aa23753c	dropIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	8090179747
26.5.0-mysql-mariadb-default-charset-collation	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.755209	176	MARK_RAN	9:1b383fa60d2db0a8952b365e725f9d16	customChange		\N	4.33.0	\N	\N	8090179747
26.5.0-invitations-table-fixed2	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-05-06 17:56:55.985214	177	EXECUTED	9:322cb11fc03181903dcd67a54f8b3cf0	createTable tableName=ORG_INVITATION; addForeignKeyConstraint baseTableName=ORG_INVITATION, constraintName=FK_ORG_INVITATION_ORG, referencedTableName=ORG; createIndex indexName=IDX_ORG_INVITATION_ORG_ID, tableName=ORG_INVITATION; createIndex index...		\N	4.33.0	\N	\N	8090179747
26.6.0-45009-broker-link-user-id	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.100806	178	EXECUTED	9:05026bbbc8d2ead5afcbda2f5fdf3a2b	createIndex indexName=IDX_BROKER_LINK_USER_ID, tableName=BROKER_LINK		\N	4.33.0	\N	\N	8090179747
26.6.0-45009-broker-link-identity-provider	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.193306	179	EXECUTED	9:7d9a0253c9de7be754efef8bba4265bd	createIndex indexName=IDX_BROKER_LINK_IDENTITY_PROVIDER, tableName=BROKER_LINK		\N	4.33.0	\N	\N	8090179747
26.6.0-org-group-relationship	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.285327	180	EXECUTED	9:05685853fba030f53548ac6bf23245e3	addColumn tableName=KEYCLOAK_GROUP; addForeignKeyConstraint baseTableName=KEYCLOAK_GROUP, constraintName=FK_GROUP_ORGANIZATION, referencedTableName=ORG; createIndex indexName=IDX_GROUP_ORG_ID, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	8090179747
26.6.0-44424-index-css-user-session-and-offline	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.380479	181	EXECUTED	9:a704d8598df241a3fd3cb91b6ab4b2d4	createIndex indexName=IDX_OFFLINE_CSS_BY_USER_SESSION_AND_OFFLINE, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
26.6.0-44424-create-realm-in-client-session	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.403545	182	EXECUTED	9:77dbbc72d943e98cfe472ba8cc56a31c	addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
26.6.0-44424-set-realm-in-client-session	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.413069	183	EXECUTED	9:3964a3148d32a55ef81126e23cdf6721	customChange		\N	4.33.0	\N	\N	8090179747
26.6.0-44424-idx-css-realm-and-clients	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.499805	184	EXECUTED	9:a093877fff41185ac24103be80e00968	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT_AND_REALM, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	8090179747
26.6.0-add-last-modified-timestamp-user	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.522116	185	EXECUTED	9:8aa583d2cdd9e913dff42fecd626c560	addColumn tableName=USER_ENTITY		\N	4.33.0	\N	\N	8090179747
26.6.0-add-timestamps-group	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.534161	186	EXECUTED	9:4363d45dc25105a3fc5db9ff6936b0a9	addColumn tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	8090179747
26.6.0-43829-user-created-timestamp-index	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-05-06 17:56:56.62105	187	EXECUTED	9:f2531a49b8bb21a7a97966d88fd1a411	createIndex indexName=IDX_USER_CREATED_TIMESTAMP, tableName=USER_ENTITY		\N	4.33.0	\N	\N	8090179747
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
64844e83-205d-4ee5-b5f1-c772a9c661f8	27e920bc-af53-4c09-a025-49dd85a50b14	f
64844e83-205d-4ee5-b5f1-c772a9c661f8	7ee13054-4969-4dcd-ab30-84e6cdbf2902	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	01af7c6b-dbc7-46b7-989a-e6798382d99e	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	41f2aded-a5c1-4719-89f0-8ea93c11bcad	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	c225ec8c-ba10-4cbd-8049-46b77fe6cd63	f
64844e83-205d-4ee5-b5f1-c772a9c661f8	c86e7f25-09ec-4d99-8c8c-533acbb19a35	f
64844e83-205d-4ee5-b5f1-c772a9c661f8	d68c7a69-91db-4046-b9e2-72b9bcdaa797	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	78e66a1e-2847-49cc-871c-d15bb8de84ac	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	ed999954-01f1-447d-b6a7-bdb76c76d3e8	f
64844e83-205d-4ee5-b5f1-c772a9c661f8	cb42a537-e158-42ed-b65b-b5464139507b	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	ac27bead-1410-449f-a23a-fa1cb0b56fe6	t
64844e83-205d-4ee5-b5f1-c772a9c661f8	8613e35b-b0cc-47a7-b034-6c8bb56f5baa	f
79297412-b299-4def-8f42-bd61d963bfcc	485c2050-95a1-43e3-803a-0f1264c0ea0f	f
79297412-b299-4def-8f42-bd61d963bfcc	c2455068-1470-4d72-836f-21fd26444b16	t
79297412-b299-4def-8f42-bd61d963bfcc	b9064254-6342-4706-bfe2-970db58c9e6f	t
79297412-b299-4def-8f42-bd61d963bfcc	cd032659-64aa-4d04-b956-a84eee2acd04	t
79297412-b299-4def-8f42-bd61d963bfcc	cc28f67d-7f95-4d7c-8c4b-807bab00bbef	t
79297412-b299-4def-8f42-bd61d963bfcc	32b3b9a2-8950-4bda-ab9b-07e22cf11015	f
79297412-b299-4def-8f42-bd61d963bfcc	3818eb2b-f515-431a-857d-decfa1190c9d	f
79297412-b299-4def-8f42-bd61d963bfcc	81e1d7f0-701a-417d-9080-bdb3010ddbe6	t
79297412-b299-4def-8f42-bd61d963bfcc	e3206a3f-df98-4b61-8620-95afabdae202	t
79297412-b299-4def-8f42-bd61d963bfcc	fc38610d-6445-44c5-a6cf-f1fc141b69c6	f
79297412-b299-4def-8f42-bd61d963bfcc	433e367b-5cc4-4861-af47-3cf6761a7f83	t
79297412-b299-4def-8f42-bd61d963bfcc	76c794a6-a6b0-4944-829b-65a10c530dd9	t
79297412-b299-4def-8f42-bd61d963bfcc	ecb664f7-89be-45fb-92f4-80ff7d307b48	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type, description, org_id, created_timestamp, last_modified_timestamp) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
357d75aa-76ac-477f-a87d-be40056d7d5a	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	${role_default-roles}	default-roles-master	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N	\N
49739323-5cc5-4fac-8be5-7e554c3778bb	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	${role_admin}	admin	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N	\N
e90638cb-b2d7-401a-994f-7c5bbda6fc0c	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	${role_create-realm}	create-realm	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N	\N
44c9c1fe-7e62-4720-9c50-105d0c988cfc	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_create-client}	create-client	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
8fab83ab-357e-4886-bd98-f100bf5cac08	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_view-realm}	view-realm	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
52329c1b-50e2-45e7-925a-dcce6ef6081e	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_view-users}	view-users	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
2f20778a-a924-4917-a4ee-9a4253969141	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_view-clients}	view-clients	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
3fdebe14-24d0-4bb0-836b-2c88aec8e4ba	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_view-events}	view-events	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
77d7cec1-5c22-4557-9285-b1137acf3669	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_view-identity-providers}	view-identity-providers	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
8729e4f3-c688-40dd-a854-68e6a312cf16	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_view-authorization}	view-authorization	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
36acf303-dc14-49cd-9e7d-04f0b62a763a	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_manage-realm}	manage-realm	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
be24c5ca-b8bd-4cfa-9acf-a6c0e3d707e1	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_manage-users}	manage-users	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
f4d193a3-c328-4157-94f1-9f52af0d8ec8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_manage-clients}	manage-clients	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
9940943b-b043-43d7-90d3-d059405c53d7	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_manage-events}	manage-events	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
b1ec01ec-f1b3-4ee2-81f2-c4734cd1cbe1	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_manage-identity-providers}	manage-identity-providers	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
6f5d1944-ef65-4ef6-a5f0-e1702c61eb53	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_manage-authorization}	manage-authorization	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
537cdfaa-873f-4b12-a745-3837a112f1bf	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_query-users}	query-users	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
aeb14708-76a0-498b-83e7-c45fde8790f2	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_query-clients}	query-clients	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
a634b55d-c203-488c-bfd5-72f39b5e39a0	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_query-realms}	query-realms	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
0403bb63-f2b8-4674-b1d5-953f8b3eaee0	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_query-groups}	query-groups	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
ed45a7af-95bd-418f-88e0-7f025794ac6c	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_view-profile}	view-profile	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
63db14c7-5fcb-4fa8-b001-6dc6d4e8fbb4	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_manage-account}	manage-account	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
07563990-f268-492d-87f7-7a9a2a8fa8c6	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_manage-account-links}	manage-account-links	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
e34275e5-e8ef-424f-8109-f53101b5cce9	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_view-applications}	view-applications	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
0bf3e687-73b5-463f-b5bc-5970f5431d58	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_view-consent}	view-consent	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
27914180-d217-4654-9006-aa08ca2e94be	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_manage-consent}	manage-consent	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
7d305868-0e2d-4a43-b5aa-49793b95b61e	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_view-groups}	view-groups	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
69da6681-6344-4d8e-93da-87f5e670ca6f	47781dd4-1c7c-46c6-a72e-4085b615aa52	t	${role_delete-account}	delete-account	64844e83-205d-4ee5-b5f1-c772a9c661f8	47781dd4-1c7c-46c6-a72e-4085b615aa52	\N
bb8773ac-8e5e-47ef-9daf-7101813588b9	4305df09-58f6-496d-a903-b1ed8ba220a5	t	${role_read-token}	read-token	64844e83-205d-4ee5-b5f1-c772a9c661f8	4305df09-58f6-496d-a903-b1ed8ba220a5	\N
ec76ddc4-35b1-4ece-bf55-b71534bd9930	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	t	${role_impersonation}	impersonation	64844e83-205d-4ee5-b5f1-c772a9c661f8	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	\N
114d4082-15ee-4adc-af40-8579e85415ec	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	${role_offline-access}	offline_access	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N	\N
c32fc887-304b-4c25-9938-be3737b3fb09	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	${role_uma_authorization}	uma_authorization	64844e83-205d-4ee5-b5f1-c772a9c661f8	\N	\N
f084e403-d707-4a59-84b4-6ca6b024e4e2	79297412-b299-4def-8f42-bd61d963bfcc	f	${role_default-roles}	default-roles-erp docs	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
4413aeab-012a-45ef-85ef-80a8bf6c71bc	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_create-client}	create-client	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
1551f71c-311a-465f-837d-18573f329eae	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_view-realm}	view-realm	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
33540733-74f0-49ec-892c-9f91cb588a03	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_view-users}	view-users	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
5ecbbaa5-fcbd-4222-ba63-81c16b67275f	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_view-clients}	view-clients	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
f8fc362d-2afe-41af-8400-e04dabe09a6e	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_view-events}	view-events	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
b6d99a87-bf3e-478e-b2fe-5b47bf8b00ca	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_view-identity-providers}	view-identity-providers	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
0d9bb9b5-bbfd-4c3a-8c4a-930b02c82a87	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_view-authorization}	view-authorization	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
b2113623-bc1b-4c5c-a7d5-ef545b0bdfdf	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_manage-realm}	manage-realm	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
7bd7d695-55ea-49e1-93a7-fcdb10c0666d	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_manage-users}	manage-users	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
10ae3595-da12-44b8-b64a-e46365548ffb	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_manage-clients}	manage-clients	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
74a611f3-98c3-4e4b-90f8-2b2e04710531	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_manage-events}	manage-events	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
2b227f5a-7cd1-4add-a98f-1a9be8974048	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_manage-identity-providers}	manage-identity-providers	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
47b66d5e-b3d6-4df7-8d2e-102bd1951d24	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_manage-authorization}	manage-authorization	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
54b6a13d-933b-46ba-b49b-0b01256c5597	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_query-users}	query-users	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
f5d81d30-6393-4c80-b721-7ba7b8c51b10	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_query-clients}	query-clients	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
21a1b92e-6641-4bc1-a4b7-e65a1d615ea9	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_query-realms}	query-realms	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
a122f522-610f-4761-b7f8-9fbe3c7c60a7	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_query-groups}	query-groups	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
4a1b5a77-f9ad-4fd2-8690-2bf85c23e92c	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_realm-admin}	realm-admin	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
96a38c98-6c33-4d16-9c83-d951c05e35a9	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_create-client}	create-client	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
bcbddb35-f1d1-49dd-bfcb-a7097c13fdb3	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_view-realm}	view-realm	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
18d29418-b9c0-4586-9a93-384354133ea5	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_view-users}	view-users	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
952c44b0-7fbe-4a2d-a5b0-4b0e62bd78e8	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_view-clients}	view-clients	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
aaf1eafd-e5df-4a78-af8d-c917b70e5297	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_view-events}	view-events	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
0d3c8761-02fc-4721-b98b-2e01a19fa2bb	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_view-identity-providers}	view-identity-providers	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
e0bc8a7f-0745-4138-82fe-17fec39fcd01	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_view-authorization}	view-authorization	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
556ef25c-4da0-46e2-af67-2a410cda31e5	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_manage-realm}	manage-realm	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
e776355c-b922-4f20-b110-3052f102fe80	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_manage-users}	manage-users	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
73e50afd-8356-400c-b4da-b2251ebb5207	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_manage-clients}	manage-clients	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
0fce3c74-eb08-4c43-9d17-fdac53e611f8	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_manage-events}	manage-events	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
2caee4c8-4155-4678-b7fe-9f8f07960a8b	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > customer-relationship-management	docs:customer-relationship-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
ae4a2fd3-ece3-483f-9185-99ea620b87d2	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > data-importation	docs:data-importation	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
30f9f7dd-2604-458f-8ed3-a151e17c546b	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_manage-identity-providers}	manage-identity-providers	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
828f4b8e-c5dd-4d31-8a73-679a356a39d6	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_manage-authorization}	manage-authorization	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
f862221f-ac51-43ef-ad80-01db23d33d64	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_query-users}	query-users	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
dd126a95-bf58-48ea-a55a-5c9a0d1e1201	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_query-clients}	query-clients	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
b8ca8ada-09ff-4968-9f6e-878d1568375f	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_query-realms}	query-realms	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
899fbe70-6997-492b-bfc4-a86612ae2974	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_query-groups}	query-groups	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
d3696c80-2551-438d-bd13-373950d38800	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_view-profile}	view-profile	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
bbe21213-ba49-4592-ae98-61394376dd5c	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_manage-account}	manage-account	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
98d6327a-18dc-426c-8cf6-dbc99e575184	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_manage-account-links}	manage-account-links	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
a66f253a-7002-4ffb-ac9c-903a0bf34522	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_view-applications}	view-applications	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
f540ccdf-eacc-4da1-8720-522dc54f6aef	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_view-consent}	view-consent	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
2b1f311b-2725-4340-921f-6fe9de7a6383	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_manage-consent}	manage-consent	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
89f0933a-2599-4dc0-860e-d4a798700f7f	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_view-groups}	view-groups	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
fc2372c5-ba1a-4088-8bbc-4e8bba3716f9	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	t	${role_delete-account}	delete-account	79297412-b299-4def-8f42-bd61d963bfcc	9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	\N
d0973e7d-1376-411b-9a1c-0f35475e35f6	ca7d86ad-b054-407e-8555-e983242f27a4	t	${role_impersonation}	impersonation	64844e83-205d-4ee5-b5f1-c772a9c661f8	ca7d86ad-b054-407e-8555-e983242f27a4	\N
b7b076f7-2bae-48cb-935d-7aa325934d54	a6c42ac8-f0cd-429e-972d-99424a49c65a	t	${role_impersonation}	impersonation	79297412-b299-4def-8f42-bd61d963bfcc	a6c42ac8-f0cd-429e-972d-99424a49c65a	\N
8feebcfc-447d-494e-a47a-5ba6cb8b116e	b4c68130-8e0d-4cb7-88d4-8b187e2039e0	t	${role_read-token}	read-token	79297412-b299-4def-8f42-bd61d963bfcc	b4c68130-8e0d-4cb7-88d4-8b187e2039e0	\N
195b1b2a-fb84-4b4b-a143-0cdf2d3f280d	79297412-b299-4def-8f42-bd61d963bfcc	f	${role_offline-access}	offline_access	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
0c369ff5-569d-4fc1-a22f-98c4ccb939ee	79297412-b299-4def-8f42-bd61d963bfcc	f	${role_uma_authorization}	uma_authorization	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
bcdc2390-9107-4d4f-ac8e-d478c29e6e13	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > about	docs:about	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
7ef241dc-fe68-4485-ba64-ee8dcb19cee7	79297412-b299-4def-8f42-bd61d963bfcc	f		docs:accounting-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
fccb39d9-6e03-4d2b-be0e-b49a69bba49c	79297412-b299-4def-8f42-bd61d963bfcc	f		docs	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
07836609-062e-4683-bd36-4f8ed0e8f38c	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > asset-management	docs:asset-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
20139c58-92cc-47db-89de-b27ae5057ba7	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > balance-management	docs:balance-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
451c3310-a44b-4a0a-9f31-24a0f518fed8	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > basic-rules	docs:basic-rules	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
8cb015d6-2efa-411c-a26e-9f0b40a52a83	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > community	docs:community	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
da6f2399-f918-4302-bc64-72797f904b03	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > devices	docs:devices	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
a78bd2b5-68af-4fec-b576-fe6264825db3	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > distribution-management	docs:distribution-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
e4f00396-d68f-47dc-a15f-98e6fa1af24f	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > downloads	docs:downloads	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
f33125b5-491c-4969-977f-01838c125916	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > return-management	docs:return-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
93e63f4c-878b-4282-93b0-3a6bf1a44eee	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > human-management	docs:human-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
467d14c0-e681-4bec-a4ca-787539b2fcb0	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > index	docs:index	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
e48d491f-848c-4da9-af8d-2ddfb69be280	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > lve	docs:lve	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
c6d826bc-199e-4302-bcf8-cb68f6b47c86	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > master-data	docs:master-data	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
c35f11e2-c4c1-4e1d-9e8a-33e863d4d7e7	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > material-management	docs:material-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
8d8fd701-d0f0-4bab-a4d0-a0cf16112356	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > meta.json	docs:meta.json	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
e132ed94-f0a1-49ef-9f9b-92755bbbf7fd	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > other-process	docs:other-process	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
98eff7a2-8d12-4d37-8abf-1b309a673472	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > pdv-management	docs:pdv-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
9fb4c91e-23be-4846-8d1b-3e31313cf4df	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > product	docs:product	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
f5c40d62-a6e7-43a2-b33c-dffeae0f7ef0	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > production-management	docs:production-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
252c7bb3-d933-41bc-8e85-e02368c98b71	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > purchase-management	docs:purchase-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
ba42e993-b497-46be-9d02-7bfb22bbe65a	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > sales-management	docs:sales-management	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
9d494452-b03d-4a3d-b907-3e8da9641710	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: docs > verticals	docs:verticals	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
3b561dea-756a-47aa-86e4-a486ca2f3551	79297412-b299-4def-8f42-bd61d963bfcc	f	Rol automático para acceso a: admin	admin	79297412-b299-4def-8f42-bd61d963bfcc	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ifu1z	26.6.1	1778090226
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version, realm_id) FROM stdin;
0Ha1KnkClw_bONBTMgfjCymP	78d20a38-d3ed-4288-aadd-603f9573972d	0	1778178740	{"authMethod":"openid-connect","redirectUri":"http://localhost:8080/admin/master/console/","notes":{"clientId":"78d20a38-d3ed-4288-aadd-603f9573972d","iss":"http://localhost:8080/realms/master","startedAt":"1778178739","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"0aaa563f-b386-48ef-b4ef-fa6ef0b41ce1","response_mode":"query","scope":"openid","userSessionStartedAt":"1778178739","redirect_uri":"http://localhost:8080/admin/master/console/","state":"0d97fe15-9d48-4878-b66d-4697d1a61cf9","code_challenge":"k3_umSAl4ML3-Vesbm_j_f5lGCJ5kJBX-CF15MrF9qc"}}	local	local	1	64844e83-205d-4ee5-b5f1-c772a9c661f8
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version, remember_me) FROM stdin;
0Ha1KnkClw_bONBTMgfjCymP	66940bd6-e40f-4f51-92c7-a07f7651e845	64844e83-205d-4ee5-b5f1-c772a9c661f8	1778178739	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiQ2hyb21lLzE0Ny4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1778178739","authenticators-completed":"{\\"1bd23afe-8cac-4860-8207-950d31301f90\\":1778178739}"},"state":"LOGGED_IN"}	1778178740	\N	1	f
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: org_invitation; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org_invitation (id, organization_id, email, first_name, last_name, created_at, expires_at, invite_link) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
0a6e2a24-ddbd-4f6f-b564-e7d20b63add3	audience resolve	openid-connect	oidc-audience-resolve-mapper	a9cb6269-7671-47ec-a87f-a1380eaa284a	\N
e56489b5-3b11-46ca-8ec7-828def8d3ed9	locale	openid-connect	oidc-usermodel-attribute-mapper	78d20a38-d3ed-4288-aadd-603f9573972d	\N
bafc558d-03c1-4e1e-a063-b900a3b40135	role list	saml	saml-role-list-mapper	\N	7ee13054-4969-4dcd-ab30-84e6cdbf2902
554c08fd-0665-4b6c-a7d3-741c5c88758e	organization	saml	saml-organization-membership-mapper	\N	01af7c6b-dbc7-46b7-989a-e6798382d99e
0fc14166-7150-4554-b334-08c29e90ef0a	full name	openid-connect	oidc-full-name-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
852d4886-fc1f-4c35-8173-ac4d843f3fab	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
84d6927c-3e33-47cd-b32b-59db5eeebc33	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
8d628cb3-28f3-43fe-86b0-032c5e9340ed	username	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
8c663408-a096-42b9-9809-448703c61df3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
c503130d-c974-4782-bb90-c7129a72971c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	website	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
542d0fde-ba22-4296-a216-6f2f835510af	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
1d7b927f-89de-4c6e-aff8-31c0a7e77736	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
25235eb2-c9c5-407d-8485-5fd1784daa21	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	7e3e2b04-4f76-4a2e-9946-3bc924b24f2f
61e14c9b-6860-4831-ae9a-7f5fec23e14c	email	openid-connect	oidc-usermodel-attribute-mapper	\N	41f2aded-a5c1-4719-89f0-8ea93c11bcad
6cb1e3a1-61c6-4548-b880-bd709a42a48e	email verified	openid-connect	oidc-usermodel-property-mapper	\N	41f2aded-a5c1-4719-89f0-8ea93c11bcad
db09908d-fc7c-4112-adf6-6fec82db122e	address	openid-connect	oidc-address-mapper	\N	c225ec8c-ba10-4cbd-8049-46b77fe6cd63
41225806-bae8-47ef-ad8f-8cc950e49803	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c86e7f25-09ec-4d99-8c8c-533acbb19a35
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c86e7f25-09ec-4d99-8c8c-533acbb19a35
80e0190e-1623-4b5b-9767-435488c52b72	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	d68c7a69-91db-4046-b9e2-72b9bcdaa797
4d88b617-5727-49b4-a82e-6468831841ac	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	d68c7a69-91db-4046-b9e2-72b9bcdaa797
1c095a25-5b44-47b5-b146-1b9e7e1d163d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	d68c7a69-91db-4046-b9e2-72b9bcdaa797
64fac249-346a-4d45-8ac6-02a25c13b00d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	78e66a1e-2847-49cc-871c-d15bb8de84ac
0f139294-067c-4bca-8f3b-25d738bf1f3d	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	ed999954-01f1-447d-b6a7-bdb76c76d3e8
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	ed999954-01f1-447d-b6a7-bdb76c76d3e8
e1477ed7-59b5-4362-8370-6252b35d23ac	acr loa level	openid-connect	oidc-acr-mapper	\N	cb42a537-e158-42ed-b65b-b5464139507b
da5982a2-2138-4bf2-b5e8-4e216a2aa06b	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	ac27bead-1410-449f-a23a-fa1cb0b56fe6
6709e9e6-a7a5-4cfd-bacc-392e70f38737	sub	openid-connect	oidc-sub-mapper	\N	ac27bead-1410-449f-a23a-fa1cb0b56fe6
0aed91ea-07a9-451d-bca3-646cf889a6b2	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	f3f394ff-9ecd-457d-ab77-950eddadcc55
cba99687-0059-4651-9936-e39bd8e1a0fd	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	f3f394ff-9ecd-457d-ab77-950eddadcc55
f53902de-4c19-47e7-b5af-0f461e7d0611	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	f3f394ff-9ecd-457d-ab77-950eddadcc55
867027fc-50a3-4879-bcbb-1be43f7969c3	organization	openid-connect	oidc-organization-membership-mapper	\N	8613e35b-b0cc-47a7-b034-6c8bb56f5baa
b3e4b6b5-97b5-4668-91b6-ee594719dff1	audience resolve	openid-connect	oidc-audience-resolve-mapper	ee333356-91c4-47f1-97b3-6481a7351eba	\N
83274a05-e76c-4dec-ad70-b031bda1b312	role list	saml	saml-role-list-mapper	\N	c2455068-1470-4d72-836f-21fd26444b16
dd62144e-5877-404b-9b5a-6ea51ad50c57	organization	saml	saml-organization-membership-mapper	\N	b9064254-6342-4706-bfe2-970db58c9e6f
ebddac27-75d6-4a98-ac2b-8209152d385d	full name	openid-connect	oidc-full-name-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
dec90f59-e719-4fb9-b85c-bc52a08dd893	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
198eca17-2c28-4d1b-b5a9-197e90107da3	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
a7988929-2459-42cb-8fa9-a1c6417eaef5	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
e5ed8c9b-033f-48a0-8191-5daa53380fae	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
cfecb699-0a14-47c6-a9a9-64edb72b2d03	username	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
44ba981d-7020-4de0-af40-0f65882bb978	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
d9714792-6f4e-45ab-84aa-5b84430c110f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
8b9e895b-5a94-4467-ae96-982b46bba51a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
fa747f18-c550-47b4-949f-e7cc42d43c11	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
d603f8e6-a717-42d1-a49b-4c5cc9014a52	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
4deb6c68-edce-4879-806d-b4b900b5c53a	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
8789c506-5841-435d-8139-7a0543125379	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	cd032659-64aa-4d04-b956-a84eee2acd04
78983881-a37f-448f-879b-e6f01eb96e0b	email	openid-connect	oidc-usermodel-attribute-mapper	\N	cc28f67d-7f95-4d7c-8c4b-807bab00bbef
9f6ee589-2390-4275-ba46-9cf65547b357	email verified	openid-connect	oidc-usermodel-property-mapper	\N	cc28f67d-7f95-4d7c-8c4b-807bab00bbef
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	address	openid-connect	oidc-address-mapper	\N	32b3b9a2-8950-4bda-ab9b-07e22cf11015
1e88162e-b32b-4206-9346-f90789ec4abf	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	3818eb2b-f515-431a-857d-decfa1190c9d
2ffedf64-ba5f-4623-acaa-bbcba1155edb	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	3818eb2b-f515-431a-857d-decfa1190c9d
9605156b-111f-41ae-aad6-6503df094350	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	81e1d7f0-701a-417d-9080-bdb3010ddbe6
e3f40368-9dfa-4bed-81fc-ab08bd0636c1	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	81e1d7f0-701a-417d-9080-bdb3010ddbe6
f14abbd2-6367-46b5-9dc1-e8111f577c06	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	81e1d7f0-701a-417d-9080-bdb3010ddbe6
0e2c4259-2cdc-4ccb-9ac3-623c397988a1	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e3206a3f-df98-4b61-8620-95afabdae202
55c6ba1e-a08e-46f1-8e74-d94721221f4f	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	fc38610d-6445-44c5-a6cf-f1fc141b69c6
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	fc38610d-6445-44c5-a6cf-f1fc141b69c6
2687d1f3-d726-4964-8eed-201847a7f1ab	acr loa level	openid-connect	oidc-acr-mapper	\N	433e367b-5cc4-4861-af47-3cf6761a7f83
5a764b5d-11fb-4612-9fab-9f0aa821d0aa	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	76c794a6-a6b0-4944-829b-65a10c530dd9
155536d7-dfb8-4395-9a14-577a3460268d	sub	openid-connect	oidc-sub-mapper	\N	76c794a6-a6b0-4944-829b-65a10c530dd9
7b664b30-6d91-4e6f-a348-393a65608d56	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	e42d94d3-4600-4208-b9f8-049f7394c433
67de238b-8792-4c85-ae00-ce457478e1af	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	e42d94d3-4600-4208-b9f8-049f7394c433
5c2321fb-ef9e-4e90-ad91-444de8323f79	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	e42d94d3-4600-4208-b9f8-049f7394c433
bf393094-b755-4258-8ace-ccf4f9c47d61	organization	openid-connect	oidc-organization-membership-mapper	\N	ecb664f7-89be-45fb-92f4-80ff7d307b48
e9395691-846c-44f5-b1f5-c465e18eedc4	locale	openid-connect	oidc-usermodel-attribute-mapper	4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	\N
99821b27-dd62-48c0-9b3d-3bfe19f03e15	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
e56489b5-3b11-46ca-8ec7-828def8d3ed9	true	introspection.token.claim
e56489b5-3b11-46ca-8ec7-828def8d3ed9	true	userinfo.token.claim
e56489b5-3b11-46ca-8ec7-828def8d3ed9	locale	user.attribute
e56489b5-3b11-46ca-8ec7-828def8d3ed9	true	id.token.claim
e56489b5-3b11-46ca-8ec7-828def8d3ed9	true	access.token.claim
e56489b5-3b11-46ca-8ec7-828def8d3ed9	locale	claim.name
e56489b5-3b11-46ca-8ec7-828def8d3ed9	String	jsonType.label
bafc558d-03c1-4e1e-a063-b900a3b40135	false	single
bafc558d-03c1-4e1e-a063-b900a3b40135	Basic	attribute.nameformat
bafc558d-03c1-4e1e-a063-b900a3b40135	Role	attribute.name
0fc14166-7150-4554-b334-08c29e90ef0a	true	introspection.token.claim
0fc14166-7150-4554-b334-08c29e90ef0a	true	userinfo.token.claim
0fc14166-7150-4554-b334-08c29e90ef0a	true	id.token.claim
0fc14166-7150-4554-b334-08c29e90ef0a	true	access.token.claim
1d7b927f-89de-4c6e-aff8-31c0a7e77736	true	introspection.token.claim
1d7b927f-89de-4c6e-aff8-31c0a7e77736	true	userinfo.token.claim
1d7b927f-89de-4c6e-aff8-31c0a7e77736	locale	user.attribute
1d7b927f-89de-4c6e-aff8-31c0a7e77736	true	id.token.claim
1d7b927f-89de-4c6e-aff8-31c0a7e77736	true	access.token.claim
1d7b927f-89de-4c6e-aff8-31c0a7e77736	locale	claim.name
1d7b927f-89de-4c6e-aff8-31c0a7e77736	String	jsonType.label
25235eb2-c9c5-407d-8485-5fd1784daa21	true	introspection.token.claim
25235eb2-c9c5-407d-8485-5fd1784daa21	true	userinfo.token.claim
25235eb2-c9c5-407d-8485-5fd1784daa21	updatedAt	user.attribute
25235eb2-c9c5-407d-8485-5fd1784daa21	true	id.token.claim
25235eb2-c9c5-407d-8485-5fd1784daa21	true	access.token.claim
25235eb2-c9c5-407d-8485-5fd1784daa21	updated_at	claim.name
25235eb2-c9c5-407d-8485-5fd1784daa21	long	jsonType.label
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	true	introspection.token.claim
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	true	userinfo.token.claim
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	birthdate	user.attribute
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	true	id.token.claim
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	true	access.token.claim
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	birthdate	claim.name
467bb0b8-96ca-4003-9319-9d6bc1c54f0b	String	jsonType.label
542d0fde-ba22-4296-a216-6f2f835510af	true	introspection.token.claim
542d0fde-ba22-4296-a216-6f2f835510af	true	userinfo.token.claim
542d0fde-ba22-4296-a216-6f2f835510af	zoneinfo	user.attribute
542d0fde-ba22-4296-a216-6f2f835510af	true	id.token.claim
542d0fde-ba22-4296-a216-6f2f835510af	true	access.token.claim
542d0fde-ba22-4296-a216-6f2f835510af	zoneinfo	claim.name
542d0fde-ba22-4296-a216-6f2f835510af	String	jsonType.label
84d6927c-3e33-47cd-b32b-59db5eeebc33	true	introspection.token.claim
84d6927c-3e33-47cd-b32b-59db5eeebc33	true	userinfo.token.claim
84d6927c-3e33-47cd-b32b-59db5eeebc33	nickname	user.attribute
84d6927c-3e33-47cd-b32b-59db5eeebc33	true	id.token.claim
84d6927c-3e33-47cd-b32b-59db5eeebc33	true	access.token.claim
84d6927c-3e33-47cd-b32b-59db5eeebc33	nickname	claim.name
84d6927c-3e33-47cd-b32b-59db5eeebc33	String	jsonType.label
852d4886-fc1f-4c35-8173-ac4d843f3fab	true	introspection.token.claim
852d4886-fc1f-4c35-8173-ac4d843f3fab	true	userinfo.token.claim
852d4886-fc1f-4c35-8173-ac4d843f3fab	lastName	user.attribute
852d4886-fc1f-4c35-8173-ac4d843f3fab	true	id.token.claim
852d4886-fc1f-4c35-8173-ac4d843f3fab	true	access.token.claim
852d4886-fc1f-4c35-8173-ac4d843f3fab	family_name	claim.name
852d4886-fc1f-4c35-8173-ac4d843f3fab	String	jsonType.label
8c663408-a096-42b9-9809-448703c61df3	true	introspection.token.claim
8c663408-a096-42b9-9809-448703c61df3	true	userinfo.token.claim
8c663408-a096-42b9-9809-448703c61df3	profile	user.attribute
8c663408-a096-42b9-9809-448703c61df3	true	id.token.claim
8c663408-a096-42b9-9809-448703c61df3	true	access.token.claim
8c663408-a096-42b9-9809-448703c61df3	profile	claim.name
8c663408-a096-42b9-9809-448703c61df3	String	jsonType.label
8d628cb3-28f3-43fe-86b0-032c5e9340ed	true	introspection.token.claim
8d628cb3-28f3-43fe-86b0-032c5e9340ed	true	userinfo.token.claim
8d628cb3-28f3-43fe-86b0-032c5e9340ed	username	user.attribute
8d628cb3-28f3-43fe-86b0-032c5e9340ed	true	id.token.claim
8d628cb3-28f3-43fe-86b0-032c5e9340ed	true	access.token.claim
8d628cb3-28f3-43fe-86b0-032c5e9340ed	preferred_username	claim.name
8d628cb3-28f3-43fe-86b0-032c5e9340ed	String	jsonType.label
c503130d-c974-4782-bb90-c7129a72971c	true	introspection.token.claim
c503130d-c974-4782-bb90-c7129a72971c	true	userinfo.token.claim
c503130d-c974-4782-bb90-c7129a72971c	picture	user.attribute
c503130d-c974-4782-bb90-c7129a72971c	true	id.token.claim
c503130d-c974-4782-bb90-c7129a72971c	true	access.token.claim
c503130d-c974-4782-bb90-c7129a72971c	picture	claim.name
c503130d-c974-4782-bb90-c7129a72971c	String	jsonType.label
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	true	introspection.token.claim
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	true	userinfo.token.claim
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	website	user.attribute
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	true	id.token.claim
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	true	access.token.claim
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	website	claim.name
c9a57a0e-cbaa-4d81-bb9d-630b5a524fdb	String	jsonType.label
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	true	introspection.token.claim
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	true	userinfo.token.claim
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	firstName	user.attribute
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	true	id.token.claim
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	true	access.token.claim
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	given_name	claim.name
e3dffc77-72f4-4458-b1c6-f4fb7b4162fd	String	jsonType.label
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	true	introspection.token.claim
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	true	userinfo.token.claim
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	middleName	user.attribute
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	true	id.token.claim
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	true	access.token.claim
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	middle_name	claim.name
f1abdc6f-fb73-4001-b1e2-2a74d67f9ee5	String	jsonType.label
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	true	introspection.token.claim
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	true	userinfo.token.claim
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	gender	user.attribute
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	true	id.token.claim
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	true	access.token.claim
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	gender	claim.name
ff191b3e-45ea-4f97-a1bf-ae00ab70ddc8	String	jsonType.label
61e14c9b-6860-4831-ae9a-7f5fec23e14c	true	introspection.token.claim
61e14c9b-6860-4831-ae9a-7f5fec23e14c	true	userinfo.token.claim
61e14c9b-6860-4831-ae9a-7f5fec23e14c	email	user.attribute
61e14c9b-6860-4831-ae9a-7f5fec23e14c	true	id.token.claim
61e14c9b-6860-4831-ae9a-7f5fec23e14c	true	access.token.claim
61e14c9b-6860-4831-ae9a-7f5fec23e14c	email	claim.name
61e14c9b-6860-4831-ae9a-7f5fec23e14c	String	jsonType.label
6cb1e3a1-61c6-4548-b880-bd709a42a48e	true	introspection.token.claim
6cb1e3a1-61c6-4548-b880-bd709a42a48e	true	userinfo.token.claim
6cb1e3a1-61c6-4548-b880-bd709a42a48e	emailVerified	user.attribute
6cb1e3a1-61c6-4548-b880-bd709a42a48e	true	id.token.claim
6cb1e3a1-61c6-4548-b880-bd709a42a48e	true	access.token.claim
6cb1e3a1-61c6-4548-b880-bd709a42a48e	email_verified	claim.name
6cb1e3a1-61c6-4548-b880-bd709a42a48e	boolean	jsonType.label
db09908d-fc7c-4112-adf6-6fec82db122e	formatted	user.attribute.formatted
db09908d-fc7c-4112-adf6-6fec82db122e	country	user.attribute.country
db09908d-fc7c-4112-adf6-6fec82db122e	true	introspection.token.claim
db09908d-fc7c-4112-adf6-6fec82db122e	postal_code	user.attribute.postal_code
db09908d-fc7c-4112-adf6-6fec82db122e	true	userinfo.token.claim
db09908d-fc7c-4112-adf6-6fec82db122e	street	user.attribute.street
db09908d-fc7c-4112-adf6-6fec82db122e	true	id.token.claim
db09908d-fc7c-4112-adf6-6fec82db122e	region	user.attribute.region
db09908d-fc7c-4112-adf6-6fec82db122e	true	access.token.claim
db09908d-fc7c-4112-adf6-6fec82db122e	locality	user.attribute.locality
41225806-bae8-47ef-ad8f-8cc950e49803	true	introspection.token.claim
41225806-bae8-47ef-ad8f-8cc950e49803	true	userinfo.token.claim
41225806-bae8-47ef-ad8f-8cc950e49803	phoneNumber	user.attribute
41225806-bae8-47ef-ad8f-8cc950e49803	true	id.token.claim
41225806-bae8-47ef-ad8f-8cc950e49803	true	access.token.claim
41225806-bae8-47ef-ad8f-8cc950e49803	phone_number	claim.name
41225806-bae8-47ef-ad8f-8cc950e49803	String	jsonType.label
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	true	introspection.token.claim
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	true	userinfo.token.claim
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	phoneNumberVerified	user.attribute
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	true	id.token.claim
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	true	access.token.claim
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	phone_number_verified	claim.name
9ab745f9-2f66-41ba-95d8-d8beb37bdd96	boolean	jsonType.label
1c095a25-5b44-47b5-b146-1b9e7e1d163d	true	introspection.token.claim
1c095a25-5b44-47b5-b146-1b9e7e1d163d	true	access.token.claim
4d88b617-5727-49b4-a82e-6468831841ac	true	introspection.token.claim
4d88b617-5727-49b4-a82e-6468831841ac	true	multivalued
4d88b617-5727-49b4-a82e-6468831841ac	foo	user.attribute
4d88b617-5727-49b4-a82e-6468831841ac	true	access.token.claim
4d88b617-5727-49b4-a82e-6468831841ac	resource_access.${client_id}.roles	claim.name
4d88b617-5727-49b4-a82e-6468831841ac	String	jsonType.label
80e0190e-1623-4b5b-9767-435488c52b72	true	introspection.token.claim
80e0190e-1623-4b5b-9767-435488c52b72	true	multivalued
80e0190e-1623-4b5b-9767-435488c52b72	foo	user.attribute
80e0190e-1623-4b5b-9767-435488c52b72	true	access.token.claim
80e0190e-1623-4b5b-9767-435488c52b72	realm_access.roles	claim.name
80e0190e-1623-4b5b-9767-435488c52b72	String	jsonType.label
64fac249-346a-4d45-8ac6-02a25c13b00d	true	introspection.token.claim
64fac249-346a-4d45-8ac6-02a25c13b00d	true	access.token.claim
0f139294-067c-4bca-8f3b-25d738bf1f3d	true	introspection.token.claim
0f139294-067c-4bca-8f3b-25d738bf1f3d	true	userinfo.token.claim
0f139294-067c-4bca-8f3b-25d738bf1f3d	username	user.attribute
0f139294-067c-4bca-8f3b-25d738bf1f3d	true	id.token.claim
0f139294-067c-4bca-8f3b-25d738bf1f3d	true	access.token.claim
0f139294-067c-4bca-8f3b-25d738bf1f3d	upn	claim.name
0f139294-067c-4bca-8f3b-25d738bf1f3d	String	jsonType.label
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	true	introspection.token.claim
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	true	multivalued
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	foo	user.attribute
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	true	id.token.claim
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	true	access.token.claim
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	groups	claim.name
e7e4ee7b-8716-4f3f-a1ce-94e67b1684c1	String	jsonType.label
e1477ed7-59b5-4362-8370-6252b35d23ac	true	introspection.token.claim
e1477ed7-59b5-4362-8370-6252b35d23ac	true	id.token.claim
e1477ed7-59b5-4362-8370-6252b35d23ac	true	access.token.claim
6709e9e6-a7a5-4cfd-bacc-392e70f38737	true	introspection.token.claim
6709e9e6-a7a5-4cfd-bacc-392e70f38737	true	access.token.claim
da5982a2-2138-4bf2-b5e8-4e216a2aa06b	AUTH_TIME	user.session.note
da5982a2-2138-4bf2-b5e8-4e216a2aa06b	true	introspection.token.claim
da5982a2-2138-4bf2-b5e8-4e216a2aa06b	true	id.token.claim
da5982a2-2138-4bf2-b5e8-4e216a2aa06b	true	access.token.claim
da5982a2-2138-4bf2-b5e8-4e216a2aa06b	auth_time	claim.name
da5982a2-2138-4bf2-b5e8-4e216a2aa06b	long	jsonType.label
0aed91ea-07a9-451d-bca3-646cf889a6b2	client_id	user.session.note
0aed91ea-07a9-451d-bca3-646cf889a6b2	true	introspection.token.claim
0aed91ea-07a9-451d-bca3-646cf889a6b2	true	id.token.claim
0aed91ea-07a9-451d-bca3-646cf889a6b2	true	access.token.claim
0aed91ea-07a9-451d-bca3-646cf889a6b2	client_id	claim.name
0aed91ea-07a9-451d-bca3-646cf889a6b2	String	jsonType.label
cba99687-0059-4651-9936-e39bd8e1a0fd	clientHost	user.session.note
cba99687-0059-4651-9936-e39bd8e1a0fd	true	introspection.token.claim
cba99687-0059-4651-9936-e39bd8e1a0fd	true	id.token.claim
cba99687-0059-4651-9936-e39bd8e1a0fd	true	access.token.claim
cba99687-0059-4651-9936-e39bd8e1a0fd	clientHost	claim.name
cba99687-0059-4651-9936-e39bd8e1a0fd	String	jsonType.label
f53902de-4c19-47e7-b5af-0f461e7d0611	clientAddress	user.session.note
f53902de-4c19-47e7-b5af-0f461e7d0611	true	introspection.token.claim
f53902de-4c19-47e7-b5af-0f461e7d0611	true	id.token.claim
f53902de-4c19-47e7-b5af-0f461e7d0611	true	access.token.claim
f53902de-4c19-47e7-b5af-0f461e7d0611	clientAddress	claim.name
f53902de-4c19-47e7-b5af-0f461e7d0611	String	jsonType.label
867027fc-50a3-4879-bcbb-1be43f7969c3	true	introspection.token.claim
867027fc-50a3-4879-bcbb-1be43f7969c3	true	multivalued
867027fc-50a3-4879-bcbb-1be43f7969c3	true	id.token.claim
867027fc-50a3-4879-bcbb-1be43f7969c3	true	access.token.claim
867027fc-50a3-4879-bcbb-1be43f7969c3	organization	claim.name
867027fc-50a3-4879-bcbb-1be43f7969c3	String	jsonType.label
83274a05-e76c-4dec-ad70-b031bda1b312	false	single
83274a05-e76c-4dec-ad70-b031bda1b312	Basic	attribute.nameformat
83274a05-e76c-4dec-ad70-b031bda1b312	Role	attribute.name
198eca17-2c28-4d1b-b5a9-197e90107da3	true	introspection.token.claim
198eca17-2c28-4d1b-b5a9-197e90107da3	true	userinfo.token.claim
198eca17-2c28-4d1b-b5a9-197e90107da3	firstName	user.attribute
198eca17-2c28-4d1b-b5a9-197e90107da3	true	id.token.claim
198eca17-2c28-4d1b-b5a9-197e90107da3	true	access.token.claim
198eca17-2c28-4d1b-b5a9-197e90107da3	given_name	claim.name
198eca17-2c28-4d1b-b5a9-197e90107da3	String	jsonType.label
44ba981d-7020-4de0-af40-0f65882bb978	true	introspection.token.claim
44ba981d-7020-4de0-af40-0f65882bb978	true	userinfo.token.claim
44ba981d-7020-4de0-af40-0f65882bb978	profile	user.attribute
44ba981d-7020-4de0-af40-0f65882bb978	true	id.token.claim
44ba981d-7020-4de0-af40-0f65882bb978	true	access.token.claim
44ba981d-7020-4de0-af40-0f65882bb978	profile	claim.name
44ba981d-7020-4de0-af40-0f65882bb978	String	jsonType.label
4deb6c68-edce-4879-806d-b4b900b5c53a	true	introspection.token.claim
4deb6c68-edce-4879-806d-b4b900b5c53a	true	userinfo.token.claim
4deb6c68-edce-4879-806d-b4b900b5c53a	zoneinfo	user.attribute
4deb6c68-edce-4879-806d-b4b900b5c53a	true	id.token.claim
4deb6c68-edce-4879-806d-b4b900b5c53a	true	access.token.claim
4deb6c68-edce-4879-806d-b4b900b5c53a	zoneinfo	claim.name
4deb6c68-edce-4879-806d-b4b900b5c53a	String	jsonType.label
8789c506-5841-435d-8139-7a0543125379	true	introspection.token.claim
8789c506-5841-435d-8139-7a0543125379	true	userinfo.token.claim
8789c506-5841-435d-8139-7a0543125379	updatedAt	user.attribute
8789c506-5841-435d-8139-7a0543125379	true	id.token.claim
8789c506-5841-435d-8139-7a0543125379	true	access.token.claim
8789c506-5841-435d-8139-7a0543125379	updated_at	claim.name
8789c506-5841-435d-8139-7a0543125379	long	jsonType.label
8b9e895b-5a94-4467-ae96-982b46bba51a	true	introspection.token.claim
8b9e895b-5a94-4467-ae96-982b46bba51a	true	userinfo.token.claim
8b9e895b-5a94-4467-ae96-982b46bba51a	website	user.attribute
8b9e895b-5a94-4467-ae96-982b46bba51a	true	id.token.claim
8b9e895b-5a94-4467-ae96-982b46bba51a	true	access.token.claim
8b9e895b-5a94-4467-ae96-982b46bba51a	website	claim.name
8b9e895b-5a94-4467-ae96-982b46bba51a	String	jsonType.label
a7988929-2459-42cb-8fa9-a1c6417eaef5	true	introspection.token.claim
a7988929-2459-42cb-8fa9-a1c6417eaef5	true	userinfo.token.claim
a7988929-2459-42cb-8fa9-a1c6417eaef5	middleName	user.attribute
a7988929-2459-42cb-8fa9-a1c6417eaef5	true	id.token.claim
a7988929-2459-42cb-8fa9-a1c6417eaef5	true	access.token.claim
a7988929-2459-42cb-8fa9-a1c6417eaef5	middle_name	claim.name
a7988929-2459-42cb-8fa9-a1c6417eaef5	String	jsonType.label
cfecb699-0a14-47c6-a9a9-64edb72b2d03	true	introspection.token.claim
cfecb699-0a14-47c6-a9a9-64edb72b2d03	true	userinfo.token.claim
cfecb699-0a14-47c6-a9a9-64edb72b2d03	username	user.attribute
cfecb699-0a14-47c6-a9a9-64edb72b2d03	true	id.token.claim
cfecb699-0a14-47c6-a9a9-64edb72b2d03	true	access.token.claim
cfecb699-0a14-47c6-a9a9-64edb72b2d03	preferred_username	claim.name
cfecb699-0a14-47c6-a9a9-64edb72b2d03	String	jsonType.label
d603f8e6-a717-42d1-a49b-4c5cc9014a52	true	introspection.token.claim
d603f8e6-a717-42d1-a49b-4c5cc9014a52	true	userinfo.token.claim
d603f8e6-a717-42d1-a49b-4c5cc9014a52	birthdate	user.attribute
d603f8e6-a717-42d1-a49b-4c5cc9014a52	true	id.token.claim
d603f8e6-a717-42d1-a49b-4c5cc9014a52	true	access.token.claim
d603f8e6-a717-42d1-a49b-4c5cc9014a52	birthdate	claim.name
d603f8e6-a717-42d1-a49b-4c5cc9014a52	String	jsonType.label
d9714792-6f4e-45ab-84aa-5b84430c110f	true	introspection.token.claim
d9714792-6f4e-45ab-84aa-5b84430c110f	true	userinfo.token.claim
d9714792-6f4e-45ab-84aa-5b84430c110f	picture	user.attribute
d9714792-6f4e-45ab-84aa-5b84430c110f	true	id.token.claim
d9714792-6f4e-45ab-84aa-5b84430c110f	true	access.token.claim
d9714792-6f4e-45ab-84aa-5b84430c110f	picture	claim.name
d9714792-6f4e-45ab-84aa-5b84430c110f	String	jsonType.label
dec90f59-e719-4fb9-b85c-bc52a08dd893	true	introspection.token.claim
dec90f59-e719-4fb9-b85c-bc52a08dd893	true	userinfo.token.claim
dec90f59-e719-4fb9-b85c-bc52a08dd893	lastName	user.attribute
dec90f59-e719-4fb9-b85c-bc52a08dd893	true	id.token.claim
dec90f59-e719-4fb9-b85c-bc52a08dd893	true	access.token.claim
dec90f59-e719-4fb9-b85c-bc52a08dd893	family_name	claim.name
dec90f59-e719-4fb9-b85c-bc52a08dd893	String	jsonType.label
e5ed8c9b-033f-48a0-8191-5daa53380fae	true	introspection.token.claim
e5ed8c9b-033f-48a0-8191-5daa53380fae	true	userinfo.token.claim
e5ed8c9b-033f-48a0-8191-5daa53380fae	nickname	user.attribute
e5ed8c9b-033f-48a0-8191-5daa53380fae	true	id.token.claim
e5ed8c9b-033f-48a0-8191-5daa53380fae	true	access.token.claim
e5ed8c9b-033f-48a0-8191-5daa53380fae	nickname	claim.name
e5ed8c9b-033f-48a0-8191-5daa53380fae	String	jsonType.label
ebddac27-75d6-4a98-ac2b-8209152d385d	true	introspection.token.claim
ebddac27-75d6-4a98-ac2b-8209152d385d	true	userinfo.token.claim
ebddac27-75d6-4a98-ac2b-8209152d385d	true	id.token.claim
ebddac27-75d6-4a98-ac2b-8209152d385d	true	access.token.claim
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	true	introspection.token.claim
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	true	userinfo.token.claim
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	locale	user.attribute
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	true	id.token.claim
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	true	access.token.claim
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	locale	claim.name
f47f6b1b-fac1-42e2-8c01-823e6b4e09b2	String	jsonType.label
fa747f18-c550-47b4-949f-e7cc42d43c11	true	introspection.token.claim
fa747f18-c550-47b4-949f-e7cc42d43c11	true	userinfo.token.claim
fa747f18-c550-47b4-949f-e7cc42d43c11	gender	user.attribute
fa747f18-c550-47b4-949f-e7cc42d43c11	true	id.token.claim
fa747f18-c550-47b4-949f-e7cc42d43c11	true	access.token.claim
fa747f18-c550-47b4-949f-e7cc42d43c11	gender	claim.name
fa747f18-c550-47b4-949f-e7cc42d43c11	String	jsonType.label
78983881-a37f-448f-879b-e6f01eb96e0b	true	introspection.token.claim
78983881-a37f-448f-879b-e6f01eb96e0b	true	userinfo.token.claim
78983881-a37f-448f-879b-e6f01eb96e0b	email	user.attribute
78983881-a37f-448f-879b-e6f01eb96e0b	true	id.token.claim
78983881-a37f-448f-879b-e6f01eb96e0b	true	access.token.claim
78983881-a37f-448f-879b-e6f01eb96e0b	email	claim.name
78983881-a37f-448f-879b-e6f01eb96e0b	String	jsonType.label
9f6ee589-2390-4275-ba46-9cf65547b357	true	introspection.token.claim
9f6ee589-2390-4275-ba46-9cf65547b357	true	userinfo.token.claim
9f6ee589-2390-4275-ba46-9cf65547b357	emailVerified	user.attribute
9f6ee589-2390-4275-ba46-9cf65547b357	true	id.token.claim
9f6ee589-2390-4275-ba46-9cf65547b357	true	access.token.claim
9f6ee589-2390-4275-ba46-9cf65547b357	email_verified	claim.name
9f6ee589-2390-4275-ba46-9cf65547b357	boolean	jsonType.label
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	formatted	user.attribute.formatted
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	country	user.attribute.country
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	true	introspection.token.claim
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	postal_code	user.attribute.postal_code
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	true	userinfo.token.claim
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	street	user.attribute.street
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	true	id.token.claim
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	region	user.attribute.region
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	true	access.token.claim
a1ad2f41-57a9-45d7-b591-aabe51f96ff8	locality	user.attribute.locality
1e88162e-b32b-4206-9346-f90789ec4abf	true	introspection.token.claim
1e88162e-b32b-4206-9346-f90789ec4abf	true	userinfo.token.claim
1e88162e-b32b-4206-9346-f90789ec4abf	phoneNumber	user.attribute
1e88162e-b32b-4206-9346-f90789ec4abf	true	id.token.claim
1e88162e-b32b-4206-9346-f90789ec4abf	true	access.token.claim
1e88162e-b32b-4206-9346-f90789ec4abf	phone_number	claim.name
1e88162e-b32b-4206-9346-f90789ec4abf	String	jsonType.label
2ffedf64-ba5f-4623-acaa-bbcba1155edb	true	introspection.token.claim
2ffedf64-ba5f-4623-acaa-bbcba1155edb	true	userinfo.token.claim
2ffedf64-ba5f-4623-acaa-bbcba1155edb	phoneNumberVerified	user.attribute
2ffedf64-ba5f-4623-acaa-bbcba1155edb	true	id.token.claim
2ffedf64-ba5f-4623-acaa-bbcba1155edb	true	access.token.claim
2ffedf64-ba5f-4623-acaa-bbcba1155edb	phone_number_verified	claim.name
2ffedf64-ba5f-4623-acaa-bbcba1155edb	boolean	jsonType.label
9605156b-111f-41ae-aad6-6503df094350	true	introspection.token.claim
9605156b-111f-41ae-aad6-6503df094350	true	multivalued
9605156b-111f-41ae-aad6-6503df094350	foo	user.attribute
9605156b-111f-41ae-aad6-6503df094350	true	access.token.claim
9605156b-111f-41ae-aad6-6503df094350	realm_access.roles	claim.name
9605156b-111f-41ae-aad6-6503df094350	String	jsonType.label
e3f40368-9dfa-4bed-81fc-ab08bd0636c1	true	introspection.token.claim
e3f40368-9dfa-4bed-81fc-ab08bd0636c1	true	multivalued
e3f40368-9dfa-4bed-81fc-ab08bd0636c1	foo	user.attribute
e3f40368-9dfa-4bed-81fc-ab08bd0636c1	true	access.token.claim
e3f40368-9dfa-4bed-81fc-ab08bd0636c1	resource_access.${client_id}.roles	claim.name
e3f40368-9dfa-4bed-81fc-ab08bd0636c1	String	jsonType.label
f14abbd2-6367-46b5-9dc1-e8111f577c06	true	introspection.token.claim
f14abbd2-6367-46b5-9dc1-e8111f577c06	true	access.token.claim
0e2c4259-2cdc-4ccb-9ac3-623c397988a1	true	introspection.token.claim
0e2c4259-2cdc-4ccb-9ac3-623c397988a1	true	access.token.claim
55c6ba1e-a08e-46f1-8e74-d94721221f4f	true	introspection.token.claim
55c6ba1e-a08e-46f1-8e74-d94721221f4f	true	userinfo.token.claim
55c6ba1e-a08e-46f1-8e74-d94721221f4f	username	user.attribute
55c6ba1e-a08e-46f1-8e74-d94721221f4f	true	id.token.claim
55c6ba1e-a08e-46f1-8e74-d94721221f4f	true	access.token.claim
55c6ba1e-a08e-46f1-8e74-d94721221f4f	upn	claim.name
55c6ba1e-a08e-46f1-8e74-d94721221f4f	String	jsonType.label
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	true	introspection.token.claim
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	true	multivalued
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	foo	user.attribute
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	true	id.token.claim
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	true	access.token.claim
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	groups	claim.name
6315b9fa-7f6b-49ed-9b5d-bfa1016f9b41	String	jsonType.label
2687d1f3-d726-4964-8eed-201847a7f1ab	true	introspection.token.claim
2687d1f3-d726-4964-8eed-201847a7f1ab	true	id.token.claim
2687d1f3-d726-4964-8eed-201847a7f1ab	true	access.token.claim
155536d7-dfb8-4395-9a14-577a3460268d	true	introspection.token.claim
155536d7-dfb8-4395-9a14-577a3460268d	true	access.token.claim
5a764b5d-11fb-4612-9fab-9f0aa821d0aa	AUTH_TIME	user.session.note
5a764b5d-11fb-4612-9fab-9f0aa821d0aa	true	introspection.token.claim
5a764b5d-11fb-4612-9fab-9f0aa821d0aa	true	id.token.claim
5a764b5d-11fb-4612-9fab-9f0aa821d0aa	true	access.token.claim
5a764b5d-11fb-4612-9fab-9f0aa821d0aa	auth_time	claim.name
5a764b5d-11fb-4612-9fab-9f0aa821d0aa	long	jsonType.label
5c2321fb-ef9e-4e90-ad91-444de8323f79	clientAddress	user.session.note
5c2321fb-ef9e-4e90-ad91-444de8323f79	true	introspection.token.claim
5c2321fb-ef9e-4e90-ad91-444de8323f79	true	id.token.claim
5c2321fb-ef9e-4e90-ad91-444de8323f79	true	access.token.claim
5c2321fb-ef9e-4e90-ad91-444de8323f79	clientAddress	claim.name
5c2321fb-ef9e-4e90-ad91-444de8323f79	String	jsonType.label
67de238b-8792-4c85-ae00-ce457478e1af	clientHost	user.session.note
67de238b-8792-4c85-ae00-ce457478e1af	true	introspection.token.claim
67de238b-8792-4c85-ae00-ce457478e1af	true	id.token.claim
67de238b-8792-4c85-ae00-ce457478e1af	true	access.token.claim
67de238b-8792-4c85-ae00-ce457478e1af	clientHost	claim.name
67de238b-8792-4c85-ae00-ce457478e1af	String	jsonType.label
7b664b30-6d91-4e6f-a348-393a65608d56	client_id	user.session.note
7b664b30-6d91-4e6f-a348-393a65608d56	true	introspection.token.claim
7b664b30-6d91-4e6f-a348-393a65608d56	true	id.token.claim
7b664b30-6d91-4e6f-a348-393a65608d56	true	access.token.claim
7b664b30-6d91-4e6f-a348-393a65608d56	client_id	claim.name
7b664b30-6d91-4e6f-a348-393a65608d56	String	jsonType.label
bf393094-b755-4258-8ace-ccf4f9c47d61	true	introspection.token.claim
bf393094-b755-4258-8ace-ccf4f9c47d61	true	multivalued
bf393094-b755-4258-8ace-ccf4f9c47d61	true	id.token.claim
bf393094-b755-4258-8ace-ccf4f9c47d61	true	access.token.claim
bf393094-b755-4258-8ace-ccf4f9c47d61	organization	claim.name
bf393094-b755-4258-8ace-ccf4f9c47d61	String	jsonType.label
e9395691-846c-44f5-b1f5-c465e18eedc4	true	introspection.token.claim
e9395691-846c-44f5-b1f5-c465e18eedc4	true	userinfo.token.claim
e9395691-846c-44f5-b1f5-c465e18eedc4	locale	user.attribute
e9395691-846c-44f5-b1f5-c465e18eedc4	true	id.token.claim
e9395691-846c-44f5-b1f5-c465e18eedc4	true	access.token.claim
e9395691-846c-44f5-b1f5-c465e18eedc4	locale	claim.name
e9395691-846c-44f5-b1f5-c465e18eedc4	String	jsonType.label
99821b27-dd62-48c0-9b3d-3bfe19f03e15	foo	user.attribute
99821b27-dd62-48c0-9b3d-3bfe19f03e15	true	introspection.token.claim
99821b27-dd62-48c0-9b3d-3bfe19f03e15	true	access.token.claim
99821b27-dd62-48c0-9b3d-3bfe19f03e15	realm_access.roles	claim.name
99821b27-dd62-48c0-9b3d-3bfe19f03e15	String	jsonType.label
99821b27-dd62-48c0-9b3d-3bfe19f03e15	true	multivalued
99821b27-dd62-48c0-9b3d-3bfe19f03e15	false	userinfo.token.claim
99821b27-dd62-48c0-9b3d-3bfe19f03e15	true	id.token.claim
99821b27-dd62-48c0-9b3d-3bfe19f03e15	false	lightweight.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
79297412-b299-4def-8f42-bd61d963bfcc	60	300	300	\N	\N	\N	t	f	0	\N	ERP Docs	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	ca7d86ad-b054-407e-8555-e983242f27a4	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	eb7b4bfd-2066-42ff-a40d-010a2312d7aa	e243ec36-cd15-459a-964c-b78150cd29e0	fc8f640d-11d5-4d3b-86b3-eff8b08f5633	506f1e42-51da-4a63-8920-f42ed9ede67d	34abf6f3-63f3-4bfe-bfb4-e935984e2a71	2592000	f	900	t	f	108eb994-100d-4ecb-8c34-938aead25692	0	f	0	0	f084e403-d707-4a59-84b4-6ca6b024e4e2
64844e83-205d-4ee5-b5f1-c772a9c661f8	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	3f22b2c3-f40d-43a4-8371-3ed918cea9c3	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	1ecb1b3d-6183-4f96-88f3-980b59df363f	a9c05ddc-77a3-4550-bf6f-b714f572fb84	18ea931c-009b-426b-86bf-06e3455dfb3f	a224e319-ba24-4846-aafb-f8046c2641a7	37308016-27d7-4420-af7f-07ac858c623a	2592000	f	900	t	f	588388d0-48fa-4dbf-bdfb-da51eedbbceb	0	f	0	0	357d75aa-76ac-477f-a87d-be40056d7d5a
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	64844e83-205d-4ee5-b5f1-c772a9c661f8	
_browser_header.xContentTypeOptions	64844e83-205d-4ee5-b5f1-c772a9c661f8	nosniff
_browser_header.referrerPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	no-referrer
_browser_header.xRobotsTag	64844e83-205d-4ee5-b5f1-c772a9c661f8	none
_browser_header.xFrameOptions	64844e83-205d-4ee5-b5f1-c772a9c661f8	SAMEORIGIN
_browser_header.contentSecurityPolicy	64844e83-205d-4ee5-b5f1-c772a9c661f8	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	64844e83-205d-4ee5-b5f1-c772a9c661f8	max-age=31536000; includeSubDomains
bruteForceProtected	64844e83-205d-4ee5-b5f1-c772a9c661f8	false
permanentLockout	64844e83-205d-4ee5-b5f1-c772a9c661f8	false
maxTemporaryLockouts	64844e83-205d-4ee5-b5f1-c772a9c661f8	0
bruteForceStrategy	64844e83-205d-4ee5-b5f1-c772a9c661f8	MULTIPLE
maxFailureWaitSeconds	64844e83-205d-4ee5-b5f1-c772a9c661f8	900
minimumQuickLoginWaitSeconds	64844e83-205d-4ee5-b5f1-c772a9c661f8	60
waitIncrementSeconds	64844e83-205d-4ee5-b5f1-c772a9c661f8	60
quickLoginCheckMilliSeconds	64844e83-205d-4ee5-b5f1-c772a9c661f8	1000
maxDeltaTimeSeconds	64844e83-205d-4ee5-b5f1-c772a9c661f8	43200
failureFactor	64844e83-205d-4ee5-b5f1-c772a9c661f8	30
maxSecondaryAuthFailures	64844e83-205d-4ee5-b5f1-c772a9c661f8	0
realmReusableOtpCode	64844e83-205d-4ee5-b5f1-c772a9c661f8	false
firstBrokerLoginFlowId	64844e83-205d-4ee5-b5f1-c772a9c661f8	e031183b-f857-4e8d-aac3-52622076fdd3
displayName	64844e83-205d-4ee5-b5f1-c772a9c661f8	Keycloak
displayNameHtml	64844e83-205d-4ee5-b5f1-c772a9c661f8	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	64844e83-205d-4ee5-b5f1-c772a9c661f8	RS256
offlineSessionMaxLifespanEnabled	64844e83-205d-4ee5-b5f1-c772a9c661f8	false
offlineSessionMaxLifespan	64844e83-205d-4ee5-b5f1-c772a9c661f8	5184000
_browser_header.contentSecurityPolicyReportOnly	79297412-b299-4def-8f42-bd61d963bfcc	
_browser_header.xContentTypeOptions	79297412-b299-4def-8f42-bd61d963bfcc	nosniff
_browser_header.referrerPolicy	79297412-b299-4def-8f42-bd61d963bfcc	no-referrer
_browser_header.xRobotsTag	79297412-b299-4def-8f42-bd61d963bfcc	none
_browser_header.xFrameOptions	79297412-b299-4def-8f42-bd61d963bfcc	SAMEORIGIN
_browser_header.contentSecurityPolicy	79297412-b299-4def-8f42-bd61d963bfcc	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	79297412-b299-4def-8f42-bd61d963bfcc	max-age=31536000; includeSubDomains
bruteForceProtected	79297412-b299-4def-8f42-bd61d963bfcc	false
permanentLockout	79297412-b299-4def-8f42-bd61d963bfcc	false
maxTemporaryLockouts	79297412-b299-4def-8f42-bd61d963bfcc	0
bruteForceStrategy	79297412-b299-4def-8f42-bd61d963bfcc	MULTIPLE
maxFailureWaitSeconds	79297412-b299-4def-8f42-bd61d963bfcc	900
minimumQuickLoginWaitSeconds	79297412-b299-4def-8f42-bd61d963bfcc	60
waitIncrementSeconds	79297412-b299-4def-8f42-bd61d963bfcc	60
quickLoginCheckMilliSeconds	79297412-b299-4def-8f42-bd61d963bfcc	1000
maxDeltaTimeSeconds	79297412-b299-4def-8f42-bd61d963bfcc	43200
failureFactor	79297412-b299-4def-8f42-bd61d963bfcc	30
maxSecondaryAuthFailures	79297412-b299-4def-8f42-bd61d963bfcc	0
realmReusableOtpCode	79297412-b299-4def-8f42-bd61d963bfcc	false
defaultSignatureAlgorithm	79297412-b299-4def-8f42-bd61d963bfcc	RS256
offlineSessionMaxLifespanEnabled	79297412-b299-4def-8f42-bd61d963bfcc	false
offlineSessionMaxLifespan	79297412-b299-4def-8f42-bd61d963bfcc	5184000
actionTokenGeneratedByAdminLifespan	79297412-b299-4def-8f42-bd61d963bfcc	43200
actionTokenGeneratedByUserLifespan	79297412-b299-4def-8f42-bd61d963bfcc	300
oauth2DeviceCodeLifespan	79297412-b299-4def-8f42-bd61d963bfcc	600
oauth2DevicePollingInterval	79297412-b299-4def-8f42-bd61d963bfcc	5
webAuthnPolicyRpEntityName	79297412-b299-4def-8f42-bd61d963bfcc	keycloak
webAuthnPolicySignatureAlgorithms	79297412-b299-4def-8f42-bd61d963bfcc	ES256,RS256
webAuthnPolicyRpId	79297412-b299-4def-8f42-bd61d963bfcc	
webAuthnPolicyAttestationConveyancePreference	79297412-b299-4def-8f42-bd61d963bfcc	not specified
webAuthnPolicyAuthenticatorAttachment	79297412-b299-4def-8f42-bd61d963bfcc	not specified
webAuthnPolicyRequireResidentKey	79297412-b299-4def-8f42-bd61d963bfcc	not specified
webAuthnPolicyUserVerificationRequirement	79297412-b299-4def-8f42-bd61d963bfcc	not specified
webAuthnPolicyCreateTimeout	79297412-b299-4def-8f42-bd61d963bfcc	0
webAuthnPolicyAvoidSameAuthenticatorRegister	79297412-b299-4def-8f42-bd61d963bfcc	false
webAuthnPolicyRpEntityNamePasswordless	79297412-b299-4def-8f42-bd61d963bfcc	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	79297412-b299-4def-8f42-bd61d963bfcc	ES256,RS256
webAuthnPolicyRpIdPasswordless	79297412-b299-4def-8f42-bd61d963bfcc	
webAuthnPolicyAttestationConveyancePreferencePasswordless	79297412-b299-4def-8f42-bd61d963bfcc	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	79297412-b299-4def-8f42-bd61d963bfcc	not specified
webAuthnPolicyRequireResidentKeyPasswordless	79297412-b299-4def-8f42-bd61d963bfcc	Yes
webAuthnPolicyUserVerificationRequirementPasswordless	79297412-b299-4def-8f42-bd61d963bfcc	required
webAuthnPolicyCreateTimeoutPasswordless	79297412-b299-4def-8f42-bd61d963bfcc	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	79297412-b299-4def-8f42-bd61d963bfcc	false
cibaBackchannelTokenDeliveryMode	79297412-b299-4def-8f42-bd61d963bfcc	poll
cibaExpiresIn	79297412-b299-4def-8f42-bd61d963bfcc	120
cibaInterval	79297412-b299-4def-8f42-bd61d963bfcc	5
cibaAuthRequestedUserHint	79297412-b299-4def-8f42-bd61d963bfcc	login_hint
parRequestUriLifespan	79297412-b299-4def-8f42-bd61d963bfcc	60
firstBrokerLoginFlowId	79297412-b299-4def-8f42-bd61d963bfcc	d9fcb579-c355-4658-87e4-fc20edf9a9bc
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
64844e83-205d-4ee5-b5f1-c772a9c661f8	jboss-logging
79297412-b299-4def-8f42-bd61d963bfcc	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	64844e83-205d-4ee5-b5f1-c772a9c661f8
password	password	t	t	79297412-b299-4def-8f42-bd61d963bfcc
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.redirect_uris (client_id, value) FROM stdin;
47781dd4-1c7c-46c6-a72e-4085b615aa52	/realms/master/account/*
a9cb6269-7671-47ec-a87f-a1380eaa284a	/realms/master/account/*
78d20a38-d3ed-4288-aadd-603f9573972d	/admin/master/console/*
9122e8dc-e3ed-4e0d-9ec9-6afcd7341c7d	/realms/ERP%20Docs/account/*
ee333356-91c4-47f1-97b3-6481a7351eba	/realms/ERP%20Docs/account/*
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	/admin/ERP%20Docs/console/*
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	http://localhost:3001/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
31f44f81-0107-458d-8d17-d7be0b1d78f0	VERIFY_EMAIL	Verify Email	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	VERIFY_EMAIL	50
0452cdaa-b316-4713-acca-afe15fa279ed	UPDATE_PROFILE	Update Profile	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	UPDATE_PROFILE	40
4c5c9aea-eb86-436b-b466-f678831bbb11	CONFIGURE_TOTP	Configure OTP	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	CONFIGURE_TOTP	10
e2bd2582-0f9a-4874-bed8-d81c1b44d82e	UPDATE_PASSWORD	Update Password	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	UPDATE_PASSWORD	30
c42bd3f6-0682-4337-b375-fc966ea80329	TERMS_AND_CONDITIONS	Terms and Conditions	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	f	TERMS_AND_CONDITIONS	20
88b4f843-a7c3-47ed-b7b4-e4b9b6ef77ba	delete_account	Delete Account	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	f	delete_account	60
239e8861-0d9f-4a22-b9eb-4638c2e45c0c	delete_credential	Delete Credential	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	delete_credential	110
9e15baf0-9050-46cf-9446-b32bf2f5abf1	update_user_locale	Update User Locale	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	update_user_locale	1000
265418c7-6a19-45eb-8d5e-fd798389496b	UPDATE_EMAIL	Update Email	64844e83-205d-4ee5-b5f1-c772a9c661f8	f	f	UPDATE_EMAIL	70
6aaeea82-97aa-4198-a656-6e408cc906ce	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
41144076-dc3c-4ba2-aa1e-0746b24fa989	webauthn-register	Webauthn Register	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	webauthn-register	80
92ae1f5f-cbf9-4201-bad8-3b0009cad509	webauthn-register-passwordless	Webauthn Register Passwordless	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	webauthn-register-passwordless	90
63ba9b13-153e-4007-b5d4-93013c9f4654	VERIFY_PROFILE	Verify Profile	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	VERIFY_PROFILE	100
adba1065-33d6-49ad-892a-556ca694aea5	idp_link	Linking Identity Provider	64844e83-205d-4ee5-b5f1-c772a9c661f8	t	f	idp_link	120
738e2d5f-2b52-47af-ba33-75b50829b409	VERIFY_EMAIL	Verify Email	79297412-b299-4def-8f42-bd61d963bfcc	t	f	VERIFY_EMAIL	50
deb93f7d-f3ff-48df-89ed-9539b200f41e	UPDATE_PROFILE	Update Profile	79297412-b299-4def-8f42-bd61d963bfcc	t	f	UPDATE_PROFILE	40
af78f360-bad0-4463-9a7f-088e6a332f58	CONFIGURE_TOTP	Configure OTP	79297412-b299-4def-8f42-bd61d963bfcc	t	f	CONFIGURE_TOTP	10
84790403-9648-4043-927d-f09c1b4bad80	UPDATE_PASSWORD	Update Password	79297412-b299-4def-8f42-bd61d963bfcc	t	f	UPDATE_PASSWORD	30
d0fe98c5-863d-4ddd-a288-9e95bbf76cfa	TERMS_AND_CONDITIONS	Terms and Conditions	79297412-b299-4def-8f42-bd61d963bfcc	f	f	TERMS_AND_CONDITIONS	20
07d71006-a3ee-40e4-867e-20311e4661ac	delete_account	Delete Account	79297412-b299-4def-8f42-bd61d963bfcc	f	f	delete_account	60
a1ce90b4-ab81-48b6-86e4-aaf620319f08	delete_credential	Delete Credential	79297412-b299-4def-8f42-bd61d963bfcc	t	f	delete_credential	110
2349393a-adff-4abb-bb90-2d12843c9b4f	update_user_locale	Update User Locale	79297412-b299-4def-8f42-bd61d963bfcc	t	f	update_user_locale	1000
fb79fa16-0eed-49a2-9c60-df7a4eeb0b9c	UPDATE_EMAIL	Update Email	79297412-b299-4def-8f42-bd61d963bfcc	f	f	UPDATE_EMAIL	70
fab5f619-bcfc-43b8-adec-9033d428e26c	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	79297412-b299-4def-8f42-bd61d963bfcc	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
0e5ec6ff-b40f-4040-8269-67482320be5e	webauthn-register	Webauthn Register	79297412-b299-4def-8f42-bd61d963bfcc	t	f	webauthn-register	80
9765cd8f-9758-4990-938f-6742efd7afcf	webauthn-register-passwordless	Webauthn Register Passwordless	79297412-b299-4def-8f42-bd61d963bfcc	t	f	webauthn-register-passwordless	90
21413561-c972-4bea-a074-047780d9241a	VERIFY_PROFILE	Verify Profile	79297412-b299-4def-8f42-bd61d963bfcc	t	f	VERIFY_PROFILE	100
3e3f3433-27dd-4513-8560-beb0f6c9f4ae	idp_link	Linking Identity Provider	79297412-b299-4def-8f42-bd61d963bfcc	t	f	idp_link	120
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
a9cb6269-7671-47ec-a87f-a1380eaa284a	63db14c7-5fcb-4fa8-b001-6dc6d4e8fbb4
a9cb6269-7671-47ec-a87f-a1380eaa284a	7d305868-0e2d-4a43-b5aa-49793b95b61e
ee333356-91c4-47f1-97b3-6481a7351eba	bbe21213-ba49-4592-ae98-61394376dd5c
ee333356-91c4-47f1-97b3-6481a7351eba	89f0933a-2599-4dc0-860e-d4a798700f7f
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	66940bd6-e40f-4f51-92c7-a07f7651e845	dad5fac7-e2f3-443f-8c9f-c877794df80a	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before, last_modified_timestamp) FROM stdin;
66940bd6-e40f-4f51-92c7-a07f7651e845	\N	22fa6a86-a5b1-43a5-9f58-931a6add5de4	f	t	\N	\N	\N	64844e83-205d-4ee5-b5f1-c772a9c661f8	admin	1778090235000	\N	0	1778090235000
ece1ab8c-ef1d-480a-bf3e-d215596c3a32	danielelpro19@gmail.com	danielelpro19@gmail.com	f	t	\N	daniel	perez	79297412-b299-4def-8f42-bd61d963bfcc	dperez	1778092751960	\N	0	1778092751960
843c15c5-60cf-4a86-9851-fb331bb9e6c9	correoparaplatad@gmail.com	correoparaplatad@gmail.com	f	t	\N	Daniel	Alexander	79297412-b299-4def-8f42-bd61d963bfcc	danitsu	1778099327038	\N	0	1778099327038
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
357d75aa-76ac-477f-a87d-be40056d7d5a	66940bd6-e40f-4f51-92c7-a07f7651e845
49739323-5cc5-4fac-8be5-7e554c3778bb	66940bd6-e40f-4f51-92c7-a07f7651e845
f084e403-d707-4a59-84b4-6ca6b024e4e2	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
fccb39d9-6e03-4d2b-be0e-b49a69bba49c	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
7ef241dc-fe68-4485-ba64-ee8dcb19cee7	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
f084e403-d707-4a59-84b4-6ca6b024e4e2	843c15c5-60cf-4a86-9851-fb331bb9e6c9
07836609-062e-4683-bd36-4f8ed0e8f38c	843c15c5-60cf-4a86-9851-fb331bb9e6c9
7ef241dc-fe68-4485-ba64-ee8dcb19cee7	843c15c5-60cf-4a86-9851-fb331bb9e6c9
20139c58-92cc-47db-89de-b27ae5057ba7	843c15c5-60cf-4a86-9851-fb331bb9e6c9
451c3310-a44b-4a0a-9f31-24a0f518fed8	843c15c5-60cf-4a86-9851-fb331bb9e6c9
bcdc2390-9107-4d4f-ac8e-d478c29e6e13	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
2caee4c8-4155-4678-b7fe-9f8f07960a8b	843c15c5-60cf-4a86-9851-fb331bb9e6c9
ae4a2fd3-ece3-483f-9185-99ea620b87d2	843c15c5-60cf-4a86-9851-fb331bb9e6c9
da6f2399-f918-4302-bc64-72797f904b03	843c15c5-60cf-4a86-9851-fb331bb9e6c9
a78bd2b5-68af-4fec-b576-fe6264825db3	843c15c5-60cf-4a86-9851-fb331bb9e6c9
e4f00396-d68f-47dc-a15f-98e6fa1af24f	843c15c5-60cf-4a86-9851-fb331bb9e6c9
93e63f4c-878b-4282-93b0-3a6bf1a44eee	843c15c5-60cf-4a86-9851-fb331bb9e6c9
e48d491f-848c-4da9-af8d-2ddfb69be280	843c15c5-60cf-4a86-9851-fb331bb9e6c9
c6d826bc-199e-4302-bcf8-cb68f6b47c86	843c15c5-60cf-4a86-9851-fb331bb9e6c9
fccb39d9-6e03-4d2b-be0e-b49a69bba49c	843c15c5-60cf-4a86-9851-fb331bb9e6c9
c35f11e2-c4c1-4e1d-9e8a-33e863d4d7e7	843c15c5-60cf-4a86-9851-fb331bb9e6c9
e132ed94-f0a1-49ef-9f9b-92755bbbf7fd	843c15c5-60cf-4a86-9851-fb331bb9e6c9
98eff7a2-8d12-4d37-8abf-1b309a673472	843c15c5-60cf-4a86-9851-fb331bb9e6c9
9fb4c91e-23be-4846-8d1b-3e31313cf4df	843c15c5-60cf-4a86-9851-fb331bb9e6c9
f5c40d62-a6e7-43a2-b33c-dffeae0f7ef0	843c15c5-60cf-4a86-9851-fb331bb9e6c9
f33125b5-491c-4969-977f-01838c125916	843c15c5-60cf-4a86-9851-fb331bb9e6c9
252c7bb3-d933-41bc-8e85-e02368c98b71	843c15c5-60cf-4a86-9851-fb331bb9e6c9
ba42e993-b497-46be-9d02-7bfb22bbe65a	843c15c5-60cf-4a86-9851-fb331bb9e6c9
9d494452-b03d-4a3d-b907-3e8da9641710	843c15c5-60cf-4a86-9851-fb331bb9e6c9
bcdc2390-9107-4d4f-ac8e-d478c29e6e13	843c15c5-60cf-4a86-9851-fb331bb9e6c9
8cb015d6-2efa-411c-a26e-9f0b40a52a83	843c15c5-60cf-4a86-9851-fb331bb9e6c9
467d14c0-e681-4bec-a4ca-787539b2fcb0	843c15c5-60cf-4a86-9851-fb331bb9e6c9
07836609-062e-4683-bd36-4f8ed0e8f38c	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
20139c58-92cc-47db-89de-b27ae5057ba7	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
451c3310-a44b-4a0a-9f31-24a0f518fed8	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
8cb015d6-2efa-411c-a26e-9f0b40a52a83	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
2caee4c8-4155-4678-b7fe-9f8f07960a8b	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
ae4a2fd3-ece3-483f-9185-99ea620b87d2	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
da6f2399-f918-4302-bc64-72797f904b03	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
a78bd2b5-68af-4fec-b576-fe6264825db3	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
e4f00396-d68f-47dc-a15f-98e6fa1af24f	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
93e63f4c-878b-4282-93b0-3a6bf1a44eee	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
e48d491f-848c-4da9-af8d-2ddfb69be280	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
c6d826bc-199e-4302-bcf8-cb68f6b47c86	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
c35f11e2-c4c1-4e1d-9e8a-33e863d4d7e7	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
8d8fd701-d0f0-4bab-a4d0-a0cf16112356	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
e132ed94-f0a1-49ef-9f9b-92755bbbf7fd	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
98eff7a2-8d12-4d37-8abf-1b309a673472	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
9fb4c91e-23be-4846-8d1b-3e31313cf4df	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
f5c40d62-a6e7-43a2-b33c-dffeae0f7ef0	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
252c7bb3-d933-41bc-8e85-e02368c98b71	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
f33125b5-491c-4969-977f-01838c125916	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
ba42e993-b497-46be-9d02-7bfb22bbe65a	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
9d494452-b03d-4a3d-b907-3e8da9641710	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
195b1b2a-fb84-4b4b-a143-0cdf2d3f280d	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
0c369ff5-569d-4fc1-a22f-98c4ccb939ee	ece1ab8c-ef1d-480a-bf3e-d215596c3a32
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.web_origins (client_id, value) FROM stdin;
78d20a38-d3ed-4288-aadd-603f9573972d	+
4c3d8865-9d5d-4405-bb1c-7ebfd09507b9	+
c83a6f34-e1d2-4c4e-a93a-7d8517d3cc97	
\.


--
-- Data for Name: workflow_state; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.workflow_state (execution_id, resource_id, workflow_id, resource_type, scheduled_step_id, scheduled_step_timestamp) FROM stdin;
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: org_invitation constraint_org_invitation; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT constraint_org_invitation PRIMARY KEY (id);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: workflow_state pk_workflow_state; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT pk_workflow_state PRIMARY KEY (execution_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org_invitation uk_org_invitation_email; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT uk_org_invitation_email UNIQUE (organization_id, email);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: workflow_state uq_workflow_resource; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT uq_workflow_resource UNIQUE (workflow_id, resource_id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_broker_link_identity_provider; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_broker_link_identity_provider ON public.broker_link USING btree (realm_id, identity_provider, broker_user_id);


--
-- Name: idx_broker_link_user_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_broker_link_user_id ON public.broker_link USING btree (user_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_entity_user_id_type; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_event_entity_user_id_type ON public.event_entity USING btree (user_id, type, event_time);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_org_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_org_id ON public.keycloak_group USING btree (org_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_by_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_css_by_client ON public.offline_client_session USING btree (client_id, offline_flag) WHERE ((client_id)::text <> 'external'::text);


--
-- Name: idx_offline_css_by_client_and_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_css_by_client_and_realm ON public.offline_client_session USING btree (realm_id, offline_flag, client_id, client_storage_provider, external_client_id);


--
-- Name: idx_offline_css_by_client_storage_provider; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_css_by_client_storage_provider ON public.offline_client_session USING btree (client_storage_provider, external_client_id, offline_flag) WHERE ((client_storage_provider)::text <> 'internal'::text);


--
-- Name: idx_offline_css_by_user_session_and_offline; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_css_by_user_session_and_offline ON public.offline_client_session USING btree (offline_flag, user_session_id);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_org_invitation_email; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_org_invitation_email ON public.org_invitation USING btree (email);


--
-- Name: idx_org_invitation_expires; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_org_invitation_expires ON public.org_invitation USING btree (expires_at);


--
-- Name: idx_org_invitation_org_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_org_invitation_org_id ON public.org_invitation USING btree (organization_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_created_timestamp; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_created_timestamp ON public.user_entity USING btree (realm_id, created_timestamp);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_user_session_expiration_created; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_session_expiration_created ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, created_on, user_session_id, user_id);


--
-- Name: idx_user_session_expiration_last_refresh; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_session_expiration_last_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, last_session_refresh, user_session_id, user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: idx_workflow_state_provider; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_workflow_state_provider ON public.workflow_state USING btree (resource_id);


--
-- Name: idx_workflow_state_step; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_workflow_state_step ON public.workflow_state USING btree (workflow_id, scheduled_step_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_organization; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_organization FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: org_invitation fk_org_invitation_org; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT fk_org_invitation_org FOREIGN KEY (organization_id) REFERENCES public.org(id) ON DELETE CASCADE;


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 3yqR8ntpkJO6GZHTylWce8kC5SxPYefODAoDhacp4AdhcAldfcN5yhFpCDdQ78T

