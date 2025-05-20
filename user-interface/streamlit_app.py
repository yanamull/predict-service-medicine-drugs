import streamlit as st
import requests
from requests.exceptions import ConnectionError
from dataclasses import dataclass

@dataclass
class Row:
    id:int
    name: str

    def __str__(self):
        return self.name

ip_api = "api"
port_api = "5000"

st.title("Предсказание выдачи транспортной страховки")
st.write("Введите данные о клиенте:")
gender = st.selectbox("Пол", [Row("Female", "Жещина"), Row("Male", "Мужчина")])
age = st.number_input("Возраст", min_value=0, max_value=150, value=25)
driving_license = st.selectbox("Наличие водительских прав", [Row(1, "Есть"), Row(0, "Нет")])
region_code = st.number_input("Код региона", min_value=0., max_value=1000., value=10.)
previously_insured = st.selectbox("Был ли ранее застрахован", [Row(1, "Да"), Row(0, "Нет")])
vehicle_age = st.number_input("Возраст транспортного средства, округленный до года", min_value=0, max_value=1000, value=1)
vehicle_damage = st.selectbox("Повреждение транспортного средства", [Row("Yes", "Было"), Row("No", "Не было")])
annual_premium = st.number_input("Страховой взнос", min_value=0.0, value=100.)
policy_sales_channel = st.number_input("Канал продаж", min_value=0., value=10.)
vintage= st.number_input("Является клиентом компани, дней", value=0)


if st.button("Предсказать"):
    data = {"Gender": gender.id,
        "Age": int(age),
        "Driving_License": driving_license.id,
        "Region_Code": float(region_code),
        "Previously_Insured": previously_insured.id,
        "Vehicle_Age": int(vehicle_age),
        "Vehicle_Damage": vehicle_damage.id,
        "Annual_Premium": float(annual_premium),
        "Policy_Sales_Channel": float(policy_sales_channel),
        "Vintage": int(vintage)
        }
    try:
        response = requests.post(f"http://{ip_api}:{port_api}/predict_model", json=data)
        if response.status_code == 200:
            prediction = response.json()["prediction"]
            st.success(f"Предсказание: {prediction}")
        else:
            st.error(f"Запрос не выполнен, код состояния {response.status_code}")
    except ConnectionError as e:
        st.error("Ошибка соединения с сервером")