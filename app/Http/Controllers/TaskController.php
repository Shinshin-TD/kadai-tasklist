<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Task;

class TaskController extends Controller
{
  
    public function index()
    {
        $tasks = Task::all();
        
        return view('tasks.index',[
            'tasks' => $tasks,
        ]);
    }
    //getでtasks/creatにアクセスされた場合の「新規登録画面表示処理]
    public function create()
    {
        $task = new Task;
        
        //メッセージ作成ビューを表示
        return view('tasks.create',[
            'task' => $task,
            ]);
    }

    public function store(Request $request)
    {
        //メッセージを作成
        $task = new Task;
        $task ->content = $request->content;
        $task->save();
        
        return redirect('/');
    }

    public function show($id)
    {
        //idの値でメッセージを検索して取得
        $task = Task::findOrFail($id);
        
        //メッセージ詳細ビューでそれを表示
        return view('tasks.show', [
            'task' => $task,
            ]);
    }

    
    public function edit($id)
    {
        //idの値でメッセージを検索して取得
        $task = Task::findOrFail($id);
        
        //メッセージ編集ビューでそれを表示
        return view('tasks.edit',[
            'task' => $task,
            ]);
    }

    public function update(Request $request, $id)
    {
        //idの値でメッセージを検索して取得
        $task = Task::findOrFail($id);
        
        $task->content = $request->content;
        $task->save();
        
        return redirect('/');
    }

    public function destroy($id)
    {
        //idの値でメッセージを検索して取得
        $task = Task::findOrFail($id);
        
        $task->delete();
        
        return redirect('/');
    }
}
