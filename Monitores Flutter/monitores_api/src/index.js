const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

const monitores = [
  {
    id: 1,
    nome: "Marcos",
    avatar: "https://t2.ea.ltmcdn.com/pt/posts/5/2/6/nomes_para_pato_de_estimacao_20625_6_600.jpg",
    horarios: [
      { dia: "Segunda", horario: "8:15 - 12:15" },
      { dia: "Segunda", horario: "18:15 - 19:00" },
      { dia: "Terça", horario: "7:30 - 10:00" },
      { dia: "Terça", horario: "18:15 - 19:00" },
      { dia: "Quarta", horario: "17:15 - 18:15" },
      { dia: "Sexta", horario: "8:15 - 9:00" },
      { dia: "Sexta", horario: "13:30 - 14:15" }
    ]
  },
  {
    id: 2,
    nome: "Grabalos",
    avatar: "https://www.petz.com.br/blog/wp-content/uploads/2021/08/pato-de-estimacao.jpg",
    horarios: [
      { dia: "Segunda", horario: "7:30 - 12:15" },
      { dia: "Terça", horario: "7:30 - 10:00" },
      { dia: "Quarta", horario: "7:30 - 8:00" },
      { dia: "Sexta", horario: "7:30 - 9:00" },
      { dia: "Sabado", horario: "10:00 - 12:15" }
    ]
  },
  {
    id: 3,
    nome: "Beatriz",
    avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCJ_ZeR0eLZZXcFZ_WmdM8bc5nQKMATsfTUMSjG03DRoWaglH1xCghmy5HRR6ANhYn_Xw&usqp=CAU",
    horarios: [
      { dia: "Segunda", horario: "7:30 - 13:00" },
      { dia: "Terça", horario: "7:30 - 9:00" },
      { dia: "Quarta", horario: "7:30 - 8:00" },
      { dia: "Sexta", horario: "7:30 - 9:00" }
    ]
  },
  {
    id: 4,
    nome: "Ricardo",
    avatar: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Amerikanische_Pekingenten_2013_01%2C_cropped.jpg/640px-Amerikanische_Pekingenten_2013_01%2C_cropped.jpg",
    horarios: [
      { dia: "Terça", horario: "19:00 - 20:00" },
      { dia: "quarta", horario: "20:30 - 22:15" },
      { dia: "quinta", horario: "15:00 - 16:00" },
      { dia: "quinta", horario: "21:30 - 22:15" },
      { dia: "Sexta", horario: "14:14 - 16:45" },
      { dia: "Sexta", horario: "20:30 - 22:15" },
      { dia: "Sabado", horario: "7:30 - 8:15" }
    ]
  },
  {
    id: 5,
    nome: "Anna",
    avatar: "https://upload.wikimedia.org/wikipedia/commons/f/ff/Anas_platyrhynchos_qtl1.jpg",
    horarios: [
      { dia: "segunda", horario: "13:30 - 14:15"},
      { dia: "Terça", horario: "8:15 - 12:15" },
      { dia: "Terça", horario: "13:30 - 14:15" },
      { dia: "quarta", horario: "8:15 - 12:15" },
      { dia: "quarta", horario: "13:30 - 14:15" },
      { dia: "quarta", horario: "16:45 - 17:30" },
      { dia: "quinta", horario: "13:30 - 14:15" },
      { dia: "Sexta", horario: "16:45 - 17:30" },
      { dia: "Sexta", horario: "16:45 - 17:30" },
    ]
  }
];

app.get('/monitores', (req, res) => {
  res.json(monitores);
});

app.get('/monitores/:id', (req, res) => {
  const monitor = monitores.find(m => m.id === parseInt(req.params.id));
  if (!monitor) return res.status(404).send('Monitor não encontrado');
  res.json(monitor);
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
