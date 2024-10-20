import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set LoginPage as the initial route
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Simple validation logic (replace with proper authentication)
    if (username == 'user' && password == '1234') {
      // Navigate to HomePage on successful login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Show error message
      setState(() {
        _errorMessage = 'Nom d\'utilisateur ou mot de passe incorrect';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _login,
                child: Text('Connexion'),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue dans l\'Application Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/home.jpg', // Replace with your image asset
              height: 250,
              width: 250,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => QuizHomePage()),
                );
              },
              child: Text('Démarrer le Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Quel est le langage de programmation utilisé pour développer des applications Android ?',
      'imageUrl': 'images/langage.jpg',
      'answers': [
        {'text': 'Java', 'score': 1},
        {'text': 'Python', 'score': 0},
        {'text': 'C#', 'score': 0},
        {'text': 'PHP', 'score': 0}
      ]
    },
    {
      'questionText': 'Que signifie "HTML" ?',
      'imageUrl': 'images/html.png',
      'answers': [
        {'text': 'HyperText Markup Language', 'score': 1},
        {'text': 'Hyper Transfer Management Language', 'score': 0},
        {'text': 'HighText Markup Language', 'score': 0},
        {'text': 'HyperLink Management Language', 'score': 0}
      ]
    },
    {
      'questionText': 'Quel est le système de gestion de version le plus utilisé ?',
      'imageUrl': 'images/systeme_gestion.jpg',
      'answers': [
        {'text': 'Git', 'score': 1},
        {'text': 'Subversion', 'score': 0},
        {'text': 'Mercurial', 'score': 0},
        {'text': 'Perforce', 'score': 0}
      ]
    },
    {
      'questionText': 'Quelle est la structure de base d’une base de données relationnelle ?',
      'imageUrl': 'images/base_donne.png',
      'answers': [
        {'text': 'Table', 'score': 1},
        {'text': 'Arborescence', 'score': 0},
        {'text': 'Pile', 'score': 0},
        {'text': 'Liste', 'score': 0}
      ]
    },
    {
      'questionText': 'Quel langage est principalement utilisé pour le développement web côté client ?',
      'imageUrl': 'images/cote_client.png',
      'answers': [
        {'text': 'JavaScript', 'score': 1},
        {'text': 'Ruby', 'score': 0},
        {'text': 'Python', 'score': 0},
        {'text': 'C++', 'score': 0}
      ]
    },
  ];

  int _questionIndex = 0;
  int _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });

    if (_questionIndex < _questions.length) {
      print('Il y a encore des questions!');
    } else {
      print('Quiz terminé!');
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(_totalScore, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageHeight = screenSize.height * 0.3; // 30% of screen height
    var imageWidth = screenSize.width * 0.8;  // 80% of screen width

    return Column(
      children: [
        Container(
          height: imageHeight,
          width: imageWidth,
          child: Image(
            image: AssetImage(questions[questionIndex]['imageUrl'] as String),
            fit: BoxFit.cover,
          ),
        ),
        Question(
          questions[questionIndex]['questionText'] as String,
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            () => answerQuestion(answer['score'] as int),
            answer['text'] as String,
          );
        }).toList()
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: ElevatedButton(
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore == 5) {
      resultText = 'Excellent!';
    } else if (resultScore >= 3) {
      resultText = 'Bien joué!';
    } else if (resultScore >= 1) {
      resultText = 'Pas mal!';
    } else {
      resultText = 'Réessayez!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Votre score est: $resultScore',
            style: TextStyle(fontSize: 24),
          ),
          TextButton(
            onPressed: resetHandler,
            child: Text('Recommencer le Quiz!'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
} 