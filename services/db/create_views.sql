CREATE OR REPLACE VIEW
oczekujace_loty AS SELECT l.kod_lotu, s.numer_rejestracyjny, l.lotnisko_odlotu_id, l.lotnisko_przylotu_id, l.czas_odlotu, l.czas_przylotu
FROM lot l JOIN samolot s ON s.samolot_id = l.samolot_id WHERE current_timestamp<czas_odlotu;

CREATE OR REPLACE VIEW
aktualne_loty AS SELECT l.kod_lotu, s.numer_rejestracyjny, l.lotnisko_odlotu_id, l.lotnisko_przylotu_id, l.czas_odlotu, l.czas_przylotu
FROM lot l JOIN samolot s ON s.samolot_id = l.samolot_id WHERE current_timestamp>czas_odlotu AND current_timestamp<czas_przylotu;

CREATE OR REPLACE VIEW
zakonczone_loty AS SELECT l.kod_lotu, s.numer_rejestracyjny, l.lotnisko_odlotu_id, l.lotnisko_przylotu_id, l.czas_odlotu, l.czas_przylotu
FROM lot l JOIN samolot s ON s.samolot_id = l.samolot_id WHERE current_timestamp>czas_przylotu;

CREATE OR REPLACE VIEW samoloty_w_powietrzu AS
SELECT s.samolot_id, s.numer_rejestracyjny, m.nazwa_modelu, ll.nazwa_linii, l.kod_lotu, l.lotnisko_odlotu_id, l.lotnisko_przylotu_id, l.czas_odlotu, l.czas_przylotu
FROM samolot s
JOIN model m ON s.model_id = m.model_id
JOIN linia_lotnicza ll ON s.linia_lotnicza_id = ll.linia_lotnicza_id
JOIN lot l ON s.samolot_id = l.samolot_id
WHERE current_timestamp>l.czas_odlotu AND current_timestamp<l.czas_przylotu;

-- CREATE OR REPLACE VIEW floty AS
-- SELECT COUNT(s.samolot_id) AS ilosc_samolotow, ll.nazwa_linii
-- FROM samolot s
-- JOIN linia_lotnicza ll ON s.linia_lotnicza_id = ll.linia_lotnicza_id
-- GROUP BY ll.nazwa_linii;

CREATE OR REPLACE VIEW floty AS
SELECT ll.nazwa_linii, m.nazwa_modelu, COUNT(s.model_id) AS ilosc_samolotow
FROM linia_lotnicza ll
JOIN samolot s ON (ll.linia_lotnicza_id=s.linia_lotnicza_id)
JOIN model m ON (s.model_id=m.model_id)
GROUP BY ll.nazwa_linii, m.nazwa_modelu;
