<?php

namespace App\Http\Controllers;

use App\Models\Caneca;
use Illuminate\Http\Request;
use Exception;

class CanecaController extends Controller
{

     /**
     * Aumenta a quantidade de canecas
     *
     * @return \Illuminate\Http\Response
     */
    public function aumentar($id)
    {
        try{

            $caneca = Caneca::find($id);
            $caneca->quantidade++;
            $caneca->save();
            
            return response()->json(['success' => 'Quantidade de canecas aumentada.', 'quantidade' => $caneca->quantidade], 200);

        } catch (exception $e) {
            return response()->json(['error' => 'Falha ao alterar quantidade de canecas.'], 500);
        }
    }

     /**
     * Diminui a quantidade de canecas
     *
     * @return \Illuminate\Http\Response
     */
    public function diminuir($id)
    {
        try{
            
            $caneca = Caneca::find($id);

            if($caneca->quantidade < 1){
                return response()->json(['error' => 'Quantidade de canecas não pode ser diminuida.'], 406);
            }

            $caneca->quantidade--;
            $caneca->save();
            
            return response()->json(['success' => 'Quantidade de canecas diminuida.', 'quantidade' => $caneca->quantidade], 200);

        } catch (exception $e) {
            return response()->json(['error' => 'Falha ao alterar quantidade de canecas.'], 500);
        }
    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $caneca = Caneca::select('id', 'quantidade')->find($id);
        
        return $caneca;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
