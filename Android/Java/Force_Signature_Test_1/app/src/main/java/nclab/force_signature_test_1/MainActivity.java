package nclab.force_signature_test_1;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import java.io.File;

public class MainActivity extends AppCompatActivity {

    EditText SubjectName_EditText;
    Button SelectSignaturePicture_Button, Reset_Button, Save_Button;
    MyPainter MyPainter_Class;
    String SubjectName_String;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        SubjectName_EditText = findViewById(R.id.SubjectName_EditText);
        SelectSignaturePicture_Button = findViewById(R.id.SelectSignaturePicture_Button);
        Reset_Button = findViewById(R.id.Reset_Button);
        Save_Button = findViewById(R.id.Save_Button);

        CheckPermission_Func();
        Init_Func();
    }

    public void CheckPermission_Func()
    {
        int PermissionInfo_Int = ContextCompat.checkSelfPermission(this,
                Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if(PermissionInfo_Int == PackageManager.PERMISSION_GRANTED){
            Toast.makeText(this,
                    "쓰기 권한 있음",Toast.LENGTH_SHORT).show();
        }
        else {
            if(ActivityCompat.shouldShowRequestPermissionRationale(this,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE)){
                Toast.makeText(this,
                        "어플리케이션 설정에서 저장소 사용 권한을 허용해주세요",Toast.LENGTH_SHORT).show();

                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},
                        100);
            }
            else{
                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},
                        100);  // 이 100은 리퀘스트코드다
            }
        }
    }

    public void Init_Func()
    {
        MyPainter_Class = findViewById(R.id.Painter_CanvasView);
        MyPainter_Class.setAlpha(0.5f);
        String path = GetExternalPath_Func();
        File file = new File(path + "signature_force");
        file.mkdir();
    }

    public String GetExternalPath_Func()
    {
        String ext = Environment.getExternalStorageState();
        if(ext.equals(Environment.MEDIA_MOUNTED))
        {
            return Environment.getExternalStorageDirectory().getAbsolutePath() + "/";
        }
        else
        {
            return getFilesDir() + "";
        }
    }

    public void onClick(View v)
    {
        switch (v.getId())
        {
            case R.id.SelectSignaturePicture_Button:

                break;
            case R.id.Reset_Button:
                MyPainter_Class.Eraser();
                break;
            case R.id.Save_Button:
                SubjectName_String = SubjectName_EditText.getText().toString();
                MyPainter_Class.SaveTxt(GetExternalPath_Func() + "Force_Signature_Test_1/" + SubjectName_String + ".txt");
                MyPainter_Class.SaveImg(GetExternalPath_Func() + "Force_Signature_Test_1/" + SubjectName_String + ".png");
                SubjectName_String = "";
                Toast.makeText(this,
                        "저장 완료",Toast.LENGTH_SHORT).show();
                break;
        }
    }
}
