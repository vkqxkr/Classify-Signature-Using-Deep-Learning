package nclab.force_signature_test_1;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.Nullable;

import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

public class MyPainter extends View {
    int oldX,oldY = -1;
    Bitmap mbitmap;
    Canvas mcanvas;
    Paint mpaint = new Paint();
    Bitmap img = BitmapFactory.decodeResource(getResources(),R.mipmap.ic_launcher);
    boolean check,scaled;
    String forceValue = "";

    public MyPainter(Context context, @Nullable AttributeSet attrs)
    {
        super(context, attrs);
        mpaint.setColor(Color.BLACK);
        mpaint.setStrokeWidth(3);
        this.setLayerType(LAYER_TYPE_SOFTWARE,null);
    }

    public MyPainter(Context context)
    {
        super(context);
        mpaint.setColor(Color.BLACK);
        mpaint.setStrokeWidth(3);
        this.setLayerType(LAYER_TYPE_SOFTWARE,null);
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh)
    {

        super.onSizeChanged(w, h, oldw, oldh);
        mbitmap = Bitmap.createBitmap(w,h, Bitmap.Config.ARGB_8888);
        mcanvas = new Canvas();
        //빗맵과 캔버스 연결
        mcanvas.setBitmap(mbitmap);
        mcanvas.drawColor(Color.WHITE);
//        drawStamp();
    }

    private void drawStamp(int X, int Y)
    {
        if(scaled==true)
        {
            Bitmap bigimg = Bitmap.createScaledBitmap(img,img.getWidth()*2,img.getHeight()*2,false);
            mcanvas.drawBitmap(bigimg,X,Y,mpaint);

        }
        else
        {
            mcanvas.drawBitmap(img,X,Y,mpaint);
        }

    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if(mbitmap != null)
            canvas.drawBitmap(mbitmap,0,0,null);

    }



    @Override
    public boolean onTouchEvent(MotionEvent event) {
        int X = (int)event.getX();
        int Y = (int)event.getY();
        if(event.getAction() == MotionEvent.ACTION_DOWN)
        {
            oldX = X; oldY = Y;
        }
        else if (event.getAction() == MotionEvent.ACTION_MOVE)
        {
            forceValue = forceValue + event.getPressure() + "\n";
            if(oldX != -1)
            {
                if(!check) //체크안됐음
                {
                    mcanvas.drawLine(oldX,oldY,X,Y,mpaint);
                }
                invalidate();
                oldX = X; oldY = Y;
            }
        }
        else if (event.getAction() == MotionEvent.ACTION_UP)
        {
            if(oldX != -1)
            {
                if(check)
                {
                    drawStamp(X,Y);
                }
                else
                {
                    mcanvas.drawLine(oldX,oldY,X,Y,mpaint);
                }
            }
            invalidate();
            oldX = -1; oldY = -1;
        }
        return true;
    }

    public void Eraser()
    {
        mbitmap.eraseColor(Color.WHITE);
        forceValue = "";
        invalidate();
    }

    @SuppressLint("WrongThread")
    public void SaveImg(String filename)
    {
        try
        {
            FileOutputStream out = new FileOutputStream(filename);
            mbitmap.compress(Bitmap.CompressFormat.PNG,100, out);
            out.close();
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
            Toast.makeText(getContext(),"File not found",Toast.LENGTH_SHORT).show();
        }
        catch (IOException e)
        {
            e.printStackTrace();
            Toast.makeText(getContext(),"IO Exception",Toast.LENGTH_SHORT).show();
        }
    }

    public void SaveTxt(String filename)
    {
        try
        {
            FileOutputStream out = new FileOutputStream(filename);
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(out));
            writer.write(forceValue);
            writer.flush();

            writer.close();
            out.close();
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
            Toast.makeText(getContext(),"File not found",Toast.LENGTH_SHORT).show();
        }
        catch (IOException e)
        {
            e.printStackTrace();
            Toast.makeText(getContext(),"IO Exception",Toast.LENGTH_SHORT).show();
        }
    }
}
