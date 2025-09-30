<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\PokemonController;
use Illuminate\Support\Facades\Artisan;

Route::get('/ping', function () {
    return response()->json(['pong' => true]);
});
Route::apiResource('users', UserController::class);
Route::get('pokemon/{name}', [PokemonController::class, 'show']);
// routes/web.php


Route::get('/run-seeders', function() {
    Artisan::call('db:seed', ['--force' => true]);
    return "Seeders ejecutados correctamente 😎";
});
