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
