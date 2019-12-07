package nclab.force_signature_test_1;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    EditText SubjectName_EditText;
    Button SelectSignaturePicture_Button, Reset_Button, Save_Button;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        SubjectName_EditText = findViewById(R.id.SubjectName_EditText);
        SelectSignaturePicture_Button = findViewById(R.id.SelectSignaturePicture_Button);
        Reset_Button = findViewById(R.id.Reset_Button);
        Save_Button = findViewById(R.id.Save_Button);
    }

    public void onClick(View v)
    {
        switch (v.getId())
        {
            case R.id.SelectSignaturePicture_Button:

                break;
            case R.id.Reset_Button:
//                mypainter.Eraser();
                break;
            case R.id.Save_Button:
//                name = subject_et.getText().toString();
//                mypainter.SaveTxt(getExternalPath() + "signature_force/" + name + ".txt");
//                mypainter.SaveImg(getExternalPath() + "signature_force/" + name + ".png");
//                name = "";
                break;
        }
    }
}
