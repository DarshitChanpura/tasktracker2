// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function update_buttons(){
  $(".manage-button").each( (index, obj) => {
    let user_id = $(obj).data('user-id');
    let manager_id = $(obj).data('manager');

    if(manager_id == ""){
      $(obj).text("Manage");
    }else{
      $(obj).text("Unmanage");
    }
  });
}

function set_button(user_id, manager_id){
  $(".manage-button").each( (index, obj) => {
    if(user_id == $(obj).data('user-id')){
      $(obj).data('manager', manager_id);
      update_buttons();
    }
  });
}

function manage(user_id){

  let text = JSON.stringify({
    manager: {
      manager_id: current_user,
      worker_id: user_id,
    }
  });

  $.ajax(manage_path, {
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); }
  });
}

function unmanage(user_id, manager_id){
  $.ajax(manage_path + "/" + manager_id, {
    method: "DELETE",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "{}",
    success: (resp) => { set_button(user_id, ""); }
  });
}

function manage_click(ev) {
  let btn = $(ev.target);
  let user_id = btn.data('user-id');

  // record-id
  let manager_id = btn.data('manager');

  if(manager_id == ""){
    manage(user_id);
  }else{
    unmanage(user_id, manager_id);
  }
}

function set_time_button(task_id, msg){
  $(".timespent-button").each( (index, obj) => {
    if(task_id == $(obj).data('task-id')){
      $(obj).data('isworking', msg);
      update_time_buttons();
    }
  });
}

function update_time_buttons(){
  $(".timespent-button").each( (index, obj) => {
    let task_id = $(obj).data('task-id');
    let isWorking = $(obj).data('isworking');

    if(isWorking == "yes"){
      $(obj).text("Stop");
    }else{
      $(obj).text("Start Working");
    }
  });
}
var start;
var stop;
function start_working(task_id){

  // set start_time
  start = new Date(Date.now());
  set_time_button(task_id, "yes");
  // let text = JSON.stringify({
  //   time_blocks: {
  //     task_id: task_id,
  //     start_time: "", //set start_time here
  //   }
  // });

  // $.ajax(timespent_path, {
  //   method: "POST",
  //   dataType: "json",
  //   contentType: "application/json; charset=UTF-8",
  //   data: text,
  //   success: (resp) => { set_time_button(task_id, "yes"); }
  // });
}

function stop_working(task_id,user_id,title,desc,completed){

  // set stop_time
  stop = new Date(Date.now());
  let text = JSON.stringify({
    time_blocks: {
      task_id: task_id,
      start_time: start,
      end_time: stop, // set stop_time here
    }
  });

  let newTask = JSON.stringify({
    task: {
      task_id: task_id,
      user_id: user_id+"",
      title: title,
      description: desc,
      completed: completed,
      start_time: start,
      stop_time: stop, // set stop_time here
    }
  });

  $.ajax(timespent_path, {
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {

      set_time_button(task_id, "no");
      $.ajax("/task", {
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: newTask,
        success: (resp) => {

        }
      });
      window.location.reload();
    }
  });
}


function timespent_click(ev) {

  let btn = $(ev.target);
  let task_id = btn.data('task-id');
  let user_id = btn.data('task-user-id');
  let title = btn.data('task-title');
  let desc = btn.data('task-desc');
  let completed = btn.data('task-comp');
  // let start-time = btn.data('task-start');
  // let end-time = btn.data('task-end');


  let isWorking = btn.data('isworking');

  if(isWorking == "no"){
    start_working(task_id);
  }else{
    stop_working(task_id,user_id,title,desc,completed);
  }
}

function init_manage(){
  // if there are no manage-buttons
  // on this page, return immediately
  if(!$(".manage-button")){
    return;
  }

  $(".manage-button").click(manage_click);

  // updates all the button texts on this page
  update_buttons();

}

function init_timespent(){


  if(!$(".timespent-button")){
    return;
  }

  $(".timespent-button").click(timespent_click);

  // updates all the button texts on this page
  update_time_buttons();

}


$(init_manage);
$(init_timespent);
