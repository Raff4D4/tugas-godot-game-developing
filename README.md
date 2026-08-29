# 2D Platformer Game - Godot 4

Proyek ini adalah game 2D Platformer sederhana yang dibuat menggunakan **Godot Engine 4**. Game ini menampilkan pergerakan karakter utama (*Ninja*) yang dapat melompat, melompat ganda (*Double Jump*), melakukan *Dash*, serta berinteraksi dengan lingkungan panggung (*TileMap*).

---

## 🎮 Fitur Utama
- **Sistem Pergerakan Kustom:**
  - Jalan Kiri / Kanan menggunakan tombol `A` dan `D` (atau tombol Panah).
  - Melompat (*Jump*) dan Lompat Ganda (*Double Jump*) menggunakan tombol `Spacebar` / `W`.
  - Fitur *Dash* instan menggunakan tombol `Shift Kiri`.
- **Sistem Fisika & Tabrakan:**
  - Penggunaan `CharacterBody2D` untuk fisika karakter utama.
  - Implementasi *Physics Layers* pada `TileMap` untuk menciptakan lantai dan rintangan yang solid.
- **Sistem Animasi:**
  - Animasi sprite dinamis (`idle`, `walk`, `jump`) menggunakan `AnimatedSprite2D` yang menyesuaikan arah pergerakan pemain.

---

## 🛠️ Kontrol Pemain
| Aksi | Tombol Keyboard |
| --- | --- |
| **Bergerak Kiri** | `A` / `Panah Kiri` |
| **Bergerak Kanan** | `D` / `Panah Kanan` |
| **Lompat / Double Jump** | `Spacebar` / `W` |
| **Dash** | `Shift Kiri` |

---

## 🚧 Kendala yang Dihadapi & Solusinya (*Troubleshooting*)

Dalam proses pengembangan game ini, terdapat beberapa kendala teknis yang dihadapi beserta solusi penyelesaiannya:

### 1. Karakter Jatuh Tembus Panggung (*Collision Missing*)
* **Kendala:** Saat game dijalankan (`F6`), karakter Ninja terus jatuh menembus lantai rumput dan keluar dari layar bawah.
* **Penyebab:**
  - `CollisionShape2D` pada node Player dalam kondisi belum memiliki bentuk fisik (*Shape* bernilai `<empty>`) atau status *Disabled*-nya aktif.
  - *Physics Layer* pada `TileSet` lantai belum dikonfigurasi untuk memiliki bentuk tabrakan bawaan (*default tile shape*).
* **Solusi:**
  - Menambahkan bentuk `RectangleShape2D` pada `CollisionShape2D` karakter dan mematikan opsi *Disabled*.
  - Mengaktifkan *Physics Layer 0* pada properti `TileMap`, kemudian menyeleksi seluruh *tileset* tanah/bangunan dan menerapkan fitur **"Reset to default tile shape"** agar setiap ubin memiliki area fisik penahan.

### 2. Error pada InputMap (`ui_focus` tidak ditemukan)
* **Kendala:** Game mengalami *crash* saat dijalankan dan memunculkan error beruntun pada panel *Debugger*: `The InputMap action "ui_focus" doesn't exist`.
* **Penyebab:** Skrip GDScript mencoba memanggil aksi tombol `ui_focus` yang tidak terdaftar di sistem bawaan Godot.
* **Solusi:** Mengganti logika input pada kodingan menggunakan pemeriksaan kunci keyboard langsung `Input.is_key_pressed(KEY_SHIFT)` untuk fitur *Dash*, atau mendaftarkan aksi kustom pada menu **Project Settings > Input Map**.

### 3. Tombol `A` dan `D` Tidak Berfungsi untuk Bergerak
* **Kendala:** Karakter hanya bisa digerakkan menggunakan tombol panah keyboard dan tidak merespons tombol `A` atau `D`.
* **Penyebab:** Fungsi `Input.get_axis("ui_left", "ui_right")` secara *default* hanya dipetakan untuk tombol panah bawaan Godot.
* **Solusi:** Menambahkan *action* baru bernama `left` (diikat ke tombol `A`) dan `right` (diikat ke tombol `D`) pada **Project Settings > Input Map**, lalu memperbarui pemanggilan di skrip menjadi `Input.get_axis("left", "right")`.

---

## 📹 Video Gameplay
Saksikan rekaman *gameplay* dari game ini melalui video berikut:

![Gameplay Demo](https://drive.google.com/file/d/17uS1AcWd7MRNR-NJswm70neJqJUzgTZQ/view?usp=sharing)

> *Atau kamu juga bisa menonton video demo gameplay:* [Link Video Gameplay ](https://drive.google.com/file/d/17uS1AcWd7MRNR-NJswm70neJqJUzgTZQ/view?usp=sharing)
