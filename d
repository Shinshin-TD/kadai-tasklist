[1mdiff --git a/app/Http/Controllers/TaskController.php b/app/Http/Controllers/TaskController.php[m
[1mindex 2301d20..3bfbdc3 100644[m
[1m--- a/app/Http/Controllers/TaskController.php[m
[1m+++ b/app/Http/Controllers/TaskController.php[m
[36m@@ -30,8 +30,16 @@[m [mclass TaskController extends Controller[m
 [m
     public function store(Request $request)[m
     {[m
[32m+[m[41m        [m
[32m+[m[32m        //バリデーション[m
[32m+[m[32m        $request->validate([[m
[32m+[m[32m            'status' => 'required|max:255',[m
[32m+[m[32m            'content' => 'required|max:255',[m
[32m+[m[32m        ]);[m
[32m+[m[41m        [m
         //メッセージを作成[m
         $task = new Task;[m
[32m+[m[32m        $task ->status = $request->status;[m
         $task ->content = $request->content;[m
         $task->save();[m
         [m
[36m@@ -63,9 +71,13 @@[m [mclass TaskController extends Controller[m
 [m
     public function update(Request $request, $id)[m
     {[m
[32m+[m[41m        [m
[32m+[m[32m        'status' => 'required|max:255',[m
[32m+[m[32m        'content' => 'required|max:255',[m
[32m+[m[41m        [m
         //idの値でメッセージを検索して取得[m
         $task = Task::findOrFail($id);[m
[31m-        [m
[32m+[m[32m        $task->status = $request->status;[m
         $task->content = $request->content;[m
         $task->save();[m
         [m
[1mdiff --git a/resources/views/tasks/create.blade.php b/resources/views/tasks/create.blade.php[m
[1mindex 4981427..f5836ab 100644[m
[1m--- a/resources/views/tasks/create.blade.php[m
[1m+++ b/resources/views/tasks/create.blade.php[m
[36m@@ -16,6 +16,11 @@[m
         <div class="col-6">[m
             {!! Form::model($task, ['route' => 'tasks.store']) !!}[m
             [m
[32m+[m[32m                <div class="form-group">[m
[32m+[m[32m                    {!! Form::label('status', 'ステータス:') !!}[m
[32m+[m[32m                    {!! Form::text('status', null, ['class' => 'form-control']) !!}[m
[32m+[m[32m                </div>[m
[32m+[m[41m            [m
                 <div class="form-group">[m
                     {!! Form::label('content', 'タスク:') !!}[m
                     {!! Form::text('content', null, ['class' => 'form-control']) !!}[m
[1mdiff --git a/resources/views/tasks/edit.blade.php b/resources/views/tasks/edit.blade.php[m
[1mindex dd0d829..80c3619 100644[m
[1m--- a/resources/views/tasks/edit.blade.php[m
[1m+++ b/resources/views/tasks/edit.blade.php[m
[36m@@ -8,6 +8,12 @@[m
         <div class="col-6">[m
             {!! Form::model($task, ['route' => ['tasks.update', $task->id], 'method' => 'put']) !!}[m
             [m
[32m+[m[32m                <div class="form-group">[m
[32m+[m[32m                    {!! Form::label('status', 'ステータス:') !!}[m
[32m+[m[32m                    {!! Form::text('status', null, ['class' => 'form-control']) !!}[m
[32m+[m[32m                </div>[m
[32m+[m[41m        [m
[32m+[m[41m            [m
                 <div class="form-group">[m
                     {!! Form::label('content', 'タスク:') !!}[m
                     {!! Form::text('content', null, ['class' => 'form-control']) !!}[m
[1mdiff --git a/resources/views/tasks/index.blade.php b/resources/views/tasks/index.blade.php[m
[1mindex 1b0c1a7..d964a36 100644[m
[1m--- a/resources/views/tasks/index.blade.php[m
[1m+++ b/resources/views/tasks/index.blade.php[m
[36m@@ -9,15 +9,17 @@[m
             <thead>[m
                 <tr>[m
                     <th>id</th>[m
[32m+[m[32m                    <th>ステータス</th>[m
                     <th>タスク</th>[m
                 </tr>[m
             </thead>[m
             <tbody>[m
                 @foreach ($tasks as $task)[m
[31m-                [m
[32m+[m[41m                    [m
                 <tr>[m
                     {{--メッセージ詳細ページへのリンク --}}[m
                     <td>{!! link_to_route('tasks.show', $task->id, ['task' => $task->id]) !!}</td>[m
[32m+[m[32m                    <td>{{ $task->status }}</td>[m
                     <td>{{ $task->content }}</td>[m
                 </tr>[m
                 @endforeach[m
[1mdiff --git a/resources/views/tasks/show.blade.php b/resources/views/tasks/show.blade.php[m
[1mindex 0d8486f..b007aae 100644[m
[1m--- a/resources/views/tasks/show.blade.php[m
[1m+++ b/resources/views/tasks/show.blade.php[m
[36m@@ -9,6 +9,10 @@[m
             <th>id</th>[m
             <td>{{$task->id }}</td>[m
         </tr>[m
[32m+[m[32m        <tr>[m
[32m+[m[32m            <th>ステータス</th>[m
[32m+[m[32m            <td>{{$task->status }}</td>[m
[32m+[m[32m        </tr>[m
         <tr>[m
             <th>タスク</th>[m
             <td>{{$task->content }}</td>[m
