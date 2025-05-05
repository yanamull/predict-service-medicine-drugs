
-- Создание таблицы active_substances (Активные вещества)
CREATE TABLE active_substances (
    mnn_id SERIAL PRIMARY KEY,
    mnn_name VARCHAR(255) NOT NULL
);

-- Создание таблицы dosage_forms (Лекарственные формы)
CREATE TABLE dosage_forms (
    dosage_form_id SERIAL PRIMARY KEY,
    form_name VARCHAR(100) NOT NULL
);

-- Создание таблицы countries (Страны производителей)
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Создание таблицы pharmaco_groups (Фармако-терапевтические группы)
CREATE TABLE pharmaco_groups (
    group_id SERIAL PRIMARY KEY,
    group_name VARCHAR(255) NOT NULL
);

-- Создание таблицы products (Препараты)
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    trade_name VARCHAR(255) NOT NULL,
    mnn_id INT NOT NULL REFERENCES active_substances(mnn_id),
    dosage_form_id INT NOT NULL REFERENCES dosage_forms(dosage_form_id),
    country_id INT NOT NULL REFERENCES countries(country_id),
    group_id INT NOT NULL REFERENCES pharmaco_groups(group_id),
    is_essential BOOLEAN,  -- ЖНВЛП
    is_pkkn BOOLEAN,       -- ПККН
    characteristic VARCHAR(100)  -- Характер
);

-- Создание таблицы sales_facts (Факты продаж/поставок)
CREATE TABLE sales_facts (
    month DATE NOT NULL,
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL,
    PRIMARY KEY (month, product_id)
);

-- Создание индексов для ускорения запросов
CREATE INDEX idx_sales_facts_product ON sales_facts(product_id);
CREATE INDEX idx_sales_facts_month ON sales_facts(month);
CREATE INDEX idx_products_mnn ON products(mnn_id);
CREATE INDEX idx_products_dosage_form ON products(dosage_form_id);
CREATE INDEX idx_products_country ON products(country_id);
CREATE INDEX idx_products_pharmaco_group ON products(group_id);
