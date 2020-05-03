--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

-- Started on 2020-04-29 22:24:08 +06

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
-- TOC entry 202 (class 1259 OID 16846)
-- Name: domain; Type: TABLE; Schema: public; Owner: zireael9797
--

CREATE TABLE public.domain (
    id text NOT NULL,
    title text NOT NULL,
    image text NOT NULL
);

--
-- TOC entry 207 (class 1259 OID 16904)
-- Name: question; Type: TABLE; Schema: public; Owner: zireael9797
--

CREATE TABLE public.question (
    id text NOT NULL,
    title text NOT NULL,
    options text[] NOT NULL,
    answer integer NOT NULL,
    test_id text NOT NULL
);




--
-- TOC entry 203 (class 1259 OID 16854)
-- Name: subdomain; Type: TABLE; Schema: public; Owner: zireael9797
--

CREATE TABLE public.subdomain (
    id text NOT NULL,
    title text NOT NULL,
    image text NOT NULL,
    did text NOT NULL
);




--
-- TOC entry 206 (class 1259 OID 16890)
-- Name: test; Type: TABLE; Schema: public; Owner: zireael9797
--

CREATE TABLE public.test (
    id text NOT NULL,
    "time" text NOT NULL,
    tp_id text NOT NULL
);




--
-- TOC entry 208 (class 1259 OID 16918)
-- Name: testsession; Type: TABLE; Schema: public; Owner: zireael9797
--

CREATE TABLE public.testsession (
    id text NOT NULL,
    test_id text,
    uid bigint,
    score numeric
);




--
-- TOC entry 204 (class 1259 OID 16868)
-- Name: topic; Type: TABLE; Schema: public; Owner: zireael9797
--

CREATE TABLE public.topic (
    id text NOT NULL,
    title text NOT NULL,
    image text NOT NULL,
    questions integer NOT NULL,
    "time" integer NOT NULL,
    sd_id text NOT NULL
);

--
-- TOC entry 205 (class 1259 OID 16882)
-- Name: user; Type: TABLE; Schema: public; Owner: zireael9797
--

CREATE TABLE public."user" (
    name text NOT NULL,
    id bigint NOT NULL
);

--
-- TOC entry 2840 (class 2606 OID 16911)
-- Name: question Question_pkey; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT "Question_pkey" PRIMARY KEY (id);


--
-- TOC entry 2827 (class 2606 OID 16853)
-- Name: domain domain_pkey; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.domain
    ADD CONSTRAINT domain_pkey PRIMARY KEY (id);


--
-- TOC entry 2835 (class 2606 OID 16941)
-- Name: user pkey; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT pkey PRIMARY KEY (id);


--
-- TOC entry 2830 (class 2606 OID 16861)
-- Name: subdomain subdomain_pkey; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.subdomain
    ADD CONSTRAINT subdomain_pkey PRIMARY KEY (id);


--
-- TOC entry 2838 (class 2606 OID 16897)
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- TOC entry 2845 (class 2606 OID 16925)
-- Name: testsession testsession_pkey; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.testsession
    ADD CONSTRAINT testsession_pkey PRIMARY KEY (id);


--
-- TOC entry 2833 (class 2606 OID 16875)
-- Name: topic topic_pkey; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (id);


--
-- TOC entry 2847 (class 2606 OID 16955)
-- Name: testsession user_test_unique; Type: CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.testsession
    ADD CONSTRAINT user_test_unique UNIQUE (uid, test_id);


--
-- TOC entry 2828 (class 1259 OID 16867)
-- Name: fki_did-sdid-fkey; Type: INDEX; Schema: public; Owner: zireael9797
--

CREATE INDEX "fki_did-sdid-fkey" ON public.subdomain USING btree (did);


--
-- TOC entry 2841 (class 1259 OID 16917)
-- Name: fki_qid-testid-kfey; Type: INDEX; Schema: public; Owner: zireael9797
--

CREATE INDEX "fki_qid-testid-kfey" ON public.question USING btree (test_id);


--
-- TOC entry 2842 (class 1259 OID 16953)
-- Name: fki_test_fkey; Type: INDEX; Schema: public; Owner: zireael9797
--

CREATE INDEX fki_test_fkey ON public.testsession USING btree (test_id);


--
-- TOC entry 2836 (class 1259 OID 16903)
-- Name: fki_tp-tst-fkey; Type: INDEX; Schema: public; Owner: zireael9797
--

CREATE INDEX "fki_tp-tst-fkey" ON public.test USING btree (tp_id);


--
-- TOC entry 2831 (class 1259 OID 16881)
-- Name: fki_tpid-sdid-fkey; Type: INDEX; Schema: public; Owner: zireael9797
--

CREATE INDEX "fki_tpid-sdid-fkey" ON public.topic USING btree (sd_id);


--
-- TOC entry 2843 (class 1259 OID 16947)
-- Name: fki_user_fkey; Type: INDEX; Schema: public; Owner: zireael9797
--

CREATE INDEX fki_user_fkey ON public.testsession USING btree (uid);


--
-- TOC entry 2848 (class 2606 OID 16862)
-- Name: subdomain did-sdid-fkey; Type: FK CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.subdomain
    ADD CONSTRAINT "did-sdid-fkey" FOREIGN KEY (did) REFERENCES public.domain(id);


--
-- TOC entry 2851 (class 2606 OID 16912)
-- Name: question qid-testid-kfey; Type: FK CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT "qid-testid-kfey" FOREIGN KEY (test_id) REFERENCES public.test(id);


--
-- TOC entry 2852 (class 2606 OID 16948)
-- Name: testsession test_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.testsession
    ADD CONSTRAINT test_fkey FOREIGN KEY (test_id) REFERENCES public.test(id);


--
-- TOC entry 2850 (class 2606 OID 16898)
-- Name: test tp-tst-fkey; Type: FK CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT "tp-tst-fkey" FOREIGN KEY (tp_id) REFERENCES public.topic(id);


--
-- TOC entry 2849 (class 2606 OID 16876)
-- Name: topic tpid-sdid-fkey; Type: FK CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.topic
    ADD CONSTRAINT "tpid-sdid-fkey" FOREIGN KEY (sd_id) REFERENCES public.subdomain(id);


--
-- TOC entry 2853 (class 2606 OID 16942)
-- Name: testsession user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: zireael9797
--

ALTER TABLE ONLY public.testsession
    ADD CONSTRAINT user_fkey FOREIGN KEY (uid) REFERENCES public."user"(id);


-- Completed on 2020-04-29 22:24:08 +06

--
-- PostgreSQL database dump complete
--

