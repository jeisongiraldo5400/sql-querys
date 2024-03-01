
-- Trigger para poder registrar un usuarios desde supabase
create function insert_user_in_public_table_for_new_user() returns trigger
    security definer
    language plpgsql
as
$$begin 

  insert into public.users (id, name, user_name, avatar_url)
  values (
    new.id,
    new.raw_user_meta_data->>'name',
    new.raw_user_meta_data->>'user_name',
    new.raw_user_meta_data->>'avatar_url'
  );

return new;

end$$;

alter function insert_user_in_public_table_for_new_user() owner to postgres;

grant execute on function insert_user_in_public_table_for_new_user() to anon;

grant execute on function insert_user_in_public_table_for_new_user() to authenticated;

grant execute on function insert_user_in_public_table_for_new_user() to service_role;

