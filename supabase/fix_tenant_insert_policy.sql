-- Fix RLS policies to allow PG owner to add tenants
-- The issue: INSERT operations require WITH CHECK clause in addition to USING clause

-- Drop existing tenant policy and recreate with WITH CHECK
DROP POLICY IF EXISTS "owner_tenants" ON tenants;

CREATE POLICY "owner_tenants" ON tenants FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Also fix other related tables that may have the same issue

-- Beds table
DROP POLICY IF EXISTS "owner_beds" ON beds;
CREATE POLICY "owner_beds" ON beds FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Rooms table  
DROP POLICY IF EXISTS "owner_rooms" ON rooms;
CREATE POLICY "owner_rooms" ON rooms FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Payments table
DROP POLICY IF EXISTS "owner_payments" ON payments;
CREATE POLICY "owner_payments" ON payments FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Rent Collection table
DROP POLICY IF EXISTS "owner_rent_collection" ON rent_collection;
CREATE POLICY "owner_rent_collection" ON rent_collection FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Complaints table
DROP POLICY IF EXISTS "owner_complaints" ON complaints;
CREATE POLICY "owner_complaints" ON complaints FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Visitors table
DROP POLICY IF EXISTS "owner_visitors" ON visitors;
CREATE POLICY "owner_visitors" ON visitors FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Expenses table
DROP POLICY IF EXISTS "owner_expenses" ON expenses;
CREATE POLICY "owner_expenses" ON expenses FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Announcements table
DROP POLICY IF EXISTS "owner_announcements" ON announcements;
CREATE POLICY "owner_announcements" ON announcements FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Activity Log table
DROP POLICY IF EXISTS "owner_activity_log" ON activity_log;
CREATE POLICY "owner_activity_log" ON activity_log FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Settings table
DROP POLICY IF EXISTS "owner_settings" ON settings;
CREATE POLICY "owner_settings" ON settings FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Checkout Records table
DROP POLICY IF EXISTS "owner_checkout_records" ON checkout_records;
CREATE POLICY "owner_checkout_records" ON checkout_records FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Checkout Messages table
DROP POLICY IF EXISTS "owner_checkout_messages" ON checkout_messages;
CREATE POLICY "owner_checkout_messages" ON checkout_messages FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Bed Transfers table
DROP POLICY IF EXISTS "owner_bed_transfers" ON bed_transfers;
CREATE POLICY "owner_bed_transfers" ON bed_transfers FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));

-- Transactions table
DROP POLICY IF EXISTS "owner_transactions" ON transactions;
CREATE POLICY "owner_transactions" ON transactions FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));
