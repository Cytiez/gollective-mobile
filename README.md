TUGAS 7
1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child bekerja antar widget.
    Widget tree adalah struktur hierariki yang menyusun semua elemen UI di Flutter, mulai dari widget paling atas sampai komponen terkecil seperti Text dan Icon. Setiap widget menjadi parent bagi widget di dalamnya, widget yang di dalam disebut child. Hubungan ini menentukan letak, dan pewarisan data, serta siklus build. Parent bertanggung jawab mengatur posisi atau ukuran child dan memanggil build() untuk merender ulang ketika diperlukan. Child dapat membaca konteks dari praent melalui BuildContext, contohnya Theme.of(context) atau ScaffoldMessenger.of(context). Perubahan pada parent biasanya memicu rebuild pada subtree anak,sehingga struktur tree dan pemisahan widget yang tepat penting untuk performa.

2. Widget yang digunakan di proyek ini dan fungsinya
    - MyHomePage(StatelessWidget) -> Halaman utaman yang merender struktur UI statis berbasis data sederhana.
    - Scaffold -> Kerangka dasar halaman Material
    - AppBar -> Header bagian atas menampilkan judul aplikasi.
    - Text -> Menampilkan text, termasuk judul dan labe tombol atau kartu
    - Padding atau EdgeInserts: Memberi jarak di sekitar widget agar letaknya rapi.
    - Column atau Row -> Menyusun widget secara vertikal dan horizontal
    - Center -> Buat child agar ada di tengah area
    - SizedBox -> Memberi jarak kosong vertikal atau horizontal secara eksplisit
    - GridView.count -> Menyusun item dalam grid dengan jumlah kolom tertentu
    - Card -> Kartu Material dengan elevasi untuk kkonten informasi
    - Container -> Pembungkus serbaguna untuk ukuran, padding, dan styling sederhana
    - MediaQuery -> Mengambil ukuran layar untuk perhitungan lebar kartu responsif
    - Icon -> Menampilkan ikon Material pada kartu item
    - InkWell -> Deteksi sentuhan dan menampilkan efek ripple
    - SnackBar -> Notifikasi singkat di bagian bawah layar saat item ditekan
    - ScaffoldMesenger -> Menampilkan SnackBar terkait Scaffold uang aktif
    - Theme.of(context).colorScheme -> Mengambil warna dari tema aplikasi untuk konsistensi desain.
    - Color -> Mendefinisikan warna khusus untuk tiap tombol
    - ItemHomepage (class model) -> Struktur data nama, ikon, dan warna setiap item grid.
    - ItemCard, InfoCard(StatelessWidget) -> Komponen presentasi untuk kartu item dan kartu info

3. Fungsi MaterialApp dan mengapa sering jadi root
    MaterialApp adalah widget pembungkus tingkat atas yang menyiapkan lingkungan Material Design: tema (ThemeData), routing/navigasi, lokalitas, dan integrasi komponen Material. Dengan MaterialApp, widget turunan dapat memanfaatkan Theme.of(context), Navigator, dan ScaffoldMessenger tanpa konfigurasi manual. Ia juga menyediakan pengaturan global seperti title, debugShowCheckedModeBanner, dan home untuk halaman pertama. Karena menjadi sumber InheritedWidget penting (tema, navigator, dsb.), MaterialApp hampir selalu dipakai sebagai root pada aplikasi berbasis Material. Pada proyek ini, biasanya MyHomePage akan dipasang sebagai home di dalam MaterialApp.

4. Perbedaan StatelessWidget dan StatefulWidget dan kapan memilihnya?
    StatelessWidget tidak menyimpan state internal yang berubah-ubah; UI-nya murni diturunkan dari properti dan data eksternal (immutable). StatefulWidget memiliki objek State yang dapat berubah selama umur widget melalui setState, sehingga cocok untuk interaksi, animasi sederhana, atau data yang dinamis. Pilih StatelessWidget saat tampilan cukup statis atau perubahan hanya datang dari atas (mis. parameter). Pilih StatefulWidget saat kamu butuh menyimpan/merubah state lokal seperti input pengguna, pemuatan data asinkron, atau toggling UI. Pada kode ini, MyHomePage, ItemCard, dan InfoCard adalah StatelessWidget karena kontennya diturunkan dari data yang relatif tetap.

