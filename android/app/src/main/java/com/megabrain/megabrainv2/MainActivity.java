package com.megabrain.megabrainv2;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.view.WindowManager.LayoutParams;
import android.view.WindowManager; 
import android.os.Bundle;
import androidx.annotation.Nullable;

public class MainActivity extends FlutterActivity 
{
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(LayoutParams.FLAG_SECURE);
    }
}
