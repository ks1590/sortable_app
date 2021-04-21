// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require moment
//= require fullcalendar
//= require bootstrap-sprockets
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require_tree .

$(function () {
  Highcharts.setOptions({
    lang: {
      thousandsSep: ",",
      numericSymbols: [null]
    },
    colors: ['#4572A7', '#AA4643', '#89A54E', '#80699B', '#3D96AE', '#DB843D', '#92A8CD', '#A47D7C', '#B5CA92'],
    plotOptions: {
      pie: {
        // 円グラフの内側のサイズ
        innerSize: '50%'
      }
    },
    responsive: {
      rules: [{
        condition: {
          maxWidth: 300
        },
        chartOptions: {
          plotOptions: {
            series: {
              dataLabels: {
                format: '<b>{point.name}</b>'
              }
            }
          }
        }
      }]
    }
  });
});
$('#graphique-repartition-budgetaire').highcharts({
  // my graphic code is here....
});

// $(document).ready(function () {

//   create_event = function (title, start, end) {
//     $.ajaxPrefilter(function (options, originalOptions, jqXHR) {
//       var token;
//       if (!options.crossDomain) {
//         token = $('meta[name="csrf-token"]').attr('content');
//         if (token) {
//           return jqXHR.setRequestHeader('X-CSRF-Token', token);
//         }
//       }
//     });
//     $.ajax({
//       type: "post",
//       url: "/events/create",
//       data: {
//         title: title,
//         start: start.toISOString(),
//         end: end.toISOString()
//       }
//     }).done(function (data) {
//       alert("登録しました!");
//     }).fail(function (data) {
//       alert("登録できませんでした。");
//     });
//   };

//   $('#calendar').fullCalendar({
//     header: {
//       left: 'prev,next today',
//       center: 'title',
//       right: 'month,agendaWeek,agendaDay'
//     },
//     navLinks: true,
//     selectable: true,
//     selectHelper: true,
//     select: function (start, end) {
//       let title = prompt('新しい取引を追加');
//       var eventData;
//       if (title) {
//         eventData = {
//           title: title,
//           start: start,
//           end: end
//         };
//         $('#calendar').fullCalendar('renderEvent', eventData, true);
//         $('#calendar').fullCalendar('unselect');
//         create_event(title, start, end);
//       }
//     },
//     timezone: 'UTC',
//     events: '/events.json',
//     editable: true
//   });

// });

// $(function () {
//   function eventCalendar() {
//     return $('#calendar').fullCalendar({});
//   };
//   function clearCalendar() {
//     $('#calendar').html('');
//   };
//   $(document).on('turbolinks:load', function () {
//     eventCalendar();
//   });
//   $(document).on('turbolinks:before-cache', clearCalendar);

//   $('#calendar').fullCalendar({
//     events: '/events.json',
//     titleFormat: 'YYYY年 M月',
//     //曜日を日本語表示
//     dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
//     //ボタンのレイアウト
//     header: {
//       left: '',
//       center: 'title',
//       right: 'today prev,next'
//     },
//     //終了時刻がないイベントの表示間隔
//     defaultTimedEventDuration: '03:00:00',
//     buttonText: {
//       prev: '前',
//       next: '次',
//       prevYear: '前年',
//       nextYear: '翌年',
//       today: '今日',
//       month: '月',
//       week: '週',
//       day: '日'
//     },
//     //イベントの時間表示を２４時間に
//     timeFormat: "HH:mm",
//     //イベントの色を変える
//     eventColor: '#63ceef',
//     //イベントの文字色を変える
//     eventTextColor: '#000000',
//   });
// });
