

SELECT * FROM pizza;
SELECT * FROM rendeles;
SELECT * FROM cim;


# get .../pizzak
  SELECT * FROM pizza;

#   post .../pizzak

  insert into pizza
    (nev, meret, ar)
    values 
    ('kiskutya', 22, 1500);

  #delete ../pizzak/1
  delete from pizza where id = 123;

  #put .../pizzak/2
    update pizza set nev = 'asddd', meret = 4534, ar = 345353535 where id = 118;
         