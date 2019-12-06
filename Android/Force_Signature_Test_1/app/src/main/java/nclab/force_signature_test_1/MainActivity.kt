package nclab.force_signature_test_1

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        var subjedtname_EditText = findViewById<EditText>(R.id.SubjectName_editText)
        var selectpicture_Button = findViewById<Button>(R.id.SignaturePicture_button)
        var reset_Button = findViewById<Button>(R.id.Reset_button)
        var save_Button = findViewById<Button>(R.id.Save_button)

        selectpicture_Button.setOnClickListener(){
            
        }
    }
}
