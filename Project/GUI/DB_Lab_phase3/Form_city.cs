﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DB_Lab_phase3
{
    public partial class Form_city : Form
    {
        public Form_city()
        {
            InitializeComponent();
        }

        private void Form_city_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'dblab_phase2_aftercreateDataSet.City' table. You can move, or remove it, as needed.
            this.cityTableAdapter.Fill(this.dblab_phase2_aftercreateDataSet.City);
            // TODO: This line of code loads data into the 'faze_2_ver1DataSet.City' table. You can move, or remove it, as needed.
            //this.cityTableAdapter.Fill(this.faze_2_ver1DataSet.City);
            //panel1.Location = new Point(
            //    this.ClientSize.Width / 2 - panel1.Size.Width / 2,
            //    this.ClientSize.Height / 2 - panel1.Size.Height / 2);
            //panel1.Anchor = AnchorStyles.None;
        }
    }
}
