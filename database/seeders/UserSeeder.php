<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            ['name' => 'Selene Rojas', 'email' => 'selene@example.com'],
            ['name' => 'Juan Pérez', 'email' => 'juan@example.com'],
            ['name' => 'María López', 'email' => 'maria@example.com'],
            ['name' => 'Dany Rojas', 'email' => 'dany@example.com'],
            ['name' => 'Juana Pérez', 'email' => 'juanita@example.com'],
            ['name' => 'Maríana López', 'email' => 'mariana@example.com'],
        ];

        foreach ($users as $user) {
            // Crea el usuario solo si no existe el email
            User::firstOrCreate(
                ['email' => $user['email']],
                ['name' => $user['name'], 'password' => bcrypt('secret')]
            );
        }
    }
}
