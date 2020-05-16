package com.megabrain.megabrainv2;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManager; 
import android.os.Bundle;
import io.flutter.embedding.engine.FlutterEngine;
import androidx.annotation.NonNull;

public class MainActivity extends FlutterActivity 
{
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) 
  {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    getWindow().addFlags(LayoutParams.FLAG_SECURE);
  }
}