5. Apa itu BuildContext, mengapa penting, dan pengunaannya di build
    BuildContext merepresentasikan posisi sebuah widget di dalam widget tree dan menjadi “kunci” untuk mengakses data yang diwariskan oleh parent (InheritedWidget). Melalui context, widget dapat memperoleh tema (Theme.of(context)), navigator, ScaffoldMessenger, ukuran media (MediaQuery), dan lain-lain. Di metode build, context dipakai untuk mengambil resource/servis yang relevan dengan lokasi widget saat ini, sehingga hasilnya konsisten dengan subtree tempat widget berada. Pada kode ini, contoh penggunaannya adalah Theme.of(context).colorScheme.primary untuk warna AppBar dan ScaffoldMessenger.of(context) untuk menampilkan SnackBar. Menjaga context yang tepat (misalnya tidak memakai context parent yang salah) penting agar panggilan seperti ScaffoldMessenger.of(context) menemukan Scaffold yang sesuai.

6. Konsep 'hot reload' dan 'hot start'
    Hot reload menyuntikkan perubahan kode ke VM dan me-rebuild widget tree tanpa me-reset state aplikasi saat ini, sehingga sangat cepat untuk iterasi UI dan logika tampilan. Ini ideal ketika kamu mengubah layout, gaya, atau implementasi build() tanpa perlu mengulang alur pengguna. Hot restart me-restart aplikasi dari awal, me-recreate state, dan menjalankan ulang main(), sehingga semua state sementara hilang. Gunakan hot restart jika perubahanmu tidak terdeteksi oleh hot reload (mis. perubahan pada main(), inisialisasi global, perubahan tipe besar) atau saat state sudah “kusut”. Dalam praktik, alur kerja umum adalah hot reload untuk iterasi cepat, dan hot restart sesekali untuk “menyegarkan” seluruh aplikasi.

