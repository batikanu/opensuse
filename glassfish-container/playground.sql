--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: bssuser; Type: SCHEMA; Schema: -; Owner: postgres
--

-- CREATE SCHEMA bssuser;


ALTER SCHEMA bssuser OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = bssuser, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auditlog; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE auditlog (
    tkey bigint NOT NULL,
    operationid character varying(5) NOT NULL,
    operationname character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    organizationid character varying(255) NOT NULL,
    organizationname character varying(255) NOT NULL,
    log text NOT NULL,
    creationtime bigint NOT NULL
);


ALTER TABLE bssuser.auditlog OWNER TO bssuser;

--
-- Name: billingadapter; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE billingadapter (
    tkey bigint NOT NULL,
    billingidentifier character varying(255) NOT NULL,
    name character varying(255),
    connectionproperties text,
    defaultadapter boolean NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.billingadapter OWNER TO bssuser;

--
-- Name: billingcontact; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE billingcontact (
    tkey bigint NOT NULL,
    address character varying(255),
    companyname character varying(255),
    email character varying(255) NOT NULL,
    orgaddressused boolean NOT NULL,
    version integer NOT NULL,
    organization_tkey bigint NOT NULL,
    billingcontactid character varying(255) NOT NULL
);


ALTER TABLE bssuser.billingcontact OWNER TO bssuser;

--
-- Name: billingcontacthistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE billingcontacthistory (
    tkey bigint NOT NULL,
    address character varying(255),
    companyname character varying(255),
    email character varying(255) NOT NULL,
    orgaddressused boolean NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    billingcontactid character varying(255)
);


ALTER TABLE bssuser.billingcontacthistory OWNER TO bssuser;

--
-- Name: billingresult; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE billingresult (
    tkey bigint NOT NULL,
    creationtime bigint NOT NULL,
    organizationtkey bigint NOT NULL,
    periodendtime bigint NOT NULL,
    periodstarttime bigint NOT NULL,
    resultxml text NOT NULL,
    version integer NOT NULL,
    chargingorgkey bigint NOT NULL,
    subscriptionkey bigint,
    currency_tkey bigint NOT NULL,
    grossamount numeric(19,2) NOT NULL,
    vendorkey bigint NOT NULL,
    netamount numeric(19,2) NOT NULL,
    usergroup_tkey bigint
);


ALTER TABLE bssuser.billingresult OWNER TO bssuser;

--
-- Name: billingsharesresult; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE billingsharesresult (
    tkey bigint NOT NULL,
    periodstarttime bigint,
    periodendtime bigint,
    organizationtkey bigint,
    resulttype character varying(255),
    resultxml text,
    creationtime bigint,
    version integer NOT NULL
);


ALTER TABLE bssuser.billingsharesresult OWNER TO bssuser;

--
-- Name: billingsubscriptionstatus; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE billingsubscriptionstatus (
    tkey bigint NOT NULL,
    subscriptionkey bigint NOT NULL,
    endoflastbilledperiod bigint NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.billingsubscriptionstatus OWNER TO bssuser;

--
-- Name: catalogentry; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE catalogentry (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    product_tkey bigint,
    anonymousvisible boolean DEFAULT false NOT NULL,
    marketplace_tkey bigint,
    visibleincatalog boolean DEFAULT true NOT NULL,
    brokerpricemodel_tkey bigint,
    resellerpricemodel_tkey bigint,
    operatorpricemodel_tkey bigint
);


ALTER TABLE bssuser.catalogentry OWNER TO bssuser;

--
-- Name: catalogentryhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE catalogentryhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    productobjkey bigint,
    anonymousvisible boolean DEFAULT false NOT NULL,
    marketplaceobjkey bigint,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    visibleincatalog boolean DEFAULT true NOT NULL,
    brokerpricemodelobjkey bigint,
    resellerpricemodelobjkey bigint,
    operatorpricemodelobjkey bigint
);


ALTER TABLE bssuser.catalogentryhistory OWNER TO bssuser;

--
-- Name: category; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE category (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    marketplacekey bigint NOT NULL,
    categoryid character varying(255) NOT NULL
);


ALTER TABLE bssuser.category OWNER TO bssuser;

--
-- Name: categoryhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE categoryhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    marketplaceobjkey bigint NOT NULL,
    categoryid character varying(255) NOT NULL
);


ALTER TABLE bssuser.categoryhistory OWNER TO bssuser;

--
-- Name: categorytocatalogentry; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE categorytocatalogentry (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    catalogentry_tkey bigint,
    category_tkey bigint
);


ALTER TABLE bssuser.categorytocatalogentry OWNER TO bssuser;

--
-- Name: categorytocatalogentryhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE categorytocatalogentryhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    catalogentry_tkey bigint,
    category_tkey bigint
);


ALTER TABLE bssuser.categorytocatalogentryhistory OWNER TO bssuser;

--
-- Name: configurationsetting; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE configurationsetting (
    tkey bigint NOT NULL,
    context_id character varying(255) NOT NULL,
    information_id character varying(255) NOT NULL,
    env_value character varying(4096),
    version integer NOT NULL
);


ALTER TABLE bssuser.configurationsetting OWNER TO bssuser;

--
-- Name: discount; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE discount (
    tkey bigint NOT NULL,
    endtime bigint,
    starttime bigint,
    value numeric(19,2) NOT NULL,
    version integer NOT NULL,
    organizationreference_tkey bigint NOT NULL
);


ALTER TABLE bssuser.discount OWNER TO bssuser;

