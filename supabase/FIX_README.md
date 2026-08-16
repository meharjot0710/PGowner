# Fix for PG Owner Unable to Add Tenants

## Problem

PG owners were unable to add tenants due to missing `WITH CHECK` clauses in Row Level Security (RLS) policies.

### Root Cause

PostgreSQL RLS policies require two types of clauses:
- **USING clause**: Used for SELECT, UPDATE, and DELETE operations to check if existing rows can be accessed
- **WITH CHECK clause**: Used for INSERT and UPDATE operations to verify if new/modified rows meet the security requirements

The original schema only included `USING` clauses, which prevented INSERT operations from working correctly.

## Solution

Added `WITH CHECK` clauses to all owner RLS policies to allow INSERT operations while maintaining the same security constraints.

### Files Modified

1. **supabase/schema.sql** - Updated the main schema file with correct RLS policies for future installations
2. **supabase/fix_tenant_insert_policy.sql** - Migration script to fix existing databases

## How to Apply This Fix

### For Existing Databases

Run the migration script in your Supabase SQL Editor:

```bash
# Option 1: Run the entire migration file
cat supabase/fix_tenant_insert_policy.sql
```

Then paste and execute the contents in Supabase Dashboard → SQL Editor.

### For New Databases

Simply run the updated `schema.sql` file which now includes the correct policies:

```bash
# In Supabase SQL Editor, run:
cat supabase/schema.sql
```

## What Changed

### Before (Broken - INSERT not allowed)
```sql
CREATE POLICY "owner_tenants" ON tenants FOR ALL USING (
  property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid())
);
```

### After (Fixed - INSERT allowed)
```sql
CREATE POLICY "owner_tenants" ON tenants FOR ALL 
  USING (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()))
  WITH CHECK (property_id IN (SELECT id FROM properties WHERE owner_id = auth.uid()));
```

## Affected Tables

The following tables had their RLS policies updated:
- tenants
- rooms
- beds
- payments
- rent_collection
- complaints
- visitors
- expenses
- announcements
- activity_log
- settings
- checkout_records
- checkout_messages
- bed_transfers
- transactions

## Testing

After applying the fix, verify that:

1. PG owners can successfully add new tenants through the UI
2. The INSERT operation completes without RLS policy violation errors
3. All other operations (SELECT, UPDATE, DELETE) continue to work as expected
4. Tenant users still cannot access data from properties they don't belong to

## Security Note

This fix does not reduce security. The `WITH CHECK` clause uses the same condition as the `USING` clause, ensuring that:
- Owners can only insert data for properties they own
- The same access control rules apply to both reading and writing data