TUGAS 8
1.  Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
    Navigator.push() akan menambahkan halaman baru di atas stack tanpa menghapus halaman sebelumnya, sedangakan Navigator.pushReplacement() akan mengganti halaman saat ini dengan halaman baru. Pada Navigator.push() user dapat kembali ke halaman sebelumnya dengan tombol back, sedangkan pada Navigator.pushReplacement() user tidak dapat kembali ke halaman sebelumnya karena sudah diganti.

    Navigator.push():
    Dari home ke Add Product lewat grid dan lewat drawer. Karena setelah mengisi ataupun batal mengesi form user akan kembali ke halaman hme.
    Navigator.pushReplacement():
    Dari halaman manapun ke Home lewat drawer. Karena jika memilih Home biasanya User tidak akan kembali ke halaman sebelumnya. Biasanya juga akan digunakan di Splash Screen, Login/Register.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
    di main.dart:
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueAccent[400]),
        ),
        home: MyHomePage(),
        );
    Pada bagian ini MaterialApp menjadi root aplikasi yang mengatur tema global dan halaman awal. Dengan begitu semua halaman yang dibagun di atasnya otomatis mengikuti style Material dan tema yang sama.

    Baik di MyHomePage(menu.dart) maupun di ProductFormPage selalu menggunakan:
    return Scaffold(
        appBar: AppBar(...),
        drawer: LeftDrawer(),
        body: ...
        );
    Scaffold ini merupakan kerangka layout: ada area khusus untuk AppBar, Drawer, body, floatingActionButton, dll. Dengan selalu membungkus setiap halaman menggunakan Scaffold, kita memastikan setiap halaman memiliki struktur dasar yang sama.

    Pada AppBarr
    appBar: AppBar(
        title: const Text(
            'Gollective',
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        ),

    appBar: AppBar(
        title: const Center(child: Text('Add News Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        ),

    Menampilkan judul halaman. Menjaga warna dan style yang cukup konsisten.

    di Drawer. Saya tidak membuat drawer baru di setiap page, tapi dengan ekstrak menjadi widget LeftDrawer yang dapat digunakan ulang.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
    Padding
    Kelebihan:
    - Memberi ruang kosong di sekeliling elemen form sehingga tampilan tidak menempel dengan pinggir layar.
    - Membuat teks label, input, dan tombol lebih mudah dibaca dan disentuh, penting untuk usability
    - Membantu membangun hierarki visual elemen yang satu blok bisa punya padding seragam sehingga terasa satu kelompok
    contoh:
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            decoration: InputDecoration(
            hintText: "Product Name",
            labelText: "Product Name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
            ),
            ),
            // ...
        ),
        ),
    Setiap TextFormField, DropdownButtonFormField, dan SwitchListTile dibungkus dengan Padding(all: 8.0). Ini membuat tiap field memiliki jarak yang konsisten, sehingga form panjang tetap terasa terstruktur, tidak sesak, dan user bisa fokus ke satu field per satu waktu tanpa distraksi visual.

    SingleChildScrollView
    Kelebihan:
    - Mengizinkan seluruh halaman discroll ketika konten form lebih panjang dari tinggi layar.
    - Menghindari error "Bottom overflowed by xx pixels" ketika keyboard muncul dan menutupi bagian bawah form.
    - Cocok untuk form yang ridak telalu dinamis tapi panjang, seperti form produk yang memiliki banyak field
    contoh:
    body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                // semua Padding(TextFormField / Dropdown / Switch) di sini
            ],
            ),
        ),
        ),
    Seluruh isi form dibungkus oleh SingleChildScrollView. Artinya, meskipun form panjang (name, description, category, price, club, season, year, condition, authenticity, thumbnail, featured, tombol Save), user tetap bisa scroll sampai bawah di HP kecil, bahkan ketika keyboard lagi terbuka. Tanpa ini, bagian bawah form seperti tombol Save bisa ketutupan dan tidak bisa diakses.

    ListView
    Kelebihan:
    - Mirip Column + scroll, tetapi ListView memiliki kemampuan scrolling bawaan dan lebih efisien untuk list panjang atau dinamis.
    - Enak dipakai jika isi form atau daftar elemen berasal dari daftar (list) yang jumlahnya bisa berubah atau banyak.
    Contoh:
    return Drawer(
        child: ListView(
            children: [
            const DrawerHeader(...),
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () { ... },
            ),
            ListTile(
                leading: const Icon(Icons.post_add),
                title: const Text('Add Product'),
                onTap: () { ... },
            ),
            ],
        ),
        );
    Di LeftDrawer, menggunakan ListView untuk menampilkan menu navigasi (DrawerHeader, ListTile Home, ListTile Add Product). Ini cocok karena konten drawer memang berupa daftar dan harus bisa di-scroll kalau menu nanti makin banyak. Kalau suatu saat memiliki form yang elemen-elemen-nya di-generate dari list (misal banyak pilihan fitur jersey, banyak input dinamis), dapat mengganti Column + SingleChildScrollView menjadi satu ListView agar struktur tetap rapi dan mudah discroll.

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
    Penyesuaian warna tema dilakukan dengan mendefinisikan **palet warna brand** di ThemeData pada MaterialApp, terutama melalui colorScheme dan appBarTheme, sehingga warna utama (primary) dan aksen (secondary) konsisten di seluruh aplikasi. Setelah itu, widget seperti AppBar, Scaffold, DrawerHeader, dan ElevatedButton tidak lagi menggunakan warna hardcode, tetapi mengambil warna dari Theme.of(context).colorScheme. Contohnya, AppBar pada MyHomePage dan DrawerHeader pada LeftDrawer sama-sama menggunakan colorScheme.primary, sehingga identitas visual Football Shop tetap konsisten di setiap halaman.
.

