
-- DDL
CREATE TABLE public.accounts (
	account_id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar NOT NULL,
	balance int8 NOT NULL,
	referral_account_id int8 NULL,
	CONSTRAINT account_id PRIMARY KEY (account_id),
	CONSTRAINT fk_referral_account FOREIGN KEY (referral_account_id) REFERENCES public.accounts(account_id)
);

CREATE TABLE public.auths (
	auth_id int8 GENERATED ALWAYS AS IDENTITY NOT NULL,
	account_id int8 NOT NULL,
	username varchar NOT NULL,
	"password" varchar NOT NULL,
	CONSTRAINT auth_id PRIMARY KEY (auth_id),
	CONSTRAINT auth_username UNIQUE (username),
	CONSTRAINT auths_unique UNIQUE (account_id)
);


CREATE TABLE public.transaction_categories (
	transaction_category_id int8 GENERATED ALWAYS AS IDENTITY NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT transaction_categories_pk PRIMARY KEY (transaction_category_id)
);


CREATE TABLE public."transaction" (
	transaction_id int8 GENERATED ALWAYS AS IDENTITY NOT NULL,
	transaction_category_id int8 NULL,
	account_id int8 NULL,
	from_account_id int8 NULL,
	to_account_id int8 NULL,
	amount int8 NULL,
	transaction_date timestamp NULL,
	CONSTRAINT transaction_pk PRIMARY KEY (transaction_id),
	CONSTRAINT transaction_category_id FOREIGN KEY (transaction_category_id) REFERENCES public."transaction"(transaction_id)
);


-- insert Record data

-- account
INSERT INTO public.accounts (name, balance, referral_account_id) VALUES
('Alice', 10000, NULL),
('Bob', 15000, NULL),
('Charlie', 20000, NULL),
('David', 25000, NULL),
('Eve', 30000, NULL);

-- transaction_categories
INSERT INTO public.transaction_categories (name) VALUES
('Makanan'),
('Minuman');


-- transaction
INSERT INTO public.transaction 
(transaction_category_id, account_id, from_account_id, to_account_id, amount, transaction_date)
VALUES
(1, 12, 1, 2, 1000, '2023-01-15'),
(2, 13, 2, 3, 1500, '2023-02-15'),
(1, 14, 3, 4, 2000, '2023-03-15'),
(2, 15, 4, 5, 2500, '2023-04-15'),
(1, 16, 5, 1, 3000, '2023-05-15'),
(2, 12, 1, 2, 3500, '2023-06-15'),
(1, 13, 2, 3, 4000, '2023-07-15'),
(2, 14, 3, 4, 4500, '2023-08-15'),
(1, 15, 4, 5, 5000, '2023-09-15'),
(2, 16, 5, 1, 5500, '2023-10-15'),
(1, 12, 1, 2, 6000, '2023-11-15'),
(2, 13, 2, 3, 6500, '2023-12-15');


-- UPDATE DATA
-- update nama dari table account
UPDATE public.accounts
SET name = 'Sugeng'
WHERE account_id = 13;

-- update balance
UPDATE public.accounts
SET balance = 5000  -- Ganti 5000 dengan jumlah saldo yang diinginkan
WHERE account_id = 15;



-- FUNCTION SELECT
-- SELECT ALL DATA ACCOUNT
select * from accounts;


-- SELECT+JOIN
select a."name" as cust_name, t.* 
from transaction t
join accounts a 
on t.account_id =a.account_id;


-- SELECT DATA ACCOUNT PALING BANYAK BALANCENYA
select * 
from accounts a
order by 3 desc
limit 1

-- SELECT DATA TRANSAKSI DI BULAN MEI (5)
select a."name", t.*
from "transaction" t
join accounts a 
on t.account_id = a.account_id 
WHERE EXTRACT(MONTH FROM transaction_date) = 5;