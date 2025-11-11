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