TUGAS 9
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model? 
    Membuat model Dart (seperti class Products yang saya buat) berfungsi sebagai "cetakan" atau contract untuk data yang kita pertukarkan dengan server.

    - Type Safety: Dart adalah bahasa yang ketat tipe. Model memastikan bahwa harga diperlakukan sebagai int, nama sebagai String, dan status autentikasi sebagai bool sejak awal. Jika ada ketidakcocokan tipe, error akan muncul saat kompilasi, bukan saat aplikasi dijalankan pengguna.
    - Struktur Data yang Jelas: Dengan model, kita tidak perlu menebak-nebak nama key (misal: apakah club_name atau clubName) karena sudah didefinisikan sebagai properti class. Fitur autocomplete di IDE juga sangat membantu.
    - Konsekuensi tanpa model: Jika kita hanya mengandalkan Map<String, dynamic>, kita rentan melakukan typo pada nama key (misal data['pric'] bukannya data['price']) yang akan menyebabkan runtime error. Selain itu, validasi data menjadi manual dan kode menjadi sulit dibaca serta di-maintain karena struktur datanya tidak eksplisit.

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.

    - Package http: Ini adalah pustaka dasar untuk melakukan permintaan jaringan (HTTP requests) seperti GET, POST, PUT, DELETE. Fungsinya hanya untuk mengirim data ke server dan menerima respons. Namun, http bersifat stateless, artinya ia tidak menyimpan data sesi atau cookie antar permintaan secara otomatis.
    - Package pbp_django_auth (CookieRequest): Ini adalah wrapper atau lapisan tambahan di atas http yang dirancang khusus untuk menangani autentikasi Django. Fungsi utamanya adalah manajemen Cookie dan Session.
    - Perbedaan: Saat login, Django mengirimkan session ID via cookie. Jika menggunakan http biasa, kita harus menangkap dan mengirim balik cookie ini secara manual di setiap request berikutnya. CookieRequest melakukan hal ini secara otomatis. Ia menyimpan cookie sesi login sehingga server mengenali siapa pengguna yang sedang mengakses data (request.user di Django tidak anonymous).

