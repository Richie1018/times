PFont font;
boolean flag;

int  timestwo;
int tm0=0; 
int ms;
int s;
int m;

// セットされた秒数を格納しておく変数
int setTimeSec = 0;
// スタートが押されたタイミングの秒数を格納しておく変数
int startTimeSec = 0;
// boolean start = false; としたほうが本当はよい
int start = 0;

void setup() {
  size(480, 320);
  flag=false;
  fill(255, 255, 255);
  font=createFont("Nina", 50);
  textFont(font);
}

int getNowSec() {
  return (hour()*60+minute())*60+second();
}


void draw() {
  background( 255 );
  // ボタンを表示する関数を利用する
  showButtons();
  if ( start == 1 ) {
    // スタートしているときはこちら
    // 0秒になったら赤色にして停止
    if( setTimeSec - (getNowSec() - startTimeSec) <= 0 ){
      setTimeSec = 0;
      showTime(0);
      start=0;
    } else {
      showTime( setTimeSec - (getNowSec() - startTimeSec) );
    }
  } else {
    // スタートしていないときはこちら
    showTime( setTimeSec );
  }


  if (key == 'A' || key == 'a') {          
    textSize (100); 
    background(0, 0, 0);
    fill(255, 255, 255);
    text(nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2), 10, 200);
    textSize (50);
    text(nf(year(), 4)+"/"+nf(month(), 2)+"/"+nf(day(), 2), 10, 60);



    if (mousePressed) {
      textSize (100); 
      background(255, 255, 255);
      fill(0, 0, 0);
      text(nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2), 10, 200);
      textSize (50);
      text(nf(year(), 4)+"/"+nf(month(), 2)+"/"+nf(day(), 2), 10, 60);
    }
  } else if (key == 'B' || key == 'b') {  
    textSize (60); 
    background(255);
    rect(0, 100, 50, 50);
    rect(350, 100, 50, 50);
    int tm=millis()-tm0; 
    ms=tm%1000;
    if (ms>=1) {
      s=(tm-ms)/1000;
    }
    text(nf(m, 2)+":"+nf(s, 2)+":"+nf(ms, 3), 10, 200);
  }

  if (mousePressed) {
    if (mouseX>=0 && mouseX<=250 && mouseY>=100 && mouseY<=150) {
      if (flag==false) {
        noLoop();
        flag=true;
      }
    } else if (mouseX>=350 && mouseX<=390 && mouseY>=100 && mouseY<=150) { 
      tm0=millis();
    }
  }


  if (key == 'C' || key == 'c') {


    // 秒数を入力として，0:00のような形で表示する関数
  }
}
void showTime( int sec )
{
  // 塗りつぶす色を黒色にしてテキストも大きく表示
  fill( 0 );
  textSize( 130 );
  // 0:00の表示は，x分 yz秒という感じになっている
  int min = sec / 60; // 分は60で割るだけでよい
  int sec60 = sec % 60; // 秒は60で割った余りとする
  // 1桁しかない場合は0を加える
  if ( sec60 < 10 ) {
    text( min+":0"+sec60, 90, 180 );
  } else {
    text( min+":"+sec60, 90, 180 );
  }
}

// ボタンを表示する関数
// いろいろといらないものは分離してしまおう
void showButtons()
{
  textSize( 30 );
  fill( 255 );
  rect( 10, 200, 100, 80 );
  rect( 370, 200, 100, 80 );
  fill( 255, 255, 255 );
  rect(380, 10, 40, 40);
  rect(430, 10, 40, 40);


  fill( 0 );
  text( "10sec", 15, 240 );
  text( "1min", 380, 240 );
  text( "R", 390, 40, 40 );
  text( "S", 442, 40, 40 );
}

void mousePressed() {
  // y座標はみんな一緒なのでまとめる
  if ( mouseY >= 200 && mouseY <= 280 ) {
    // mouseXの座標に応じてボタンの番号を返す
    if ( mouseX >= 10 && mouseX <= 110 ) {
      // 10secボタンが押されたら10秒加算
      setTimeSec = setTimeSec + 10;
    } else if ( mouseX >= 370 && mouseX <= 450 ) {
      // 1minボタンが押されたら60秒加算
      setTimeSec = setTimeSec + 60;
    }
  }
  if ( mouseY >= 30 && mouseY <= 40 ) {
    if ( mouseX >= 380 && mouseX <= 420 ) {
      // clearボタンが押されたら0にする
      setTimeSec = 0;
    } 

    if ( mouseY >= 30 && mouseY <= 40 ) {
      if ( mouseX >= 430 && mouseX <= 470 ) {
        // startボタンが押されたら現在時間を記憶しておく
        // そしてstartという変数のフラグを1にする
        // booleanで定義しているときはstart = true; とする
        start = 1;
        startTimeSec = getNowSec();
      }
    }
  }
  // 何も押されていなかったら0を返す
}
