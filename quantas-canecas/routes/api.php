<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CanecaController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('canecas/{id}/aumentar', [CanecaController::class, 'aumentar']);

Route::post('canecas/{id}/diminuir', [CanecaController::class, 'diminuir']);

Route::resource('canecas', CanecaController::class);