3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
    Instance CookieRequest harus bersifat Singleton (satu objek yang sama dipakai bersama) atau dibagikan melalui state management (seperti Provider yang saya gunakan di main.dart) agar status login pengguna konsisten. Jika saya membuat instance CookieRequest baru di setiap halaman (misal di halaman Login buat baru, di halaman Form buat baru lagi), maka cookie sesi login yang didapat saat login akan hilang di halaman lain. Akibatnya, pengguna akan dianggap belum login (logout) setiap kali berpindah halaman. Dengan membagikan satu instance, cookie jar-nya tetap sama di seluruh aplikasi.

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django.
    - 10.0.2.2 pada Android Emulator: Emulator Android berjalan di jaringan virtual (VM). IP localhost (127.0.0.1) di dalam emulator merujuk pada emulator itu sendiri. Untuk mengakses localhost komputer host (tempat Django berjalan), Android menyediakan alias IP khusus 10.0.2.2.
    - ALLOWED_HOSTS: Django secara default memblokir request dari host yang tidak dikenal. Menambahkan 10.0.2.2 mengizinkan Django menerima request yang berasal dari emulator.
    - CORS (Cross-Origin Resource Sharing): Karena Flutter (terutama web) dan server Django dianggap berasal dari origin yang berbeda, browser/klien akan memblokir akses. Mengaktifkan CORS (django-cors-headers) memberitahu browser/klien bahwa Flutter diizinkan mengambil data dari Django.
    - Izin Internet: Di Android, aplikasi di-sandbox dan tidak boleh akses internet secara default. Kita wajib menambahkan <uses-permission android:name="android.permission.INTERNET" /> di AndroidManifest.xml.
    - Akibat jika salah: Aplikasi akan mengalami error koneksi seperti SocketException: Connection refused, data tidak akan muncul, atau login selalu gagal karena cookie ditolak.

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
    1. Input: Pengguna mengisi data di ProductFormPage (nama, harga, klub, musim, dll). Validasi form berjalan di sisi Flutter.
    2. Serialisasi & Kirim: Data dikonversi menjadi JSON (jsonEncode) dan dikirim via request.postJson ke endpoint Django (misal: /create-flutter/).
    3. Proses Server: Django menerima JSON, memvalidasi, membuat objek model Product, menyimpannya ke database, dan mengembalikan respons sukses.
    4. Fetch Data: Setelah sukses, pengguna kembali ke halaman list. Di sini, FutureBuilder memanggil fungsi fetchProducts yang melakukan GET request ke endpoint JSON Django.
    5. Deserialisasi & Tampil: Respons JSON dari server diubah kembali menjadi objek Dart (Product.fromJson). Widget ListView kemudian membangun tampilan (ProductEntryCard) berdasarkan data list objek tersebut.

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout.
    1. Register: Pengguna input data di RegisterPage. Flutter mengirim POST request ke endpoint register Django. Django membuat User baru dan menyimpannya.

    2. Login:

        - Pengguna input username/password di LoginPage.
        - Flutter mengirim POST ke endpoint login Django via request.login.
        - Django memverifikasi kredensial. Jika valid, Django membuat sesi dan mengirimkan cookie sessionid.
        - CookieRequest di Flutter menyimpan cookie tersebut. Status loggedIn menjadi true.

    3. Akses Menu: Saat pengguna mengakses halaman produk, CookieRequest menyertakan cookie sessionid tadi secara otomatis. Django mengecek cookie, mengetahui user tersebut valid, dan mengembalikan data milik user tersebut (jika difilter).
    4. Logout: Tombol logout ditekan. Flutter kirim request ke endpoint logout. Django menghapus sesi di server. Flutter menghapus cookie yang tersimpan di CookieRequest dan mengembalikan user ke halaman login.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step!
    mplementasi ini saya lakukan untuk menghubungkan "Gollective" (aplikasi jersey) dengan backend Django:
    1. Setup Django:
        - Membuat app authentication dan menambahkan library corsheaders.
        - Menambahkan method view khusus untuk Flutter di main/views.py yaitu add_product_flutter yang @csrf_exempt. View ini memparsing JSON request body untuk membuat objek Product (termasuk field custom saya: club_name, season, release_year, condition, authenticity).
        - Mengonfigurasi URL routing untuk auth dan API produk.
    2. Integrasi Model di Flutter
        - Mengambil contoh JSON dari endpoint localhost:8000/json/.
        - Membuat model Dart menggunakan Quicktype dan menyimpannya di lib/models/product_entry.dart. Model Products ini mencakup enum untuk kategori dan kondisi (Mint/Second).
    3. State Management
        - Menambahkan package provider dan pbp_django_auth.
        - Di main.dart, saya membungkus MaterialApp dengan Provider yang menyediakan satu instance CookieRequest ke seluruh widget tree.
    4. Halaman Login dan Register
        - Membuat login.dart dan register.dart. Menggunakan request.login dan request.postJson untuk berkomunikasi dengan Django.
        - Menangani respons error dan menampilkan SnackBar atau AlertDialog jika login gagal.
    5. Halaman Daftar Produk
        - Membuat product_entry_list.dart yang menggunakan FutureBuilder.
        - Mengambil data via request.get. Data dikonversi jadi list Products.
        - Menampilkan data menggunakan widget custom ProductEntryCard yang saya buat di widgets/product_entry_card.dart, menampilkan detail spesifik seperti "Authentic/Replica" dan logo klub (via URL thumbnail).
    6. Halaman Form
        - Membuat product_form.dart. Form ini memiliki input lengkap sesuai model Django saya: TextFormField untuk nama/klub/musim, Dropdown untuk kategori/kondisi, dan Switch untuk status authenticity.
        - Mengirim data JSON ke Django saat tombol Save ditekan.
    7. Logout
        - Menambahkan logika logout pada widget kartu menu atau drawer, memanggil request.logout untuk membersihkan sesi.