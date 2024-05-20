import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqlHelper {
  static const String _databaseName = 'daregames.db';
  static final _lock = Lock();

//Patron de diseño singleton se crea una sola vez apartir de que se llama la instancia del constructor,
//si fuera get se crearia hasta que se manda a llamar el parametro.

  SqlHelper._privateConstructor();
  static final SqlHelper instance = SqlHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    await _lock.synchronized(() async {
      final path = await getDatabasesPath();
      _database = await openDatabase(
        join(path, _databaseName),
        version: 1,
        onDowngrade: onDatabaseDowngradeDelete,
        onCreate: _onCreate,
        onConfigure: _onConfigure,
        onOpen: _onOpen,
      );
    });

    return _database;
  }

  Future _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future _onCreate(Database db, int version) async {
    print('LocalDB -> Creating database version $version');
    await db.transaction(
      (txn) async {
        await txn
            .execute(
              'CREATE TABLE IF NOT EXISTS categories ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'name TEXT NOT NULL, '
              'identifier TEXT NOT NULL'
              ')',
            )
            .catchError(_error);

        await txn
            .execute(
              'CREATE TABLE IF NOT EXISTS levels ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'name TEXT NOT NULL, '
              'category_id INTEGER NOT NULL, '
              'FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE'
              ')',
            )
            .catchError(_error);

        await txn
            .execute(
              'CREATE TABLE IF NOT EXISTS preferences ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'preferences_text TEXT NOT NULL, '
              'identifier INTEGER NOT NULL, '
              'level_id INTEGER NOT NULL, '
              'category_id INTEGER NOT NULL, '
              'FOREIGN KEY (level_id) REFERENCES levels(id) ON DELETE CASCADE ON UPDATE CASCADE,'
              'FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE'
              ')',
            )
            .catchError(_error);

        await _insertIntoCategoriesQuery(txn);
        await _insertIntoLevelsQuery(txn);
        await _insertIntoPreferencesQuery(txn);
      },
    );
  }

  Future _onOpen(Database db) async {}

  Future<void> _insertIntoCategoriesQuery(Transaction txn) async {
    var categoryBactch = txn.batch();
    categoryBactch.insert('categories', {'name': 'Parejas', 'identifier': 'couples'});
    categoryBactch.insert('categories', {'name': '+ 18', 'identifier': 'adults_only'});
    categoryBactch.insert('categories', {'name': 'Para Todos', 'identifier': 'family'});
    categoryBactch.insert('categories', {'name': 'Verdad o Reto', 'identifier': 'truth_or_dare'});
    await categoryBactch.commit();
  }

  Future<void> _insertIntoLevelsQuery(Transaction txn) async {
    var levelBactch = txn.batch();
    //2
    levelBactch.insert('levels', {'name': '1', 'category_id': 2});
    levelBactch.insert('levels', {'name': '2', 'category_id': 2});
    levelBactch.insert('levels', {'name': '3', 'category_id': 2});
    levelBactch.insert('levels', {'name': '4', 'category_id': 2});
    levelBactch.insert('levels', {'name': '5', 'category_id': 2});
    levelBactch.insert('levels', {'name': '6', 'category_id': 2});
    levelBactch.insert('levels', {'name': '7', 'category_id': 2});
    levelBactch.insert('levels', {'name': '8', 'category_id': 2});
    levelBactch.insert('levels', {'name': '9', 'category_id': 2});
    levelBactch.insert('levels', {'name': '10', 'category_id': 2});
    levelBactch.insert('levels', {'name': '11', 'category_id': 2});
    levelBactch.insert('levels', {'name': '12', 'category_id': 2});
    levelBactch.insert('levels', {'name': '13', 'category_id': 2});
    levelBactch.insert('levels', {'name': '14', 'category_id': 2});
    levelBactch.insert('levels', {'name': '31', 'category_id': 2});
    levelBactch.insert('levels', {'name': '32', 'category_id': 2});
    levelBactch.insert('levels', {'name': '33', 'category_id': 2});
    levelBactch.insert('levels', {'name': '34', 'category_id': 2});
//3
    levelBactch.insert('levels', {'name': '15', 'category_id': 3});
    levelBactch.insert('levels', {'name': '16', 'category_id': 3});
    levelBactch.insert('levels', {'name': '17', 'category_id': 3});
    levelBactch.insert('levels', {'name': '18', 'category_id': 3});
    levelBactch.insert('levels', {'name': '19', 'category_id': 3});
    levelBactch.insert('levels', {'name': '20', 'category_id': 3});
    levelBactch.insert('levels', {'name': '21', 'category_id': 3});
    levelBactch.insert('levels', {'name': '22', 'category_id': 3});
    levelBactch.insert('levels', {'name': '23', 'category_id': 3});
    levelBactch.insert('levels', {'name': '24', 'category_id': 3});
    levelBactch.insert('levels', {'name': '25', 'category_id': 3});
    levelBactch.insert('levels', {'name': '26', 'category_id': 3});
    levelBactch.insert('levels', {'name': '27', 'category_id': 3});
    levelBactch.insert('levels', {'name': '28', 'category_id': 3});
    levelBactch.insert('levels', {'name': '29', 'category_id': 3});
    levelBactch.insert('levels', {'name': '30', 'category_id': 3});
    //4
    levelBactch.insert('levels', {'name': '35', 'category_id': 4});
    levelBactch.insert('levels', {'name': '36', 'category_id': 4});
    levelBactch.insert('levels', {'name': '37', 'category_id': 4});
    levelBactch.insert('levels', {'name': '38', 'category_id': 4});
    levelBactch.insert('levels', {'name': '39', 'category_id': 4});
    levelBactch.insert('levels', {'name': '40', 'category_id': 4});
    levelBactch.insert('levels', {'name': '41', 'category_id': 4});
    levelBactch.insert('levels', {'name': '42', 'category_id': 4});

    levelBactch.insert('levels', {'name': '43', 'category_id': 4});
    levelBactch.insert('levels', {'name': '44', 'category_id': 4});
    levelBactch.insert('levels', {'name': '45', 'category_id': 4});
    levelBactch.insert('levels', {'name': '46', 'category_id': 4});
    levelBactch.insert('levels', {'name': '47', 'category_id': 4});
    levelBactch.insert('levels', {'name': '48', 'category_id': 4});
    levelBactch.insert('levels', {'name': '49', 'category_id': 4});
    levelBactch.insert('levels', {'name': '50', 'category_id': 4});

    //1
    levelBactch.insert('levels', {'name': '51', 'category_id': 1});
    levelBactch.insert('levels', {'name': '52', 'category_id': 1});
    levelBactch.insert('levels', {'name': '53', 'category_id': 1});
    levelBactch.insert('levels', {'name': '54', 'category_id': 1});
    levelBactch.insert('levels', {'name': '55', 'category_id': 1});
    levelBactch.insert('levels', {'name': '56', 'category_id': 1});
    levelBactch.insert('levels', {'name': '57', 'category_id': 1});
    levelBactch.insert('levels', {'name': '58', 'category_id': 1});
    levelBactch.insert('levels', {'name': '59', 'category_id': 1});
    levelBactch.insert('levels', {'name': '60', 'category_id': 1});
    levelBactch.insert('levels', {'name': '61', 'category_id': 1});
    levelBactch.insert('levels', {'name': '62', 'category_id': 1});
    levelBactch.insert('levels', {'name': '63', 'category_id': 1});
    levelBactch.insert('levels', {'name': '64', 'category_id': 1});
    levelBactch.insert('levels', {'name': '65', 'category_id': 1});
    levelBactch.insert('levels', {'name': '66', 'category_id': 1});

    await levelBactch.commit();
  }

  Future<void> _insertIntoPreferencesQuery(Transaction txn) async {
    var preferencesTextBactch = txn.batch();

    final List<Map<String, dynamic>> json = [
      {'preferences_text': 'Que tu abuela vea un vídeo sexual tuyo', 'level_id': 1, 'category_id': 2, 'identifier': 1},
      {'preferences_text': 'Que alguien lo suba a Facebook durante 5 minutos', 'level_id': 1, 'category_id': 2, 'identifier': 1},
      {'preferences_text': 'Ser virgen hasta los 40 y después tener un sexo increíble', 'level_id': 2, 'category_id': 2, 'identifier': 2},
      {'preferences_text': 'Tener sexo mediocre toda tu vida', 'level_id': 2, 'category_id': 2, 'identifier': 2},
      {'preferences_text': 'Que tus padres te vean manteniendo relaciones', 'level_id': 3, 'category_id': 2, 'identifier': 3},
      {'preferences_text': 'Ver a tus padres teniendo relaciones', 'level_id': 3, 'category_id': 2, 'identifier': 3},
      {'preferences_text': 'Tener sexo durante 1 minuto', 'level_id': 4, 'category_id': 2, 'identifier': 4},
      {'preferences_text': 'Tener sexo durante 10 horas seguidas', 'level_id': 4, 'category_id': 2, 'identifier': 4},
      {'preferences_text': 'Tener relaciones con tu jefe sin que nadie se entere ', 'level_id': 5, 'category_id': 2, 'identifier': 5},
      {'preferences_text': 'No tenerlas pero que todo el mundo piense que sí.', 'level_id': 5, 'category_id': 2, 'identifier': 5},
      {'preferences_text': 'Tener mucho placer pero ser incapaz de darlo', 'level_id': 6, 'category_id': 2, 'identifier': 6},
      {'preferences_text': 'No sentir placer pero dar mucho al otro', 'level_id': 6, 'category_id': 2, 'identifier': 6},
      {'preferences_text': 'Estar 1 año en tu trabajo cobrando 5 veces más', 'level_id': 7, 'category_id': 2, 'identifier': 7},
      {'preferences_text': 'Estar un año sin trabajar pero cobrando la mitad.', 'level_id': 7, 'category_id': 2, 'identifier': 7},
      {'preferences_text': 'Tener 10 hijos', 'level_id': 8, 'category_id': 2, 'identifier': 8},
      {'preferences_text': 'No tener ninguno', 'level_id': 8, 'category_id': 2, 'identifier': 8},
      {'preferences_text': 'Que nadie se presente a tu boda', 'level_id': 9, 'category_id': 2, 'identifier': 9},
      {'preferences_text': 'Que nadie se presente a tu funeral', 'level_id': 9, 'category_id': 2, 'identifier': 9},
      {'preferences_text': 'Perder 1 millón', 'level_id': 10, 'category_id': 2, 'identifier': 10},
      {'preferences_text': 'Que la persona que más odies gane 1 millón', 'level_id': 10, 'category_id': 2, 'identifier': 10},
      {'preferences_text': 'Tener la apariencia de un niño de 10 años toda la vida', 'level_id': 11, 'category_id': 2, 'identifier': 11},
      {'preferences_text': 'Tener la apariencia de un señor de 70', 'level_id': 11, 'category_id': 2, 'identifier': 11},
      {'preferences_text': 'No poder beber cerveza nunca más', 'level_id': 12, 'category_id': 2, 'identifier': 12},
      {'preferences_text': 'Solo beber cerveza durante toda la vida', 'level_id': 12, 'category_id': 2, 'identifier': 12},
      {'preferences_text': 'Tener una casa diminuta', 'level_id': 13, 'category_id': 2, 'identifier': 13},
      {'preferences_text': 'Tener una casa enorme pero no poder salir de ella', 'level_id': 13, 'category_id': 2, 'identifier': 13},
      {'preferences_text': 'No salir nunca de tu ciudad', 'level_id': 14, 'category_id': 2, 'identifier': 14},
      {'preferences_text': 'Salir pero no poder volver nunca más', 'level_id': 14, 'category_id': 2, 'identifier': 14},
      {'preferences_text': 'Creer que tu pareja te es infiel sin que lo sea', 'level_id': 31, 'category_id': 2, 'identifier': 15},
      {'preferences_text': 'Que tu pareja te sea infiel sin que te enteres', 'level_id': 31, 'category_id': 2, 'identifier': 15},
      {'preferences_text': 'Tener la boca en el culo', 'level_id': 32, 'category_id': 2, 'identifier': 16},
      {'preferences_text': 'El culo en la boca', 'level_id': 32, 'category_id': 2, 'identifier': 16},
      {'preferences_text': 'Tener la nariz en el cogote', 'level_id': 33, 'category_id': 2, 'identifier': 17},
      {'preferences_text': 'Tener la nariz en la rodilla', 'level_id': 33, 'category_id': 2, 'identifier': 17},
      {'preferences_text': 'Llegar muy tarde a tu boda', 'level_id': 34, 'category_id': 2, 'identifier': 18},
      {'preferences_text': 'Que tu pareja llegue muy tarde a tu boda', 'level_id': 34, 'category_id': 2, 'identifier': 18},
      //
      //
      {'preferences_text': 'Pasar un año a 40º ', 'level_id': 15, 'category_id': 3, 'identifier': 1},
      {'preferences_text': 'Pasar un año a -10º', 'level_id': 15, 'category_id': 3, 'identifier': 1},
      {'preferences_text': 'Comer una caca con sabor a pastel', 'level_id': 16, 'category_id': 3, 'identifier': 2},
      {'preferences_text': 'Pastel con sabor a caca', 'level_id': 16, 'category_id': 3, 'identifier': 2},
      {'preferences_text': 'Morir quemado', 'level_id': 17, 'category_id': 3, 'identifier': 3},
      {'preferences_text': 'Morir congelado', 'level_id': 17, 'category_id': 3, 'identifier': 3},
      {'preferences_text': 'Tener el cuello como una jirafa', 'level_id': 18, 'category_id': 3, 'identifier': 4},
      {'preferences_text': 'Tener la nariz como un elefante.', 'level_id': 18, 'category_id': 3, 'identifier': 4},
      {'preferences_text': 'Tener 3 piernas', 'level_id': 19, 'category_id': 3, 'identifier': 5},
      {'preferences_text': 'Tener 3 brazos', 'level_id': 19, 'category_id': 3, 'identifier': 5},
      {'preferences_text': 'Qué mañana tengas un bebé', 'level_id': 20, 'category_id': 3, 'identifier': 6},
      {'preferences_text': 'No poder tenerlo hasta los 65', 'level_id': 20, 'category_id': 3, 'identifier': 6},
      {'preferences_text': 'Pasar 5 años en la cárcel ', 'level_id': 22, 'category_id': 3, 'identifier': 7},
      {'preferences_text': '10 años en coma', 'level_id': 22, 'category_id': 3, 'identifier': 7},
      {'preferences_text': 'Oler muy mal sin que tu te des cuenta ', 'level_id': 23, 'category_id': 3, 'identifier': 8},
      {'preferences_text': 'Sentir un olor asqueroso constantemente sin que nadie más se de cuenta', 'level_id': 23, 'category_id': 3, 'identifier': 8},
      {'preferences_text': 'No cambiarte la ropa en 1 mes', 'level_id': 24, 'category_id': 3, 'identifier': 9},
      {'preferences_text': 'No ducharte en 1 mes', 'level_id': 24, 'category_id': 3, 'identifier': 9},
      {'preferences_text': 'Comerte un huevo podrido', 'level_id': 25, 'category_id': 3, 'identifier': 10},
      {'preferences_text': 'Beberte leche pasada', 'level_id': 25, 'category_id': 3, 'identifier': 10},
      {'preferences_text': 'Que siempre te huela el aliento', 'level_id': 26, 'category_id': 3, 'identifier': 11},
      {'preferences_text': 'Que siempre te huelan las axilas', 'level_id': 26, 'category_id': 3, 'identifier': 11},
      {'preferences_text': 'Hacer caca 10 veces al día', 'level_id': 27, 'category_id': 3, 'identifier': 12},
      {'preferences_text': 'Hacer cada 1 vez cada 2 semanas', 'level_id': 27, 'category_id': 3, 'identifier': 12},
      {'preferences_text': 'Quitar con las manos comida podrida del fregadero', 'level_id': 28, 'category_id': 3, 'identifier': 13},
      {'preferences_text': 'No lavarte las manos en 1 semana.', 'level_id': 28, 'category_id': 3, 'identifier': 13},
      {'preferences_text': 'No llevar nunca más ropa interior', 'level_id': 29, 'category_id': 3, 'identifier': 14},
      {'preferences_text': 'Solo poder llevar ropa interior usada', 'level_id': 29, 'category_id': 3, 'identifier': 14},
      {'preferences_text': 'Estar 1 semana en tu ciudad acompañado de la persona de tus sueños', 'level_id': 30, 'category_id': 3, 'identifier': 15},
      {'preferences_text': '1 semana en el lugar de tus sueños solo', 'level_id': 30, 'category_id': 3, 'identifier': 15},
      //
      //
      {'preferences_text': '¿Quién fue la última persona que besaste?', 'level_id': 35, 'category_id': 4, 'identifier': 1},
      {'preferences_text': 'Confiésale tus sentimientos a tu crush por mensaje', 'level_id': 35, 'category_id': 4, 'identifier': 1},
      {'preferences_text': '¿Has creado un perfil falso en Instagram para stalkear?', 'level_id': 36, 'category_id': 4, 'identifier': 2},
      {'preferences_text': 'Confiésale tus sentimientos a tu crush por mensaje', 'level_id': 36, 'category_id': 4, 'identifier': 2},
      {'preferences_text': '¿Serías capaz de matar a alguien por amor?', 'level_id': 37, 'category_id': 4, 'identifier': 3},
      {'preferences_text': 'Muestra tu mensaje más HOT', 'level_id': 37, 'category_id': 4, 'identifier': 3},
      {'preferences_text': '¿Te consideras una persona superficial?', 'level_id': 38, 'category_id': 4, 'identifier': 4},
      {'preferences_text': 'Llámale a tu peor enemigo y dile que lo amas', 'level_id': 38, 'category_id': 4, 'identifier': 4},
      {'preferences_text': '¿Alguna vez has sido infiel?', 'level_id': 39, 'category_id': 4, 'identifier': 5},
      {'preferences_text': 'Haz 100 sentadillas', 'level_id': 39, 'category_id': 4, 'identifier': 5},
      {'preferences_text': '¿Cuál es el secreto que nunca le has contado a nadie?', 'level_id': 40, 'category_id': 4, 'identifier': 6},
      {'preferences_text': 'Brinca durante 3 minutos', 'level_id': 40, 'category_id': 4, 'identifier': 6},
      {'preferences_text': '¿Qué es lo más extraño que has comido?', 'level_id': 41, 'category_id': 4, 'identifier': 7},
      {'preferences_text': 'Bebe una cerveza en 30 segundos', 'level_id': 41, 'category_id': 4, 'identifier': 7},
      {'preferences_text': '¿Cuál es la peor experiencia íntima que has tenido?', 'level_id': 42, 'category_id': 4, 'identifier': 8},
      {'preferences_text': 'Baila sexy', 'level_id': 42, 'category_id': 4, 'identifier': 8},
      {'preferences_text': '¿Cuál es tu mayor inseguridad?', 'level_id': 43, 'category_id': 4, 'identifier': 9},
      {'preferences_text': 'Pela un plátano con los dedos de los pies', 'level_id': 43, 'category_id': 4, 'identifier': 9},
      {'preferences_text': '¿Cuál es el sueño más extraño que has tenido?', 'level_id': 44, 'category_id': 4, 'identifier': 10},
      {'preferences_text': 'Come una cucharada de sal', 'level_id': 44, 'category_id': 4, 'identifier': 10},
      {'preferences_text': '¿Cuál es el sueño más extraño que has tenido?', 'level_id': 45, 'category_id': 4, 'identifier': 11},
      {'preferences_text': 'Muestra la última nude que mandaste', 'level_id': 45, 'category_id': 4, 'identifier': 11},
      {'preferences_text': '¿Por qué se rompió tu última relación?', 'level_id': 46, 'category_id': 4, 'identifier': 12},
      {'preferences_text': 'Cortarte un mechón de pelo', 'level_id': 46, 'category_id': 4, 'identifier': 12},
      {'preferences_text': '¿Cuál es el rumor más extraño que has escuchado sobre ti?', 'level_id': 47, 'category_id': 4, 'identifier': 13},
      {'preferences_text': 'Canta a capela tu canción favorita', 'level_id': 47, 'category_id': 4, 'identifier': 13},
      {'preferences_text': '¿Cuál es tu combinación de alimentos asquerosos favorita?', 'level_id': 48, 'category_id': 4, 'identifier': 14},
      {'preferences_text': 'Muestra tu talento secreto', 'level_id': 48, 'category_id': 4, 'identifier': 14},
      {'preferences_text': 'De este grupo, ¿quién se te hace más sexy?', 'level_id': 49, 'category_id': 4, 'identifier': 15},
      {'preferences_text': 'Enseñar tu historial de Google', 'level_id': 49, 'category_id': 4, 'identifier': 15},
      {'preferences_text': '¿Cuál ha sido la peor vergüenza que has pasado en público?', 'level_id': 50, 'category_id': 4, 'identifier': 16},
      {'preferences_text': 'Toma 5 shots seguidos', 'level_id': 50, 'category_id': 4, 'identifier': 16},
      //
      //
      {'preferences_text': '¿Qué sientes cuando nos besamos y nos abrazamos?', 'level_id': 51, 'category_id': 1, 'identifier': 1},
      {'preferences_text': '¿En qué momento notaste que yo te gustaba?', 'level_id': 51, 'category_id': 1, 'identifier': 1},
      {'preferences_text': 'Cuando despiertas a mi lado, ¿qué es lo primero que pasa por tu cabeza?', 'level_id': 52, 'category_id': 1, 'identifier': 2},
      {'preferences_text': '¿Crees que podríamos mantener una relación a distancia?', 'level_id': 52, 'category_id': 1, 'identifier': 2},
      {'preferences_text': '¿Cómo te sientes cuando pasamos un largo período de tiempo separados?', 'level_id': 53, 'category_id': 1, 'identifier': 3},
      {'preferences_text': '¿Crees en el amor a primera vista o en las almas gemelas', 'level_id': 53, 'category_id': 1, 'identifier': 3},
      {'preferences_text': '¿Cuál fue tu primera impresión cuando me viste por primera vez?', 'level_id': 54, 'category_id': 1, 'identifier': 4},
      {'preferences_text': '¿Qué fue lo que más te llamó la atención cuando me viste por primera vez?', 'level_id': 54, 'category_id': 1, 'identifier': 4},
      {'preferences_text': '¿Cómo describirías mi forma de besar?', 'level_id': 55, 'category_id': 1, 'identifier': 5},
      {'preferences_text': '¿Qué es lo que más te gusta de mi cuerpo?', 'level_id': 55, 'category_id': 1, 'identifier': 5},
      {'preferences_text': '¿Cuál de mis defectos crees que es más gracioso?', 'level_id': 56, 'category_id': 1, 'identifier': 6},
      {'preferences_text': '¿Dónde prefieres que te bese?', 'level_id': 56, 'category_id': 1, 'identifier': 6},
      {'preferences_text': '¿Podrías describir mi olor?', 'level_id': 57, 'category_id': 1, 'identifier': 7},
      {'preferences_text': '¿Hay algo que no te guste de mi?', 'level_id': 57, 'category_id': 1, 'identifier': 7},
      {'preferences_text': 'Si tuvieras que describirme en tres palabras, ¿cuáles serían?', 'level_id': 58, 'category_id': 1, 'identifier': 8},
      {'preferences_text': '¿Sonríes cuando recibes un mensaje mío en el celular?', 'level_id': 58, 'category_id': 1, 'identifier': 8},
      {'preferences_text': '¿Qué tipo de ropa interior te gusta usar?', 'level_id': 59, 'category_id': 1, 'identifier': 9},
      {'preferences_text': '¿Qué parte de tu cuerpo te gusta más?', 'level_id': 59, 'category_id': 1, 'identifier': 9},
      {'preferences_text': '¿Qué es lo más vergonzoso que has hecho en una fiesta?', 'level_id': 60, 'category_id': 1, 'identifier': 10},
      {'preferences_text': '¿Por qué se rompió tu última relación?', 'level_id': 60, 'category_id': 1, 'identifier': 10},
      {'preferences_text': '¿Alguna vez has enviado nudes?', 'level_id': 61, 'category_id': 1, 'identifier': 11},
      {'preferences_text': '¿Has tenido amigas con derecho?', 'level_id': 61, 'category_id': 1, 'identifier': 11},
      {'preferences_text': '¿Cómo sería un día perfecto para ti?', 'level_id': 62, 'category_id': 1, 'identifier': 12},
      {'preferences_text': '¿Qué es la cosa más estúpida que has hecho en tu vida?', 'level_id': 62, 'category_id': 1, 'identifier': 12},
      {'preferences_text': '¿Qué actividad te hace sentir más feliz?', 'level_id': 63, 'category_id': 1, 'identifier': 13},
      {'preferences_text': '¿Dónde te refugiarías en un mal momento?', 'level_id': 63, 'category_id': 1, 'identifier': 13},
      {'preferences_text': '¿Qué tipo de música te pones para animarte?', 'level_id': 64, 'category_id': 1, 'identifier': 14},
      {'preferences_text': '¿Qué serie o película te hace reír siempre?', 'level_id': 64, 'category_id': 1, 'identifier': 14},
      {'preferences_text': '¿Serías capaz de hacer algo caliente en el cine?', 'level_id': 65, 'category_id': 1, 'identifier': 15},
      {'preferences_text': '¿Qué opinas de las relaciones abiertas?', 'level_id': 65, 'category_id': 1, 'identifier': 15},
      {'preferences_text': '¿Te gustaría hacerlo en un sitio público?', 'level_id': 66, 'category_id': 1, 'identifier': 16},
      {'preferences_text': '¿Tienes algún fetiche?', 'level_id': 66, 'category_id': 1, 'identifier': 16},
    ];

    for (var item in json) {
      preferencesTextBactch.insert('preferences', item);
    }

    await preferencesTextBactch.commit();
  }

  void _error(dynamic error) {
    print('LocalDB -> Error:$error');
  }
}
