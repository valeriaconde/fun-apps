using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace dinoapp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void TextBox_KeyDown(object sender, KeyEventArgs e)
        {
            Random numH = new Random();
            Random numW = new Random();
            // Random picN = new Random();

            int wid = numW.Next(10, 540);
            int hei = numH.Next(10, 63);
            // int pic = picN.Next(0, 27);

            //string[] pictures = { "/dino.jpeg", "/dino2.png", "/dino3.jpg", "/dino4.jpg", "/dino5.jpg", "/dino6.png", "/dino7.jpg", "/dino8.jpg", "/dino9.jpg", "/dino10.jpg", "/dino11.jpg", "/dino12.jpg", "/dino13.jpg", "/dino14.jpg", "/dino15.jpeg", "/dino16.jpg", "/dino17.jpg", "/dino18.png", "/dino20.jpg", "/dino21.jpg", "/dino22.jpg", "/dino23.jpg", "/dino24.jpg", "/dino25.jpg", "/dino28.jpg", "/dino29.jpg", "/dino30.jpg", "/dino31.jpg" };
            //string src = pictures[pic];

            string src = "";
                      
            switch (e.Key)
            {
                case System.Windows.Input.Key.A:
                    src = "/dino.jpeg";
                    break;
                case System.Windows.Input.Key.B:
                    src = "/dino3.jpg";
                    break;
                case System.Windows.Input.Key.C:
                    src = "/dino4.jpg";
                    break;
                case System.Windows.Input.Key.D:
                    src = "/dino5.jpg";
                    break;
                case System.Windows.Input.Key.E:
                    src = "/dino6.png";
                    break;
                case System.Windows.Input.Key.F:
                    src = "/dino8.jpg";
                    break;
                case System.Windows.Input.Key.G:
                    src = "/dino7.jpg";
                    break;
                case System.Windows.Input.Key.H:
                    src = "/dino2.png";
                    break;
                case System.Windows.Input.Key.I:
                    src = "/dino9.jpg";
                    break;
                case System.Windows.Input.Key.J:
                    src = "/dino10.jpg";
                    break;
                case System.Windows.Input.Key.K:
                    src = "/dino11.jpg";
                    break;
                case System.Windows.Input.Key.L:
                    src = "/dino12.jpg";
                    break;
                case System.Windows.Input.Key.M:
                    src = "/dino13.jpg";
                    break;
                case System.Windows.Input.Key.N:
                    src = "/dino14.jpg";
                    break;
                case System.Windows.Input.Key.O:
                    src = "/dino15.jpeg";
                    break;
                case System.Windows.Input.Key.P:
                    src = "/dino16.jpg";
                    break;
                case System.Windows.Input.Key.Q:
                    src = "/dino17.jpg";
                    break;
                case System.Windows.Input.Key.R:
                    src = "/dino18.png";
                    break;
                case System.Windows.Input.Key.S:
                    src = "/dino20.jpg";
                    break;
                case System.Windows.Input.Key.T:
                    src = "/dino21.jpg";
                    break;
                case System.Windows.Input.Key.U:
                    src = "/dino22.jpg";
                    break;
                case System.Windows.Input.Key.V:
                    src = "/dino23.jpg";
                    break;
                case System.Windows.Input.Key.W:
                    src = "/dino24.jpg";
                    break;
                case System.Windows.Input.Key.X:
                    src = "/dino25.jpg";
                    break;
                case System.Windows.Input.Key.Y:
                    src = "/dino28.jpg";
                    break;
                case System.Windows.Input.Key.Z:
                    src = "/dino29.jpg";
                    break;
                case System.Windows.Input.Key.Space:
                    src = "/dino30.jpg";
                    break;
                case System.Windows.Input.Key.Enter:
                    src = "/dino31.jpg";
                    break;
                default:
                    break;
            }
            img.Source = new BitmapImage(new Uri(@src, UriKind.Relative));
            img.Margin = new Thickness(wid, hei, 0, 0);
        }
    }
}
