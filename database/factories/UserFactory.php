<?php
namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\User;

class UserFactory extends Factory
{
protected $model = User::class;

public function definition(): array
{
return [
'name' => 'Test User',
'email' => 'test@example.com',
'password' => bcrypt('password'),
];
}
}