--
-- Name: discounthistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE discounthistory (
    tkey bigint NOT NULL,
    endtime bigint,
    starttime bigint,
    value numeric(19,2) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationreferenceobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.discounthistory OWNER TO bssuser;

--
-- Name: enterpriselandingpage; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE enterpriselandingpage (
    tkey bigint NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.enterpriselandingpage OWNER TO bssuser;

--
-- Name: event; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE event (
    tkey bigint NOT NULL,
    eventidentifier character varying(255) NOT NULL,
    eventtype character varying(255) NOT NULL,
    version integer NOT NULL,
    technicalproduct_tkey bigint
);


ALTER TABLE bssuser.event OWNER TO bssuser;

--
-- Name: eventhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE eventhistory (
    tkey bigint NOT NULL,
    eventidentifier character varying(255) NOT NULL,
    eventtype character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    technicalproductobjkey bigint,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.eventhistory OWNER TO bssuser;

--
-- Name: gatheredevent; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE gatheredevent (
    tkey bigint NOT NULL,
    actor character varying(255),
    eventidentifier character varying(255) NOT NULL,
    multiplier bigint NOT NULL,
    occurrencetime bigint NOT NULL,
    subscriptiontkey bigint NOT NULL,
    type character varying(255) NOT NULL,
    uniqueid character varying(255),
    version integer NOT NULL,
    billingresult_tkey bigint
);


ALTER TABLE bssuser.gatheredevent OWNER TO bssuser;

--
-- Name: hibernate_sequences; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE hibernate_sequences (
    sequence_name character varying(255),
    sequence_next_hi_value integer
);


ALTER TABLE bssuser.hibernate_sequences OWNER TO bssuser;

--
-- Name: imageresource; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE imageresource (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    imagetype character varying(255) NOT NULL,
    objectkey bigint NOT NULL,
    buffer oid NOT NULL,
    contenttype character varying(255)
);


ALTER TABLE bssuser.imageresource OWNER TO bssuser;

--
-- Name: landingpageproduct; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE landingpageproduct (
    tkey bigint NOT NULL,
    landingpage_tkey bigint NOT NULL,
    product_tkey bigint NOT NULL,
    "position" integer NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.landingpageproduct OWNER TO bssuser;

--
-- Name: localizedresource; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE localizedresource (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    locale character varying(255) NOT NULL,
    objecttype character varying(255) NOT NULL,
    objectkey bigint NOT NULL,
    value text NOT NULL
);


ALTER TABLE bssuser.localizedresource OWNER TO bssuser;

--
-- Name: marketingpermission; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE marketingpermission (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    technicalproduct_tkey bigint NOT NULL,
    organizationreference_tkey bigint NOT NULL
);


ALTER TABLE bssuser.marketingpermission OWNER TO bssuser;

--
-- Name: marketingpermissionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE marketingpermissionhistory (
    tkey bigint NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    technicalproductobjkey bigint NOT NULL,
    organizationreferenceobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL
);


ALTER TABLE bssuser.marketingpermissionhistory OWNER TO bssuser;

--
-- Name: marketplace; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE marketplace (
    tkey bigint NOT NULL,
    creationdate bigint NOT NULL,
    version integer NOT NULL,
    organization_tkey bigint NOT NULL,
    marketplaceid character varying(255) NOT NULL,
    open boolean DEFAULT false NOT NULL,
    taggingenabled boolean DEFAULT true NOT NULL,
    reviewenabled boolean DEFAULT true NOT NULL,
    socialbookmarkenabled boolean DEFAULT true NOT NULL,
    brandingurl character varying(255),
    categoriesenabled boolean DEFAULT true NOT NULL,
    publiclandingpage_tkey bigint,
    pricemodel_tkey bigint NOT NULL,
    brokerpricemodel_tkey bigint NOT NULL,
    resellerpricemodel_tkey bigint NOT NULL,
    trackingcode text,
    enterpriselandingpage_tkey bigint
);


ALTER TABLE bssuser.marketplace OWNER TO bssuser;

--
-- Name: marketplacehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE marketplacehistory (
    tkey bigint NOT NULL,
    creationdate bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    marketplaceid character varying(255),
    open boolean DEFAULT false NOT NULL,
    taggingenabled boolean DEFAULT true NOT NULL,
    reviewenabled boolean DEFAULT true NOT NULL,
    socialbookmarkenabled boolean DEFAULT true NOT NULL,
    brandingurl character varying(255),
    categoriesenabled boolean DEFAULT true NOT NULL,
    pricemodelobjkey bigint NOT NULL,
    brokerpricemodelobjkey bigint NOT NULL,
    resellerpricemodelobjkey bigint NOT NULL,
    trackingcode text
);


ALTER TABLE bssuser.marketplacehistory OWNER TO bssuser;

--
-- Name: marketplacetoorganization; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE marketplacetoorganization (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    marketplace_tkey bigint NOT NULL,
    organization_tkey bigint NOT NULL,
    publishingaccess character varying(255) DEFAULT 'PUBLISHING_ACCESS_GRANTED'::character varying NOT NULL
);


ALTER TABLE bssuser.marketplacetoorganization OWNER TO bssuser;

--
-- Name: marketplacetoorganizationhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE marketplacetoorganizationhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    marketplaceobjkey bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    publishingaccess character varying(255) DEFAULT 'PUBLISHING_ACCESS_GRANTED'::character varying NOT NULL
);


ALTER TABLE bssuser.marketplacetoorganizationhistory OWNER TO bssuser;

--
-- Name: modifiedentity; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE modifiedentity (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    targetobjectkey bigint NOT NULL,
    targetobjecttype character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE bssuser.modifiedentity OWNER TO bssuser;

--
-- Name: modifiedentityhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE modifiedentityhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    targetobjectkey bigint NOT NULL,
    targetobjecttype character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE bssuser.modifiedentityhistory OWNER TO bssuser;

--
-- Name: modifieduda; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE modifieduda (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    targetobjectkey bigint NOT NULL,
    targetobjecttype character varying(255) NOT NULL,
    subscriptionkey bigint NOT NULL,
    value character varying(255)
);


ALTER TABLE bssuser.modifieduda OWNER TO bssuser;

--
-- Name: modifiedudahistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE modifiedudahistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    targetobjectkey bigint NOT NULL,
    targetobjecttype character varying(255) NOT NULL,
    subscriptionkey bigint NOT NULL,
    value character varying(255)
);


ALTER TABLE bssuser.modifiedudahistory OWNER TO bssuser;

--
-- Name: onbehalfuserreference; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE onbehalfuserreference (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    lastaccesstime bigint NOT NULL,
    masteruser_tkey bigint NOT NULL,
    slaveuser_tkey bigint NOT NULL
);


ALTER TABLE bssuser.onbehalfuserreference OWNER TO bssuser;

--
-- Name: onbehalfuserreferencehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE onbehalfuserreferencehistory (
    tkey bigint NOT NULL,
    objversion bigint NOT NULL,
    objkey bigint NOT NULL,
    invocationdate timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    lastaccesstime bigint NOT NULL,
    masteruserobjkey bigint NOT NULL,
    slaveuserobjkey bigint NOT NULL
);


ALTER TABLE bssuser.onbehalfuserreferencehistory OWNER TO bssuser;

--
-- Name: operationparameter; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE operationparameter (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    technicalproductoperation_tkey bigint NOT NULL,
    id character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    mandatory boolean
);


ALTER TABLE bssuser.operationparameter OWNER TO bssuser;

--
-- Name: operationparameterhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE operationparameterhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    invocationdate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    technicalproductoperationobjkey bigint NOT NULL,
    id character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    mandatory boolean
);


ALTER TABLE bssuser.operationparameterhistory OWNER TO bssuser;

--
-- Name: operationrecord; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE operationrecord (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    transactionid character varying(255) NOT NULL,
    executiondate bigint NOT NULL,
    status character varying(255) NOT NULL,
    technicalproductoperation_tkey bigint NOT NULL,
    subscription_tkey bigint NOT NULL,
    user_tkey bigint NOT NULL
);


ALTER TABLE bssuser.operationrecord OWNER TO bssuser;

--
-- Name: organization; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organization (
    tkey bigint NOT NULL,
    address character varying(255),
    deregistrationdate bigint,
    distinguishedname character varying(4096),
    email character varying(255),
    locale character varying(255),
    name character varying(255),
    organizationid character varying(255) NOT NULL,
    phone character varying(255),
    registrationdate bigint NOT NULL,
    version integer NOT NULL,
    domicilecountry_tkey bigint,
    url character varying(255),
    supportemail character varying(255),
    remoteldapactive boolean DEFAULT false NOT NULL,
    cutoffday integer NOT NULL,
    operatorpricemodel_tkey bigint,
    CONSTRAINT organization_cutoffday CHECK (((cutoffday > 0) AND (cutoffday < 29)))
);


ALTER TABLE bssuser.organization OWNER TO bssuser;

--
-- Name: organizationhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationhistory (
    tkey bigint NOT NULL,
    address character varying(255),
    deregistrationdate bigint,
    distinguishedname character varying(4096),
    email character varying(255),
    locale character varying(255),
    name character varying(255),
    organizationid character varying(255) NOT NULL,
    phone character varying(255),
    registrationdate bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    domicilecountryobjkey bigint,
    url character varying(255),
    supportemail character varying(255),
    remoteldapactive boolean DEFAULT false NOT NULL,
    cutoffday integer NOT NULL,
    operatorpricemodelobjkey bigint,
    CONSTRAINT organizationhistory_cutoffday CHECK (((cutoffday > 0) AND (cutoffday < 29)))
);


ALTER TABLE bssuser.organizationhistory OWNER TO bssuser;

--
-- Name: organizationreference; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationreference (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    targetkey bigint NOT NULL,
    sourcekey bigint NOT NULL,
    referencetype character varying(255) DEFAULT 'TECHNOLOGY_PROVIDER_TO_SUPPLIER'::character varying NOT NULL
);


ALTER TABLE bssuser.organizationreference OWNER TO bssuser;

--
-- Name: organizationreferencehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationreferencehistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    targetobjkey bigint NOT NULL,
    sourceobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    referencetype character varying(255) DEFAULT 'TECHNOLOGY_PROVIDER_TO_SUPPLIER'::character varying NOT NULL
);


ALTER TABLE bssuser.organizationreferencehistory OWNER TO bssuser;

--
-- Name: organizationreftopaymenttype; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationreftopaymenttype (
    tkey bigint NOT NULL,
    usedasdefault boolean NOT NULL,
    version integer NOT NULL,
    organizationreference_tkey bigint NOT NULL,
    organizationrole_tkey bigint NOT NULL,
    paymenttype_tkey bigint NOT NULL,
    usedasservicedefault boolean DEFAULT true NOT NULL
);


ALTER TABLE bssuser.organizationreftopaymenttype OWNER TO bssuser;

--
-- Name: organizationrole; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationrole (
    tkey bigint NOT NULL,
    rolename character varying(255) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.organizationrole OWNER TO bssuser;

--
-- Name: organizationsetting; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationsetting (
    tkey bigint NOT NULL,
    settingtype character varying(255) NOT NULL,
    settingvalue character varying(255),
    version integer NOT NULL,
    organization_tkey bigint NOT NULL
);


ALTER TABLE bssuser.organizationsetting OWNER TO bssuser;

--
-- Name: organizationtocountry; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationtocountry (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    organization_tkey bigint,
    supportedcountry_tkey bigint
);


ALTER TABLE bssuser.organizationtocountry OWNER TO bssuser;

--
-- Name: organizationtocountryhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationtocountryhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint,
    supportedcountryobjkey bigint,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.organizationtocountryhistory OWNER TO bssuser;

--
-- Name: organizationtorole; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationtorole (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    organization_tkey bigint NOT NULL,
    organizationrole_tkey bigint NOT NULL
);


ALTER TABLE bssuser.organizationtorole OWNER TO bssuser;

--
-- Name: organizationtorolehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE organizationtorolehistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationroletkey bigint NOT NULL,
    organizationtkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.organizationtorolehistory OWNER TO bssuser;

--
-- Name: parameter; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parameter (
    tkey bigint NOT NULL,
    configurable boolean NOT NULL,
    value character varying(255),
    version integer NOT NULL,
    parameterdefinitionkey bigint NOT NULL,
    parametersetkey bigint NOT NULL
);


ALTER TABLE bssuser.parameter OWNER TO bssuser;

--
-- Name: parameterdefinition; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parameterdefinition (
    tkey bigint NOT NULL,
    configurable boolean NOT NULL,
    defaultvalue character varying(255),
    mandatory boolean NOT NULL,
    maximumvalue bigint,
    minimumvalue bigint,
    parameterid character varying(255) NOT NULL,
    parametertype character varying(255) NOT NULL,
    valuetype character varying(255) NOT NULL,
    version integer NOT NULL,
    technicalproduct_tkey bigint,
    modificationtype character varying(255) NOT NULL
);


ALTER TABLE bssuser.parameterdefinition OWNER TO bssuser;

--
-- Name: parameterdefinitionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parameterdefinitionhistory (
    tkey bigint NOT NULL,
    configurable boolean NOT NULL,
    defaultvalue character varying(255),
    mandatory boolean NOT NULL,
    maximumvalue bigint,
    minimumvalue bigint,
    parameterid character varying(255) NOT NULL,
    parametertype character varying(255) NOT NULL,
    valuetype character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    technicalproductobjkey bigint,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    modificationtype character varying(255) NOT NULL
);


ALTER TABLE bssuser.parameterdefinitionhistory OWNER TO bssuser;

--
-- Name: parameterhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parameterhistory (
    tkey bigint NOT NULL,
    configurable boolean NOT NULL,
    value character varying(255),
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    parameterdefinitionobjkey bigint NOT NULL,
    parametersetobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.parameterhistory OWNER TO bssuser;

--
-- Name: parameteroption; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parameteroption (
    tkey bigint NOT NULL,
    optionid character varying(255) NOT NULL,
    version integer NOT NULL,
    parameterdefinition_tkey bigint NOT NULL
);


ALTER TABLE bssuser.parameteroption OWNER TO bssuser;

--
-- Name: parameteroptionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parameteroptionhistory (
    tkey bigint NOT NULL,
    optionid character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    parameterdefobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.parameteroptionhistory OWNER TO bssuser;

--
-- Name: parameterset; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parameterset (
    tkey bigint NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.parameterset OWNER TO bssuser;

--
-- Name: parametersethistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE parametersethistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.parametersethistory OWNER TO bssuser;

--
-- Name: paymentinfo; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE paymentinfo (
    tkey bigint NOT NULL,
    creationtime bigint NOT NULL,
    externalidentifier character varying(255),
    version integer NOT NULL,
    paymenttype_tkey bigint NOT NULL,
    paymentinfoid character varying(255) NOT NULL,
    organization_tkey bigint NOT NULL,
    providername character varying(255),
    accountnumber character varying(255)
);


ALTER TABLE bssuser.paymentinfo OWNER TO bssuser;

--
-- Name: paymentinfohistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE paymentinfohistory (
    tkey bigint NOT NULL,
    creationtime bigint NOT NULL,
    externalidentifier character varying(255),
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    paymenttypeobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    paymentinfoid character varying(255),
    organizationobjkey bigint,
    providername character varying(255),
    accountnumber character varying(255)
);


ALTER TABLE bssuser.paymentinfohistory OWNER TO bssuser;

--
-- Name: paymentresult; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE paymentresult (
    tkey bigint NOT NULL,
    processingexception text,
    processingresult text,
    processingstatus character varying(255) NOT NULL,
    processingtime bigint NOT NULL,
    version integer NOT NULL,
    billingresult_tkey bigint NOT NULL
);


ALTER TABLE bssuser.paymentresult OWNER TO bssuser;

--
-- Name: paymentresulthistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE paymentresulthistory (
    tkey bigint NOT NULL,
    processingexception text,
    processingresult text,
    processingstatus character varying(255) NOT NULL,
    processingtime bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    billingresultobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.paymentresulthistory OWNER TO bssuser;

--
-- Name: paymenttype; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE paymenttype (
    tkey bigint NOT NULL,
    collectiontype character varying(255) NOT NULL,
    paymenttypeid character varying(255) NOT NULL,
    version integer NOT NULL,
    psp_tkey bigint NOT NULL
);


ALTER TABLE bssuser.paymenttype OWNER TO bssuser;

--
-- Name: paymenttypehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE paymenttypehistory (
    tkey bigint NOT NULL,
    objversion bigint NOT NULL,
    objkey bigint NOT NULL,
    invocationdate timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    pspobjkey bigint NOT NULL,
    collectiontype character varying(255) NOT NULL,
    paymenttypeid character varying(255) NOT NULL
);


ALTER TABLE bssuser.paymenttypehistory OWNER TO bssuser;

--
-- Name: platformsetting; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE platformsetting (
    tkey bigint NOT NULL,
    settingtype character varying(255) NOT NULL,
    settingvalue character varying(255),
    version integer NOT NULL
);


ALTER TABLE bssuser.platformsetting OWNER TO bssuser;

--
-- Name: platformuser; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE platformuser (
    tkey bigint NOT NULL,
    additionalname character varying(255),
    address character varying(255),
    creationdate bigint NOT NULL,
    email character varying(255),
    failedlogincounter integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    locale character varying(255) NOT NULL,
    phone character varying(255),
    salutation character varying(255),
    status character varying(255) NOT NULL,
    passwordsalt bigint DEFAULT 0 NOT NULL,
    passwordhash bytea,
    userid character varying(255) NOT NULL,
    version integer NOT NULL,
    organizationkey bigint NOT NULL,
    useridcnt bigint,
    olduserid character varying(255),
    realmuserid character varying(255),
    passwordrecoverystartdate bigint DEFAULT 0 NOT NULL
);


ALTER TABLE bssuser.platformuser OWNER TO bssuser;

--
-- Name: platformuserhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE platformuserhistory (
    tkey bigint NOT NULL,
    additionalname character varying(255),
    address character varying(255),
    creationdate bigint NOT NULL,
    email character varying(255),
    failedlogincounter integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    locale character varying(255) NOT NULL,
    phone character varying(255),
    salutation character varying(255),
    status character varying(255) NOT NULL,
    passwordsalt bigint DEFAULT 0 NOT NULL,
    passwordhash bytea,
    userid character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    realmuserid character varying(255),
    passwordrecoverystartdate bigint DEFAULT 0 NOT NULL
);


ALTER TABLE bssuser.platformuserhistory OWNER TO bssuser;

--
-- Name: pricedevent; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedevent (
    tkey bigint NOT NULL,
    eventprice numeric NOT NULL,
    version integer NOT NULL,
    eventkey bigint NOT NULL,
    pricemodelkey bigint NOT NULL
);


ALTER TABLE bssuser.pricedevent OWNER TO bssuser;

--
-- Name: pricedeventhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedeventhistory (
    tkey bigint NOT NULL,
    eventprice numeric NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    eventobjkey bigint NOT NULL,
    pricemodelobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.pricedeventhistory OWNER TO bssuser;

--
-- Name: pricedoption; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedoption (
    tkey bigint NOT NULL,
    pricepersubscription numeric NOT NULL,
    priceperuser numeric NOT NULL,
    version integer NOT NULL,
    parameteroptionkey bigint,
    pricedparameter_tkey bigint
);


ALTER TABLE bssuser.pricedoption OWNER TO bssuser;

--
-- Name: pricedoptionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedoptionhistory (
    tkey bigint NOT NULL,
    pricepersubscription numeric NOT NULL,
    priceperuser numeric NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    parameteroptionobjkey bigint NOT NULL,
    pricedparameterobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.pricedoptionhistory OWNER TO bssuser;

--
-- Name: pricedparameter; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedparameter (
    tkey bigint NOT NULL,
    pricepersubscription numeric NOT NULL,
    priceperuser numeric NOT NULL,
    version integer NOT NULL,
    parameter_tkey bigint,
    pricemodelkey bigint
);


ALTER TABLE bssuser.pricedparameter OWNER TO bssuser;

--
-- Name: pricedparameterhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedparameterhistory (
    tkey bigint NOT NULL,
    pricepersubscription numeric NOT NULL,
    priceperuser numeric NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    parameterobjkey bigint NOT NULL,
    pricemodelobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.pricedparameterhistory OWNER TO bssuser;

--
-- Name: pricedproductrole; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedproductrole (
    tkey bigint NOT NULL,
    priceperuser numeric NOT NULL,
    version integer NOT NULL,
    pricemodel_tkey bigint,
    pricedoption_tkey bigint,
    pricedparameter_tkey bigint,
    roledefinition_tkey bigint NOT NULL
);


ALTER TABLE bssuser.pricedproductrole OWNER TO bssuser;

--
-- Name: pricedproductrolehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricedproductrolehistory (
    tkey bigint NOT NULL,
    priceperuser numeric NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    pricemodelobjkey bigint,
    pricedoptionobjkey bigint,
    pricedparameterobjkey bigint,
    roledefinitionobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.pricedproductrolehistory OWNER TO bssuser;

--
-- Name: pricemodel; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricemodel (
    tkey bigint NOT NULL,
    onetimefee numeric NOT NULL,
    period character varying(255),
    priceperperiod numeric NOT NULL,
    priceperuserassignment numeric NOT NULL,
    version integer NOT NULL,
    currency_tkey bigint,
    freeperiod integer DEFAULT 0 NOT NULL,
    type character varying(255) NOT NULL,
    provisioningcompleted boolean DEFAULT true NOT NULL
);


ALTER TABLE bssuser.pricemodel OWNER TO bssuser;

--
-- Name: pricemodelhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pricemodelhistory (
    tkey bigint NOT NULL,
    onetimefee numeric NOT NULL,
    period character varying(255),
    priceperperiod numeric NOT NULL,
    priceperuserassignment numeric NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    currencyobjkey bigint,
    productobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    freeperiod integer DEFAULT 0 NOT NULL,
    type character varying(255),
    provisioningcompleted boolean DEFAULT true NOT NULL
);


ALTER TABLE bssuser.pricemodelhistory OWNER TO bssuser;

--
-- Name: product; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE product (
    tkey bigint NOT NULL,
    deprovisioningdate bigint,
    productid character varying(255) NOT NULL,
    provisioningdate bigint NOT NULL,
    status character varying(255) NOT NULL,
    version integer NOT NULL,
    vendorkey bigint NOT NULL,
    parameterset_tkey bigint,
    pricemodel_tkey bigint,
    targetcustomer_tkey bigint,
    technicalproduct_tkey bigint NOT NULL,
    template_tkey bigint,
    type character varying(255) NOT NULL,
    autoassignuserenabled boolean DEFAULT false,
    configuratorurl character varying(512) DEFAULT NULL::character varying
);


ALTER TABLE bssuser.product OWNER TO bssuser;

--
-- Name: productfeedback; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE productfeedback (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    averagerating numeric(3,2) NOT NULL,
    product_tkey bigint NOT NULL
);


ALTER TABLE bssuser.productfeedback OWNER TO bssuser;

--
-- Name: producthistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE producthistory (
    tkey bigint NOT NULL,
    deprovisioningdate bigint,
    productid character varying(255) NOT NULL,
    provisioningdate bigint NOT NULL,
    status character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    parametersetobjkey bigint,
    pricemodelobjkey bigint,
    vendorobjkey bigint NOT NULL,
    targetcustomerobjkey bigint,
    technicalproductobjkey bigint NOT NULL,
    templateobjkey bigint,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    type character varying(255),
    autoassignuserenabled boolean DEFAULT false,
    configuratorurl character varying(512) DEFAULT NULL::character varying
);


ALTER TABLE bssuser.producthistory OWNER TO bssuser;

--
-- Name: productreference; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE productreference (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    sourceproduct_tkey bigint NOT NULL,
    targetproduct_tkey bigint NOT NULL
);


ALTER TABLE bssuser.productreference OWNER TO bssuser;

--
-- Name: productreferencehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE productreferencehistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    sourceproducttkey bigint NOT NULL,
    targetproducttkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.productreferencehistory OWNER TO bssuser;

--
-- Name: productreview; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE productreview (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    rating integer NOT NULL,
    title character varying(255) NOT NULL,
    comment character varying(2000) NOT NULL,
    modificationdate bigint NOT NULL,
    platformuser_tkey bigint NOT NULL,
    productfeedback_tkey bigint NOT NULL
);


ALTER TABLE bssuser.productreview OWNER TO bssuser;

--
-- Name: productreviewhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE productreviewhistory (
    tkey bigint NOT NULL,
    objversion bigint NOT NULL,
    objkey bigint NOT NULL,
    invocationdate timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    rating integer NOT NULL,
    title character varying(255) NOT NULL,
    comment character varying(2000) NOT NULL,
    modificationdate bigint NOT NULL,
    platformuserobjkey bigint NOT NULL,
    productfeedbackobjkey bigint NOT NULL
);


ALTER TABLE bssuser.productreviewhistory OWNER TO bssuser;

--
-- Name: producttopaymenttype; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE producttopaymenttype (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    product_tkey bigint NOT NULL,
    paymenttype_tkey bigint NOT NULL
);


ALTER TABLE bssuser.producttopaymenttype OWNER TO bssuser;

--
-- Name: producttopaymenttypehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE producttopaymenttypehistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    productobjkey bigint NOT NULL,
    paymenttypeobjkey bigint NOT NULL
);


ALTER TABLE bssuser.producttopaymenttypehistory OWNER TO bssuser;

--
-- Name: psp; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE psp (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    identifier character varying(255) NOT NULL,
    wsdlurl character varying(255) NOT NULL,
    distinguishedname character varying(4096)
);


ALTER TABLE bssuser.psp OWNER TO bssuser;

--
-- Name: pspaccount; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pspaccount (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    pspidentifier character varying(255) NOT NULL,
    psp_tkey bigint NOT NULL,
    organization_tkey bigint NOT NULL
);


ALTER TABLE bssuser.pspaccount OWNER TO bssuser;

--
-- Name: pspaccounthistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pspaccounthistory (
    tkey bigint NOT NULL,
    objversion bigint NOT NULL,
    objkey bigint NOT NULL,
    invocationdate timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    pspidentifier character varying(255) NOT NULL,
    pspobjkey bigint NOT NULL,
    organizationobjkey bigint NOT NULL
);


ALTER TABLE bssuser.pspaccounthistory OWNER TO bssuser;

--
-- Name: psphistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE psphistory (
    tkey bigint NOT NULL,
    objversion bigint NOT NULL,
    objkey bigint NOT NULL,
    invocationdate timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    identifier character varying(255) NOT NULL,
    wsdlurl character varying(255) NOT NULL,
    distinguishedname character varying(4096)
);


ALTER TABLE bssuser.psphistory OWNER TO bssuser;

--
-- Name: pspsetting; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pspsetting (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    settingkey character varying(255) NOT NULL,
    settingvalue character varying(255) NOT NULL,
    psp_tkey bigint NOT NULL
);


ALTER TABLE bssuser.pspsetting OWNER TO bssuser;

--
-- Name: pspsettinghistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE pspsettinghistory (
    tkey bigint NOT NULL,
    objversion bigint NOT NULL,
    objkey bigint NOT NULL,
    invocationdate timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    settingkey character varying(255) NOT NULL,
    settingvalue character varying(255) NOT NULL,
    pspobjkey bigint NOT NULL
);


ALTER TABLE bssuser.pspsettinghistory OWNER TO bssuser;

--
-- Name: publiclandingpage; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE publiclandingpage (
    tkey bigint NOT NULL,
    numberservices integer NOT NULL,
    fillincriterion character varying(25) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.publiclandingpage OWNER TO bssuser;

--
-- Name: report; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE report (
    tkey bigint NOT NULL,
    reportname character varying(255) NOT NULL,
    version integer NOT NULL,
    organizationrole_tkey bigint NOT NULL
);


ALTER TABLE bssuser.report OWNER TO bssuser;

--
-- Name: reportresultcache; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE reportresultcache (
    tkey bigint NOT NULL,
    cachekey character varying(255) NOT NULL,
    version integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    report bytea
);


ALTER TABLE bssuser.reportresultcache OWNER TO bssuser;

--
-- Name: revenuesharemodel; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE revenuesharemodel (
    tkey bigint NOT NULL,
    revenueshare numeric(5,2) NOT NULL,
    revenuesharemodeltype character varying(255) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.revenuesharemodel OWNER TO bssuser;

--
-- Name: revenuesharemodelhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE revenuesharemodelhistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    revenueshare numeric(5,2) NOT NULL,
    revenuesharemodeltype character varying(255) NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.revenuesharemodelhistory OWNER TO bssuser;

--
-- Name: roleassignment; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE roleassignment (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    user_tkey bigint NOT NULL,
    userrole_tkey bigint NOT NULL
);


ALTER TABLE bssuser.roleassignment OWNER TO bssuser;

--
-- Name: roleassignmenthistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE roleassignmenthistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    userobjkey bigint NOT NULL,
    userroleobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.roleassignmenthistory OWNER TO bssuser;

--
-- Name: roledefinition; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE roledefinition (
    tkey bigint NOT NULL,
    roleid character varying(255) NOT NULL,
    version integer NOT NULL,
    technicalproduct_tkey bigint NOT NULL
);


ALTER TABLE bssuser.roledefinition OWNER TO bssuser;

--
-- Name: roledefinitionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE roledefinitionhistory (
    tkey bigint NOT NULL,
    roleid character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    technicalproductobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.roledefinitionhistory OWNER TO bssuser;

--
-- Name: session; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE session (
    tkey bigint NOT NULL,
    nodename character varying(255) NOT NULL,
    platformuserid character varying(255) NOT NULL,
    platformuserkey bigint NOT NULL,
    sessionid character varying(255),
    sessiontype character varying(255),
    subscriptiontkey bigint,
    usertoken character varying(255),
    version integer NOT NULL
);


ALTER TABLE bssuser.session OWNER TO bssuser;

--
-- Name: steppedprice; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE steppedprice (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    pricemodel_tkey bigint,
    pricedevent_tkey bigint,
    pricedparameter_tkey bigint,
    upperlimit bigint,
    price numeric NOT NULL,
    additionalprice numeric NOT NULL,
    freeentitycount bigint NOT NULL
);


ALTER TABLE bssuser.steppedprice OWNER TO bssuser;

--
-- Name: steppedpricehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE steppedpricehistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    pricemodelobjkey bigint,
    pricedeventobjkey bigint,
    pricedparameterobjkey bigint,
    upperlimit bigint,
    price numeric NOT NULL,
    additionalprice numeric NOT NULL,
    freeentitycount bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.steppedpricehistory OWNER TO bssuser;

--
-- Name: subscription; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE subscription (
    tkey bigint NOT NULL,
    accessinfo character varying(4096),
    activationdate bigint,
    baseurl character varying(255),
    creationdate bigint NOT NULL,
    deactivationdate bigint,
    loginpath character varying(255),
    productinstanceid character varying(255),
    purchaseordernumber character varying(255),
    status character varying(255) NOT NULL,
    subscriptionid character varying(255) NOT NULL,
    timeoutmailsent boolean NOT NULL,
    version integer NOT NULL,
    organizationkey bigint NOT NULL,
    product_tkey bigint NOT NULL,
    marketplace_tkey bigint,
    paymentinfo_tkey bigint,
    billingcontact_tkey bigint,
    cutoffday integer NOT NULL,
    owner_tkey bigint,
    asynctempproductkey bigint,
    usergroup_tkey bigint,
    CONSTRAINT subscription_cutoffday CHECK (((cutoffday > 0) AND (cutoffday < 29)))
);


ALTER TABLE bssuser.subscription OWNER TO bssuser;

--
-- Name: subscriptionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE subscriptionhistory (
    tkey bigint NOT NULL,
    accessinfo character varying(4096),
    activationdate bigint,
    baseurl character varying(255),
    creationdate bigint NOT NULL,
    deactivationdate bigint,
    loginpath character varying(255),
    productinstanceid character varying(255),
    purchaseordernumber character varying(255),
    status character varying(255) NOT NULL,
    subscriptionid character varying(255) NOT NULL,
    timeoutmailsent boolean NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    productobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    marketplaceobjkey bigint,
    paymentinfoobjkey bigint,
    billingcontactobjkey bigint,
    cutoffday integer NOT NULL,
    ownerobjkey bigint,
    asynctempproductobjkey bigint,
    usergroupobjkey bigint,
    CONSTRAINT subscriptionhistory_cutoffday CHECK (((cutoffday > 0) AND (cutoffday < 29)))
);


ALTER TABLE bssuser.subscriptionhistory OWNER TO bssuser;

--
-- Name: supportedcountry; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE supportedcountry (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    countryisocode character varying(2)
);


ALTER TABLE bssuser.supportedcountry OWNER TO bssuser;

--
-- Name: supportedcurrency; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE supportedcurrency (
    tkey bigint NOT NULL,
    currencyisocode character varying(255) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.supportedcurrency OWNER TO bssuser;

--
-- Name: supportedlanguage; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE supportedlanguage (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    languageisocode character varying(255) NOT NULL,
    activestatus boolean,
    defaultstatus boolean
);


ALTER TABLE bssuser.supportedlanguage OWNER TO bssuser;

--
-- Name: supportedlanguagehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE supportedlanguagehistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    languageisocode character varying(255) NOT NULL,
    activestatus boolean,
    defaultstatus boolean
);


ALTER TABLE bssuser.supportedlanguagehistory OWNER TO bssuser;

--
-- Name: tag; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE tag (
    tkey bigint NOT NULL,
    locale character varying(255) NOT NULL,
    value character varying(255) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.tag OWNER TO bssuser;

--
-- Name: technicalproduct; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE technicalproduct (
    tkey bigint NOT NULL,
    accesstype character varying(255),
    baseurl character varying(255),
    loginpath character varying(255),
    provisioningpassword character varying(255),
    provisioningtimeout bigint,
    provisioningtype character varying(255),
    provisioningurl character varying(255) NOT NULL,
    provisioningusername character varying(255),
    provisioningversion character varying(255),
    technicalproductbuildid character varying(255),
    technicalproductid character varying(255) NOT NULL,
    version integer NOT NULL,
    organizationkey bigint NOT NULL,
    onlyonesubscriptionallowed boolean DEFAULT false,
    allowingonbehalfacting boolean DEFAULT false NOT NULL,
    billingidentifier character varying(255) NOT NULL
);


ALTER TABLE bssuser.technicalproduct OWNER TO bssuser;

--
-- Name: technicalproducthistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE technicalproducthistory (
    tkey bigint NOT NULL,
    accesstype character varying(255),
    baseurl character varying(255),
    loginpath character varying(255),
    provisioningpassword character varying(255),
    provisioningtimeout bigint,
    provisioningtype character varying(255),
    provisioningurl character varying(255) NOT NULL,
    provisioningusername character varying(255),
    provisioningversion character varying(255),
    technicalproductbuildid character varying(255),
    technicalproductid character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    onlyonesubscriptionallowed boolean DEFAULT false,
    allowingonbehalfacting boolean DEFAULT false NOT NULL,
    billingidentifier character varying(255) NOT NULL
);


ALTER TABLE bssuser.technicalproducthistory OWNER TO bssuser;

--
-- Name: technicalproductoperation; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE technicalproductoperation (
    tkey bigint NOT NULL,
    actionurl character varying(255) NOT NULL,
    operationid character varying(255) NOT NULL,
    version integer NOT NULL,
    technicalproduct_tkey bigint NOT NULL
);


ALTER TABLE bssuser.technicalproductoperation OWNER TO bssuser;

--
-- Name: technicalproductoperationhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE technicalproductoperationhistory (
    tkey bigint NOT NULL,
    actionurl character varying(255) NOT NULL,
    operationid character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    technicalproductobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.technicalproductoperationhistory OWNER TO bssuser;

--
-- Name: technicalproducttag; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE technicalproducttag (
    tkey bigint NOT NULL,
    tag_tkey bigint NOT NULL,
    technicalproduct_tkey bigint NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.technicalproducttag OWNER TO bssuser;

--
-- Name: timerprocessing; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE timerprocessing (
    tkey bigint NOT NULL,
    duration bigint NOT NULL,
    nodename character varying(255) NOT NULL,
    starttime bigint NOT NULL,
    starttimemutex bigint NOT NULL,
    success boolean NOT NULL,
    timertype character varying(255) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.timerprocessing OWNER TO bssuser;

--
-- Name: triggerdefinition; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE triggerdefinition (
    tkey bigint NOT NULL,
    suspendprocess boolean NOT NULL,
    target character varying(255),
    targettype character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    version integer NOT NULL,
    organization_tkey bigint,
    name character varying(255) NOT NULL
);


ALTER TABLE bssuser.triggerdefinition OWNER TO bssuser;

--
-- Name: triggerdefinitionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE triggerdefinitionhistory (
    tkey bigint NOT NULL,
    suspendprocess boolean NOT NULL,
    target character varying(255),
    targettype character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE bssuser.triggerdefinitionhistory OWNER TO bssuser;

--
-- Name: triggerprocess; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE triggerprocess (
    tkey bigint NOT NULL,
    activationdate bigint NOT NULL,
    status character varying(255) NOT NULL,
    version integer NOT NULL,
    triggerdefinition_tkey bigint NOT NULL,
    user_tkey bigint
);


ALTER TABLE bssuser.triggerprocess OWNER TO bssuser;

--
-- Name: triggerprocesshistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE triggerprocesshistory (
    tkey bigint NOT NULL,
    activationdate bigint NOT NULL,
    status character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    triggerdefinitionobjkey bigint NOT NULL,
    userobjkey bigint,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.triggerprocesshistory OWNER TO bssuser;

--
-- Name: triggerprocessidentifier; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE triggerprocessidentifier (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    triggerprocess_tkey bigint NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE bssuser.triggerprocessidentifier OWNER TO bssuser;

--
-- Name: triggerprocessparameter; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE triggerprocessparameter (
    tkey bigint NOT NULL,
    name character varying(255) NOT NULL,
    serializedvalue text,
    version integer NOT NULL,
    triggerprocess_tkey bigint NOT NULL,
    serialized boolean DEFAULT false NOT NULL
);


ALTER TABLE bssuser.triggerprocessparameter OWNER TO bssuser;

--
-- Name: uda; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE uda (
    tkey bigint NOT NULL,
    udadefinitionkey bigint NOT NULL,
    targetobjectkey bigint NOT NULL,
    udavalue character varying(255),
    version integer NOT NULL
);


ALTER TABLE bssuser.uda OWNER TO bssuser;

--
-- Name: udadefinition; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE udadefinition (
    tkey bigint NOT NULL,
    defaultvalue character varying(255),
    targettype character varying(255) NOT NULL,
    udaid character varying(255) NOT NULL,
    version integer NOT NULL,
    organizationkey bigint NOT NULL,
    configurationtype character varying(255) NOT NULL
);


ALTER TABLE bssuser.udadefinition OWNER TO bssuser;

--
-- Name: udadefinitionhistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE udadefinitionhistory (
    tkey bigint NOT NULL,
    defaultvalue character varying(255),
    targettype character varying(255) NOT NULL,
    udaid character varying(255) NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    configurationtype character varying(255) NOT NULL
);


ALTER TABLE bssuser.udadefinitionhistory OWNER TO bssuser;

--
-- Name: udahistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE udahistory (
    tkey bigint NOT NULL,
    targetobjectkey bigint NOT NULL,
    udavalue character varying(255),
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    udadefinitionobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.udahistory OWNER TO bssuser;

--
-- Name: unitroleassignment; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE unitroleassignment (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    usergrouptouser_tkey bigint NOT NULL,
    unituserrole_tkey bigint NOT NULL
);


ALTER TABLE bssuser.unitroleassignment OWNER TO bssuser;

--
-- Name: unituserrole; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE unituserrole (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    rolename character varying(255) NOT NULL
);


ALTER TABLE bssuser.unituserrole OWNER TO bssuser;

--
-- Name: usagelicense; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE usagelicense (
    tkey bigint NOT NULL,
    applicationuserid character varying(255),
    assignmentdate bigint NOT NULL,
    version integer NOT NULL,
    roledefinition_tkey bigint,
    subscription_tkey bigint NOT NULL,
    user_tkey bigint NOT NULL
);


ALTER TABLE bssuser.usagelicense OWNER TO bssuser;

--
-- Name: usagelicensehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE usagelicensehistory (
    tkey bigint NOT NULL,
    applicationuserid character varying(255),
    assignmentdate bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    roledefinitionobjkey bigint,
    subscriptionobjkey bigint NOT NULL,
    userobjkey bigint NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.usagelicensehistory OWNER TO bssuser;

--
-- Name: usergroup; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE usergroup (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    name character varying(256) NOT NULL,
    description character varying(255),
    isdefault boolean NOT NULL,
    organization_tkey bigint NOT NULL,
    referenceid character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE bssuser.usergroup OWNER TO bssuser;

--
-- Name: usergrouphistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE usergrouphistory (
    tkey bigint NOT NULL,
    name character varying(256) NOT NULL,
    description character varying(255),
    isdefault boolean NOT NULL,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    organizationobjkey bigint NOT NULL,
    referenceid character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE bssuser.usergrouphistory OWNER TO bssuser;

--
-- Name: usergrouptoinvisibleproduct; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE usergrouptoinvisibleproduct (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    product_tkey bigint,
    usergroup_tkey bigint
);


ALTER TABLE bssuser.usergrouptoinvisibleproduct OWNER TO bssuser;

--
-- Name: usergrouptouser; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE usergrouptouser (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    usergroup_tkey bigint,
    platformuser_tkey bigint
);


ALTER TABLE bssuser.usergrouptouser OWNER TO bssuser;

--
-- Name: userrole; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE userrole (
    tkey bigint NOT NULL,
    rolename character varying(255) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE bssuser.userrole OWNER TO bssuser;

--
-- Name: vatrate; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE vatrate (
    tkey bigint NOT NULL,
    version integer NOT NULL,
    rate numeric(5,2) NOT NULL,
    owningorganization_tkey bigint NOT NULL,
    targetcountry_tkey bigint,
    targetorganization_tkey bigint
);


ALTER TABLE bssuser.vatrate OWNER TO bssuser;

--
-- Name: vatratehistory; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE vatratehistory (
    tkey bigint NOT NULL,
    moddate timestamp without time zone NOT NULL,
    modtype character varying(255) NOT NULL,
    moduser character varying(255) NOT NULL,
    objkey bigint NOT NULL,
    objversion bigint NOT NULL,
    rate numeric(5,2) NOT NULL,
    owningorganizationobjkey bigint NOT NULL,
    targetcountryobjkey bigint,
    targetorganizationobjkey bigint,
    invocationdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE bssuser.vatratehistory OWNER TO bssuser;

--
-- Name: version; Type: TABLE; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE TABLE version (
    productmajorversion integer NOT NULL,
    productminorversion integer NOT NULL,
    schemaversion integer NOT NULL,
    migrationdate timestamp without time zone
);


ALTER TABLE bssuser.version OWNER TO bssuser;

--
-- Data for Name: auditlog; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY auditlog (tkey, operationid, operationname, userid, organizationid, organizationname, log, creationtime) FROM stdin;
32	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName=""|parameterName="CONCURRENT_USER"|userOption="OFF"|parameterValue="3"|	1445419082981
33	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName=""|parameterName="NAMED_USER"|userOption="OFF"|parameterValue="2"|	1445419082981
34	30090	DEFINE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|technServiceName="MockService"|shortDescription="YES"|description="YES"|locale="en"|autoAssignUser="NO"|	1445419082981
35	30091	SET_SERVICE_AS_PUBLIC	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|public="true"|	1445419083168
36	30092	ASSIGN_SERVICE_TO_MARKETPLACE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|marketplaceId="924f4415"|marketplaceName="Global Marketplace"|	1445419083168
37	30090	DEFINE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|technServiceName="MockService"|shortDescription="YES"|description="YES"|locale="en"|autoAssignUser="NO"|	1445419083745
38	30091	SET_SERVICE_AS_PUBLIC	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|public="true"|	1445419083839
39	30092	ASSIGN_SERVICE_TO_MARKETPLACE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|marketplaceId="924f4415"|marketplaceName="Global Marketplace"|	1445419083839
40	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="CONCURRENT_USER"|userOption="OFF"|parameterValue="10"|	1445419084385
41	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="MEMORY_STORAGE"|userOption="ON"|parameterValue="Optimum storage (2GB)"|	1445419084385
42	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="DISK_SPACE"|userOption="ON"|parameterValue=""|	1445419084385
43	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="MAX_FOLDER_NUMBER2"|userOption="ON"|parameterValue="200"|	1445419084385
44	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="STRING_DATA_TYPE"|userOption="ON"|parameterValue=""|	1445419084385
45	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="MAX_FILE_NUMBER"|userOption="ON"|parameterValue="200"|	1445419084385
46	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="MAX_FOLDER_NUMBER"|userOption="ON"|parameterValue="200"|	1445419084385
47	30097	UPDATE_SERVICE_PARAMETERS	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName=""|parameterName="RENAME_FOLDER"|userOption="ON"|parameterValue="YES"|	1445419084385
48	30090	DEFINE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|technServiceName="MockService"|shortDescription="YES"|description="YES"|locale="en"|autoAssignUser="NO"|	1445419084385
49	30091	SET_SERVICE_AS_PUBLIC	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|public="true"|	1445419084525
50	30092	ASSIGN_SERVICE_TO_MARKETPLACE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|marketplaceId="924f4415"|marketplaceName="Global Marketplace"|	1445419084525
51	30062	EDIT_FREE_PRICE_MODEL_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|	1445419085165
52	30072	LOCALIZE_PRICE_MODEL_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|locale="en"|description="YES"|license="YES"|	1445419085165
53	30062	EDIT_FREE_PRICE_MODEL_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|	1445419085633
54	30072	LOCALIZE_PRICE_MODEL_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|locale="en"|description="YES"|license="YES"|	1445419085633
55	30051	EDIT_CHARGEABLE_PRICE_MODEL_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|currency="EUR"|timeUnit="MONTH"|calculationMode="PRO_RATA"|trialPeriod="OFF"|daysOfTrial="0"|	1445419086085
56	30054	EDIT_SUBSCRIPTION_PRICE_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|currency="EUR"|timeUnit="MONTH"|oneTimeFee="50"|recurringCharge="50"|	1445419086085
57	30070	EDIT_ONETIME_FEE_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|currency="EUR"|timeUnit="MONTH"|oneTimeFee="50"|	1445419086085
58	30072	LOCALIZE_PRICE_MODEL_FOR_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|locale="en"|description="YES"|license="YES"|	1445419086085
59	30101	DEFINE_UPGRADE_DOWNGRADE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|targetId="ServiceStarter"|targetName="Trial"|upDownGrade="ON"|	1445419086319
60	30101	DEFINE_UPGRADE_DOWNGRADE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|targetId="ServiceProfessional"|targetName="Trial"|upDownGrade="ON"|	1445419086319
61	30101	DEFINE_UPGRADE_DOWNGRADE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|targetId="ServiceTrial"|targetName="Starter"|upDownGrade="ON"|	1445419086507
62	30101	DEFINE_UPGRADE_DOWNGRADE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|targetId="ServiceProfessional"|targetName="Starter"|upDownGrade="ON"|	1445419086507
63	30102	ACTIVATE_DEACTIVATE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceTrial"|serviceName="Trial"|marketplaceId="924f4415"|marketplaceName="Global Marketplace"|activation="ON"|inCatalog="ON"|	1445419090204
64	30102	ACTIVATE_DEACTIVATE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|marketplaceId="924f4415"|marketplaceName="Global Marketplace"|activation="ON"|inCatalog="ON"|	1445419090204
65	30102	ACTIVATE_DEACTIVATE_SERVICE	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceProfessional"|serviceName="Professional"|marketplaceId="924f4415"|marketplaceName="Global Marketplace"|activation="ON"|inCatalog="ON"|	1445419090204
66	30000	SUBSCRIBE_SERVICE	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceTrial"|serviceName="Trial"|subscriptionName="Subscription to Trial Service"|	1445419621346
67	30001	ASSIGN_USER_TO_SUBSCRIPTION	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceTrial"|serviceName="Trial"|subscriptionName="Subscription to Trial Service"|user="customer"|	1445419629364
68	30000	SUBSCRIBE_SERVICE	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceStarter"|serviceName="Starter"|subscriptionName="Subscription to Starter Service"|	1445419754248
69	30001	ASSIGN_USER_TO_SUBSCRIPTION	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceStarter"|serviceName="Starter"|subscriptionName="Subscription to Starter Service"|user="customer"|	1445419759708
70	30005	EDIT_SUBSCRIPTION_PARAMETER_CONFIGURATION	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceProfessional"|serviceName="Professional"|subscriptionName="Professional"|parameterName="DISK_SPACE"|parameterValue="Minimum Storage (100GB)"|	1445419834544
71	30000	SUBSCRIBE_SERVICE	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceProfessional"|serviceName="Professional"|subscriptionName="Professional"|	1445419834544
72	30001	ASSIGN_USER_TO_SUBSCRIPTION	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceProfessional"|serviceName="Professional"|subscriptionName="Subscription to Professional Service"|user="customer"|	1445419940880
73	30009	EXECUTE_SERVICE_OPERATION	customer	9d7e9cfc	CustomerOrganization	|serviceId="ServiceTrial"|serviceName="Trial"|subscriptionName="Subscription to Trial Service"|serviceOperation="HELP"|	1445420261408
74	30012	VIEW_SUBSCRIPTION	admin	e03659fb	TechProvAndSupplier	|serviceId="ServiceStarter"|serviceName="Starter"|subscriptionName="Subscription to Starter Service"|customerKey="9d7e9cfc"|customerName="CustomerOrganization"|	1445421714785
\.


--
-- Data for Name: billingadapter; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY billingadapter (tkey, billingidentifier, name, connectionproperties, defaultadapter, version) FROM stdin;
1	NATIVE_BILLING	Native CT-MG Billing	\N	t	0
\.


--
-- Data for Name: billingcontact; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY billingcontact (tkey, address, companyname, email, orgaddressused, version, organization_tkey, billingcontactid) FROM stdin;
10000	Bahnhofweg 6\n81735 Munich	Customer Organization	customer@oscm.org	f	0	10003	Billing Address
\.


--
-- Data for Name: billingcontacthistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY billingcontacthistory (tkey, address, companyname, email, orgaddressused, moddate, modtype, moduser, objkey, objversion, organizationobjkey, invocationdate, billingcontactid) FROM stdin;
10000	Bahnhofweg 6\n81735 Munich	Customer Organization	customer@oscm.org	f	2015-10-21 11:30:23.234	ADD	10003	10000	0	10003	2015-10-21 11:30:23.234	Billing Address
\.


--
-- Data for Name: billingresult; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY billingresult (tkey, creationtime, organizationtkey, periodendtime, periodstarttime, resultxml, version, chargingorgkey, subscriptionkey, currency_tkey, grossamount, vendorkey, netamount, usergroup_tkey) FROM stdin;
\.


--
-- Data for Name: billingsharesresult; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY billingsharesresult (tkey, periodstarttime, periodendtime, organizationtkey, resulttype, resultxml, creationtime, version) FROM stdin;
\.


--
-- Data for Name: billingsubscriptionstatus; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY billingsubscriptionstatus (tkey, subscriptionkey, endoflastbilledperiod, version) FROM stdin;
\.


--
-- Data for Name: catalogentry; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY catalogentry (tkey, version, product_tkey, anonymousvisible, marketplace_tkey, visibleincatalog, brokerpricemodel_tkey, resellerpricemodel_tkey, operatorpricemodel_tkey) FROM stdin;
10003	1	10003	t	10004	t	\N	\N	10024
10004	1	10004	t	10004	t	\N	\N	10025
10005	1	10005	t	10004	t	\N	\N	10026
\.


--
-- Data for Name: catalogentryhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY catalogentryhistory (tkey, moddate, modtype, moduser, objkey, objversion, productobjkey, anonymousvisible, marketplaceobjkey, invocationdate, visibleincatalog, brokerpricemodelobjkey, resellerpricemodelobjkey, operatorpricemodelobjkey) FROM stdin;
10006	2015-10-21 11:18:02.56	ADD	10002	10003	0	10003	f	\N	2015-10-21 11:18:02.56	f	\N	\N	10024
10007	2015-10-21 11:18:03.106	MODIFY	10002	10003	1	10003	t	10004	2015-10-21 11:18:03.106	t	\N	\N	10024
10008	2015-10-21 11:18:03.574	ADD	10002	10004	0	10004	f	\N	2015-10-21 11:18:03.574	f	\N	\N	10025
10009	2015-10-21 11:18:03.808	MODIFY	10002	10004	1	10004	t	10004	2015-10-21 11:18:03.808	t	\N	\N	10025
10010	2015-10-21 11:18:04.229	ADD	10002	10005	0	10005	f	\N	2015-10-21 11:18:04.229	f	\N	\N	10026
10011	2015-10-21 11:18:04.447	MODIFY	10002	10005	1	10005	t	10004	2015-10-21 11:18:04.447	t	\N	\N	10026
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY category (tkey, version, marketplacekey, categoryid) FROM stdin;
\.


--
-- Data for Name: categoryhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY categoryhistory (tkey, moddate, modtype, moduser, objkey, objversion, invocationdate, marketplaceobjkey, categoryid) FROM stdin;
\.


--
-- Data for Name: categorytocatalogentry; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY categorytocatalogentry (tkey, version, catalogentry_tkey, category_tkey) FROM stdin;
\.


--
-- Data for Name: categorytocatalogentryhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY categorytocatalogentryhistory (tkey, moddate, modtype, moduser, objkey, objversion, invocationdate, catalogentry_tkey, category_tkey) FROM stdin;
\.


--
-- Data for Name: configurationsetting; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY configurationsetting (tkey, context_id, information_id, env_value, version) FROM stdin;
3	global	LOG_LEVEL	INFO	0
4	global	LOG_FILE_PATH	../logs	0
5	global	LOG_CONFIG_FILE	./log4j.properties	0
6	global	PERMITTED_PERIOD_UNCONFIRMED_ORGANIZATIONS	604800000	0
7	global	TIMER_INTERVAL_ORGANIZATION	86400000	0
8	global	TIMER_INTERVAL_ORGANIZATION_OFFSET	0	0
9	global	TIMER_INTERVAL_SUBSCRIPTION_EXPIRATION	21600000	0
10	global	TIMER_INTERVAL_SUBSCRIPTION_EXPIRATION_OFFSET	0	0
14	global	PSP_USAGE_ENABLED	false	0
15	global	TIMER_INTERVAL_BILLING_OFFSET	345600000	0
16	global	HIDDEN_UI_ELEMENTS	operator.manageBillingAdapters,techService.viewBillingAdapters	0
19	global	IDP_ASSERTION_EXPIRATION	1800000	0
20	global	IDP_ASSERTION_VALIDITY_TOLERANCE	600000	0
21	global	TAGGING_MAX_TAGS	20	0
22	global	TAGGING_MIN_SCORE	1	0
23	global	WS_TIMEOUT	30000	0
24	global	SEARCH_INDEX_MASTER_FACTORY_NAME	jms/bss/masterIndexerQueueFactory	0
25	global	SEARCH_INDEX_MASTER_QUEUE_NAME	jms/bss/masterIndexerQueue	0
26	global	AUTH_MODE	INTERNAL	0
33	global	AUDIT_LOG_ENABLED	true	0
34	global	AUDIT_LOG_MAX_ENTRIES_RETRIEVED	100	0
37	global	MAX_NUMBER_ALLOWED_USERS	10	0
38	global	TIMER_INTERVAL_USER_COUNT	43200000	0
17	global	IDP_PRIVATE_KEY_FILE_PATH	<path>	1
18	global	IDP_PUBLIC_CERTIFICATE_FILE_PATH	<path>	1
1	global	BASE_URL	http://localhost:8080/oscm-portal	2
2	global	BASE_URL_HTTPS	http://localhost:8081/oscm-portal	2
11	global	REPORT_ENGINEURL	http://localhost:8080/birt/frameset?\_\_report\=${reportname}.rptdesign&SessionId\=${sessionid}&\_\_locale\=${locale}&WSDLURL\=${wsdlurl}&SOAPEndPoint\=${soapendpoint}&wsname=Report&wsport=ReportPort	2
13	global	REPORT_SOAP_ENDPOINT	http://localhost:8080/Report/ReportingServiceBean	1
12	global	REPORT_WSDLURL	http://localhost:8080/Report/ReportingServiceBean?wsdl	1
\.


--
-- Data for Name: discount; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY discount (tkey, endtime, starttime, value, version, organizationreference_tkey) FROM stdin;
\.


--
-- Data for Name: discounthistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY discounthistory (tkey, endtime, starttime, value, moddate, modtype, moduser, objkey, objversion, organizationreferenceobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: enterpriselandingpage; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY enterpriselandingpage (tkey, version) FROM stdin;
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY event (tkey, eventidentifier, eventtype, version, technicalproduct_tkey) FROM stdin;
1000	USER_LOGIN_TO_SERVICE	PLATFORM_EVENT	0	\N
1001	USER_LOGOUT_FROM_SERVICE	PLATFORM_EVENT	0	\N
10006	FILE_DOWNLOAD	SERVICE_EVENT	0	10002
10007	FILE_UPLOAD	SERVICE_EVENT	0	10002
10008	FOLDER_NEW	SERVICE_EVENT	0	10002
\.


--
-- Data for Name: eventhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY eventhistory (tkey, eventidentifier, eventtype, moddate, modtype, moduser, objkey, objversion, technicalproductobjkey, invocationdate) FROM stdin;
1000	USER_LOGIN_TO_SERVICE	PLATFORM_EVENT	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1000	0	\N	2015-10-21 11:16:00.664
1001	USER_LOGOUT_FROM_SERVICE	PLATFORM_EVENT	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1001	0	\N	2015-10-21 11:16:00.664
10006	FILE_DOWNLOAD	SERVICE_EVENT	2015-10-21 11:18:00.111	ADD	10002	10006	0	10002	2015-10-21 11:18:00.111
10007	FILE_UPLOAD	SERVICE_EVENT	2015-10-21 11:18:00.111	ADD	10002	10007	0	10002	2015-10-21 11:18:00.111
10008	FOLDER_NEW	SERVICE_EVENT	2015-10-21 11:18:00.111	ADD	10002	10008	0	10002	2015-10-21 11:18:00.111
\.


--
-- Data for Name: gatheredevent; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY gatheredevent (tkey, actor, eventidentifier, multiplier, occurrencetime, subscriptiontkey, type, uniqueid, version, billingresult_tkey) FROM stdin;
\.


--
-- Data for Name: hibernate_sequences; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY hibernate_sequences (sequence_name, sequence_next_hi_value) FROM stdin;
BillingContact	12
BillingContactHistory	12
BillingResult	12
ConfigurationSetting	12
Discount	12
DiscountHistory	12
Event	12
EventHistory	12
GatheredEvent	12
Organization	12
OrganizationHistory	12
OrganizationRole	12
OrganizationSetting	12
Parameter	12
ParameterDefinition	12
ParameterDefinitionHistory	12
ParameterHistory	12
ParameterOption	12
ParameterOptionHistory	12
ParameterSet	12
ParameterSetHistory	12
PaymentResult	12
PaymentResultHistory	12
PaymentType	12
PlatformUser	12
PlatformUserHistory	12
PricedEvent	12
PricedEventHistory	12
PricedOption	12
PricedOptionHistory	12
PricedParameter	12
PricedParameterHistory	12
PricedProductRole	12
PricedProductRoleHistory	12
PriceModel	12
PriceModelHistory	12
Product	12
ProductReference	12
ProductReferenceHistory	12
Report	12
RoleDefinition	12
RoleDefinitionHistory	12
Session	12
SteppedPrice	12
SteppedPriceHistory	12
SupportedCurrency	12
TechnicalProduct	12
TechnicalProductHistory	12
TechnicalProductOperation	12
TechnicalProductOperationHistory	12
TimerProcessing	12
TriggerDefinition	12
TriggerProcess	12
TriggerProcessParameter	12
UdaDefinition	12
UdaDefinitionHistory	12
Uda	12
UdaHistory	12
SupportedCountry	12
OrganizationToCountry	12
OrganizationToCountryHistory	12
VatRate	12
VatRateHistory	12
CatalogEntryHistory	12
Marketplace	12
MarketplaceHistory	12
OrganizationReference	12
Tag	12
TechnicalProductTag	12
UserRole	12
RoleAssignment	12
RoleAssignmentHistory	12
ProductReview	12
ProductReviewHistory	12
ProductFeedback	12
OnBehalfUserReference	12
OnBehalfUserReferenceHistory	12
LocalizedResource	12
ImageResource	12
PaymentInfo	12
PaymentInfoHistory	12
MarketplaceToOrganization	12
MarketplaceToOrganizationHistory	12
ProductToPaymentType	12
ProductToPaymentTypeHistory	12
PSP	12
PSPHistory	12
PaymentTypeHistory	12
PSPAccount	12
PSPAccountHistory	12
OrganizationReferenceHistory	12
MarketingPermission	12
MarketingPermissionHistory	12
TriggerDefinitionHistory	12
TriggerProcessHistory	12
OrganizationToRole	12
OrganizationToRoleHistory	12
OrganizationRefToPaymentType	12
Category	12
CategoryHistory	12
TriggerProcessIdentifier	12
CategoryToCatalogEntry	12
CategoryToCatalogEntryHistory	12
LandingpageProduct	12
ReportResultCache	12
BillingSharesResult	12
PlatformSetting	12
PSPSetting	12
PSPSettingHistory	12
Subscription	12
SubscriptionHistory	12
CatalogEntry	12
UsageLicense	12
UsageLicenseHistory	12
RevenueShareModel	12
RevenueShareModelHistory	12
ProductHistory	12
SupportedLanguage	12
SupportedLanguageHistory	12
OperationParameter	12
OperationParameterHistory	12
PublicLandingpage	12
EnterpriseLandingpage	12
ModifiedEntity	12
ModifiedEntityHistory	12
ModifiedUda	12
ModifiedUdaHistory	12
UserGroup	12
UserGroupToUser	12
UserGroupToInvisibleProduct	12
BillingSubscriptionStatus	12
UserGroupHistory	12
UnitRoleAssignment	12
UnitUserRole	12
BillingAdapter	12
OperationRecord	12
\.


--
-- Data for Name: imageresource; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY imageresource (tkey, version, imagetype, objectkey, buffer, contenttype) FROM stdin;
\.


--
-- Data for Name: landingpageproduct; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY landingpageproduct (tkey, landingpage_tkey, product_tkey, "position", version) FROM stdin;
\.


--
-- Data for Name: localizedresource; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY localizedresource (tkey, version, locale, objecttype, objectkey, value) FROM stdin;
10109	0	en	MARKETPLACE_NAME	10004	Global Marketplace
10110	0	en	MARKETPLACE_NAME	10005	Local Marketplace
10111	0	en	TEC_PRODUCT_TECHNICAL_DESC	10002	You can create\n    \tfolders upload files and share them with other users.
10112	0	de	TEC_PRODUCT_TECHNICAL_DESC	10002	Sie können Ordner\n    \tanlegen, Dateien hochladen und diese mit anderen Teilnehmern\n    \tgemeinsam nutzen.
10113	0	en	PRODUCT_LICENSE_DESC	10002	<b>License Agreement</b><br/><br/>\nThe license terms of (hereinafter called "licensor") are applied\nfor the concession of the rights of use for the entire or partly\nuse of the object code of the software SmartSVN (hereinafter called "SOFTWARE")\nto contractors, juristic persons under public law or official fund assets in terms\nof §310 in conjunction with §14 BGB [Civil Code] (hereinafter called "licensee").\nHerewith the inclusion of the licensee's own terms and conditions is contradicted,\nunless their validity has explicitly been agreed to.<br/><br/>\n\n2 Scope of the Rights of Use<br/><br/>\n\n2.1 The following terms are valid for the assignment and use of the SOFTWARE\nfor an unlimited period of time including any documentation and the license\nfile (a file that is custom-made for each individual granting of a license,\nthe file being necessary for the operation of the SOFTWARE).<br/><br/>\n\n2.2 They are not valid for additional services such as installation,\nintegration, parameterization and customization of the SOFTWARE\nto the licensee's requirements.
10114	0	en	OPTION_PARAMETER_DEF_DESC	10012	Minimum Storage (1GB)
10115	0	en	OPTION_PARAMETER_DEF_DESC	10013	Optimum storage (2GB)
10116	0	en	OPTION_PARAMETER_DEF_DESC	10014	Maximum storage (4GB)
10117	0	en	PARAMETER_DEF_DESC	10016	Incremental memory storage
10118	0	en	OPTION_PARAMETER_DEF_DESC	10015	Minimum Storage (100GB)
10119	0	en	OPTION_PARAMETER_DEF_DESC	10016	Optimum storage (200GB)
10120	0	en	OPTION_PARAMETER_DEF_DESC	10017	Maximum storage (400GB)
10121	0	en	PARAMETER_DEF_DESC	10017	Incremental disk storage
10122	0	en	PARAMETER_DEF_DESC	10018	Number of folders that can be created.
10123	0	en	PARAMETER_DEF_DESC	10019	Number of folders that can be created.
10124	0	en	PARAMETER_DEF_DESC	10020	Number of files that can be uploaded.
10125	0	en	PARAMETER_DEF_DESC	10021	Number of folders that can be created.
10126	0	en	PARAMETER_DEF_DESC	10022	Cannot be configured
10127	0	en	PARAMETER_DEF_DESC	10023	Rename any user folder
10128	0	en	EVENT_DESC	10006	File Download
10129	0	en	EVENT_DESC	10007	File Upload
10130	0	en	EVENT_DESC	10008	New Folder
10131	0	en	ROLE_DEF_NAME	10006	Administrator
10132	0	de	ROLE_DEF_NAME	10006	Administrator
10133	0	en	ROLE_DEF_DESC	10006	Administrators have full access to all data entities and can execute administartive tasks such as role assignments and user creation.
10134	0	de	ROLE_DEF_DESC	10006	Administratoren haben vollen Datenzugriff und können administartive Aufgaben erledigen wie Rollen zuweisen oder Benutzer anlegen.
10135	0	en	ROLE_DEF_NAME	10007	User
10136	0	de	ROLE_DEF_NAME	10007	Benutzer
10137	0	en	ROLE_DEF_DESC	10007	Users have full access to all data entities but cannot execute adminstartive tasks.
10138	0	de	ROLE_DEF_DESC	10007	Benutzer haben vollen Datenzugriff aber können keine administrativen Aufgaben erledigen.
10139	0	en	ROLE_DEF_NAME	10008	Guest
10140	0	de	ROLE_DEF_NAME	10008	Gast
10141	0	en	ROLE_DEF_DESC	10008	Gustes only have limited read access.
10142	0	de	ROLE_DEF_DESC	10008	Gäste haben nur eingeschränkten Lesezugriff.
10143	0	en	TECHNICAL_PRODUCT_OPERATION_NAME	10004	Help
10144	0	de	TECHNICAL_PRODUCT_OPERATION_NAME	10004	Hilfe
10145	0	en	TECHNICAL_PRODUCT_OPERATION_DESCRIPTION	10004	Help activation.
10146	0	de	TECHNICAL_PRODUCT_OPERATION_DESCRIPTION	10004	Hilfe Aktivierung.
10147	0	en	TECHNICAL_PRODUCT_OPERATION_NAME	10005	Error
10148	0	de	TECHNICAL_PRODUCT_OPERATION_NAME	10005	Fehler
10149	0	en	TECHNICAL_PRODUCT_OPERATION_DESCRIPTION	10005	Cause an error.
10150	0	de	TECHNICAL_PRODUCT_OPERATION_DESCRIPTION	10005	Einen Fehler verursachen.
10151	0	en	PRODUCT_MARKETING_NAME	10003	Trial
10152	0	en	PRODUCT_MARKETING_DESC	10003	Trial description
10153	0	en	PRODUCT_SHORT_DESCRIPTION	10003	Trial short description
10154	0	de	PRODUCT_MARKETING_DESC	10003	Sie können Ordner\n    \tanlegen, Dateien hochladen und diese mit anderen Teilnehmern\n    \tgemeinsam nutzen.
10155	0	en	PRODUCT_MARKETING_NAME	10004	Starter
10156	0	en	PRODUCT_MARKETING_DESC	10004	Starter description
10157	0	en	PRODUCT_SHORT_DESCRIPTION	10004	Starter short description
10158	0	de	PRODUCT_MARKETING_DESC	10004	Sie können Ordner\n    \tanlegen, Dateien hochladen und diese mit anderen Teilnehmern\n    \tgemeinsam nutzen.
10159	0	en	PRODUCT_MARKETING_NAME	10005	Professional
10160	0	en	PRODUCT_MARKETING_DESC	10005	Professional description
10161	0	en	PRODUCT_SHORT_DESCRIPTION	10005	Professional short description
10162	0	de	PRODUCT_MARKETING_DESC	10005	Sie können Ordner\n    \tanlegen, Dateien hochladen und diese mit anderen Teilnehmern\n    \tgemeinsam nutzen.
10163	0	en	PRICEMODEL_LICENSE	10003	
10164	0	en	PRICEMODEL_LICENSE	10004	
10165	0	en	PRICEMODEL_DESCRIPTION	10005	ServiceProfessional
10166	0	en	PRICEMODEL_LICENSE	10005	
10108	1	en	ORGANIZATION_DESCRIPTION	10002	This is a technical provider and supplier organization.
10167	1	en	ORGANIZATION_DESCRIPTION	10003	This is customer organization.
10168	0	en	ORGANIZATION_DESCRIPTION	1	
10169	0	en	PRICEMODEL_LICENSE	10006	
10170	0	en	PRICEMODEL_LICENSE	10007	
10171	0	en	PRICEMODEL_DESCRIPTION	10008	ServiceProfessional
10172	0	en	PRICEMODEL_LICENSE	10008	
10106	0	en	PAYMENT_TYPE_NAME	10004	CREDIT_CARD
10107	0	en	PAYMENT_TYPE_NAME	10005	DIRECT_DEBIT
\.


--
-- Data for Name: marketingpermission; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY marketingpermission (tkey, version, technicalproduct_tkey, organizationreference_tkey) FROM stdin;
10002	0	10002	10008
\.


--
-- Data for Name: marketingpermissionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY marketingpermissionhistory (tkey, objkey, objversion, technicalproductobjkey, organizationreferenceobjkey, invocationdate, moddate, modtype, moduser) FROM stdin;
10002	10002	0	10002	10008	2015-10-21 11:18:00.111	2015-10-21 11:18:00.111	ADD	10002
\.


--
-- Data for Name: marketplace; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY marketplace (tkey, creationdate, version, organization_tkey, marketplaceid, open, taggingenabled, reviewenabled, socialbookmarkenabled, brandingurl, categoriesenabled, publiclandingpage_tkey, pricemodel_tkey, brokerpricemodel_tkey, resellerpricemodel_tkey, trackingcode, enterpriselandingpage_tkey) FROM stdin;
10004	1445419026932	0	1	924f4415	f	t	t	f	\N	t	10004	10020	10018	10019	\N	\N
10005	1445419059280	0	10002	e03659fb	f	t	t	f	\N	t	10005	10023	10021	10022	\N	\N
\.


--
-- Data for Name: marketplacehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY marketplacehistory (tkey, creationdate, moddate, modtype, moduser, objkey, objversion, organizationobjkey, invocationdate, marketplaceid, open, taggingenabled, reviewenabled, socialbookmarkenabled, brandingurl, categoriesenabled, pricemodelobjkey, brokerpricemodelobjkey, resellerpricemodelobjkey, trackingcode) FROM stdin;
10004	1445419026932	2015-10-21 11:17:06.932	ADD	1000	10004	0	1	2015-10-21 11:17:06.932	924f4415	f	t	t	f	\N	t	10020	10018	10019	\N
10005	1445419059280	2015-10-21 11:17:39.28	ADD	1000	10005	0	10002	2015-10-21 11:17:39.28	e03659fb	f	t	t	f	\N	t	10023	10021	10022	\N
\.


--
-- Data for Name: marketplacetoorganization; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY marketplacetoorganization (tkey, version, marketplace_tkey, organization_tkey, publishingaccess) FROM stdin;
10004	0	10005	10002	PUBLISHING_ACCESS_GRANTED
10005	0	10004	10002	PUBLISHING_ACCESS_GRANTED
\.


--
-- Data for Name: marketplacetoorganizationhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY marketplacetoorganizationhistory (tkey, moddate, invocationdate, modtype, moduser, objkey, objversion, marketplaceobjkey, organizationobjkey, publishingaccess) FROM stdin;
10004	2015-10-21 11:17:39.28	2015-10-21 11:17:39.28	ADD	1000	10004	0	10005	10002	PUBLISHING_ACCESS_GRANTED
10005	2015-10-21 11:17:39.439	2015-10-21 11:17:39.439	ADD	1000	10005	0	10004	10002	PUBLISHING_ACCESS_GRANTED
\.


--
-- Data for Name: modifiedentity; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY modifiedentity (tkey, version, targetobjectkey, targetobjecttype, value) FROM stdin;
\.


--
-- Data for Name: modifiedentityhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY modifiedentityhistory (tkey, moddate, modtype, moduser, objkey, objversion, invocationdate, targetobjectkey, targetobjecttype, value) FROM stdin;
\.


--
-- Data for Name: modifieduda; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY modifieduda (tkey, version, targetobjectkey, targetobjecttype, subscriptionkey, value) FROM stdin;
\.


--
-- Data for Name: modifiedudahistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY modifiedudahistory (tkey, moddate, modtype, moduser, objkey, objversion, invocationdate, targetobjectkey, targetobjecttype, subscriptionkey, value) FROM stdin;
\.


--
-- Data for Name: onbehalfuserreference; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY onbehalfuserreference (tkey, version, lastaccesstime, masteruser_tkey, slaveuser_tkey) FROM stdin;
\.


--
-- Data for Name: onbehalfuserreferencehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY onbehalfuserreferencehistory (tkey, objversion, objkey, invocationdate, moddate, modtype, moduser, lastaccesstime, masteruserobjkey, slaveuserobjkey) FROM stdin;
\.


--
-- Data for Name: operationparameter; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY operationparameter (tkey, version, technicalproductoperation_tkey, id, type, mandatory) FROM stdin;
\.


--
-- Data for Name: operationparameterhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY operationparameterhistory (tkey, moddate, invocationdate, modtype, moduser, objkey, objversion, technicalproductoperationobjkey, id, type, mandatory) FROM stdin;
\.


--
-- Data for Name: operationrecord; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY operationrecord (tkey, version, transactionid, executiondate, status, technicalproductoperation_tkey, subscription_tkey, user_tkey) FROM stdin;
10000	0	c7c5f128	1445420261033	COMPLETED	10004	10000	10003
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organization (tkey, address, deregistrationdate, distinguishedname, email, locale, name, organizationid, phone, registrationdate, version, domicilecountry_tkey, url, supportemail, remoteldapactive, cutoffday, operatorpricemodel_tkey) FROM stdin;
1	\N	\N	\N	\N	en	\N	PLATFORM_OPERATOR	\N	1445418960664	1	55	\N	\N	f	1	\N
10002	5th Block, Broadway	\N	\N	admin@oscm.org	en	TechProvAndSupplier	e03659fb	0049 89 123456789	1445419014299	2	55	http://www.example.com	\N	f	1	10017
10003	Street ZIP City	\N	\N	customer@oscm.org	en	CustomerOrganization	9d7e9cfc	0049 89 123456789	1445419092606	3	55	http://www.customer.com	\N	f	1	\N
\.


--
-- Data for Name: organizationhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationhistory (tkey, address, deregistrationdate, distinguishedname, email, locale, name, organizationid, phone, registrationdate, moddate, modtype, moduser, objkey, objversion, invocationdate, domicilecountryobjkey, url, supportemail, remoteldapactive, cutoffday, operatorpricemodelobjkey) FROM stdin;
1	\N	\N	\N	\N	en	\N	PLATFORM_OPERATOR	\N	1445418960664	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1	0	2015-10-21 11:16:00.664	\N	\N	\N	f	1	\N
10004	5th Block, Broadway	\N	\N	administrator@oscm.org	en	TechProvAndSupplier	e03659fb	0049 89 123456789	1445419014299	2015-10-21 11:16:54.299	ADD	1000	10002	0	2015-10-21 11:16:54.299	\N	http://www.example.com	\N	f	1	10017
10005	5th Block, Broadway	\N	\N	administrator@oscm.org	en	TechProvAndSupplier	e03659fb	0049 89 123456789	1445419014299	2015-10-21 11:16:54.299	MODIFY	1000	10002	1	2015-10-21 11:16:54.299	55	http://www.example.com	\N	f	1	10017
10006	Street ZIP City	\N	\N	administrator@oscm.org	en	Testorg	9d7e9cfc	0049 89 123456789	1445419092606	2015-10-21 11:18:12.606	ADD	10002	10003	0	2015-10-21 11:18:12.606	\N	http://www.fujitsu.com	\N	f	1	\N
10007	Street ZIP City	\N	\N	administrator@oscm.org	en	Testorg	9d7e9cfc	0049 89 123456789	1445419092606	2015-10-21 11:18:12.606	MODIFY	10002	10003	1	2015-10-21 11:18:12.606	55	http://www.fujitsu.com	\N	f	1	\N
10008	\N	\N	\N	\N	en	\N	PLATFORM_OPERATOR	\N	1445418960664	2015-10-21 11:19:20.909	MODIFY	1000	1	1	2015-10-21 11:19:20.909	55	\N	\N	f	1	\N
10009	5th Block, Broadway	\N	\N	admin@oscm.org	en	TechProvAndSupplier	e03659fb	0049 89 123456789	1445419014299	2015-10-21 11:20:46.977	MODIFY	1000	10002	2	2015-10-21 11:20:46.977	55	http://www.example.com	\N	f	1	10017
10010	Street ZIP City	\N	\N	admin@oscm.org	en	CustomerOrganization	9d7e9cfc	0049 89 123456789	1445419092606	2015-10-21 11:21:55.476	MODIFY	1000	10003	2	2015-10-21 11:21:55.476	55	http://www.customer.com	\N	f	1	\N
10011	Street ZIP City	\N	\N	customer@oscm.org	en	CustomerOrganization	9d7e9cfc	0049 89 123456789	1445419092606	2015-10-21 11:26:23.282	MODIFY	10003	10003	3	2015-10-21 11:26:23.282	55	http://www.customer.com	\N	f	1	\N
\.


--
-- Data for Name: organizationreference; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationreference (tkey, version, targetkey, sourcekey, referencetype) FROM stdin;
10006	0	10002	10002	SUPPLIER_TO_CUSTOMER
10007	0	10002	1	PLATFORM_OPERATOR_TO_SUPPLIER
10008	0	10002	10002	TECHNOLOGY_PROVIDER_TO_SUPPLIER
10009	0	10003	10002	SUPPLIER_TO_CUSTOMER
\.


--
-- Data for Name: organizationreferencehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationreferencehistory (tkey, moddate, modtype, moduser, objkey, objversion, targetobjkey, sourceobjkey, invocationdate, referencetype) FROM stdin;
10006	2015-10-21 11:16:54.299	ADD	1000	10006	0	10002	10002	2015-10-21 11:16:54.299	SUPPLIER_TO_CUSTOMER
10007	2015-10-21 11:16:54.299	ADD	1000	10007	0	10002	1	2015-10-21 11:16:54.299	PLATFORM_OPERATOR_TO_SUPPLIER
10008	2015-10-21 11:18:00.111	ADD	10002	10008	0	10002	10002	2015-10-21 11:18:00.111	TECHNOLOGY_PROVIDER_TO_SUPPLIER
10009	2015-10-21 11:18:12.606	ADD	10002	10009	0	10003	10002	2015-10-21 11:18:12.606	SUPPLIER_TO_CUSTOMER
\.


--
-- Data for Name: organizationreftopaymenttype; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationreftopaymenttype (tkey, usedasdefault, version, organizationreference_tkey, organizationrole_tkey, paymenttype_tkey, usedasservicedefault) FROM stdin;
10006	t	1	10007	1	3	t
10007	t	1	10007	1	10004	t
10009	f	0	10009	3	3	f
10010	f	0	10009	3	10004	f
10011	f	0	10006	3	10004	f
10008	t	2	10007	1	10005	t
10012	f	0	10006	3	3	f
\.


--
-- Data for Name: organizationrole; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationrole (tkey, rolename, version) FROM stdin;
1	SUPPLIER	0
2	TECHNOLOGY_PROVIDER	0
3	CUSTOMER	0
4	PLATFORM_OPERATOR	0
5	MARKETPLACE_OWNER	0
6	BROKER	0
7	RESELLER	0
\.


--
-- Data for Name: organizationsetting; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationsetting (tkey, settingtype, settingvalue, version, organization_tkey) FROM stdin;
\.


--
-- Data for Name: organizationtocountry; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationtocountry (tkey, version, organization_tkey, supportedcountry_tkey) FROM stdin;
1	0	1	0
2	0	1	1
3	0	1	2
4	0	1	3
5	0	1	4
6	0	1	5
7	0	1	6
8	0	1	7
9	0	1	8
10	0	1	9
11	0	1	10
12	0	1	11
13	0	1	12
14	0	1	13
15	0	1	14
16	0	1	15
17	0	1	16
18	0	1	17
19	0	1	18
20	0	1	19
21	0	1	20
22	0	1	21
23	0	1	22
24	0	1	23
25	0	1	24
26	0	1	25
27	0	1	26
28	0	1	27
29	0	1	28
30	0	1	29
31	0	1	30
32	0	1	31
33	0	1	32
34	0	1	33
35	0	1	34
36	0	1	35
37	0	1	36
38	0	1	37
39	0	1	38
40	0	1	39
41	0	1	40
42	0	1	41
43	0	1	42
44	0	1	43
45	0	1	44
46	0	1	45
47	0	1	46
48	0	1	47
49	0	1	48
50	0	1	49
51	0	1	50
52	0	1	51
53	0	1	52
54	0	1	53
55	0	1	54
56	0	1	55
57	0	1	56
58	0	1	57
59	0	1	58
60	0	1	59
61	0	1	60
62	0	1	61
63	0	1	62
64	0	1	63
65	0	1	64
66	0	1	65
67	0	1	66
68	0	1	67
69	0	1	68
70	0	1	69
71	0	1	70
72	0	1	71
73	0	1	72
74	0	1	73
75	0	1	74
76	0	1	75
77	0	1	76
78	0	1	77
79	0	1	78
80	0	1	79
81	0	1	80
82	0	1	81
83	0	1	82
84	0	1	83
85	0	1	84
86	0	1	85
87	0	1	86
88	0	1	87
89	0	1	88
90	0	1	89
91	0	1	90
92	0	1	91
93	0	1	92
94	0	1	93
95	0	1	94
96	0	1	95
97	0	1	96
98	0	1	97
99	0	1	98
100	0	1	99
101	0	1	100
102	0	1	101
103	0	1	102
104	0	1	103
105	0	1	104
106	0	1	105
107	0	1	106
108	0	1	107
109	0	1	108
110	0	1	109
111	0	1	110
112	0	1	111
113	0	1	112
114	0	1	113
115	0	1	114
116	0	1	115
117	0	1	116
118	0	1	117
119	0	1	118
120	0	1	119
121	0	1	120
122	0	1	121
123	0	1	122
124	0	1	123
125	0	1	124
126	0	1	125
127	0	1	126
128	0	1	127
129	0	1	128
130	0	1	129
131	0	1	130
132	0	1	131
133	0	1	132
134	0	1	133
135	0	1	134
136	0	1	135
137	0	1	136
138	0	1	137
139	0	1	138
140	0	1	139
141	0	1	140
142	0	1	141
143	0	1	142
144	0	1	143
145	0	1	144
146	0	1	145
147	0	1	146
148	0	1	147
149	0	1	148
150	0	1	149
151	0	1	150
152	0	1	151
153	0	1	152
154	0	1	153
155	0	1	154
156	0	1	155
157	0	1	156
158	0	1	157
159	0	1	158
160	0	1	159
161	0	1	160
162	0	1	161
163	0	1	162
164	0	1	163
165	0	1	164
166	0	1	165
167	0	1	166
168	0	1	167
169	0	1	168
170	0	1	169
171	0	1	170
172	0	1	171
173	0	1	172
174	0	1	173
175	0	1	174
176	0	1	175
177	0	1	176
178	0	1	177
179	0	1	178
180	0	1	179
181	0	1	180
182	0	1	181
183	0	1	182
184	0	1	183
185	0	1	184
186	0	1	185
187	0	1	186
188	0	1	187
189	0	1	188
190	0	1	189
191	0	1	190
192	0	1	191
193	0	1	192
194	0	1	193
195	0	1	194
196	0	1	195
197	0	1	196
198	0	1	197
199	0	1	198
200	0	1	199
201	0	1	200
202	0	1	201
203	0	1	202
204	0	1	203
205	0	1	204
206	0	1	205
207	0	1	206
208	0	1	207
209	0	1	208
210	0	1	209
211	0	1	210
212	0	1	211
213	0	1	212
214	0	1	213
215	0	1	214
216	0	1	215
217	0	1	216
218	0	1	217
219	0	1	218
220	0	1	219
221	0	1	220
222	0	1	221
223	0	1	222
224	0	1	223
225	0	1	224
226	0	1	225
227	0	1	226
228	0	1	227
229	0	1	228
230	0	1	229
231	0	1	230
232	0	1	231
233	0	1	232
234	0	1	233
235	0	1	234
236	0	1	235
237	0	1	236
238	0	1	237
239	0	1	238
240	0	1	239
241	0	1	240
\.


--
-- Data for Name: organizationtocountryhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationtocountryhistory (tkey, moddate, modtype, moduser, objkey, objversion, organizationobjkey, supportedcountryobjkey, invocationdate) FROM stdin;
1	2015-10-21 11:16:05.921	ADD	1000	1	0	1	0	1970-01-01 00:00:00
2	2015-10-21 11:16:05.921	ADD	1000	2	0	1	1	1970-01-01 00:00:00
3	2015-10-21 11:16:05.921	ADD	1000	3	0	1	2	1970-01-01 00:00:00
4	2015-10-21 11:16:05.921	ADD	1000	4	0	1	3	1970-01-01 00:00:00
5	2015-10-21 11:16:05.921	ADD	1000	5	0	1	4	1970-01-01 00:00:00
6	2015-10-21 11:16:05.921	ADD	1000	6	0	1	5	1970-01-01 00:00:00
7	2015-10-21 11:16:05.921	ADD	1000	7	0	1	6	1970-01-01 00:00:00
8	2015-10-21 11:16:05.921	ADD	1000	8	0	1	7	1970-01-01 00:00:00
9	2015-10-21 11:16:05.921	ADD	1000	9	0	1	8	1970-01-01 00:00:00
10	2015-10-21 11:16:05.921	ADD	1000	10	0	1	9	1970-01-01 00:00:00
11	2015-10-21 11:16:05.921	ADD	1000	11	0	1	10	1970-01-01 00:00:00
12	2015-10-21 11:16:05.921	ADD	1000	12	0	1	11	1970-01-01 00:00:00
13	2015-10-21 11:16:05.921	ADD	1000	13	0	1	12	1970-01-01 00:00:00
14	2015-10-21 11:16:05.921	ADD	1000	14	0	1	13	1970-01-01 00:00:00
15	2015-10-21 11:16:05.921	ADD	1000	15	0	1	14	1970-01-01 00:00:00
16	2015-10-21 11:16:05.921	ADD	1000	16	0	1	15	1970-01-01 00:00:00
17	2015-10-21 11:16:05.921	ADD	1000	17	0	1	16	1970-01-01 00:00:00
18	2015-10-21 11:16:05.921	ADD	1000	18	0	1	17	1970-01-01 00:00:00
19	2015-10-21 11:16:05.921	ADD	1000	19	0	1	18	1970-01-01 00:00:00
20	2015-10-21 11:16:05.921	ADD	1000	20	0	1	19	1970-01-01 00:00:00
21	2015-10-21 11:16:05.921	ADD	1000	21	0	1	20	1970-01-01 00:00:00
22	2015-10-21 11:16:05.921	ADD	1000	22	0	1	21	1970-01-01 00:00:00
23	2015-10-21 11:16:05.921	ADD	1000	23	0	1	22	1970-01-01 00:00:00
24	2015-10-21 11:16:05.921	ADD	1000	24	0	1	23	1970-01-01 00:00:00
25	2015-10-21 11:16:05.921	ADD	1000	25	0	1	24	1970-01-01 00:00:00
26	2015-10-21 11:16:05.921	ADD	1000	26	0	1	25	1970-01-01 00:00:00
27	2015-10-21 11:16:05.921	ADD	1000	27	0	1	26	1970-01-01 00:00:00
28	2015-10-21 11:16:05.921	ADD	1000	28	0	1	27	1970-01-01 00:00:00
29	2015-10-21 11:16:05.921	ADD	1000	29	0	1	28	1970-01-01 00:00:00
30	2015-10-21 11:16:05.921	ADD	1000	30	0	1	29	1970-01-01 00:00:00
31	2015-10-21 11:16:05.921	ADD	1000	31	0	1	30	1970-01-01 00:00:00
32	2015-10-21 11:16:05.921	ADD	1000	32	0	1	31	1970-01-01 00:00:00
33	2015-10-21 11:16:05.921	ADD	1000	33	0	1	32	1970-01-01 00:00:00
34	2015-10-21 11:16:05.921	ADD	1000	34	0	1	33	1970-01-01 00:00:00
35	2015-10-21 11:16:05.921	ADD	1000	35	0	1	34	1970-01-01 00:00:00
36	2015-10-21 11:16:05.921	ADD	1000	36	0	1	35	1970-01-01 00:00:00
37	2015-10-21 11:16:05.921	ADD	1000	37	0	1	36	1970-01-01 00:00:00
38	2015-10-21 11:16:05.921	ADD	1000	38	0	1	37	1970-01-01 00:00:00
39	2015-10-21 11:16:05.921	ADD	1000	39	0	1	38	1970-01-01 00:00:00
40	2015-10-21 11:16:05.921	ADD	1000	40	0	1	39	1970-01-01 00:00:00
41	2015-10-21 11:16:05.921	ADD	1000	41	0	1	40	1970-01-01 00:00:00
42	2015-10-21 11:16:05.921	ADD	1000	42	0	1	41	1970-01-01 00:00:00
43	2015-10-21 11:16:05.921	ADD	1000	43	0	1	42	1970-01-01 00:00:00
44	2015-10-21 11:16:05.921	ADD	1000	44	0	1	43	1970-01-01 00:00:00
45	2015-10-21 11:16:05.921	ADD	1000	45	0	1	44	1970-01-01 00:00:00
46	2015-10-21 11:16:05.921	ADD	1000	46	0	1	45	1970-01-01 00:00:00
47	2015-10-21 11:16:05.921	ADD	1000	47	0	1	46	1970-01-01 00:00:00
48	2015-10-21 11:16:05.921	ADD	1000	48	0	1	47	1970-01-01 00:00:00
49	2015-10-21 11:16:05.921	ADD	1000	49	0	1	48	1970-01-01 00:00:00
50	2015-10-21 11:16:05.921	ADD	1000	50	0	1	49	1970-01-01 00:00:00
51	2015-10-21 11:16:05.921	ADD	1000	51	0	1	50	1970-01-01 00:00:00
52	2015-10-21 11:16:05.921	ADD	1000	52	0	1	51	1970-01-01 00:00:00
53	2015-10-21 11:16:05.921	ADD	1000	53	0	1	52	1970-01-01 00:00:00
54	2015-10-21 11:16:05.921	ADD	1000	54	0	1	53	1970-01-01 00:00:00
55	2015-10-21 11:16:05.921	ADD	1000	55	0	1	54	1970-01-01 00:00:00
56	2015-10-21 11:16:05.921	ADD	1000	56	0	1	55	1970-01-01 00:00:00
57	2015-10-21 11:16:05.921	ADD	1000	57	0	1	56	1970-01-01 00:00:00
58	2015-10-21 11:16:05.921	ADD	1000	58	0	1	57	1970-01-01 00:00:00
59	2015-10-21 11:16:05.921	ADD	1000	59	0	1	58	1970-01-01 00:00:00
60	2015-10-21 11:16:05.921	ADD	1000	60	0	1	59	1970-01-01 00:00:00
61	2015-10-21 11:16:05.921	ADD	1000	61	0	1	60	1970-01-01 00:00:00
62	2015-10-21 11:16:05.921	ADD	1000	62	0	1	61	1970-01-01 00:00:00
63	2015-10-21 11:16:05.921	ADD	1000	63	0	1	62	1970-01-01 00:00:00
64	2015-10-21 11:16:05.921	ADD	1000	64	0	1	63	1970-01-01 00:00:00
65	2015-10-21 11:16:05.921	ADD	1000	65	0	1	64	1970-01-01 00:00:00
66	2015-10-21 11:16:05.921	ADD	1000	66	0	1	65	1970-01-01 00:00:00
67	2015-10-21 11:16:05.921	ADD	1000	67	0	1	66	1970-01-01 00:00:00
68	2015-10-21 11:16:05.921	ADD	1000	68	0	1	67	1970-01-01 00:00:00
69	2015-10-21 11:16:05.921	ADD	1000	69	0	1	68	1970-01-01 00:00:00
70	2015-10-21 11:16:05.921	ADD	1000	70	0	1	69	1970-01-01 00:00:00
71	2015-10-21 11:16:05.921	ADD	1000	71	0	1	70	1970-01-01 00:00:00
72	2015-10-21 11:16:05.921	ADD	1000	72	0	1	71	1970-01-01 00:00:00
73	2015-10-21 11:16:05.921	ADD	1000	73	0	1	72	1970-01-01 00:00:00
74	2015-10-21 11:16:05.921	ADD	1000	74	0	1	73	1970-01-01 00:00:00
75	2015-10-21 11:16:05.921	ADD	1000	75	0	1	74	1970-01-01 00:00:00
76	2015-10-21 11:16:05.921	ADD	1000	76	0	1	75	1970-01-01 00:00:00
77	2015-10-21 11:16:05.921	ADD	1000	77	0	1	76	1970-01-01 00:00:00
78	2015-10-21 11:16:05.921	ADD	1000	78	0	1	77	1970-01-01 00:00:00
79	2015-10-21 11:16:05.921	ADD	1000	79	0	1	78	1970-01-01 00:00:00
80	2015-10-21 11:16:05.921	ADD	1000	80	0	1	79	1970-01-01 00:00:00
81	2015-10-21 11:16:05.921	ADD	1000	81	0	1	80	1970-01-01 00:00:00
82	2015-10-21 11:16:05.921	ADD	1000	82	0	1	81	1970-01-01 00:00:00
83	2015-10-21 11:16:05.921	ADD	1000	83	0	1	82	1970-01-01 00:00:00
84	2015-10-21 11:16:05.921	ADD	1000	84	0	1	83	1970-01-01 00:00:00
85	2015-10-21 11:16:05.921	ADD	1000	85	0	1	84	1970-01-01 00:00:00
86	2015-10-21 11:16:05.921	ADD	1000	86	0	1	85	1970-01-01 00:00:00
87	2015-10-21 11:16:05.921	ADD	1000	87	0	1	86	1970-01-01 00:00:00
88	2015-10-21 11:16:05.921	ADD	1000	88	0	1	87	1970-01-01 00:00:00
89	2015-10-21 11:16:05.921	ADD	1000	89	0	1	88	1970-01-01 00:00:00
90	2015-10-21 11:16:05.921	ADD	1000	90	0	1	89	1970-01-01 00:00:00
91	2015-10-21 11:16:05.921	ADD	1000	91	0	1	90	1970-01-01 00:00:00
92	2015-10-21 11:16:05.921	ADD	1000	92	0	1	91	1970-01-01 00:00:00
93	2015-10-21 11:16:05.921	ADD	1000	93	0	1	92	1970-01-01 00:00:00
94	2015-10-21 11:16:05.921	ADD	1000	94	0	1	93	1970-01-01 00:00:00
95	2015-10-21 11:16:05.921	ADD	1000	95	0	1	94	1970-01-01 00:00:00
96	2015-10-21 11:16:05.921	ADD	1000	96	0	1	95	1970-01-01 00:00:00
97	2015-10-21 11:16:05.921	ADD	1000	97	0	1	96	1970-01-01 00:00:00
98	2015-10-21 11:16:05.921	ADD	1000	98	0	1	97	1970-01-01 00:00:00
99	2015-10-21 11:16:05.921	ADD	1000	99	0	1	98	1970-01-01 00:00:00
100	2015-10-21 11:16:05.921	ADD	1000	100	0	1	99	1970-01-01 00:00:00
101	2015-10-21 11:16:05.921	ADD	1000	101	0	1	100	1970-01-01 00:00:00
102	2015-10-21 11:16:05.921	ADD	1000	102	0	1	101	1970-01-01 00:00:00
103	2015-10-21 11:16:05.921	ADD	1000	103	0	1	102	1970-01-01 00:00:00
104	2015-10-21 11:16:05.921	ADD	1000	104	0	1	103	1970-01-01 00:00:00
105	2015-10-21 11:16:05.921	ADD	1000	105	0	1	104	1970-01-01 00:00:00
106	2015-10-21 11:16:05.921	ADD	1000	106	0	1	105	1970-01-01 00:00:00
107	2015-10-21 11:16:05.921	ADD	1000	107	0	1	106	1970-01-01 00:00:00
108	2015-10-21 11:16:05.921	ADD	1000	108	0	1	107	1970-01-01 00:00:00
109	2015-10-21 11:16:05.921	ADD	1000	109	0	1	108	1970-01-01 00:00:00
110	2015-10-21 11:16:05.921	ADD	1000	110	0	1	109	1970-01-01 00:00:00
111	2015-10-21 11:16:05.921	ADD	1000	111	0	1	110	1970-01-01 00:00:00
112	2015-10-21 11:16:05.921	ADD	1000	112	0	1	111	1970-01-01 00:00:00
113	2015-10-21 11:16:05.921	ADD	1000	113	0	1	112	1970-01-01 00:00:00
114	2015-10-21 11:16:05.921	ADD	1000	114	0	1	113	1970-01-01 00:00:00
115	2015-10-21 11:16:05.921	ADD	1000	115	0	1	114	1970-01-01 00:00:00
116	2015-10-21 11:16:05.921	ADD	1000	116	0	1	115	1970-01-01 00:00:00
117	2015-10-21 11:16:05.921	ADD	1000	117	0	1	116	1970-01-01 00:00:00
118	2015-10-21 11:16:05.921	ADD	1000	118	0	1	117	1970-01-01 00:00:00
119	2015-10-21 11:16:05.921	ADD	1000	119	0	1	118	1970-01-01 00:00:00
120	2015-10-21 11:16:05.921	ADD	1000	120	0	1	119	1970-01-01 00:00:00
121	2015-10-21 11:16:05.921	ADD	1000	121	0	1	120	1970-01-01 00:00:00
122	2015-10-21 11:16:05.921	ADD	1000	122	0	1	121	1970-01-01 00:00:00
123	2015-10-21 11:16:05.921	ADD	1000	123	0	1	122	1970-01-01 00:00:00
124	2015-10-21 11:16:05.921	ADD	1000	124	0	1	123	1970-01-01 00:00:00
125	2015-10-21 11:16:05.921	ADD	1000	125	0	1	124	1970-01-01 00:00:00
126	2015-10-21 11:16:05.921	ADD	1000	126	0	1	125	1970-01-01 00:00:00
127	2015-10-21 11:16:05.921	ADD	1000	127	0	1	126	1970-01-01 00:00:00
128	2015-10-21 11:16:05.921	ADD	1000	128	0	1	127	1970-01-01 00:00:00
129	2015-10-21 11:16:05.921	ADD	1000	129	0	1	128	1970-01-01 00:00:00
130	2015-10-21 11:16:05.921	ADD	1000	130	0	1	129	1970-01-01 00:00:00
131	2015-10-21 11:16:05.921	ADD	1000	131	0	1	130	1970-01-01 00:00:00
132	2015-10-21 11:16:05.921	ADD	1000	132	0	1	131	1970-01-01 00:00:00
133	2015-10-21 11:16:05.921	ADD	1000	133	0	1	132	1970-01-01 00:00:00
134	2015-10-21 11:16:05.921	ADD	1000	134	0	1	133	1970-01-01 00:00:00
135	2015-10-21 11:16:05.921	ADD	1000	135	0	1	134	1970-01-01 00:00:00
136	2015-10-21 11:16:05.921	ADD	1000	136	0	1	135	1970-01-01 00:00:00
137	2015-10-21 11:16:05.921	ADD	1000	137	0	1	136	1970-01-01 00:00:00
138	2015-10-21 11:16:05.921	ADD	1000	138	0	1	137	1970-01-01 00:00:00
139	2015-10-21 11:16:05.921	ADD	1000	139	0	1	138	1970-01-01 00:00:00
140	2015-10-21 11:16:05.921	ADD	1000	140	0	1	139	1970-01-01 00:00:00
141	2015-10-21 11:16:05.921	ADD	1000	141	0	1	140	1970-01-01 00:00:00
142	2015-10-21 11:16:05.921	ADD	1000	142	0	1	141	1970-01-01 00:00:00
143	2015-10-21 11:16:05.921	ADD	1000	143	0	1	142	1970-01-01 00:00:00
144	2015-10-21 11:16:05.921	ADD	1000	144	0	1	143	1970-01-01 00:00:00
145	2015-10-21 11:16:05.921	ADD	1000	145	0	1	144	1970-01-01 00:00:00
146	2015-10-21 11:16:05.921	ADD	1000	146	0	1	145	1970-01-01 00:00:00
147	2015-10-21 11:16:05.921	ADD	1000	147	0	1	146	1970-01-01 00:00:00
148	2015-10-21 11:16:05.921	ADD	1000	148	0	1	147	1970-01-01 00:00:00
149	2015-10-21 11:16:05.921	ADD	1000	149	0	1	148	1970-01-01 00:00:00
150	2015-10-21 11:16:05.921	ADD	1000	150	0	1	149	1970-01-01 00:00:00
151	2015-10-21 11:16:05.921	ADD	1000	151	0	1	150	1970-01-01 00:00:00
152	2015-10-21 11:16:05.921	ADD	1000	152	0	1	151	1970-01-01 00:00:00
153	2015-10-21 11:16:05.921	ADD	1000	153	0	1	152	1970-01-01 00:00:00
154	2015-10-21 11:16:05.921	ADD	1000	154	0	1	153	1970-01-01 00:00:00
155	2015-10-21 11:16:05.921	ADD	1000	155	0	1	154	1970-01-01 00:00:00
156	2015-10-21 11:16:05.921	ADD	1000	156	0	1	155	1970-01-01 00:00:00
157	2015-10-21 11:16:05.921	ADD	1000	157	0	1	156	1970-01-01 00:00:00
158	2015-10-21 11:16:05.921	ADD	1000	158	0	1	157	1970-01-01 00:00:00
159	2015-10-21 11:16:05.921	ADD	1000	159	0	1	158	1970-01-01 00:00:00
160	2015-10-21 11:16:05.921	ADD	1000	160	0	1	159	1970-01-01 00:00:00
161	2015-10-21 11:16:05.921	ADD	1000	161	0	1	160	1970-01-01 00:00:00
162	2015-10-21 11:16:05.921	ADD	1000	162	0	1	161	1970-01-01 00:00:00
163	2015-10-21 11:16:05.921	ADD	1000	163	0	1	162	1970-01-01 00:00:00
164	2015-10-21 11:16:05.921	ADD	1000	164	0	1	163	1970-01-01 00:00:00
165	2015-10-21 11:16:05.921	ADD	1000	165	0	1	164	1970-01-01 00:00:00
166	2015-10-21 11:16:05.921	ADD	1000	166	0	1	165	1970-01-01 00:00:00
167	2015-10-21 11:16:05.921	ADD	1000	167	0	1	166	1970-01-01 00:00:00
168	2015-10-21 11:16:05.921	ADD	1000	168	0	1	167	1970-01-01 00:00:00
169	2015-10-21 11:16:05.921	ADD	1000	169	0	1	168	1970-01-01 00:00:00
170	2015-10-21 11:16:05.921	ADD	1000	170	0	1	169	1970-01-01 00:00:00
171	2015-10-21 11:16:05.921	ADD	1000	171	0	1	170	1970-01-01 00:00:00
172	2015-10-21 11:16:05.921	ADD	1000	172	0	1	171	1970-01-01 00:00:00
173	2015-10-21 11:16:05.921	ADD	1000	173	0	1	172	1970-01-01 00:00:00
174	2015-10-21 11:16:05.921	ADD	1000	174	0	1	173	1970-01-01 00:00:00
175	2015-10-21 11:16:05.921	ADD	1000	175	0	1	174	1970-01-01 00:00:00
176	2015-10-21 11:16:05.921	ADD	1000	176	0	1	175	1970-01-01 00:00:00
177	2015-10-21 11:16:05.921	ADD	1000	177	0	1	176	1970-01-01 00:00:00
178	2015-10-21 11:16:05.921	ADD	1000	178	0	1	177	1970-01-01 00:00:00
179	2015-10-21 11:16:05.921	ADD	1000	179	0	1	178	1970-01-01 00:00:00
180	2015-10-21 11:16:05.921	ADD	1000	180	0	1	179	1970-01-01 00:00:00
181	2015-10-21 11:16:05.921	ADD	1000	181	0	1	180	1970-01-01 00:00:00
182	2015-10-21 11:16:05.921	ADD	1000	182	0	1	181	1970-01-01 00:00:00
183	2015-10-21 11:16:05.921	ADD	1000	183	0	1	182	1970-01-01 00:00:00
184	2015-10-21 11:16:05.921	ADD	1000	184	0	1	183	1970-01-01 00:00:00
185	2015-10-21 11:16:05.921	ADD	1000	185	0	1	184	1970-01-01 00:00:00
186	2015-10-21 11:16:05.921	ADD	1000	186	0	1	185	1970-01-01 00:00:00
187	2015-10-21 11:16:05.921	ADD	1000	187	0	1	186	1970-01-01 00:00:00
188	2015-10-21 11:16:05.921	ADD	1000	188	0	1	187	1970-01-01 00:00:00
189	2015-10-21 11:16:05.921	ADD	1000	189	0	1	188	1970-01-01 00:00:00
190	2015-10-21 11:16:05.921	ADD	1000	190	0	1	189	1970-01-01 00:00:00
191	2015-10-21 11:16:05.921	ADD	1000	191	0	1	190	1970-01-01 00:00:00
192	2015-10-21 11:16:05.921	ADD	1000	192	0	1	191	1970-01-01 00:00:00
193	2015-10-21 11:16:05.921	ADD	1000	193	0	1	192	1970-01-01 00:00:00
194	2015-10-21 11:16:05.921	ADD	1000	194	0	1	193	1970-01-01 00:00:00
195	2015-10-21 11:16:05.921	ADD	1000	195	0	1	194	1970-01-01 00:00:00
196	2015-10-21 11:16:05.921	ADD	1000	196	0	1	195	1970-01-01 00:00:00
197	2015-10-21 11:16:05.921	ADD	1000	197	0	1	196	1970-01-01 00:00:00
198	2015-10-21 11:16:05.921	ADD	1000	198	0	1	197	1970-01-01 00:00:00
199	2015-10-21 11:16:05.921	ADD	1000	199	0	1	198	1970-01-01 00:00:00
200	2015-10-21 11:16:05.921	ADD	1000	200	0	1	199	1970-01-01 00:00:00
201	2015-10-21 11:16:05.921	ADD	1000	201	0	1	200	1970-01-01 00:00:00
202	2015-10-21 11:16:05.921	ADD	1000	202	0	1	201	1970-01-01 00:00:00
203	2015-10-21 11:16:05.921	ADD	1000	203	0	1	202	1970-01-01 00:00:00
204	2015-10-21 11:16:05.921	ADD	1000	204	0	1	203	1970-01-01 00:00:00
205	2015-10-21 11:16:05.921	ADD	1000	205	0	1	204	1970-01-01 00:00:00
206	2015-10-21 11:16:05.921	ADD	1000	206	0	1	205	1970-01-01 00:00:00
207	2015-10-21 11:16:05.921	ADD	1000	207	0	1	206	1970-01-01 00:00:00
208	2015-10-21 11:16:05.921	ADD	1000	208	0	1	207	1970-01-01 00:00:00
209	2015-10-21 11:16:05.921	ADD	1000	209	0	1	208	1970-01-01 00:00:00
210	2015-10-21 11:16:05.921	ADD	1000	210	0	1	209	1970-01-01 00:00:00
211	2015-10-21 11:16:05.921	ADD	1000	211	0	1	210	1970-01-01 00:00:00
212	2015-10-21 11:16:05.921	ADD	1000	212	0	1	211	1970-01-01 00:00:00
213	2015-10-21 11:16:05.921	ADD	1000	213	0	1	212	1970-01-01 00:00:00
214	2015-10-21 11:16:05.921	ADD	1000	214	0	1	213	1970-01-01 00:00:00
215	2015-10-21 11:16:05.921	ADD	1000	215	0	1	214	1970-01-01 00:00:00
216	2015-10-21 11:16:05.921	ADD	1000	216	0	1	215	1970-01-01 00:00:00
217	2015-10-21 11:16:05.921	ADD	1000	217	0	1	216	1970-01-01 00:00:00
218	2015-10-21 11:16:05.921	ADD	1000	218	0	1	217	1970-01-01 00:00:00
219	2015-10-21 11:16:05.921	ADD	1000	219	0	1	218	1970-01-01 00:00:00
220	2015-10-21 11:16:05.921	ADD	1000	220	0	1	219	1970-01-01 00:00:00
221	2015-10-21 11:16:05.921	ADD	1000	221	0	1	220	1970-01-01 00:00:00
222	2015-10-21 11:16:05.921	ADD	1000	222	0	1	221	1970-01-01 00:00:00
223	2015-10-21 11:16:05.921	ADD	1000	223	0	1	222	1970-01-01 00:00:00
224	2015-10-21 11:16:05.921	ADD	1000	224	0	1	223	1970-01-01 00:00:00
225	2015-10-21 11:16:05.921	ADD	1000	225	0	1	224	1970-01-01 00:00:00
226	2015-10-21 11:16:05.921	ADD	1000	226	0	1	225	1970-01-01 00:00:00
227	2015-10-21 11:16:05.921	ADD	1000	227	0	1	226	1970-01-01 00:00:00
228	2015-10-21 11:16:05.921	ADD	1000	228	0	1	227	1970-01-01 00:00:00
229	2015-10-21 11:16:05.921	ADD	1000	229	0	1	228	1970-01-01 00:00:00
230	2015-10-21 11:16:05.921	ADD	1000	230	0	1	229	1970-01-01 00:00:00
231	2015-10-21 11:16:05.921	ADD	1000	231	0	1	230	1970-01-01 00:00:00
232	2015-10-21 11:16:05.921	ADD	1000	232	0	1	231	1970-01-01 00:00:00
233	2015-10-21 11:16:05.921	ADD	1000	233	0	1	232	1970-01-01 00:00:00
234	2015-10-21 11:16:05.921	ADD	1000	234	0	1	233	1970-01-01 00:00:00
235	2015-10-21 11:16:05.921	ADD	1000	235	0	1	234	1970-01-01 00:00:00
236	2015-10-21 11:16:05.921	ADD	1000	236	0	1	235	1970-01-01 00:00:00
237	2015-10-21 11:16:05.921	ADD	1000	237	0	1	236	1970-01-01 00:00:00
238	2015-10-21 11:16:05.921	ADD	1000	238	0	1	237	1970-01-01 00:00:00
239	2015-10-21 11:16:05.921	ADD	1000	239	0	1	238	1970-01-01 00:00:00
240	2015-10-21 11:16:05.921	ADD	1000	240	0	1	239	1970-01-01 00:00:00
241	2015-10-21 11:16:05.921	ADD	1000	241	0	1	240	1970-01-01 00:00:00
\.


--
-- Data for Name: organizationtorole; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationtorole (tkey, version, organization_tkey, organizationrole_tkey) FROM stdin;
1	0	1	4
2	0	1	3
3	0	1	5
10008	0	10002	2
10009	0	10002	1
10010	0	10002	3
10011	0	10002	5
10012	0	10003	3
\.


--
-- Data for Name: organizationtorolehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY organizationtorolehistory (tkey, moddate, modtype, moduser, objkey, objversion, organizationroletkey, organizationtkey, invocationdate) FROM stdin;
1	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1	0	4	1	2015-10-21 11:16:00.664
2	2015-10-21 11:16:03.144	ADD	ANONYMOUS	2	0	3	1	1970-01-01 00:00:00
3	2015-10-21 11:16:04.018	ADD	ANONYMOUS	3	0	5	1	1970-01-01 00:00:00
10008	2015-10-21 11:16:54.299	ADD	1000	10008	0	2	10002	2015-10-21 11:16:54.299
10009	2015-10-21 11:16:54.299	ADD	1000	10009	0	1	10002	2015-10-21 11:16:54.299
10010	2015-10-21 11:16:54.299	ADD	1000	10010	0	3	10002	2015-10-21 11:16:54.299
10011	2015-10-21 11:17:39.28	ADD	1000	10011	0	5	10002	2015-10-21 11:17:39.28
10012	2015-10-21 11:18:12.606	ADD	10002	10012	0	3	10003	2015-10-21 11:18:12.606
\.


--
-- Data for Name: parameter; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parameter (tkey, configurable, value, version, parameterdefinitionkey, parametersetkey) FROM stdin;
10020	f	3	0	1000	10003
10021	f	2	0	1001	10003
10022	f	2	0	10016	10003
10023	f	200	0	10018	10003
10024	f	200	0	10020	10003
10025	f	200	0	10021	10003
10026	f	true	0	10023	10003
10027	f	2	0	10016	10004
10028	f	200	0	10018	10004
10029	f	200	0	10020	10004
10030	f	200	0	10021	10004
10031	f	true	0	10023	10004
10032	f	10	0	1000	10005
10033	t	2	0	10016	10005
10034	t	\N	0	10017	10005
10035	t	200	0	10018	10005
10036	t	\N	0	10019	10005
10037	t	200	0	10020	10005
10038	t	200	0	10021	10005
10039	t	true	0	10023	10005
10040	f	3	0	1000	10006
10041	f	2	0	1001	10006
10042	f	2	0	10016	10006
10043	f	200	0	10018	10006
10044	f	200	0	10020	10006
10045	f	200	0	10021	10006
10046	f	true	0	10023	10006
10047	f	2	0	10016	10007
10048	f	200	0	10018	10007
10049	f	200	0	10020	10007
10050	f	200	0	10021	10007
10051	f	true	0	10023	10007
10052	f	10	0	1000	10008
10053	t	2	0	10016	10008
10055	t	200	0	10018	10008
10056	t	\N	0	10019	10008
10057	t	200	0	10020	10008
10058	t	200	0	10021	10008
10059	t	true	0	10023	10008
10054	t	1	1	10017	10008
\.


--
-- Data for Name: parameterdefinition; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parameterdefinition (tkey, configurable, defaultvalue, mandatory, maximumvalue, minimumvalue, parameterid, parametertype, valuetype, version, technicalproduct_tkey, modificationtype) FROM stdin;
1000	t	\N	f	\N	1	CONCURRENT_USER	PLATFORM_PARAMETER	LONG	0	\N	STANDARD
1001	t	\N	f	\N	1	NAMED_USER	PLATFORM_PARAMETER	LONG	0	\N	STANDARD
1002	t	\N	f	\N	0	PERIOD	PLATFORM_PARAMETER	DURATION	0	\N	STANDARD
10016	t	2	f	\N	\N	MEMORY_STORAGE	SERVICE_PARAMETER	ENUMERATION	1	10002	STANDARD
10017	t	\N	f	\N	\N	DISK_SPACE	SERVICE_PARAMETER	ENUMERATION	0	10002	STANDARD
10018	t	200	t	500	12	MAX_FOLDER_NUMBER2	SERVICE_PARAMETER	INTEGER	0	10002	STANDARD
10019	t	\N	f	\N	\N	STRING_DATA_TYPE	SERVICE_PARAMETER	STRING	0	10002	STANDARD
10020	t	200	f	500	12	MAX_FILE_NUMBER	SERVICE_PARAMETER	INTEGER	0	10002	STANDARD
10021	t	200	f	500	12	MAX_FOLDER_NUMBER	SERVICE_PARAMETER	INTEGER	0	10002	STANDARD
10022	f	200	f	500	12	NON_CONFIGURABLE	SERVICE_PARAMETER	INTEGER	0	10002	STANDARD
10023	t	true	f	\N	\N	RENAME_FOLDER	SERVICE_PARAMETER	BOOLEAN	0	10002	STANDARD
\.


--
-- Data for Name: parameterdefinitionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parameterdefinitionhistory (tkey, configurable, defaultvalue, mandatory, maximumvalue, minimumvalue, parameterid, parametertype, valuetype, moddate, modtype, moduser, objkey, objversion, technicalproductobjkey, invocationdate, modificationtype) FROM stdin;
1000	f	\N	f	\N	1	CONCURRENT_USER	PLATFORM_PARAMETER	LONG	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1000	0	\N	2015-10-21 11:16:00.664	STANDARD
1001	f	\N	f	\N	1	NAMED_USER	PLATFORM_PARAMETER	LONG	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1001	0	\N	2015-10-21 11:16:00.664	STANDARD
1002	f	\N	f	\N	0	PERIOD	PLATFORM_PARAMETER	DURATION	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1002	0	\N	2015-10-21 11:16:00.664	STANDARD
10018	t	\N	f	\N	\N	MEMORY_STORAGE	SERVICE_PARAMETER	ENUMERATION	2015-10-21 11:18:00.111	ADD	10002	10016	0	10002	2015-10-21 11:18:00.111	STANDARD
10019	t	2	f	\N	\N	MEMORY_STORAGE	SERVICE_PARAMETER	ENUMERATION	2015-10-21 11:18:00.111	MODIFY	10002	10016	1	10002	2015-10-21 11:18:00.111	STANDARD
10020	t	\N	f	\N	\N	DISK_SPACE	SERVICE_PARAMETER	ENUMERATION	2015-10-21 11:18:00.111	ADD	10002	10017	0	10002	2015-10-21 11:18:00.111	STANDARD
10021	t	200	t	500	12	MAX_FOLDER_NUMBER2	SERVICE_PARAMETER	INTEGER	2015-10-21 11:18:00.111	ADD	10002	10018	0	10002	2015-10-21 11:18:00.111	STANDARD
10022	t	\N	f	\N	\N	STRING_DATA_TYPE	SERVICE_PARAMETER	STRING	2015-10-21 11:18:00.111	ADD	10002	10019	0	10002	2015-10-21 11:18:00.111	STANDARD
10023	t	200	f	500	12	MAX_FILE_NUMBER	SERVICE_PARAMETER	INTEGER	2015-10-21 11:18:00.111	ADD	10002	10020	0	10002	2015-10-21 11:18:00.111	STANDARD
10024	t	200	f	500	12	MAX_FOLDER_NUMBER	SERVICE_PARAMETER	INTEGER	2015-10-21 11:18:00.111	ADD	10002	10021	0	10002	2015-10-21 11:18:00.111	STANDARD
10025	f	200	f	500	12	NON_CONFIGURABLE	SERVICE_PARAMETER	INTEGER	2015-10-21 11:18:00.111	ADD	10002	10022	0	10002	2015-10-21 11:18:00.111	STANDARD
10026	t	true	f	\N	\N	RENAME_FOLDER	SERVICE_PARAMETER	BOOLEAN	2015-10-21 11:18:00.111	ADD	10002	10023	0	10002	2015-10-21 11:18:00.111	STANDARD
\.


--
-- Data for Name: parameterhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parameterhistory (tkey, configurable, value, moddate, modtype, moduser, objkey, objversion, parameterdefinitionobjkey, parametersetobjkey, invocationdate) FROM stdin;
10020	f	3	2015-10-21 11:18:02.56	ADD	10002	10020	0	1000	10003	2015-10-21 11:18:02.56
10021	f	2	2015-10-21 11:18:02.56	ADD	10002	10021	0	1001	10003	2015-10-21 11:18:02.56
10022	f	2	2015-10-21 11:18:02.56	ADD	10002	10022	0	10016	10003	2015-10-21 11:18:02.56
10023	f	200	2015-10-21 11:18:02.56	ADD	10002	10023	0	10018	10003	2015-10-21 11:18:02.56
10024	f	200	2015-10-21 11:18:02.56	ADD	10002	10024	0	10020	10003	2015-10-21 11:18:02.56
10025	f	200	2015-10-21 11:18:02.56	ADD	10002	10025	0	10021	10003	2015-10-21 11:18:02.56
10026	f	true	2015-10-21 11:18:02.56	ADD	10002	10026	0	10023	10003	2015-10-21 11:18:02.56
10027	f	2	2015-10-21 11:18:03.574	ADD	10002	10027	0	10016	10004	2015-10-21 11:18:03.574
10028	f	200	2015-10-21 11:18:03.574	ADD	10002	10028	0	10018	10004	2015-10-21 11:18:03.574
10029	f	200	2015-10-21 11:18:03.574	ADD	10002	10029	0	10020	10004	2015-10-21 11:18:03.574
10030	f	200	2015-10-21 11:18:03.574	ADD	10002	10030	0	10021	10004	2015-10-21 11:18:03.574
10031	f	true	2015-10-21 11:18:03.574	ADD	10002	10031	0	10023	10004	2015-10-21 11:18:03.574
10032	f	10	2015-10-21 11:18:04.229	ADD	10002	10032	0	1000	10005	2015-10-21 11:18:04.229
10033	t	2	2015-10-21 11:18:04.229	ADD	10002	10033	0	10016	10005	2015-10-21 11:18:04.229
10034	t	\N	2015-10-21 11:18:04.229	ADD	10002	10034	0	10017	10005	2015-10-21 11:18:04.229
10035	t	200	2015-10-21 11:18:04.229	ADD	10002	10035	0	10018	10005	2015-10-21 11:18:04.229
10036	t	\N	2015-10-21 11:18:04.229	ADD	10002	10036	0	10019	10005	2015-10-21 11:18:04.229
10037	t	200	2015-10-21 11:18:04.229	ADD	10002	10037	0	10020	10005	2015-10-21 11:18:04.229
10038	t	200	2015-10-21 11:18:04.229	ADD	10002	10038	0	10021	10005	2015-10-21 11:18:04.229
10039	t	true	2015-10-21 11:18:04.229	ADD	10002	10039	0	10023	10005	2015-10-21 11:18:04.229
10040	f	3	2015-10-21 11:27:00.55	ADD	10003	10040	0	1000	10006	2015-10-21 11:27:00.55
10041	f	2	2015-10-21 11:27:00.55	ADD	10003	10041	0	1001	10006	2015-10-21 11:27:00.55
10042	f	2	2015-10-21 11:27:00.55	ADD	10003	10042	0	10016	10006	2015-10-21 11:27:00.55
10043	f	200	2015-10-21 11:27:00.55	ADD	10003	10043	0	10018	10006	2015-10-21 11:27:00.55
10044	f	200	2015-10-21 11:27:00.55	ADD	10003	10044	0	10020	10006	2015-10-21 11:27:00.55
10045	f	200	2015-10-21 11:27:00.55	ADD	10003	10045	0	10021	10006	2015-10-21 11:27:00.55
10046	f	true	2015-10-21 11:27:00.55	ADD	10003	10046	0	10023	10006	2015-10-21 11:27:00.55
10047	f	2	2015-10-21 11:29:13.858	ADD	10003	10047	0	10016	10007	2015-10-21 11:29:13.858
10048	f	200	2015-10-21 11:29:13.858	ADD	10003	10048	0	10018	10007	2015-10-21 11:29:13.858
10049	f	200	2015-10-21 11:29:13.858	ADD	10003	10049	0	10020	10007	2015-10-21 11:29:13.858
10050	f	200	2015-10-21 11:29:13.858	ADD	10003	10050	0	10021	10007	2015-10-21 11:29:13.858
10051	f	true	2015-10-21 11:29:13.858	ADD	10003	10051	0	10023	10007	2015-10-21 11:29:13.858
10052	f	10	2015-10-21 11:30:34.108	ADD	10003	10052	0	1000	10008	2015-10-21 11:30:34.108
10053	t	2	2015-10-21 11:30:34.108	ADD	10003	10053	0	10016	10008	2015-10-21 11:30:34.108
10054	t	\N	2015-10-21 11:30:34.108	ADD	10003	10054	0	10017	10008	2015-10-21 11:30:34.108
10055	t	200	2015-10-21 11:30:34.108	ADD	10003	10055	0	10018	10008	2015-10-21 11:30:34.108
10056	t	\N	2015-10-21 11:30:34.108	ADD	10003	10056	0	10019	10008	2015-10-21 11:30:34.108
10057	t	200	2015-10-21 11:30:34.108	ADD	10003	10057	0	10020	10008	2015-10-21 11:30:34.108
10058	t	200	2015-10-21 11:30:34.108	ADD	10003	10058	0	10021	10008	2015-10-21 11:30:34.108
10059	t	true	2015-10-21 11:30:34.108	ADD	10003	10059	0	10023	10008	2015-10-21 11:30:34.108
10060	t	1	2015-10-21 11:30:34.108	MODIFY	10003	10054	1	10017	10008	2015-10-21 11:30:34.108
\.


--
-- Data for Name: parameteroption; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parameteroption (tkey, optionid, version, parameterdefinition_tkey) FROM stdin;
10012	1	0	10016
10013	2	0	10016
10014	3	0	10016
10015	1	0	10017
10016	2	0	10017
10017	3	0	10017
\.


--
-- Data for Name: parameteroptionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parameteroptionhistory (tkey, optionid, moddate, modtype, moduser, objkey, objversion, parameterdefobjkey, invocationdate) FROM stdin;
10012	1	2015-10-21 11:18:00.111	ADD	10002	10012	0	10016	2015-10-21 11:18:00.111
10013	2	2015-10-21 11:18:00.111	ADD	10002	10013	0	10016	2015-10-21 11:18:00.111
10014	3	2015-10-21 11:18:00.111	ADD	10002	10014	0	10016	2015-10-21 11:18:00.111
10015	1	2015-10-21 11:18:00.111	ADD	10002	10015	0	10017	2015-10-21 11:18:00.111
10016	2	2015-10-21 11:18:00.111	ADD	10002	10016	0	10017	2015-10-21 11:18:00.111
10017	3	2015-10-21 11:18:00.111	ADD	10002	10017	0	10017	2015-10-21 11:18:00.111
\.


--
-- Data for Name: parameterset; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parameterset (tkey, version) FROM stdin;
10003	0
10004	0
10005	0
10006	0
10007	0
10008	0
\.


--
-- Data for Name: parametersethistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY parametersethistory (tkey, moddate, modtype, moduser, objkey, objversion, invocationdate) FROM stdin;
10003	2015-10-21 11:18:02.56	ADD	10002	10003	0	2015-10-21 11:18:02.56
10004	2015-10-21 11:18:03.574	ADD	10002	10004	0	2015-10-21 11:18:03.574
10005	2015-10-21 11:18:04.229	ADD	10002	10005	0	2015-10-21 11:18:04.229
10006	2015-10-21 11:27:00.55	ADD	10003	10006	0	2015-10-21 11:27:00.55
10007	2015-10-21 11:29:13.858	ADD	10003	10007	0	2015-10-21 11:29:13.858
10008	2015-10-21 11:30:34.108	ADD	10003	10008	0	2015-10-21 11:30:34.108
\.


--
-- Data for Name: paymentinfo; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY paymentinfo (tkey, creationtime, externalidentifier, version, paymenttype_tkey, paymentinfoid, organization_tkey, providername, accountnumber) FROM stdin;
2	1445418963487	\N	1	3	INVOICE	1	\N	\N
10002	1445419014299	\N	0	3	Invoice	10002	\N	\N
10003	1445419092606	\N	0	3	Invoice	10003	\N	\N
\.


--
-- Data for Name: paymentinfohistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY paymentinfohistory (tkey, creationtime, externalidentifier, moddate, modtype, moduser, objkey, objversion, paymenttypeobjkey, invocationdate, paymentinfoid, organizationobjkey, providername, accountnumber) FROM stdin;
2	1445418963487	\N	2015-10-21 11:16:03.487	ADD	ANONYMOUS	2	1	3	2015-10-21 11:16:03.487	INVOICE	1	\N	\N
10002	1445419014299	\N	2015-10-21 11:16:54.299	ADD	1000	10002	0	3	2015-10-21 11:16:54.299	Invoice	10002	\N	\N
10003	1445419092606	\N	2015-10-21 11:18:12.606	ADD	10002	10003	0	3	2015-10-21 11:18:12.606	Invoice	10003	\N	\N
\.


--
-- Data for Name: paymentresult; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY paymentresult (tkey, processingexception, processingresult, processingstatus, processingtime, version, billingresult_tkey) FROM stdin;
\.


--
-- Data for Name: paymentresulthistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY paymentresulthistory (tkey, processingexception, processingresult, processingstatus, processingtime, moddate, modtype, moduser, objkey, objversion, billingresultobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: paymenttype; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY paymenttype (tkey, collectiontype, paymenttypeid, version, psp_tkey) FROM stdin;
3	ORGANIZATION	INVOICE	0	1
10004	PAYMENT_SERVICE_PROVIDER	CREDIT_CARD	0	10002
10005	PAYMENT_SERVICE_PROVIDER	DIRECT_DEBIT	0	10002
\.


--
-- Data for Name: paymenttypehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY paymenttypehistory (tkey, objversion, objkey, invocationdate, moddate, modtype, moduser, pspobjkey, collectiontype, paymenttypeid) FROM stdin;
3	0	3	2015-10-21 11:16:04.174	2015-10-21 11:16:04.174	ADD	1000	1	ORGANIZATION	INVOICE
10004	0	10004	2015-10-21 11:16:36.181	2015-10-21 11:16:36.181	ADD	1000	10002	PAYMENT_SERVICE_PROVIDER	CREDIT_CARD
10005	0	10005	2015-10-21 11:16:36.231	2015-10-21 11:16:36.231	ADD	1000	10002	PAYMENT_SERVICE_PROVIDER	DIRECT_DEBIT
\.


--
-- Data for Name: platformsetting; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY platformsetting (tkey, settingtype, settingvalue, version) FROM stdin;
\.


--
-- Data for Name: platformuser; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY platformuser (tkey, additionalname, address, creationdate, email, failedlogincounter, firstname, lastname, locale, phone, salutation, status, passwordsalt, passwordhash, userid, version, organizationkey, useridcnt, olduserid, realmuserid, passwordrecoverystartdate) FROM stdin;
1000	\N	\N	1445418960664	administrator@oscm.org	0	\N	\N	en	\N	\N	ACTIVE	0	\\x016f6b79f3cfbdf9c265ebfb50869f489c0ceb992842ac175a6bd369547024cf	administrator	1	1	1	administrator	administrator	0
10002			1445419014299	admin@oscm.org	0	Firstname	Lastname	en		MR	ACTIVE	-2919461748401708521	\\xa6d0e591ec483409855760a9075780f5215d2323ea428640076b7832411c24b8	admin	2	10002	\N	\N	admin	0
10003	\N	\N	1445419092606	customer@oscm.org	0	\N	\N	en	\N	\N	ACTIVE	-1816460487126741386	\\xf3c3b20e5893d55ecef738aaf9d14b120fc815d44f8c75c9100ff3701651ce50	customer	2	10003	\N	\N	customer	0
\.


--
-- Data for Name: platformuserhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY platformuserhistory (tkey, additionalname, address, creationdate, email, failedlogincounter, firstname, lastname, locale, phone, salutation, status, passwordsalt, passwordhash, userid, moddate, modtype, moduser, objkey, objversion, organizationobjkey, invocationdate, realmuserid, passwordrecoverystartdate) FROM stdin;
1	\N	\N	1445418960664	\N	0	\N	\N	en	\N	\N	ACTIVE	0	\\x016f6b79f3cfbdf9c265ebfb50869f489c0ceb992842ac175a6bd369547024cf	administrator	2015-10-21 11:16:00.664	ADD	ANONYMOUS	1	0	1	2015-10-21 11:16:00.664	administrator	0
10004			1445419014299	administrator@oscm.org	0	Firstname	Lastname	en		MR	PASSWORD_MUST_BE_CHANGED	-3283339059919823613	\\x18c492a083f56fca621995f194158e2c57ae442ef9444b73a560884a8ad6612f	admin	2015-10-21 11:16:54.299	ADD	1000	10002	0	10002	2015-10-21 11:16:54.299	admin	0
10005			1445419014299	administrator@oscm.org	0	Firstname	Lastname	en		MR	ACTIVE	-2919461748401708521	\\xa6d0e591ec483409855760a9075780f5215d2323ea428640076b7832411c24b8	admin	2015-10-21 11:17:40.948	MODIFY	10002	10002	1	10002	2015-10-21 11:17:40.948	admin	0
10006	\N	\N	1445419092606	administrator@oscm.org	0	\N	\N	en	\N	\N	PASSWORD_MUST_BE_CHANGED	-1965807927587036167	\\x787745aea3e6180347621617bce2283ca6b05c7fb4eb16c2f704d48745507fa8	customer	2015-10-21 11:18:12.606	ADD	10002	10003	0	10003	2015-10-21 11:18:12.606	customer	0
10007	\N	\N	1445419092606	administrator@oscm.org	0	\N	\N	en	\N	\N	ACTIVE	-1816460487126741386	\\xf3c3b20e5893d55ecef738aaf9d14b120fc815d44f8c75c9100ff3701651ce50	customer	2015-10-21 11:18:18.815	MODIFY	10003	10003	1	10003	2015-10-21 11:18:18.815	customer	0
10008	\N	\N	1445418960664	administrator@oscm.org	0	\N	\N	en	\N	\N	ACTIVE	0	\\x016f6b79f3cfbdf9c265ebfb50869f489c0ceb992842ac175a6bd369547024cf	administrator	2015-10-21 11:19:20.909	MODIFY	1000	1000	1	1	2015-10-21 11:19:20.909	administrator	0
10009			1445419014299	admin@oscm.org	0	Firstname	Lastname	en		MR	ACTIVE	-2919461748401708521	\\xa6d0e591ec483409855760a9075780f5215d2323ea428640076b7832411c24b8	admin	2015-10-21 11:24:57.809	MODIFY	10002	10002	2	10002	2015-10-21 11:24:57.809	admin	0
10010	\N	\N	1445419092606	customer@oscm.org	0	\N	\N	en	\N	\N	ACTIVE	-1816460487126741386	\\xf3c3b20e5893d55ecef738aaf9d14b120fc815d44f8c75c9100ff3701651ce50	customer	2015-10-21 11:26:23.282	MODIFY	10003	10003	2	10003	2015-10-21 11:26:23.282	customer	0
\.


--
-- Data for Name: pricedevent; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedevent (tkey, eventprice, version, eventkey, pricemodelkey) FROM stdin;
\.


--
-- Data for Name: pricedeventhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedeventhistory (tkey, eventprice, moddate, modtype, moduser, objkey, objversion, eventobjkey, pricemodelobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: pricedoption; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedoption (tkey, pricepersubscription, priceperuser, version, parameteroptionkey, pricedparameter_tkey) FROM stdin;
\.


--
-- Data for Name: pricedoptionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedoptionhistory (tkey, pricepersubscription, priceperuser, moddate, modtype, moduser, objkey, objversion, parameteroptionobjkey, pricedparameterobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: pricedparameter; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedparameter (tkey, pricepersubscription, priceperuser, version, parameter_tkey, pricemodelkey) FROM stdin;
\.


--
-- Data for Name: pricedparameterhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedparameterhistory (tkey, pricepersubscription, priceperuser, moddate, modtype, moduser, objkey, objversion, parameterobjkey, pricemodelobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: pricedproductrole; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedproductrole (tkey, priceperuser, version, pricemodel_tkey, pricedoption_tkey, pricedparameter_tkey, roledefinition_tkey) FROM stdin;
\.


--
-- Data for Name: pricedproductrolehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricedproductrolehistory (tkey, priceperuser, moddate, modtype, moduser, objkey, objversion, pricemodelobjkey, pricedoptionobjkey, pricedparameterobjkey, roledefinitionobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: pricemodel; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricemodel (tkey, onetimefee, period, priceperperiod, priceperuserassignment, version, currency_tkey, freeperiod, type, provisioningcompleted) FROM stdin;
10003	0	\N	0	0	0	\N	0	FREE_OF_CHARGE	t
10004	0	\N	0	0	0	\N	0	FREE_OF_CHARGE	t
10005	50	MONTH	50	50	0	10002	0	PRO_RATA	t
10006	0	\N	0	0	1	\N	0	FREE_OF_CHARGE	t
10007	0	\N	0	0	1	\N	0	FREE_OF_CHARGE	t
10008	50	MONTH	50	50	1	10002	0	PRO_RATA	t
\.


--
-- Data for Name: pricemodelhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pricemodelhistory (tkey, onetimefee, period, priceperperiod, priceperuserassignment, moddate, modtype, moduser, objkey, objversion, currencyobjkey, productobjkey, invocationdate, freeperiod, type, provisioningcompleted) FROM stdin;
10003	0	\N	0	0	2015-10-21 11:18:05.04	ADD	10002	10003	0	\N	10003	2015-10-21 11:18:05.04	0	FREE_OF_CHARGE	t
10004	0	\N	0	0	2015-10-21 11:18:05.524	ADD	10002	10004	0	\N	10004	2015-10-21 11:18:05.524	0	FREE_OF_CHARGE	t
10005	50	MONTH	50	50	2015-10-21 11:18:05.945	ADD	10002	10005	0	10002	10005	2015-10-21 11:18:05.945	0	PRO_RATA	t
10006	0	\N	0	0	2015-10-21 11:27:00.55	ADD	10003	10006	0	\N	10006	2015-10-21 11:27:00.55	0	FREE_OF_CHARGE	f
10007	0	\N	0	0	2015-10-21 11:27:00.55	MODIFY	10003	10006	1	\N	10006	2015-10-21 11:27:00.55	0	FREE_OF_CHARGE	t
10008	0	\N	0	0	2015-10-21 11:29:13.858	ADD	10003	10007	0	\N	10007	2015-10-21 11:29:13.858	0	FREE_OF_CHARGE	f
10009	0	\N	0	0	2015-10-21 11:29:13.858	MODIFY	10003	10007	1	\N	10007	2015-10-21 11:29:13.858	0	FREE_OF_CHARGE	t
10010	50	MONTH	50	50	2015-10-21 11:30:34.108	ADD	10003	10008	0	10002	10008	2015-10-21 11:30:34.108	0	PRO_RATA	f
10011	50	MONTH	50	50	2015-10-21 11:30:34.108	MODIFY	10003	10008	1	10002	10008	2015-10-21 11:30:34.108	0	PRO_RATA	t
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY product (tkey, deprovisioningdate, productid, provisioningdate, status, version, vendorkey, parameterset_tkey, pricemodel_tkey, targetcustomer_tkey, technicalproduct_tkey, template_tkey, type, autoassignuserenabled, configuratorurl) FROM stdin;
10003	\N	ServiceTrial	1445419082560	ACTIVE	2	10002	10003	10003	\N	10002	\N	TEMPLATE	f	\N
10004	\N	ServiceStarter	1445419083574	ACTIVE	2	10002	10004	10004	\N	10002	\N	TEMPLATE	f	\N
10005	\N	ServiceProfessional	1445419084229	ACTIVE	2	10002	10005	10005	\N	10002	\N	TEMPLATE	f	\N
10006	\N	ServiceTrial#54374562-211f-4197-878a-0c6d140e8d4310003	1445419620550	ACTIVE	0	10002	10006	10006	\N	10002	10003	SUBSCRIPTION	f	\N
10007	\N	ServiceStarter#1c8b107e-a840-4776-bb0e-e69d5a7fdfa010003	1445419753858	ACTIVE	0	10002	10007	10007	\N	10002	10004	SUBSCRIPTION	f	\N
10008	\N	ServiceProfessional#20b22c68-fc5e-49cf-87c0-69bb89e0e68110003	1445419834108	ACTIVE	0	10002	10008	10008	\N	10002	10005	SUBSCRIPTION	f	\N
\.


--
-- Data for Name: productfeedback; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY productfeedback (tkey, version, averagerating, product_tkey) FROM stdin;
\.


--
-- Data for Name: producthistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY producthistory (tkey, deprovisioningdate, productid, provisioningdate, status, moddate, modtype, moduser, objkey, objversion, parametersetobjkey, pricemodelobjkey, vendorobjkey, targetcustomerobjkey, technicalproductobjkey, templateobjkey, invocationdate, type, autoassignuserenabled, configuratorurl) FROM stdin;
10006	\N	ServiceTrial	1445419082560	INACTIVE	2015-10-21 11:18:02.56	ADD	10002	10003	0	10003	\N	10002	\N	10002	\N	2015-10-21 11:18:02.56	TEMPLATE	f	\N
10007	\N	ServiceStarter	1445419083574	INACTIVE	2015-10-21 11:18:03.574	ADD	10002	10004	0	10004	\N	10002	\N	10002	\N	2015-10-21 11:18:03.574	TEMPLATE	f	\N
10008	\N	ServiceProfessional	1445419084229	INACTIVE	2015-10-21 11:18:04.229	ADD	10002	10005	0	10005	\N	10002	\N	10002	\N	2015-10-21 11:18:04.229	TEMPLATE	f	\N
10009	\N	ServiceTrial	1445419082560	INACTIVE	2015-10-21 11:18:05.04	MODIFY	10002	10003	1	10003	10003	10002	\N	10002	\N	2015-10-21 11:18:05.04	TEMPLATE	f	\N
10010	\N	ServiceStarter	1445419083574	INACTIVE	2015-10-21 11:18:05.524	MODIFY	10002	10004	1	10004	10004	10002	\N	10002	\N	2015-10-21 11:18:05.524	TEMPLATE	f	\N
10011	\N	ServiceProfessional	1445419084229	INACTIVE	2015-10-21 11:18:05.945	MODIFY	10002	10005	1	10005	10005	10002	\N	10002	\N	2015-10-21 11:18:05.945	TEMPLATE	f	\N
10012	\N	ServiceTrial	1445419082560	ACTIVE	2015-10-21 11:18:09.283	MODIFY	10002	10003	2	10003	10003	10002	\N	10002	\N	2015-10-21 11:18:09.283	TEMPLATE	f	\N
10013	\N	ServiceStarter	1445419083574	ACTIVE	2015-10-21 11:18:09.72	MODIFY	10002	10004	2	10004	10004	10002	\N	10002	\N	2015-10-21 11:18:09.72	TEMPLATE	f	\N
10014	\N	ServiceProfessional	1445419084229	ACTIVE	2015-10-21 11:18:10.157	MODIFY	10002	10005	2	10005	10005	10002	\N	10002	\N	2015-10-21 11:18:10.157	TEMPLATE	f	\N
10015	\N	ServiceTrial#54374562-211f-4197-878a-0c6d140e8d4310003	1445419620550	ACTIVE	2015-10-21 11:27:00.55	ADD	10003	10006	0	10006	10006	10002	\N	10002	10003	2015-10-21 11:27:00.55	SUBSCRIPTION	f	\N
10016	\N	ServiceStarter#1c8b107e-a840-4776-bb0e-e69d5a7fdfa010003	1445419753858	ACTIVE	2015-10-21 11:29:13.858	ADD	10003	10007	0	10007	10007	10002	\N	10002	10004	2015-10-21 11:29:13.858	SUBSCRIPTION	f	\N
10017	\N	ServiceProfessional#20b22c68-fc5e-49cf-87c0-69bb89e0e68110003	1445419834108	ACTIVE	2015-10-21 11:30:34.108	ADD	10003	10008	0	10008	10008	10002	\N	10002	10005	2015-10-21 11:30:34.108	SUBSCRIPTION	f	\N
\.


--
-- Data for Name: productreference; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY productreference (tkey, version, sourceproduct_tkey, targetproduct_tkey) FROM stdin;
10004	0	10003	10004
10005	0	10003	10005
10006	0	10004	10003
10007	0	10004	10005
\.


--
-- Data for Name: productreferencehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY productreferencehistory (tkey, moddate, modtype, moduser, objkey, objversion, sourceproducttkey, targetproducttkey, invocationdate) FROM stdin;
10004	2015-10-21 11:18:06.304	ADD	10002	10004	0	10003	10004	2015-10-21 11:18:06.304
10005	2015-10-21 11:18:06.304	ADD	10002	10005	0	10003	10005	2015-10-21 11:18:06.304
10006	2015-10-21 11:18:06.475	ADD	10002	10006	0	10004	10003	2015-10-21 11:18:06.475
10007	2015-10-21 11:18:06.475	ADD	10002	10007	0	10004	10005	2015-10-21 11:18:06.475
\.


--
-- Data for Name: productreview; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY productreview (tkey, version, rating, title, comment, modificationdate, platformuser_tkey, productfeedback_tkey) FROM stdin;
\.


--
-- Data for Name: productreviewhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY productreviewhistory (tkey, objversion, objkey, invocationdate, moddate, modtype, moduser, rating, title, comment, modificationdate, platformuserobjkey, productfeedbackobjkey) FROM stdin;
\.


--
-- Data for Name: producttopaymenttype; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY producttopaymenttype (tkey, version, product_tkey, paymenttype_tkey) FROM stdin;
10009	0	10003	3
10010	0	10003	10004
10011	0	10003	10005
10012	0	10004	3
10013	0	10004	10004
10014	0	10004	10005
10015	0	10005	3
10016	0	10005	10004
10017	0	10005	10005
\.


--
-- Data for Name: producttopaymenttypehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY producttopaymenttypehistory (tkey, moddate, invocationdate, modtype, moduser, objkey, objversion, productobjkey, paymenttypeobjkey) FROM stdin;
10009	2015-10-21 11:18:02.56	2015-10-21 11:18:02.56	ADD	10002	10009	0	10003	3
10010	2015-10-21 11:18:02.56	2015-10-21 11:18:02.56	ADD	10002	10010	0	10003	10004
10011	2015-10-21 11:18:02.56	2015-10-21 11:18:02.56	ADD	10002	10011	0	10003	10005
10012	2015-10-21 11:18:03.574	2015-10-21 11:18:03.574	ADD	10002	10012	0	10004	3
10013	2015-10-21 11:18:03.574	2015-10-21 11:18:03.574	ADD	10002	10013	0	10004	10004
10014	2015-10-21 11:18:03.574	2015-10-21 11:18:03.574	ADD	10002	10014	0	10004	10005
10015	2015-10-21 11:18:04.229	2015-10-21 11:18:04.229	ADD	10002	10015	0	10005	3
10016	2015-10-21 11:18:04.229	2015-10-21 11:18:04.229	ADD	10002	10016	0	10005	10004
10017	2015-10-21 11:18:04.229	2015-10-21 11:18:04.229	ADD	10002	10017	0	10005	10005
\.


--
-- Data for Name: psp; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY psp (tkey, version, identifier, wsdlurl, distinguishedname) FROM stdin;
1	0	Invoice		\N
10002	0	heidelpay	http://www.yoursite.com	\N
\.


--
-- Data for Name: pspaccount; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pspaccount (tkey, version, pspidentifier, psp_tkey, organization_tkey) FROM stdin;
10002	0	Test	10002	10002
\.


--
-- Data for Name: pspaccounthistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pspaccounthistory (tkey, objversion, objkey, invocationdate, moddate, modtype, moduser, pspidentifier, pspobjkey, organizationobjkey) FROM stdin;
10002	0	10002	2015-10-21 11:17:32.666	2015-10-21 11:17:32.666	ADD	1000	Test	10002	10002
\.


--
-- Data for Name: psphistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY psphistory (tkey, objversion, objkey, invocationdate, moddate, modtype, moduser, identifier, wsdlurl, distinguishedname) FROM stdin;
1	0	1	2015-10-21 11:16:04.174	2015-10-21 11:16:04.174	ADD	1000	Invoice		\N
10002	0	10002	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	heidelpay	http://www.yoursite.com	\N
\.


--
-- Data for Name: pspsetting; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pspsetting (tkey, version, settingkey, settingvalue, psp_tkey) FROM stdin;
10026	0	PSP_POST_URL		10002
10027	0	PSP_RESPONSE_SERVLET_URL		10002
10028	0	PSP_USER_PWD		10002
10029	0	PSP_USER_LOGIN		10002
10030	0	PSP_TRANSACTION_CHANNEL		10002
10031	0	PSP_SECURITY_SENDER		10002
10032	0	PSP_XML_URL		10002
10033	0	PSP_TXN_MODE		10002
10034	0	BASE_URL		10002
10035	0	PSP_SUPPORTED_DD_COUNTRIES		10002
10036	0	PSP_SUPPORTED_CC_BRANDS		10002
10037	0	PSP_PAYMENT_REGISTRATION_WSDL		10002
10038	0	PSP_FRONTEND_JS_PATH		10002
\.


--
-- Data for Name: pspsettinghistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY pspsettinghistory (tkey, objversion, objkey, invocationdate, moddate, modtype, moduser, settingkey, settingvalue, pspobjkey) FROM stdin;
10026	0	10026	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_POST_URL		10002
10027	0	10027	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_RESPONSE_SERVLET_URL		10002
10028	0	10028	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_USER_PWD		10002
10029	0	10029	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_USER_LOGIN		10002
10030	0	10030	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_TRANSACTION_CHANNEL		10002
10031	0	10031	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_SECURITY_SENDER		10002
10032	0	10032	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_XML_URL		10002
10033	0	10033	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_TXN_MODE		10002
10034	0	10034	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	BASE_URL		10002
10035	0	10035	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_SUPPORTED_DD_COUNTRIES		10002
10036	0	10036	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_SUPPORTED_CC_BRANDS		10002
10037	0	10037	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_PAYMENT_REGISTRATION_WSDL		10002
10038	0	10038	2015-10-21 11:16:36.102	2015-10-21 11:16:36.102	ADD	1000	PSP_FRONTEND_JS_PATH		10002
\.


--
-- Data for Name: publiclandingpage; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY publiclandingpage (tkey, numberservices, fillincriterion, version) FROM stdin;
10004	6	NAME_ASCENDING	1
10005	6	NAME_ASCENDING	1
\.


--
-- Data for Name: report; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY report (tkey, reportname, version, organizationrole_tkey) FROM stdin;
0	Subscription	0	3
1	Event	0	3
2	Supplier_Product	0	1
3	Supplier_Customer	0	1
4	Provider_Event	0	2
5	Provider_Supplier	0	2
6	Provider_Subscription	0	2
7	Provider_Instance	0	2
8	Supplier_Billing	0	1
9	Supplier_PaymentResultStatus	0	1
10	Supplier_BillingDetails	0	1
11	Customer_BillingDetails	0	3
13	Supplier_Revenue	0	4
12	Customer_PaymentPreview	0	3
14	ExternalServices	0	4
15	Broker_RevenueShare	0	6
16	Reseller_RevenueShare	0	7
17	Partner_RevenueShare	0	4
18	Supplier_RevenueShare	0	1
19	Suppliers_RevenueShare	0	4
20	Supplier_BillingOfASupplier	0	4
21	Supplier_BillingDetailsOfASupplier	0	4
22	Supplier_CustomerOfASupplier	0	4
23	Supplier_ProductOfASupplier	0	4
\.


--
-- Data for Name: reportresultcache; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY reportresultcache (tkey, cachekey, version, "timestamp", report) FROM stdin;
\.


--
-- Data for Name: revenuesharemodel; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY revenuesharemodel (tkey, revenueshare, revenuesharemodeltype, version) FROM stdin;
10017	0.00	OPERATOR_REVENUE_SHARE	0
10018	0.00	BROKER_REVENUE_SHARE	0
10019	0.00	RESELLER_REVENUE_SHARE	0
10020	0.00	MARKETPLACE_REVENUE_SHARE	0
10021	0.00	BROKER_REVENUE_SHARE	0
10022	0.00	RESELLER_REVENUE_SHARE	0
10023	0.00	MARKETPLACE_REVENUE_SHARE	0
10024	0.00	OPERATOR_REVENUE_SHARE	0
10025	0.00	OPERATOR_REVENUE_SHARE	0
10026	0.00	OPERATOR_REVENUE_SHARE	0
\.


--
-- Data for Name: revenuesharemodelhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY revenuesharemodelhistory (tkey, moddate, modtype, moduser, objkey, objversion, revenueshare, revenuesharemodeltype, invocationdate) FROM stdin;
10017	2015-10-21 11:16:54.299	ADD	1000	10017	0	0.00	OPERATOR_REVENUE_SHARE	2015-10-21 11:16:54.299
10018	2015-10-21 11:17:06.932	ADD	1000	10018	0	0.00	BROKER_REVENUE_SHARE	2015-10-21 11:17:06.932
10019	2015-10-21 11:17:06.932	ADD	1000	10019	0	0.00	RESELLER_REVENUE_SHARE	2015-10-21 11:17:06.932
10020	2015-10-21 11:17:06.932	ADD	1000	10020	0	0.00	MARKETPLACE_REVENUE_SHARE	2015-10-21 11:17:06.932
10021	2015-10-21 11:17:39.28	ADD	1000	10021	0	0.00	BROKER_REVENUE_SHARE	2015-10-21 11:17:39.28
10022	2015-10-21 11:17:39.28	ADD	1000	10022	0	0.00	RESELLER_REVENUE_SHARE	2015-10-21 11:17:39.28
10023	2015-10-21 11:17:39.28	ADD	1000	10023	0	0.00	MARKETPLACE_REVENUE_SHARE	2015-10-21 11:17:39.28
10024	2015-10-21 11:18:02.56	ADD	10002	10024	0	0.00	OPERATOR_REVENUE_SHARE	2015-10-21 11:18:02.56
10025	2015-10-21 11:18:03.574	ADD	10002	10025	0	0.00	OPERATOR_REVENUE_SHARE	2015-10-21 11:18:03.574
10026	2015-10-21 11:18:04.229	ADD	10002	10026	0	0.00	OPERATOR_REVENUE_SHARE	2015-10-21 11:18:04.229
\.


--
-- Data for Name: roleassignment; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY roleassignment (tkey, version, user_tkey, userrole_tkey) FROM stdin;
1	0	1000	1
2	0	1000	4
3	0	1000	5
10008	0	10002	2
10009	0	10002	3
10010	0	10002	1
10011	0	10002	5
10012	0	10003	1
\.


--
-- Data for Name: roleassignmenthistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY roleassignmenthistory (tkey, moddate, modtype, moduser, objkey, objversion, userobjkey, userroleobjkey, invocationdate) FROM stdin;
1	2015-10-21 11:16:03.191	ADD	ANONYMOUS	1	0	1000	1	1970-01-01 00:00:00
2	2015-10-21 11:16:03.191	ADD	ANONYMOUS	1	0	1000	1	1970-01-01 00:00:00
3	2015-10-21 11:16:04.08	ADD	ANONYMOUS	1	0	1000	3	1970-01-01 00:00:00
10008	2015-10-21 11:16:54.299	ADD	1000	10008	0	10002	2	2015-10-21 11:16:54.299
10009	2015-10-21 11:16:54.299	ADD	1000	10009	0	10002	3	2015-10-21 11:16:54.299
10010	2015-10-21 11:16:54.299	ADD	1000	10010	0	10002	1	2015-10-21 11:16:54.299
10011	2015-10-21 11:17:39.28	ADD	1000	10011	0	10002	5	2015-10-21 11:17:39.28
10012	2015-10-21 11:18:12.606	ADD	10002	10012	0	10003	1	2015-10-21 11:18:12.606
\.


--
-- Data for Name: roledefinition; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY roledefinition (tkey, roleid, version, technicalproduct_tkey) FROM stdin;
10006	ADMIN	0	10002
10007	USER	0	10002
10008	GUEST	0	10002
\.


--
-- Data for Name: roledefinitionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY roledefinitionhistory (tkey, roleid, moddate, modtype, moduser, objkey, objversion, technicalproductobjkey, invocationdate) FROM stdin;
10006	ADMIN	2015-10-21 11:18:00.111	ADD	10002	10006	0	10002	2015-10-21 11:18:00.111
10007	USER	2015-10-21 11:18:00.111	ADD	10002	10007	0	10002	2015-10-21 11:18:00.111
10008	GUEST	2015-10-21 11:18:00.111	ADD	10002	10008	0	10002	2015-10-21 11:18:00.111
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY session (tkey, nodename, platformuserid, platformuserkey, sessionid, sessiontype, subscriptiontkey, usertoken, version) FROM stdin;
10011	SingleNode	customer	10003	9be46af9ea3a0099df56819f8ec0	SERVICE_SESSION	10000	kNm710qFVKZQWM8ESF7UVsd5oOGrXtUerQeTpz7V	0
10012	SingleNode	customer	10003	9be46af9ea3a0099df56819f8ec0	SERVICE_SESSION	10002	eoVMUeskQHGYO00XdFhMXVjq1OKjy49OnFONgNzt	0
\.


--
-- Data for Name: steppedprice; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY steppedprice (tkey, version, pricemodel_tkey, pricedevent_tkey, pricedparameter_tkey, upperlimit, price, additionalprice, freeentitycount) FROM stdin;
\.


--
-- Data for Name: steppedpricehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY steppedpricehistory (tkey, moddate, modtype, moduser, objkey, objversion, pricemodelobjkey, pricedeventobjkey, pricedparameterobjkey, upperlimit, price, additionalprice, freeentitycount, invocationdate) FROM stdin;
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY subscription (tkey, accessinfo, activationdate, baseurl, creationdate, deactivationdate, loginpath, productinstanceid, purchaseordernumber, status, subscriptionid, timeoutmailsent, version, organizationkey, product_tkey, marketplace_tkey, paymentinfo_tkey, billingcontact_tkey, cutoffday, owner_tkey, asynctempproductkey, usergroup_tkey) FROM stdin;
10000	\N	1445419620550	\N	1445419620550	\N	\N	Subscription to Trial Service	1234567890	ACTIVE	Subscription to Trial Service	f	1	10003	10006	10004	\N	\N	1	10003	\N	\N
10001	\N	1445419753858	\N	1445419753858	\N	\N	Subscription to Starter Service	642789346234	ACTIVE	Subscription to Starter Service	f	1	10003	10007	10004	\N	\N	1	10003	\N	\N
10002	\N	1445419834108	\N	1445419834108	\N	\N	Professional	56467567567	ACTIVE	Subscription to Professional Service	f	2	10003	10008	10004	10003	10000	1	10003	\N	\N
\.


--
-- Data for Name: subscriptionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY subscriptionhistory (tkey, accessinfo, activationdate, baseurl, creationdate, deactivationdate, loginpath, productinstanceid, purchaseordernumber, status, subscriptionid, timeoutmailsent, moddate, modtype, moduser, objkey, objversion, organizationobjkey, productobjkey, invocationdate, marketplaceobjkey, paymentinfoobjkey, billingcontactobjkey, cutoffday, ownerobjkey, asynctempproductobjkey, usergroupobjkey) FROM stdin;
10000	\N	1445419620550	\N	1445419620550	\N	\N	Subscription to Trial Service	1234567890	ACTIVE	Subscription to Trial Service	f	2015-10-21 11:27:00.55	ADD	10003	10000	0	10003	10006	2015-10-21 11:27:00.55	10004	\N	\N	1	10003	\N	\N
10001	\N	1445419620550	\N	1445419620550	\N	\N	Subscription to Trial Service	1234567890	ACTIVE	Subscription to Trial Service	f	2015-10-21 11:27:00.55	MODIFY	10003	10000	1	10003	10006	2015-10-21 11:27:00.55	10004	\N	\N	1	10003	\N	\N
10002	\N	1445419753858	\N	1445419753858	\N	\N	Subscription to Starter Service	642789346234	ACTIVE	Subscription to Starter Service	f	2015-10-21 11:29:13.858	ADD	10003	10001	0	10003	10007	2015-10-21 11:29:13.858	10004	\N	\N	1	10003	\N	\N
10003	\N	1445419753858	\N	1445419753858	\N	\N	Subscription to Starter Service	642789346234	ACTIVE	Subscription to Starter Service	f	2015-10-21 11:29:13.858	MODIFY	10003	10001	1	10003	10007	2015-10-21 11:29:13.858	10004	\N	\N	1	10003	\N	\N
10004	\N	1445419834108	\N	1445419834108	\N	\N	Professional	\N	ACTIVE	Professional	f	2015-10-21 11:30:34.108	ADD	10003	10002	0	10003	10008	2015-10-21 11:30:34.108	10004	10003	10000	1	10003	\N	\N
10005	\N	1445419834108	\N	1445419834108	\N	\N	Professional	\N	ACTIVE	Professional	f	2015-10-21 11:30:34.108	MODIFY	10003	10002	1	10003	10008	2015-10-21 11:30:34.108	10004	10003	10000	1	10003	\N	\N
10006	\N	1445419834108	\N	1445419834108	\N	\N	Professional	56467567567	ACTIVE	Subscription to Professional Service	f	2015-10-21 11:31:24.014	MODIFY	10003	10002	2	10003	10008	2015-10-21 11:31:24.014	10004	10003	10000	1	10003	\N	\N
\.


--
-- Data for Name: supportedcountry; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY supportedcountry (tkey, version, countryisocode) FROM stdin;
0	0	AD
1	0	AE
2	0	AF
3	0	AG
4	0	AI
5	0	AL
6	0	AM
7	0	AN
8	0	AO
9	0	AQ
10	0	AR
11	0	AS
12	0	AT
13	0	AU
14	0	AW
15	0	AX
16	0	AZ
17	0	BA
18	0	BB
19	0	BD
20	0	BE
21	0	BF
22	0	BG
23	0	BH
24	0	BI
25	0	BJ
26	0	BM
27	0	BN
28	0	BO
29	0	BR
30	0	BS
31	0	BT
32	0	BV
33	0	BW
34	0	BY
35	0	BZ
36	0	CA
37	0	CC
38	0	CD
39	0	CF
40	0	CG
41	0	CH
42	0	CI
43	0	CK
44	0	CL
45	0	CM
46	0	CN
47	0	CO
48	0	CR
50	0	CU
51	0	CV
52	0	CX
53	0	CY
54	0	CZ
55	0	DE
56	0	DJ
57	0	DK
58	0	DM
59	0	DO
60	0	DZ
61	0	EC
62	0	EE
63	0	EG
64	0	EH
65	0	ER
66	0	ES
67	0	ET
68	0	FI
69	0	FJ
70	0	FK
71	0	FM
72	0	FO
73	0	FR
74	0	GA
75	0	GB
76	0	GD
77	0	GE
78	0	GF
79	0	GH
80	0	GI
81	0	GL
82	0	GM
83	0	GN
84	0	GP
85	0	GQ
86	0	GR
87	0	GS
88	0	GT
89	0	GU
90	0	GW
91	0	GY
92	0	HK
93	0	HM
94	0	HN
95	0	HR
96	0	HT
97	0	HU
98	0	ID
99	0	IE
100	0	IL
101	0	IN
102	0	IO
103	0	IQ
104	0	IR
105	0	IS
106	0	IT
107	0	JM
108	0	JO
109	0	JP
110	0	KE
111	0	KG
112	0	KH
113	0	KI
114	0	KM
115	0	KN
116	0	KP
117	0	KR
118	0	KW
119	0	KY
120	0	KZ
121	0	LA
122	0	LB
123	0	LC
124	0	LI
125	0	LK
126	0	LR
127	0	LS
128	0	LT
129	0	LU
130	0	LV
131	0	LY
132	0	MA
133	0	MC
134	0	MD
135	0	MG
136	0	MH
137	0	MK
138	0	ML
139	0	MM
140	0	MN
141	0	MO
142	0	MP
143	0	MQ
144	0	MR
145	0	MS
146	0	MT
147	0	MU
148	0	MV
149	0	MW
150	0	MX
151	0	MY
152	0	MZ
153	0	NA
154	0	NC
155	0	NE
156	0	NF
157	0	NG
158	0	NI
159	0	NL
160	0	NO
161	0	NP
162	0	NR
163	0	NU
164	0	NZ
165	0	OM
166	0	PA
167	0	PE
168	0	PF
169	0	PG
170	0	PH
171	0	PK
172	0	PL
173	0	PM
174	0	PN
175	0	PR
176	0	PS
177	0	PT
178	0	PW
179	0	PY
180	0	QA
181	0	RE
182	0	RO
183	0	RU
184	0	RW
185	0	SA
186	0	SB
187	0	SC
188	0	SD
189	0	SE
190	0	SG
191	0	SH
192	0	SI
193	0	SJ
194	0	SK
195	0	SL
196	0	SM
197	0	SN
198	0	SO
199	0	SR
200	0	ST
201	0	SV
202	0	SY
203	0	SZ
204	0	TC
205	0	TD
206	0	TF
207	0	TG
208	0	TH
209	0	TJ
210	0	TK
211	0	TL
212	0	TM
213	0	TN
214	0	TO
215	0	TR
216	0	TT
217	0	TV
218	0	TW
219	0	TZ
220	0	UA
221	0	UG
222	0	UM
223	0	US
224	0	UY
225	0	UZ
226	0	VA
227	0	VC
228	0	VE
229	0	VG
230	0	VI
231	0	VN
232	0	VU
233	0	WF
234	0	WS
235	0	YE
236	0	YT
237	0	ZA
238	0	ZM
239	0	ZW
49	0	ME
240	0	RS
\.


--
-- Data for Name: supportedcurrency; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY supportedcurrency (tkey, currencyisocode, version) FROM stdin;
10002	EUR	0
10003	USD	0
10004	JPY	0
\.


--
-- Data for Name: supportedlanguage; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY supportedlanguage (tkey, version, languageisocode, activestatus, defaultstatus) FROM stdin;
1	0	en	t	t
2	0	de	t	f
3	0	ja	t	f
\.


--
-- Data for Name: supportedlanguagehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY supportedlanguagehistory (tkey, moddate, modtype, moduser, objkey, objversion, invocationdate, languageisocode, activestatus, defaultstatus) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY tag (tkey, locale, value, version) FROM stdin;
10010	en	enterprise	0
10011	en	service	0
10012	en	security	0
10013	en	integration	0
10014	en	office	0
\.


--
-- Data for Name: technicalproduct; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY technicalproduct (tkey, accesstype, baseurl, loginpath, provisioningpassword, provisioningtimeout, provisioningtype, provisioningurl, provisioningusername, provisioningversion, technicalproductbuildid, technicalproductid, version, organizationkey, onlyonesubscriptionallowed, allowingonbehalfacting, billingidentifier) FROM stdin;
10002	LOGIN	http://localhost:8080/oscm-integrationtests-mockproduct	/login	adminadmin	\N	SYNCHRONOUS	http://localhost:8080/oscm-integrationtests-mockproduct/ProvisioningService?wsdl	admin	1.0	20.10.2015	MockService	1	10002	f	f	NATIVE_BILLING
\.


--
-- Data for Name: technicalproducthistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY technicalproducthistory (tkey, accesstype, baseurl, loginpath, provisioningpassword, provisioningtimeout, provisioningtype, provisioningurl, provisioningusername, provisioningversion, technicalproductbuildid, technicalproductid, moddate, modtype, moduser, objkey, objversion, organizationobjkey, invocationdate, onlyonesubscriptionallowed, allowingonbehalfacting, billingidentifier) FROM stdin;
10005	LOGIN	http://localhost:8080/oscm-integrationtests-mockproduct	/login	adminadmin	\N	SYNCHRONOUS	http://localhost:8080/oscm-integrationtests-mockproduct/ProvisioningService?wsdl	admin	1.0	20.10.2015	MockService	2015-10-21 11:18:00.111	MODIFY	10002	10002	1	10002	2015-10-21 11:18:00.111	f	f	NATIVE_BILLING
10004	LOGIN	\N	\N	\N	\N	SYNCHRONOUS	http://localhost:8080/oscm-integrationtests-mockproduct/ProvisioningService?wsdl	\N	1.0	\N	MockService	2015-10-21 11:18:00.111	ADD	10002	10002	0	10002	2015-10-21 11:18:00.111	f	f	NATIVE_BILLING
\.


--
-- Data for Name: technicalproductoperation; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY technicalproductoperation (tkey, actionurl, operationid, version, technicalproduct_tkey) FROM stdin;
10004	http://localhost:8181/oscm-integrationtests-mockproduct/OperationService?wsdl	HELP	0	10002
10005	http://localhost:8181/oscm-integrationtests-mockproduct/OperationService?wsdl	CAUSE_ERROR	0	10002
\.


--
-- Data for Name: technicalproductoperationhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY technicalproductoperationhistory (tkey, actionurl, operationid, moddate, modtype, moduser, objkey, objversion, technicalproductobjkey, invocationdate) FROM stdin;
10004	http://localhost:8181/oscm-integrationtests-mockproduct/OperationService?wsdl	HELP	2015-10-21 11:18:00.111	ADD	10002	10004	0	10002	2015-10-21 11:18:00.111
10005	http://localhost:8181/oscm-integrationtests-mockproduct/OperationService?wsdl	CAUSE_ERROR	2015-10-21 11:18:00.111	ADD	10002	10005	0	10002	2015-10-21 11:18:00.111
\.


--
-- Data for Name: technicalproducttag; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY technicalproducttag (tkey, tag_tkey, technicalproduct_tkey, version) FROM stdin;
10010	10010	10002	0
10011	10011	10002	0
10012	10012	10002	0
10013	10013	10002	0
10014	10014	10002	0
\.


--
-- Data for Name: timerprocessing; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY timerprocessing (tkey, duration, nodename, starttime, starttimemutex, success, timertype, version) FROM stdin;
\.


--
-- Data for Name: triggerdefinition; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY triggerdefinition (tkey, suspendprocess, target, targettype, type, version, organization_tkey, name) FROM stdin;
\.


--
-- Data for Name: triggerdefinitionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY triggerdefinitionhistory (tkey, suspendprocess, target, targettype, type, moddate, modtype, moduser, objkey, objversion, organizationobjkey, invocationdate, name) FROM stdin;
\.


--
-- Data for Name: triggerprocess; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY triggerprocess (tkey, activationdate, status, version, triggerdefinition_tkey, user_tkey) FROM stdin;
\.


--
-- Data for Name: triggerprocesshistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY triggerprocesshistory (tkey, activationdate, status, moddate, modtype, moduser, objkey, objversion, triggerdefinitionobjkey, userobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: triggerprocessidentifier; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY triggerprocessidentifier (tkey, version, triggerprocess_tkey, name, value) FROM stdin;
\.


--
-- Data for Name: triggerprocessparameter; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY triggerprocessparameter (tkey, name, serializedvalue, version, triggerprocess_tkey, serialized) FROM stdin;
\.


--
-- Data for Name: uda; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY uda (tkey, udadefinitionkey, targetobjectkey, udavalue, version) FROM stdin;
\.


--
-- Data for Name: udadefinition; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY udadefinition (tkey, defaultvalue, targettype, udaid, version, organizationkey, configurationtype) FROM stdin;
\.


--
-- Data for Name: udadefinitionhistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY udadefinitionhistory (tkey, defaultvalue, targettype, udaid, moddate, modtype, moduser, objkey, objversion, organizationobjkey, invocationdate, configurationtype) FROM stdin;
\.


--
-- Data for Name: udahistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY udahistory (tkey, targetobjectkey, udavalue, moddate, modtype, moduser, objkey, objversion, udadefinitionobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: unitroleassignment; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY unitroleassignment (tkey, version, usergrouptouser_tkey, unituserrole_tkey) FROM stdin;
\.


--
-- Data for Name: unituserrole; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY unituserrole (tkey, version, rolename) FROM stdin;
1	0	ADMINISTRATOR
2	0	USER
\.


--
-- Data for Name: usagelicense; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY usagelicense (tkey, applicationuserid, assignmentdate, version, roledefinition_tkey, subscription_tkey, user_tkey) FROM stdin;
10000	customer	1445419628865	1	10006	10000	10003
10001	customer	1445419759380	1	10006	10001	10003
10002	customer	1445419940537	1	10006	10002	10003
\.


--
-- Data for Name: usagelicensehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY usagelicensehistory (tkey, applicationuserid, assignmentdate, moddate, modtype, moduser, objkey, objversion, roledefinitionobjkey, subscriptionobjkey, userobjkey, invocationdate) FROM stdin;
10000	customer	1445419628865	2015-10-21 11:27:09.364	ADD	10003	10000	0	10006	10000	10003	2015-10-21 11:27:09.364
10001	customer	1445419628865	2015-10-21 11:27:09.364	MODIFY	10003	10000	1	10006	10000	10003	2015-10-21 11:27:09.364
10002	customer	1445419759380	2015-10-21 11:29:19.708	ADD	10003	10001	0	10006	10001	10003	2015-10-21 11:29:19.708
10003	customer	1445419759380	2015-10-21 11:29:19.708	MODIFY	10003	10001	1	10006	10001	10003	2015-10-21 11:29:19.708
10004	customer	1445419940537	2015-10-21 11:32:20.88	ADD	10003	10002	0	10006	10002	10003	2015-10-21 11:32:20.88
10005	customer	1445419940537	2015-10-21 11:32:20.88	MODIFY	10003	10002	1	10006	10002	10003	2015-10-21 11:32:20.88
\.


--
-- Data for Name: usergroup; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY usergroup (tkey, version, name, description, isdefault, organization_tkey, referenceid) FROM stdin;
1	0	default	\N	t	1	\N
10002	0	default	\N	t	10002	\N
10003	0	default	\N	t	10003	\N
\.


--
-- Data for Name: usergrouphistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY usergrouphistory (tkey, name, description, isdefault, invocationdate, moddate, modtype, moduser, objkey, objversion, organizationobjkey, referenceid) FROM stdin;
1	default	\N	t	2015-10-21 11:16:06.202	2015-10-21 11:16:06.202	ADD	1000	1	0	1	\N
10002	default	\N	t	2015-10-21 11:16:54.299	2015-10-21 11:16:54.299	ADD	1000	10002	0	10002	\N
10003	default	\N	t	2015-10-21 11:18:12.606	2015-10-21 11:18:12.606	ADD	10002	10003	0	10003	\N
\.


--
-- Data for Name: usergrouptoinvisibleproduct; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY usergrouptoinvisibleproduct (tkey, version, product_tkey, usergroup_tkey) FROM stdin;
\.


--
-- Data for Name: usergrouptouser; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY usergrouptouser (tkey, version, usergroup_tkey, platformuser_tkey) FROM stdin;
\.


--
-- Data for Name: userrole; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY userrole (tkey, rolename, version) FROM stdin;
1	ORGANIZATION_ADMIN	0
2	SERVICE_MANAGER	0
3	TECHNOLOGY_MANAGER	0
4	PLATFORM_OPERATOR	0
5	MARKETPLACE_OWNER	0
6	BROKER_MANAGER	0
7	RESELLER_MANAGER	0
8	SUBSCRIPTION_MANAGER	0
9	UNIT_ADMINISTRATOR	0
\.


--
-- Data for Name: vatrate; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY vatrate (tkey, version, rate, owningorganization_tkey, targetcountry_tkey, targetorganization_tkey) FROM stdin;
\.


--
-- Data for Name: vatratehistory; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY vatratehistory (tkey, moddate, modtype, moduser, objkey, objversion, rate, owningorganizationobjkey, targetcountryobjkey, targetorganizationobjkey, invocationdate) FROM stdin;
\.


--
-- Data for Name: version; Type: TABLE DATA; Schema: bssuser; Owner: bssuser
--

COPY version (productmajorversion, productminorversion, schemaversion, migrationdate) FROM stdin;
2	8	11	2015-10-21 11:16:06.326
\.


--
-- Name: auditlog_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY auditlog
    ADD CONSTRAINT auditlog_pk PRIMARY KEY (tkey);


--
-- Name: bc_orgkey_billingcontactid_uk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingcontact
    ADD CONSTRAINT bc_orgkey_billingcontactid_uk UNIQUE (organization_tkey, billingcontactid);


--
-- Name: billingadapter_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingadapter
    ADD CONSTRAINT billingadapter_pk PRIMARY KEY (tkey);


--
-- Name: billingadapter_uniq; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingadapter
    ADD CONSTRAINT billingadapter_uniq UNIQUE (billingidentifier);


--
-- Name: billingcontact_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingcontact
    ADD CONSTRAINT billingcontact_pk PRIMARY KEY (tkey);


--
-- Name: billingcontacthistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingcontacthistory
    ADD CONSTRAINT billingcontacthistory_pk PRIMARY KEY (tkey);


--
-- Name: billingresult_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingresult
    ADD CONSTRAINT billingresult_pk PRIMARY KEY (tkey);


--
-- Name: billingsharesresult_org_period_uc; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingsharesresult
    ADD CONSTRAINT billingsharesresult_org_period_uc UNIQUE (organizationtkey, resulttype, periodstarttime, periodendtime);


--
-- Name: billingsharesresult_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingsharesresult
    ADD CONSTRAINT billingsharesresult_pk PRIMARY KEY (tkey);


--
-- Name: billingsubscriptionstatus_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY billingsubscriptionstatus
    ADD CONSTRAINT billingsubscriptionstatus_pk PRIMARY KEY (tkey);


--
-- Name: catalogentry_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY catalogentry
    ADD CONSTRAINT catalogentry_pk PRIMARY KEY (tkey);


--
-- Name: catalogentryhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY catalogentryhistory
    ADD CONSTRAINT catalogentryhistory_pk PRIMARY KEY (tkey);


--
-- Name: category_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pk PRIMARY KEY (tkey);


--
-- Name: categoryhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY categoryhistory
    ADD CONSTRAINT categoryhistory_pk PRIMARY KEY (tkey);


--
-- Name: categorytocatalogentry_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY categorytocatalogentry
    ADD CONSTRAINT categorytocatalogentry_pk PRIMARY KEY (tkey);


--
-- Name: categorytocatalogentryhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY categorytocatalogentryhistory
    ADD CONSTRAINT categorytocatalogentryhistory_pk PRIMARY KEY (tkey);


--
-- Name: configurationsetting_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY configurationsetting
    ADD CONSTRAINT configurationsetting_pk PRIMARY KEY (tkey);


--
-- Name: discount_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY discount
    ADD CONSTRAINT discount_pk PRIMARY KEY (tkey);


--
-- Name: discounthistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY discounthistory
    ADD CONSTRAINT discounthistory_pk PRIMARY KEY (tkey);


--
-- Name: enterpriselandingpage_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY enterpriselandingpage
    ADD CONSTRAINT enterpriselandingpage_pk PRIMARY KEY (tkey);


--
-- Name: event_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pk PRIMARY KEY (tkey);


--
-- Name: eventhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY eventhistory
    ADD CONSTRAINT eventhistory_pk PRIMARY KEY (tkey);


--
-- Name: gatheredevent_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY gatheredevent
    ADD CONSTRAINT gatheredevent_pk PRIMARY KEY (tkey);


--
-- Name: imageresource_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY imageresource
    ADD CONSTRAINT imageresource_pk PRIMARY KEY (tkey);


--
-- Name: landingpage_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY publiclandingpage
    ADD CONSTRAINT landingpage_pk PRIMARY KEY (tkey);


--
-- Name: landingpageproduct_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY landingpageproduct
    ADD CONSTRAINT landingpageproduct_pk PRIMARY KEY (tkey);


--
-- Name: localizedresource_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY localizedresource
    ADD CONSTRAINT localizedresource_pk PRIMARY KEY (tkey);


--
-- Name: marketingpermission_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY marketingpermission
    ADD CONSTRAINT marketingpermission_pk PRIMARY KEY (tkey);


--
-- Name: marketingpermissionhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY marketingpermissionhistory
    ADD CONSTRAINT marketingpermissionhistory_pk PRIMARY KEY (tkey);


--
-- Name: marketplace_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY marketplace
    ADD CONSTRAINT marketplace_pk PRIMARY KEY (tkey);


--
-- Name: marketplacehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY marketplacehistory
    ADD CONSTRAINT marketplacehistory_pk PRIMARY KEY (tkey);


--
-- Name: marketplacetoorganization_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY marketplacetoorganization
    ADD CONSTRAINT marketplacetoorganization_pk PRIMARY KEY (tkey);


--
-- Name: marketplacetoorganizationhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY marketplacetoorganizationhistory
    ADD CONSTRAINT marketplacetoorganizationhistory_pk PRIMARY KEY (tkey);


--
-- Name: modifiedentity_objkey_type_uc; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY modifiedentity
    ADD CONSTRAINT modifiedentity_objkey_type_uc UNIQUE (targetobjectkey, targetobjecttype);


--
-- Name: modifiedentity_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY modifiedentity
    ADD CONSTRAINT modifiedentity_pk PRIMARY KEY (tkey);


--
-- Name: modifiedentityhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY modifiedentityhistory
    ADD CONSTRAINT modifiedentityhistory_pk PRIMARY KEY (tkey);


--
-- Name: modifieduda_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY modifieduda
    ADD CONSTRAINT modifieduda_pk PRIMARY KEY (tkey);


--
-- Name: modifieduda_uc; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY modifieduda
    ADD CONSTRAINT modifieduda_uc UNIQUE (targetobjectkey, targetobjecttype, subscriptionkey);


--
-- Name: modifiedudahistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY modifiedudahistory
    ADD CONSTRAINT modifiedudahistory_pk PRIMARY KEY (tkey);


--
-- Name: mptoorg_mpkey_orgkey_uc; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY marketplacetoorganization
    ADD CONSTRAINT mptoorg_mpkey_orgkey_uc UNIQUE (marketplace_tkey, organization_tkey);


--
-- Name: onbehalfuserreference_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY onbehalfuserreference
    ADD CONSTRAINT onbehalfuserreference_pk PRIMARY KEY (tkey);


--
-- Name: onbehalfuserreferencehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY onbehalfuserreferencehistory
    ADD CONSTRAINT onbehalfuserreferencehistory_pk PRIMARY KEY (tkey);


--
-- Name: operationparameter_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY operationparameter
    ADD CONSTRAINT operationparameter_pk PRIMARY KEY (tkey);


--
-- Name: operationparameter_uc; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY operationparameter
    ADD CONSTRAINT operationparameter_uc UNIQUE (technicalproductoperation_tkey, id);


--
-- Name: operationparameterhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY operationparameterhistory
    ADD CONSTRAINT operationparameterhistory_pk PRIMARY KEY (tkey);


--
-- Name: operationrecord_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY operationrecord
    ADD CONSTRAINT operationrecord_pk PRIMARY KEY (tkey);


--
-- Name: organization_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pk PRIMARY KEY (tkey);


--
-- Name: organizationhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationhistory
    ADD CONSTRAINT organizationhistory_pk PRIMARY KEY (tkey);


--
-- Name: organizationreference_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationreference
    ADD CONSTRAINT organizationreference_pk PRIMARY KEY (tkey);


--
-- Name: organizationreferencehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationreferencehistory
    ADD CONSTRAINT organizationreferencehistory_pk PRIMARY KEY (tkey);


--
-- Name: organizationrole_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_pk PRIMARY KEY (tkey);


--
-- Name: organizationsetting_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationsetting
    ADD CONSTRAINT organizationsetting_pk PRIMARY KEY (tkey);


--
-- Name: organizationtocountry_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationtocountry
    ADD CONSTRAINT organizationtocountry_pk PRIMARY KEY (tkey);


--
-- Name: organizationtocountryhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationtocountryhistory
    ADD CONSTRAINT organizationtocountryhistory_pk PRIMARY KEY (tkey);


--
-- Name: organizationtopaymenttype_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationreftopaymenttype
    ADD CONSTRAINT organizationtopaymenttype_pk PRIMARY KEY (tkey);


--
-- Name: organizationtorole_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationtorole
    ADD CONSTRAINT organizationtorole_pk PRIMARY KEY (tkey);


--
-- Name: organizationtorolehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY organizationtorolehistory
    ADD CONSTRAINT organizationtorolehistory_pk PRIMARY KEY (tkey);


--
-- Name: parameter_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT parameter_pk PRIMARY KEY (tkey);


--
-- Name: parameterdefinition_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parameterdefinition
    ADD CONSTRAINT parameterdefinition_pk PRIMARY KEY (tkey);


--
-- Name: parameterdefinitionhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parameterdefinitionhistory
    ADD CONSTRAINT parameterdefinitionhistory_pk PRIMARY KEY (tkey);


--
-- Name: parameterhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parameterhistory
    ADD CONSTRAINT parameterhistory_pk PRIMARY KEY (tkey);


--
-- Name: parameteroption_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parameteroption
    ADD CONSTRAINT parameteroption_pk PRIMARY KEY (tkey);


--
-- Name: parameteroptionhistory_uc; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parameteroptionhistory
    ADD CONSTRAINT parameteroptionhistory_uc PRIMARY KEY (tkey);


--
-- Name: parameterset_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parameterset
    ADD CONSTRAINT parameterset_pk PRIMARY KEY (tkey);


--
-- Name: parametersethistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY parametersethistory
    ADD CONSTRAINT parametersethistory_pk PRIMARY KEY (tkey);


--
-- Name: paymentinfo_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY paymentinfo
    ADD CONSTRAINT paymentinfo_pk PRIMARY KEY (tkey);


--
-- Name: paymentinfohistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY paymentinfohistory
    ADD CONSTRAINT paymentinfohistory_pk PRIMARY KEY (tkey);


--
-- Name: paymentresult_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY paymentresult
    ADD CONSTRAINT paymentresult_pk PRIMARY KEY (tkey);


--
-- Name: paymentresulthistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY paymentresulthistory
    ADD CONSTRAINT paymentresulthistory_pk PRIMARY KEY (tkey);


--
-- Name: paymenttype_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY paymenttype
    ADD CONSTRAINT paymenttype_pk PRIMARY KEY (tkey);


--
-- Name: pi_orgkey_paymentinfoid_uk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY paymentinfo
    ADD CONSTRAINT pi_orgkey_paymentinfoid_uk UNIQUE (organization_tkey, paymentinfoid);


--
-- Name: platformsetting_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY platformsetting
    ADD CONSTRAINT platformsetting_pk PRIMARY KEY (tkey);


--
-- Name: platformuser_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY platformuser
    ADD CONSTRAINT platformuser_pk PRIMARY KEY (tkey);


--
-- Name: platformuserhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY platformuserhistory
    ADD CONSTRAINT platformuserhistory_pk PRIMARY KEY (tkey);


--
-- Name: pricedevent_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedevent
    ADD CONSTRAINT pricedevent_pk PRIMARY KEY (tkey);


--
-- Name: pricedeventhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedeventhistory
    ADD CONSTRAINT pricedeventhistory_pk PRIMARY KEY (tkey);


--
-- Name: pricedoption_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedoption
    ADD CONSTRAINT pricedoption_pk PRIMARY KEY (tkey);


--
-- Name: pricedoptionhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedoptionhistory
    ADD CONSTRAINT pricedoptionhistory_pk PRIMARY KEY (tkey);


--
-- Name: pricedparameter_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedparameter
    ADD CONSTRAINT pricedparameter_pk PRIMARY KEY (tkey);


--
-- Name: pricedparameterhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedparameterhistory
    ADD CONSTRAINT pricedparameterhistory_pk PRIMARY KEY (tkey);


--
-- Name: pricedproductrole_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedproductrole
    ADD CONSTRAINT pricedproductrole_pk PRIMARY KEY (tkey);


--
-- Name: pricedproductrolehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricedproductrolehistory
    ADD CONSTRAINT pricedproductrolehistory_pk PRIMARY KEY (tkey);


--
-- Name: pricemodel_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricemodel
    ADD CONSTRAINT pricemodel_pk PRIMARY KEY (tkey);


--
-- Name: pricemodelhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pricemodelhistory
    ADD CONSTRAINT pricemodelhistory_pk PRIMARY KEY (tkey);


--
-- Name: product_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pk PRIMARY KEY (tkey);


--
-- Name: productfeedback_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY productfeedback
    ADD CONSTRAINT productfeedback_pk PRIMARY KEY (tkey);


--
-- Name: producthistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY producthistory
    ADD CONSTRAINT producthistory_pk PRIMARY KEY (tkey);


--
-- Name: productreference_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY productreference
    ADD CONSTRAINT productreference_pk PRIMARY KEY (tkey);


--
-- Name: productreferencehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY productreferencehistory
    ADD CONSTRAINT productreferencehistory_pk PRIMARY KEY (tkey);


--
-- Name: productreview_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY productreview
    ADD CONSTRAINT productreview_pk PRIMARY KEY (tkey);


--
-- Name: productreviewhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY productreviewhistory
    ADD CONSTRAINT productreviewhistory_pk PRIMARY KEY (tkey);


--
-- Name: producttopaymenttype_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY producttopaymenttype
    ADD CONSTRAINT producttopaymenttype_pk PRIMARY KEY (tkey);


--
-- Name: producttopaymenttypehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY producttopaymenttypehistory
    ADD CONSTRAINT producttopaymenttypehistory_pk PRIMARY KEY (tkey);


--
-- Name: psp_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY psp
    ADD CONSTRAINT psp_pk PRIMARY KEY (tkey);


--
-- Name: pspaccount_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pspaccount
    ADD CONSTRAINT pspaccount_pk PRIMARY KEY (tkey);


--
-- Name: pspaccounthistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pspaccounthistory
    ADD CONSTRAINT pspaccounthistory_pk PRIMARY KEY (tkey);


--
-- Name: psphistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY psphistory
    ADD CONSTRAINT psphistory_pk PRIMARY KEY (tkey);


--
-- Name: pspsetting_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pspsetting
    ADD CONSTRAINT pspsetting_pk PRIMARY KEY (tkey);


--
-- Name: pspsettinghistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY pspsettinghistory
    ADD CONSTRAINT pspsettinghistory_pk PRIMARY KEY (tkey);


--
-- Name: report_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_pk PRIMARY KEY (tkey);


--
-- Name: reportresultcache_cachekey_key; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY reportresultcache
    ADD CONSTRAINT reportresultcache_cachekey_key UNIQUE (cachekey);


--
-- Name: reportresultcache_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY reportresultcache
    ADD CONSTRAINT reportresultcache_pk PRIMARY KEY (tkey);


--
-- Name: revenuesharemodel_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY revenuesharemodel
    ADD CONSTRAINT revenuesharemodel_pk PRIMARY KEY (tkey);


--
-- Name: revenuesharemodelhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY revenuesharemodelhistory
    ADD CONSTRAINT revenuesharemodelhistory_pk PRIMARY KEY (tkey);


--
-- Name: roleassignment_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY roleassignment
    ADD CONSTRAINT roleassignment_pk PRIMARY KEY (tkey);


--
-- Name: roleassignmenthistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY roleassignmenthistory
    ADD CONSTRAINT roleassignmenthistory_pk PRIMARY KEY (tkey);


--
-- Name: roledefinition_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY roledefinition
    ADD CONSTRAINT roledefinition_pk PRIMARY KEY (tkey);


--
-- Name: roledefinitionhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY roledefinitionhistory
    ADD CONSTRAINT roledefinitionhistory_pk PRIMARY KEY (tkey);


--
-- Name: session_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY session
    ADD CONSTRAINT session_pk PRIMARY KEY (tkey);


--
-- Name: steppedprice_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY steppedprice
    ADD CONSTRAINT steppedprice_pk PRIMARY KEY (tkey);


--
-- Name: steppedpricehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY steppedpricehistory
    ADD CONSTRAINT steppedpricehistory_pk PRIMARY KEY (tkey);


--
-- Name: subscription_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_pk PRIMARY KEY (tkey);


--
-- Name: subscriptionhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY subscriptionhistory
    ADD CONSTRAINT subscriptionhistory_pk PRIMARY KEY (tkey);


--
-- Name: supportedcountry_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY supportedcountry
    ADD CONSTRAINT supportedcountry_pk PRIMARY KEY (tkey);


--
-- Name: supportedcurrency_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY supportedcurrency
    ADD CONSTRAINT supportedcurrency_pk PRIMARY KEY (tkey);


--
-- Name: supportedlanguage_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY supportedlanguage
    ADD CONSTRAINT supportedlanguage_pk PRIMARY KEY (tkey);


--
-- Name: supportedlanguagehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY supportedlanguagehistory
    ADD CONSTRAINT supportedlanguagehistory_pk PRIMARY KEY (tkey);


--
-- Name: tag_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pk PRIMARY KEY (tkey);


--
-- Name: technicalproduct_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY technicalproduct
    ADD CONSTRAINT technicalproduct_pk PRIMARY KEY (tkey);


--
-- Name: technicalproducthistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY technicalproducthistory
    ADD CONSTRAINT technicalproducthistory_pk PRIMARY KEY (tkey);


--
-- Name: technicalproductoperation_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY technicalproductoperation
    ADD CONSTRAINT technicalproductoperation_pk PRIMARY KEY (tkey);


--
-- Name: technicalproductoperationhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY technicalproductoperationhistory
    ADD CONSTRAINT technicalproductoperationhistory_pk PRIMARY KEY (tkey);


--
-- Name: technicalproducttag_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY technicalproducttag
    ADD CONSTRAINT technicalproducttag_pk PRIMARY KEY (tkey);


--
-- Name: timerprocessing_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY timerprocessing
    ADD CONSTRAINT timerprocessing_pk PRIMARY KEY (tkey);


--
-- Name: triggerdefinition_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY triggerdefinition
    ADD CONSTRAINT triggerdefinition_pk PRIMARY KEY (tkey);


--
-- Name: triggerdefinitionhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY triggerdefinitionhistory
    ADD CONSTRAINT triggerdefinitionhistory_pk PRIMARY KEY (tkey);


--
-- Name: triggerprocess_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY triggerprocess
    ADD CONSTRAINT triggerprocess_pk PRIMARY KEY (tkey);


--
-- Name: triggerprocesshistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY triggerprocesshistory
    ADD CONSTRAINT triggerprocesshistory_pk PRIMARY KEY (tkey);


--
-- Name: triggerprocessidentifier_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY triggerprocessidentifier
    ADD CONSTRAINT triggerprocessidentifier_pk PRIMARY KEY (tkey);


--
-- Name: triggerprocessmodification_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY triggerprocessparameter
    ADD CONSTRAINT triggerprocessmodification_pk PRIMARY KEY (tkey);


--
-- Name: uda_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY uda
    ADD CONSTRAINT uda_pk PRIMARY KEY (tkey);


--
-- Name: udadefinition_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY udadefinition
    ADD CONSTRAINT udadefinition_pk PRIMARY KEY (tkey);


--
-- Name: udadefinitionhistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY udadefinitionhistory
    ADD CONSTRAINT udadefinitionhistory_pk PRIMARY KEY (tkey);


--
-- Name: udahistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY udahistory
    ADD CONSTRAINT udahistory_pk PRIMARY KEY (tkey);


--
-- Name: unitroleassignment_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY unitroleassignment
    ADD CONSTRAINT unitroleassignment_pk PRIMARY KEY (tkey);


--
-- Name: unituserrole_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY unituserrole
    ADD CONSTRAINT unituserrole_pk PRIMARY KEY (tkey);


--
-- Name: usagelicense_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY usagelicense
    ADD CONSTRAINT usagelicense_pk PRIMARY KEY (tkey);


--
-- Name: usagelicensehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY usagelicensehistory
    ADD CONSTRAINT usagelicensehistory_pk PRIMARY KEY (tkey);


--
-- Name: usergroup_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY usergroup
    ADD CONSTRAINT usergroup_pk PRIMARY KEY (tkey);


--
-- Name: usergrouphistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY usergrouphistory
    ADD CONSTRAINT usergrouphistory_pk PRIMARY KEY (tkey);


--
-- Name: usergrouptoinvisibleproduct_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY usergrouptoinvisibleproduct
    ADD CONSTRAINT usergrouptoinvisibleproduct_pk PRIMARY KEY (tkey);


--
-- Name: usergrouptouser_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY usergrouptouser
    ADD CONSTRAINT usergrouptouser_pk PRIMARY KEY (tkey);


--
-- Name: userrole_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY userrole
    ADD CONSTRAINT userrole_pk PRIMARY KEY (tkey);


--
-- Name: vatrate_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY vatrate
    ADD CONSTRAINT vatrate_pk PRIMARY KEY (tkey);


--
-- Name: vatratehistory_pk; Type: CONSTRAINT; Schema: bssuser; Owner: bssuser; Tablespace: 
--

ALTER TABLE ONLY vatratehistory
    ADD CONSTRAINT vatratehistory_pk PRIMARY KEY (tkey);


--
-- Name: auditlog_creationdate_opname_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX auditlog_creationdate_opname_idx ON auditlog USING btree (creationtime, operationname);


--
-- Name: billingcontact_orgkey_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX billingcontact_orgkey_nuidx ON billingcontact USING btree (organization_tkey);


--
-- Name: billingresult_orgkey_date_sub_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX billingresult_orgkey_date_sub_uidx ON billingresult USING btree (organizationtkey, periodstarttime, periodendtime, subscriptionkey);


--
-- Name: billingsubstatus_subkey_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX billingsubstatus_subkey_uidx ON billingsubscriptionstatus USING btree (subscriptionkey);


--
-- Name: category_marketplace_id_unidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX category_marketplace_id_unidx ON category USING btree (marketplacekey, categoryid);


--
-- Name: configurationsetting_idctx_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX configurationsetting_idctx_idx ON configurationsetting USING btree (information_id, context_id);


--
-- Name: event_tp_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX event_tp_nuidx ON event USING btree (technicalproduct_tkey);


--
-- Name: gatheredevent_billres_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX gatheredevent_billres_nuidx ON gatheredevent USING btree (billingresult_tkey);


--
-- Name: gatheredevent_subuid_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX gatheredevent_subuid_idx ON gatheredevent USING btree (subscriptiontkey, uniqueid);


--
-- Name: imageresourceresource_bk_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX imageresourceresource_bk_uidx ON imageresource USING btree (objectkey, imagetype);


--
-- Name: localizedresource_bk_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX localizedresource_bk_uidx ON localizedresource USING btree (objectkey, locale, objecttype);


--
-- Name: marketingpermission_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX marketingpermission_uidx ON marketingpermission USING btree (technicalproduct_tkey, organizationreference_tkey);


--
-- Name: marketplace_bk; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX marketplace_bk ON marketplace USING btree (marketplaceid);


--
-- Name: marketplace_organization_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX marketplace_organization_idx ON marketplace USING btree (organization_tkey);


--
-- Name: onbehalfuserreference_usrs_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX onbehalfuserreference_usrs_uidx ON onbehalfuserreference USING btree (masteruser_tkey, slaveuser_tkey);


--
-- Name: operationrecord_subscription_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX operationrecord_subscription_nuidx ON operationrecord USING btree (subscription_tkey);


--
-- Name: operationrecord_transactionid_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX operationrecord_transactionid_nuidx ON operationrecord USING btree (transactionid);


--
-- Name: operationrecord_user_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX operationrecord_user_nuidx ON operationrecord USING btree (user_tkey);


--
-- Name: operationrecord_usersubscription_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX operationrecord_usersubscription_idx ON operationrecord USING btree (user_tkey, subscription_tkey);


--
-- Name: organization_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX organization_bk_idx ON organization USING btree (organizationid);


--
-- Name: organizationreference_source_target_type_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX organizationreference_source_target_type_uidx ON organizationreference USING btree (sourcekey, targetkey, referencetype);


--
-- Name: organizationreference_sup_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX organizationreference_sup_nuidx ON organizationreference USING btree (targetkey);


--
-- Name: organizationrole_role_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX organizationrole_role_uidx ON organizationrole USING btree (rolename);


--
-- Name: organizationsetting_org_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX organizationsetting_org_nuidx ON organizationsetting USING btree (organization_tkey);


--
-- Name: organizationsetting_orgtype_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX organizationsetting_orgtype_uidx ON organizationsetting USING btree (organization_tkey, settingtype);


--
-- Name: organizationtocountry_orgctr_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX organizationtocountry_orgctr_nuidx ON organizationtocountry USING btree (organization_tkey, supportedcountry_tkey);


--
-- Name: organizationtorole_org_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX organizationtorole_org_nuidx ON organizationtorole USING btree (organization_tkey);


--
-- Name: organizationtorole_org_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX organizationtorole_org_uidx ON organizationtorole USING btree (organization_tkey, organizationrole_tkey);


--
-- Name: organizationtorole_orgrole_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX organizationtorole_orgrole_nuidx ON organizationtorole USING btree (organizationrole_tkey);


--
-- Name: orghistory_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX orghistory_nuidx ON organizationhistory USING btree (objkey);


--
-- Name: orgreftopaymenttype_orgrole_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX orgreftopaymenttype_orgrole_nuidx ON organizationreftopaymenttype USING btree (organizationrole_tkey);


--
-- Name: orgreftopaymenttype_pt_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX orgreftopaymenttype_pt_nuidx ON organizationreftopaymenttype USING btree (paymenttype_tkey);


--
-- Name: orgreftopt_orgref_pt_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX orgreftopt_orgref_pt_uidx ON organizationreftopaymenttype USING btree (organizationreference_tkey, paymenttype_tkey);


--
-- Name: parameter_paramdef_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX parameter_paramdef_nuidx ON parameter USING btree (parameterdefinitionkey);


--
-- Name: parameter_paramset_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX parameter_paramset_nuidx ON parameter USING btree (parametersetkey);


--
-- Name: parameterdefinition_tp_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX parameterdefinition_tp_nuidx ON parameterdefinition USING btree (technicalproduct_tkey);


--
-- Name: parameterdefinitionhistory_datekeyversion; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX parameterdefinitionhistory_datekeyversion ON parameterdefinitionhistory USING btree (moddate, objkey, objversion);


--
-- Name: parameterhistory_dateversion; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX parameterhistory_dateversion ON parameterhistory USING btree (moddate, objkey);


--
-- Name: parameteroption_paramdef_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX parameteroption_paramdef_nuidx ON parameteroption USING btree (parameterdefinition_tkey);


--
-- Name: paymentinfo_ptype_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX paymentinfo_ptype_nuidx ON paymentinfo USING btree (paymenttype_tkey);


--
-- Name: paymentresult_billres_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX paymentresult_billres_nuidx ON paymentresult USING btree (billingresult_tkey);


--
-- Name: paymenttype_ptype_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX paymenttype_ptype_uidx ON paymenttype USING btree (paymenttypeid);


--
-- Name: platformsetting_type_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX platformsetting_type_uidx ON platformsetting USING btree (settingtype);


--
-- Name: platformuser_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX platformuser_bk_idx ON platformuser USING btree (userid);


--
-- Name: platformuser_org_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX platformuser_org_nuidx ON platformuser USING btree (organizationkey);


--
-- Name: pricedevent_evt_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedevent_evt_nuidx ON pricedevent USING btree (eventkey);


--
-- Name: pricedevent_pm_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedevent_pm_nuidx ON pricedevent USING btree (pricemodelkey);


--
-- Name: pricedoption_paramopt_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedoption_paramopt_nuidx ON pricedoption USING btree (parameteroptionkey);


--
-- Name: pricedoption_pparam_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedoption_pparam_nuidx ON pricedoption USING btree (pricedparameter_tkey);


--
-- Name: pricedparameter_param_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedparameter_param_nuidx ON pricedparameter USING btree (parameter_tkey);


--
-- Name: pricedparameter_pm_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedparameter_pm_nuidx ON pricedparameter USING btree (pricemodelkey);


--
-- Name: pricedparameterhistory_datepmkeyversion; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedparameterhistory_datepmkeyversion ON pricedparameterhistory USING btree (moddate, pricemodelobjkey, objversion);


--
-- Name: pricedproductrole_pm_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedproductrole_pm_nuidx ON pricedproductrole USING btree (pricemodel_tkey);


--
-- Name: pricedproductrole_popt_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedproductrole_popt_nuidx ON pricedproductrole USING btree (pricedoption_tkey);


--
-- Name: pricedproductrole_pparam_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedproductrole_pparam_nuidx ON pricedproductrole USING btree (pricedparameter_tkey);


--
-- Name: pricedproductrole_roledef_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricedproductrole_roledef_nuidx ON pricedproductrole USING btree (roledefinition_tkey);


--
-- Name: pricemodel_currency_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricemodel_currency_nuidx ON pricemodel USING btree (currency_tkey);


--
-- Name: pricemodelhistory_objkey_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX pricemodelhistory_objkey_nuidx ON pricemodelhistory USING btree (objkey);


--
-- Name: product_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX product_bk_idx ON product USING btree (productid, vendorkey);


--
-- Name: product_paramset_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX product_paramset_nuidx ON product USING btree (parameterset_tkey);


--
-- Name: product_pm_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX product_pm_nuidx ON product USING btree (pricemodel_tkey);


--
-- Name: product_supp_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX product_supp_nuidx ON product USING btree (vendorkey);


--
-- Name: product_targetcust_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX product_targetcust_nuidx ON product USING btree (targetcustomer_tkey);


--
-- Name: product_template_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX product_template_nuidx ON product USING btree (template_tkey);


--
-- Name: product_tp_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX product_tp_nuidx ON product USING btree (technicalproduct_tkey);


--
-- Name: producthistory_objkey_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX producthistory_objkey_nuidx ON producthistory USING btree (objkey);


--
-- Name: productreference_srcprod_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX productreference_srcprod_nuidx ON productreference USING btree (sourceproduct_tkey);


--
-- Name: productreference_tgtprod_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX productreference_tgtprod_nuidx ON productreference USING btree (targetproduct_tkey);


--
-- Name: productreview_usrrts_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX productreview_usrrts_uidx ON productreview USING btree (platformuser_tkey, productfeedback_tkey);


--
-- Name: producttopaymenttype_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX producttopaymenttype_bk_idx ON producttopaymenttype USING btree (product_tkey, paymenttype_tkey);


--
-- Name: psp_id_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX psp_id_uidx ON psp USING btree (identifier);


--
-- Name: pspaccount_orgpsp_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX pspaccount_orgpsp_uidx ON pspaccount USING btree (psp_tkey, organization_tkey);


--
-- Name: pspsetting_key_bk; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX pspsetting_key_bk ON pspsetting USING btree (psp_tkey, settingkey);


--
-- Name: report_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX report_bk_idx ON report USING btree (reportname);


--
-- Name: report_orgrole_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX report_orgrole_nuidx ON report USING btree (organizationrole_tkey);


--
-- Name: roleassignment_org_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX roleassignment_org_nuidx ON roleassignment USING btree (user_tkey);


--
-- Name: roleassignment_org_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX roleassignment_org_uidx ON roleassignment USING btree (user_tkey, userrole_tkey);


--
-- Name: roleassignment_orgrole_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX roleassignment_orgrole_nuidx ON roleassignment USING btree (userrole_tkey);


--
-- Name: roledefinition_tp_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX roledefinition_tp_nuidx ON roledefinition USING btree (technicalproduct_tkey);


--
-- Name: session_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX session_bk_idx ON session USING btree (sessionid, subscriptiontkey, sessiontype);


--
-- Name: steppedprice_pevent_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX steppedprice_pevent_nuidx ON steppedprice USING btree (pricedevent_tkey);


--
-- Name: steppedprice_pm_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX steppedprice_pm_nuidx ON steppedprice USING btree (pricemodel_tkey);


--
-- Name: steppedprice_pparam_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX steppedprice_pparam_nuidx ON steppedprice USING btree (pricedparameter_tkey);


--
-- Name: subscription_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX subscription_bk_idx ON subscription USING btree (subscriptionid, organizationkey);


--
-- Name: subscription_org_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX subscription_org_nuidx ON subscription USING btree (organizationkey);


--
-- Name: subscription_prod_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX subscription_prod_nuidx ON subscription USING btree (product_tkey);


--
-- Name: subscriptionhistory_objkey_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX subscriptionhistory_objkey_idx ON subscriptionhistory USING btree (objkey);


--
-- Name: subscriptionhistory_orgobjkey_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX subscriptionhistory_orgobjkey_nuidx ON subscriptionhistory USING btree (organizationobjkey);


--
-- Name: supportedcountry_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX supportedcountry_bk_idx ON supportedcountry USING btree (countryisocode);


--
-- Name: supportedcurrency_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX supportedcurrency_bk_idx ON supportedcurrency USING btree (currencyisocode);


--
-- Name: tag_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX tag_bk_idx ON tag USING btree (locale, value);


--
-- Name: technicalproduct_org_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX technicalproduct_org_nuidx ON technicalproduct USING btree (organizationkey);


--
-- Name: technicalproducttag_uc_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX technicalproducttag_uc_idx ON technicalproducttag USING btree (technicalproduct_tkey, tag_tkey);


--
-- Name: timerprocessing_uc_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX timerprocessing_uc_uidx ON timerprocessing USING btree (timertype, starttimemutex);


--
-- Name: tprodoperation_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX tprodoperation_bk_idx ON technicalproductoperation USING btree (technicalproduct_tkey, operationid);


--
-- Name: tprodoperation_tp_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX tprodoperation_tp_nuidx ON technicalproductoperation USING btree (technicalproduct_tkey);


--
-- Name: triggerdefinition_org_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX triggerdefinition_org_nuidx ON triggerdefinition USING btree (organization_tkey);


--
-- Name: triggerprocess_trigdef_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX triggerprocess_trigdef_nuidx ON triggerprocess USING btree (triggerdefinition_tkey);


--
-- Name: triggerprocess_user_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX triggerprocess_user_nuidx ON triggerprocess USING btree (user_tkey);


--
-- Name: triggerprocessidentifier_identity_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX triggerprocessidentifier_identity_nuidx ON triggerprocessidentifier USING btree (triggerprocess_tkey, name, value);


--
-- Name: triggerprocessparameter_trigproc_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX triggerprocessparameter_trigproc_nuidx ON triggerprocessparameter USING btree (triggerprocess_tkey);


--
-- Name: uda_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX uda_bk_idx ON uda USING btree (udadefinitionkey, targetobjectkey);


--
-- Name: uda_udadefinitionkey_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX uda_udadefinitionkey_nuidx ON uda USING btree (udadefinitionkey);


--
-- Name: udadefinition_bk_idx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX udadefinition_bk_idx ON udadefinition USING btree (organizationkey, udaid, targettype);


--
-- Name: udadefinition_orgkey_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX udadefinition_orgkey_nuidx ON udadefinition USING btree (organizationkey);


--
-- Name: usagelicense_roledef_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX usagelicense_roledef_nuidx ON usagelicense USING btree (roledefinition_tkey);


--
-- Name: usagelicense_sub_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX usagelicense_sub_nuidx ON usagelicense USING btree (subscription_tkey);


--
-- Name: usagelicense_user_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX usagelicense_user_nuidx ON usagelicense USING btree (user_tkey);


--
-- Name: usagelicensehistory_moddate; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX usagelicensehistory_moddate ON usagelicensehistory USING btree (moddate DESC);


--
-- Name: usagelicensehistory_objkey; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX usagelicensehistory_objkey ON usagelicensehistory USING btree (objkey);


--
-- Name: usergrouptoinvisibleproduct_productgroup_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX usergrouptoinvisibleproduct_productgroup_nuidx ON usergrouptoinvisibleproduct USING btree (product_tkey, usergroup_tkey);


--
-- Name: usergrouptoinvisibleproduct_usergroup; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX usergrouptoinvisibleproduct_usergroup ON usergrouptoinvisibleproduct USING btree (usergroup_tkey);


--
-- Name: usergrouptouser_groupuser_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX usergrouptouser_groupuser_nuidx ON usergrouptouser USING btree (usergroup_tkey, platformuser_tkey);


--
-- Name: userrole_role_uidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE UNIQUE INDEX userrole_role_uidx ON userrole USING btree (rolename);


--
-- Name: vatrate_orgkey_nuidx; Type: INDEX; Schema: bssuser; Owner: bssuser; Tablespace: 
--

CREATE INDEX vatrate_orgkey_nuidx ON vatrate USING btree (owningorganization_tkey);


--
-- Name: billingcontact_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY billingcontact
    ADD CONSTRAINT billingcontact_organization_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: billingresult_supportedcurrency_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY billingresult
    ADD CONSTRAINT billingresult_supportedcurrency_fk FOREIGN KEY (currency_tkey) REFERENCES supportedcurrency(tkey);


--
-- Name: billingresult_to_usergroup_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY billingresult
    ADD CONSTRAINT billingresult_to_usergroup_fk FOREIGN KEY (usergroup_tkey) REFERENCES usergroup(tkey) ON DELETE SET NULL;


--
-- Name: brokerpricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplace
    ADD CONSTRAINT brokerpricemodel_fk FOREIGN KEY (brokerpricemodel_tkey) REFERENCES revenuesharemodel(tkey);


--
-- Name: brokerpricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY catalogentry
    ADD CONSTRAINT brokerpricemodel_fk FOREIGN KEY (brokerpricemodel_tkey) REFERENCES revenuesharemodel(tkey);


--
-- Name: catalogentry_marketplace_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY catalogentry
    ADD CONSTRAINT catalogentry_marketplace_fk FOREIGN KEY (marketplace_tkey) REFERENCES marketplace(tkey);


--
-- Name: catalogentry_product_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY catalogentry
    ADD CONSTRAINT catalogentry_product_fk FOREIGN KEY (product_tkey) REFERENCES product(tkey);


--
-- Name: categorytocatalogentry_catalogentry_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY categorytocatalogentry
    ADD CONSTRAINT categorytocatalogentry_catalogentry_fk FOREIGN KEY (catalogentry_tkey) REFERENCES catalogentry(tkey);


--
-- Name: categorytocatalogentry_category_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY categorytocatalogentry
    ADD CONSTRAINT categorytocatalogentry_category_fk FOREIGN KEY (category_tkey) REFERENCES category(tkey);


--
-- Name: discount_organizationreference_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY discount
    ADD CONSTRAINT discount_organizationreference_fk FOREIGN KEY (organizationreference_tkey) REFERENCES organizationreference(tkey);


--
-- Name: event_to_techprod_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_to_techprod_fk FOREIGN KEY (technicalproduct_tkey) REFERENCES technicalproduct(tkey);


--
-- Name: gathevt_to_billres_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY gatheredevent
    ADD CONSTRAINT gathevt_to_billres_fk FOREIGN KEY (billingresult_tkey) REFERENCES billingresult(tkey);


--
-- Name: landingpageproduct_landingpage_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY landingpageproduct
    ADD CONSTRAINT landingpageproduct_landingpage_fk FOREIGN KEY (landingpage_tkey) REFERENCES publiclandingpage(tkey) ON DELETE CASCADE;


--
-- Name: landingpageproduct_product_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY landingpageproduct
    ADD CONSTRAINT landingpageproduct_product_fk FOREIGN KEY (product_tkey) REFERENCES product(tkey);


--
-- Name: marketingpermission_organizationreference_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketingpermission
    ADD CONSTRAINT marketingpermission_organizationreference_fk FOREIGN KEY (organizationreference_tkey) REFERENCES organizationreference(tkey);


--
-- Name: marketingpermission_technicalproduct_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketingpermission
    ADD CONSTRAINT marketingpermission_technicalproduct_fk FOREIGN KEY (technicalproduct_tkey) REFERENCES technicalproduct(tkey);


--
-- Name: marketplace_enterpriselandingpage_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplace
    ADD CONSTRAINT marketplace_enterpriselandingpage_fk FOREIGN KEY (enterpriselandingpage_tkey) REFERENCES enterpriselandingpage(tkey);


--
-- Name: marketplace_landingpage_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplace
    ADD CONSTRAINT marketplace_landingpage_fk FOREIGN KEY (publiclandingpage_tkey) REFERENCES publiclandingpage(tkey);


--
-- Name: marketplace_to_org_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplace
    ADD CONSTRAINT marketplace_to_org_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: mptoorg_marketplace_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplacetoorganization
    ADD CONSTRAINT mptoorg_marketplace_fk FOREIGN KEY (marketplace_tkey) REFERENCES marketplace(tkey);


--
-- Name: mptoorg_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplacetoorganization
    ADD CONSTRAINT mptoorg_organization_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: onbehalfuserreference_masteruser_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY onbehalfuserreference
    ADD CONSTRAINT onbehalfuserreference_masteruser_fk FOREIGN KEY (masteruser_tkey) REFERENCES platformuser(tkey);


--
-- Name: onbehalfuserreference_slaveuser_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY onbehalfuserreference
    ADD CONSTRAINT onbehalfuserreference_slaveuser_fk FOREIGN KEY (slaveuser_tkey) REFERENCES platformuser(tkey);


--
-- Name: operationparameter_technicalproductoperation_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY operationparameter
    ADD CONSTRAINT operationparameter_technicalproductoperation_fk FOREIGN KEY (technicalproductoperation_tkey) REFERENCES technicalproductoperation(tkey);


--
-- Name: operationrecord_subscription_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY operationrecord
    ADD CONSTRAINT operationrecord_subscription_fk FOREIGN KEY (subscription_tkey) REFERENCES subscription(tkey);


--
-- Name: operationrecord_technicalproductoperation_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY operationrecord
    ADD CONSTRAINT operationrecord_technicalproductoperation_fk FOREIGN KEY (technicalproductoperation_tkey) REFERENCES technicalproductoperation(tkey);


--
-- Name: operationrecord_user_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY operationrecord
    ADD CONSTRAINT operationrecord_user_fk FOREIGN KEY (user_tkey) REFERENCES platformuser(tkey);


--
-- Name: operatorpricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT operatorpricemodel_fk FOREIGN KEY (operatorpricemodel_tkey) REFERENCES revenuesharemodel(tkey);


--
-- Name: operatorpricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY catalogentry
    ADD CONSTRAINT operatorpricemodel_fk FOREIGN KEY (operatorpricemodel_tkey) REFERENCES revenuesharemodel(tkey);


--
-- Name: organizationreference_to_source_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationreference
    ADD CONSTRAINT organizationreference_to_source_fk FOREIGN KEY (sourcekey) REFERENCES organization(tkey);


--
-- Name: organizationreference_to_target_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationreference
    ADD CONSTRAINT organizationreference_to_target_fk FOREIGN KEY (targetkey) REFERENCES organization(tkey);


--
-- Name: organizationreftopaymenttype_organizationref_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationreftopaymenttype
    ADD CONSTRAINT organizationreftopaymenttype_organizationref_fk FOREIGN KEY (organizationreference_tkey) REFERENCES organizationreference(tkey);


--
-- Name: organizationtocountry_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationtocountry
    ADD CONSTRAINT organizationtocountry_organization_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: organizationtocountry_supportedcountry_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationtocountry
    ADD CONSTRAINT organizationtocountry_supportedcountry_fk FOREIGN KEY (supportedcountry_tkey) REFERENCES supportedcountry(tkey);


--
-- Name: organizationtopaymenttype_organizationrole_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationreftopaymenttype
    ADD CONSTRAINT organizationtopaymenttype_organizationrole_fk FOREIGN KEY (organizationrole_tkey) REFERENCES organizationrole(tkey);


--
-- Name: organizationtopaymenttype_paymenttype_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationreftopaymenttype
    ADD CONSTRAINT organizationtopaymenttype_paymenttype_fk FOREIGN KEY (paymenttype_tkey) REFERENCES paymenttype(tkey);


--
-- Name: orgtorole_org_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationtorole
    ADD CONSTRAINT orgtorole_org_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: orgtorole_role_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationtorole
    ADD CONSTRAINT orgtorole_role_fk FOREIGN KEY (organizationrole_tkey) REFERENCES organizationrole(tkey);


--
-- Name: param_to_def_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT param_to_def_fk FOREIGN KEY (parameterdefinitionkey) REFERENCES parameterdefinition(tkey);


--
-- Name: param_to_paramset_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT param_to_paramset_fk FOREIGN KEY (parametersetkey) REFERENCES parameterset(tkey);


--
-- Name: parameter_to_pricedparameter_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedparameter
    ADD CONSTRAINT parameter_to_pricedparameter_fk FOREIGN KEY (parameter_tkey) REFERENCES parameter(tkey);


--
-- Name: parameteroption_to_parameterdef_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY parameteroption
    ADD CONSTRAINT parameteroption_to_parameterdef_fk FOREIGN KEY (parameterdefinition_tkey) REFERENCES parameterdefinition(tkey);


--
-- Name: paymentinfo_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY paymentinfo
    ADD CONSTRAINT paymentinfo_organization_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: paymentinfo_paymenttype_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY paymentinfo
    ADD CONSTRAINT paymentinfo_paymenttype_fk FOREIGN KEY (paymenttype_tkey) REFERENCES paymenttype(tkey);


--
-- Name: paymentresult_to_billingresult_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY paymentresult
    ADD CONSTRAINT paymentresult_to_billingresult_fk FOREIGN KEY (billingresult_tkey) REFERENCES billingresult(tkey);


--
-- Name: paymenttype_psp_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY paymenttype
    ADD CONSTRAINT paymenttype_psp_fk FOREIGN KEY (psp_tkey) REFERENCES psp(tkey);


--
-- Name: platformuser_to_org_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY platformuser
    ADD CONSTRAINT platformuser_to_org_fk FOREIGN KEY (organizationkey) REFERENCES organization(tkey);


--
-- Name: pricedevent_to_event_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedevent
    ADD CONSTRAINT pricedevent_to_event_fk FOREIGN KEY (eventkey) REFERENCES event(tkey);


--
-- Name: pricedevent_to_pricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedevent
    ADD CONSTRAINT pricedevent_to_pricemodel_fk FOREIGN KEY (pricemodelkey) REFERENCES pricemodel(tkey);


--
-- Name: pricedoption_to_parameteroption_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedoption
    ADD CONSTRAINT pricedoption_to_parameteroption_fk FOREIGN KEY (parameteroptionkey) REFERENCES parameteroption(tkey);


--
-- Name: pricedoption_to_pricedparameter_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedoption
    ADD CONSTRAINT pricedoption_to_pricedparameter_fk FOREIGN KEY (pricedparameter_tkey) REFERENCES pricedparameter(tkey);


--
-- Name: pricedproductrole_pricedoption_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedproductrole
    ADD CONSTRAINT pricedproductrole_pricedoption_fk FOREIGN KEY (pricedoption_tkey) REFERENCES pricedoption(tkey);


--
-- Name: pricedproductrole_pricedparameter_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedproductrole
    ADD CONSTRAINT pricedproductrole_pricedparameter_fk FOREIGN KEY (pricedparameter_tkey) REFERENCES pricedparameter(tkey);


--
-- Name: pricedproductrole_pricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedproductrole
    ADD CONSTRAINT pricedproductrole_pricemodel_fk FOREIGN KEY (pricemodel_tkey) REFERENCES pricemodel(tkey);


--
-- Name: pricedproductrole_roledefinition_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedproductrole
    ADD CONSTRAINT pricedproductrole_roledefinition_fk FOREIGN KEY (roledefinition_tkey) REFERENCES roledefinition(tkey);


--
-- Name: pricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplace
    ADD CONSTRAINT pricemodel_fk FOREIGN KEY (pricemodel_tkey) REFERENCES revenuesharemodel(tkey);


--
-- Name: pricemodel_to_currency; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricemodel
    ADD CONSTRAINT pricemodel_to_currency FOREIGN KEY (currency_tkey) REFERENCES supportedcurrency(tkey);


--
-- Name: pricemodel_to_pricedparam_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pricedparameter
    ADD CONSTRAINT pricemodel_to_pricedparam_fk FOREIGN KEY (pricemodelkey) REFERENCES pricemodel(tkey);


--
-- Name: prod_paramset_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY product
    ADD CONSTRAINT prod_paramset_fk FOREIGN KEY (parameterset_tkey) REFERENCES parameterset(tkey);


--
-- Name: prod_pricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY product
    ADD CONSTRAINT prod_pricemodel_fk FOREIGN KEY (pricemodel_tkey) REFERENCES pricemodel(tkey);


--
-- Name: prod_tarcust_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY product
    ADD CONSTRAINT prod_tarcust_fk FOREIGN KEY (targetcustomer_tkey) REFERENCES organization(tkey);


--
-- Name: prod_techprod_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY product
    ADD CONSTRAINT prod_techprod_fk FOREIGN KEY (technicalproduct_tkey) REFERENCES technicalproduct(tkey);


--
-- Name: prod_template_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY product
    ADD CONSTRAINT prod_template_fk FOREIGN KEY (template_tkey) REFERENCES product(tkey);


--
-- Name: prod_to_org_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY product
    ADD CONSTRAINT prod_to_org_fk FOREIGN KEY (vendorkey) REFERENCES organization(tkey);


--
-- Name: productfeedback_product_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY productfeedback
    ADD CONSTRAINT productfeedback_product_fk FOREIGN KEY (product_tkey) REFERENCES product(tkey);


--
-- Name: productreference_srcprod_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY productreference
    ADD CONSTRAINT productreference_srcprod_fk FOREIGN KEY (sourceproduct_tkey) REFERENCES product(tkey);


--
-- Name: productreference_tgtprod_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY productreference
    ADD CONSTRAINT productreference_tgtprod_fk FOREIGN KEY (targetproduct_tkey) REFERENCES product(tkey);


--
-- Name: productreview_platformuser_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY productreview
    ADD CONSTRAINT productreview_platformuser_fk FOREIGN KEY (platformuser_tkey) REFERENCES platformuser(tkey);


--
-- Name: productreview_productfeedback_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY productreview
    ADD CONSTRAINT productreview_productfeedback_fk FOREIGN KEY (productfeedback_tkey) REFERENCES productfeedback(tkey);


--
-- Name: producttopaymenttype_paymenttype_pk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY producttopaymenttype
    ADD CONSTRAINT producttopaymenttype_paymenttype_pk FOREIGN KEY (paymenttype_tkey) REFERENCES paymenttype(tkey);


--
-- Name: producttopaymenttype_product_pk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY producttopaymenttype
    ADD CONSTRAINT producttopaymenttype_product_pk FOREIGN KEY (product_tkey) REFERENCES product(tkey);


--
-- Name: pspaccount_org_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pspaccount
    ADD CONSTRAINT pspaccount_org_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: pspaccount_psp_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pspaccount
    ADD CONSTRAINT pspaccount_psp_fk FOREIGN KEY (psp_tkey) REFERENCES psp(tkey);


--
-- Name: pspsetting_psp_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY pspsetting
    ADD CONSTRAINT pspsetting_psp_fk FOREIGN KEY (psp_tkey) REFERENCES psp(tkey);


--
-- Name: report_to_orgrole_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_to_orgrole_fk FOREIGN KEY (organizationrole_tkey) REFERENCES organizationrole(tkey);


--
-- Name: resellerpricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY marketplace
    ADD CONSTRAINT resellerpricemodel_fk FOREIGN KEY (resellerpricemodel_tkey) REFERENCES revenuesharemodel(tkey);


--
-- Name: resellerpricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY catalogentry
    ADD CONSTRAINT resellerpricemodel_fk FOREIGN KEY (resellerpricemodel_tkey) REFERENCES revenuesharemodel(tkey);


--
-- Name: roleassgnment_to_role_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY roleassignment
    ADD CONSTRAINT roleassgnment_to_role_fk FOREIGN KEY (userrole_tkey) REFERENCES userrole(tkey);


--
-- Name: roleassgnment_to_user_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY roleassignment
    ADD CONSTRAINT roleassgnment_to_user_fk FOREIGN KEY (user_tkey) REFERENCES platformuser(tkey) ON DELETE CASCADE;


--
-- Name: roledefinition_technicalproduct_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY roledefinition
    ADD CONSTRAINT roledefinition_technicalproduct_fk FOREIGN KEY (technicalproduct_tkey) REFERENCES technicalproduct(tkey);


--
-- Name: setting_to_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY organizationsetting
    ADD CONSTRAINT setting_to_organization_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: steppedprice_pricedevent_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY steppedprice
    ADD CONSTRAINT steppedprice_pricedevent_fk FOREIGN KEY (pricedevent_tkey) REFERENCES pricedevent(tkey);


--
-- Name: steppedprice_pricedparameter_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY steppedprice
    ADD CONSTRAINT steppedprice_pricedparameter_fk FOREIGN KEY (pricedparameter_tkey) REFERENCES pricedparameter(tkey);


--
-- Name: steppedprice_pricemodel_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY steppedprice
    ADD CONSTRAINT steppedprice_pricemodel_fk FOREIGN KEY (pricemodel_tkey) REFERENCES pricemodel(tkey);


--
-- Name: subscription_to_mpl_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_to_mpl_fk FOREIGN KEY (marketplace_tkey) REFERENCES marketplace(tkey);


--
-- Name: subscription_to_org_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_to_org_fk FOREIGN KEY (organizationkey) REFERENCES organization(tkey);


--
-- Name: subscription_to_paymentinfo_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_to_paymentinfo_fk FOREIGN KEY (paymentinfo_tkey) REFERENCES paymentinfo(tkey);


--
-- Name: subscription_to_platformuser_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_to_platformuser_fk FOREIGN KEY (owner_tkey) REFERENCES platformuser(tkey) ON DELETE SET NULL;


--
-- Name: subscription_to_product_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_to_product_fk FOREIGN KEY (product_tkey) REFERENCES product(tkey);


--
-- Name: subscription_to_usergroup_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_to_usergroup_fk FOREIGN KEY (usergroup_tkey) REFERENCES usergroup(tkey);


--
-- Name: tech_prod_to_org_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY technicalproduct
    ADD CONSTRAINT tech_prod_to_org_fk FOREIGN KEY (organizationkey) REFERENCES organization(tkey);


--
-- Name: tech_prod_to_param_def_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY parameterdefinition
    ADD CONSTRAINT tech_prod_to_param_def_fk FOREIGN KEY (technicalproduct_tkey) REFERENCES technicalproduct(tkey);


--
-- Name: technicalproductoperation_technicalproduct_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY technicalproductoperation
    ADD CONSTRAINT technicalproductoperation_technicalproduct_fk FOREIGN KEY (technicalproduct_tkey) REFERENCES technicalproduct(tkey);


--
-- Name: technicalproducttag_to_tag_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY technicalproducttag
    ADD CONSTRAINT technicalproducttag_to_tag_fk FOREIGN KEY (tag_tkey) REFERENCES tag(tkey);


--
-- Name: technicalproducttag_to_tp_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY technicalproducttag
    ADD CONSTRAINT technicalproducttag_to_tp_fk FOREIGN KEY (technicalproduct_tkey) REFERENCES technicalproduct(tkey);


--
-- Name: triggerdefinition_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY triggerdefinition
    ADD CONSTRAINT triggerdefinition_organization_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: triggerprocess_triggerdefinition_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY triggerprocess
    ADD CONSTRAINT triggerprocess_triggerdefinition_fk FOREIGN KEY (triggerdefinition_tkey) REFERENCES triggerdefinition(tkey);


--
-- Name: triggerprocess_user_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY triggerprocess
    ADD CONSTRAINT triggerprocess_user_fk FOREIGN KEY (user_tkey) REFERENCES platformuser(tkey);


--
-- Name: triggerprocessidentifier_triggerprocess_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY triggerprocessidentifier
    ADD CONSTRAINT triggerprocessidentifier_triggerprocess_fk FOREIGN KEY (triggerprocess_tkey) REFERENCES triggerprocess(tkey);


--
-- Name: triggerprocessmodification_triggerprocess_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY triggerprocessparameter
    ADD CONSTRAINT triggerprocessmodification_triggerprocess_fk FOREIGN KEY (triggerprocess_tkey) REFERENCES triggerprocess(tkey);


--
-- Name: uda_udadefinition_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY uda
    ADD CONSTRAINT uda_udadefinition_fk FOREIGN KEY (udadefinitionkey) REFERENCES udadefinition(tkey);


--
-- Name: udadefinition_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY udadefinition
    ADD CONSTRAINT udadefinition_organization_fk FOREIGN KEY (organizationkey) REFERENCES organization(tkey);


--
-- Name: unitroleassignment_to_unituserrole_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY unitroleassignment
    ADD CONSTRAINT unitroleassignment_to_unituserrole_fk FOREIGN KEY (unituserrole_tkey) REFERENCES unituserrole(tkey) ON DELETE SET NULL;


--
-- Name: unitroleassignment_to_usergrouptouser_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY unitroleassignment
    ADD CONSTRAINT unitroleassignment_to_usergrouptouser_fk FOREIGN KEY (usergrouptouser_tkey) REFERENCES usergrouptouser(tkey) ON DELETE SET NULL;


--
-- Name: usagelicense_roledefinition_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usagelicense
    ADD CONSTRAINT usagelicense_roledefinition_fk FOREIGN KEY (roledefinition_tkey) REFERENCES roledefinition(tkey);


--
-- Name: usagelicense_to_puser_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usagelicense
    ADD CONSTRAINT usagelicense_to_puser_fk FOREIGN KEY (user_tkey) REFERENCES platformuser(tkey);


--
-- Name: usagelicense_to_sub_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usagelicense
    ADD CONSTRAINT usagelicense_to_sub_fk FOREIGN KEY (subscription_tkey) REFERENCES subscription(tkey);


--
-- Name: usergroup_organization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usergroup
    ADD CONSTRAINT usergroup_organization_fk FOREIGN KEY (organization_tkey) REFERENCES organization(tkey);


--
-- Name: usergrouptoinvisibleproduct_product_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usergrouptoinvisibleproduct
    ADD CONSTRAINT usergrouptoinvisibleproduct_product_fk FOREIGN KEY (product_tkey) REFERENCES product(tkey);


--
-- Name: usergrouptoinvisibleproduct_usergroup_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usergrouptoinvisibleproduct
    ADD CONSTRAINT usergrouptoinvisibleproduct_usergroup_fk FOREIGN KEY (usergroup_tkey) REFERENCES usergroup(tkey);


--
-- Name: usergrouptouser_group_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usergrouptouser
    ADD CONSTRAINT usergrouptouser_group_fk FOREIGN KEY (usergroup_tkey) REFERENCES usergroup(tkey);


--
-- Name: usergrouptouser_platformuser_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY usergrouptouser
    ADD CONSTRAINT usergrouptouser_platformuser_fk FOREIGN KEY (platformuser_tkey) REFERENCES platformuser(tkey);


--
-- Name: vatrate_owningorganization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY vatrate
    ADD CONSTRAINT vatrate_owningorganization_fk FOREIGN KEY (owningorganization_tkey) REFERENCES organization(tkey);


--
-- Name: vatrate_targetcountry_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY vatrate
    ADD CONSTRAINT vatrate_targetcountry_fk FOREIGN KEY (targetcountry_tkey) REFERENCES supportedcountry(tkey);


--
-- Name: vatrate_targetganization_fk; Type: FK CONSTRAINT; Schema: bssuser; Owner: bssuser
--

ALTER TABLE ONLY vatrate
    ADD CONSTRAINT vatrate_targetganization_fk FOREIGN KEY (targetorganization_tkey) REFERENCES organization(tkey);


--
-- Name: bssuser; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA bssuser FROM PUBLIC;
REVOKE ALL ON SCHEMA bssuser FROM postgres;
GRANT ALL ON SCHEMA bssuser TO postgres;
GRANT ALL ON SCHEMA bssuser TO bssuser;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

