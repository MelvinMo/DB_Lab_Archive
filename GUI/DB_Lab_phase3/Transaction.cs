//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DB_Lab_phase3
{
    using System;
    using System.Collections.Generic;
    
    public partial class Transaction
    {
        public int TransactionID { get; set; }
        public Nullable<int> TypeCode { get; set; }
        public Nullable<int> PersonID { get; set; }
        public Nullable<System.Guid> VIN { get; set; }
        public string Date { get; set; }
        public Nullable<int> Price { get; set; }
        public string Currency { get; set; }
    
        public virtual Person Person { get; set; }
        public virtual Transaction_Type Transaction_Type { get; set; }
        public virtual Vehicle Vehicle { get; set; }
    }
}
