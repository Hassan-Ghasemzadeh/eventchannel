package com.example.eventchannel

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity(), SensorEventListener, EventChannel.StreamHandler {
    private lateinit var sensorManager: SensorManager

    private var gyroscopeSensor: Sensor? = null

    private var eventSink: EventChannel.EventSink? = null
    private val CHANNEL = "com.example.eventchannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager

        gyroscopeSensor = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)

        val event = EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        event.setStreamHandler(this)
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event!!.sensor.type == Sensor.TYPE_GYROSCOPE) {
            val values = listOf(event.values[0], event.values[1], event.values[2])

            eventSink!!.success(values)
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        //do nothing for now
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        registerSensor()
    }

    override fun onCancel(arguments: Any?) {
        unRegisterListener()
        eventSink = null
    }

    //register sensor

    private fun registerSensor() {
        if (eventSink == null) return

        gyroscopeSensor = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)

        sensorManager.registerListener(this, gyroscopeSensor, SensorManager.SENSOR_DELAY_UI)
    }


    private fun unRegisterListener() {
        if (eventSink == null) return
        sensorManager.unregisterListener(this, gyroscopeSensor)
    }
}
