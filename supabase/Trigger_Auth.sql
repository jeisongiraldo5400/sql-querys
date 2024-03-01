
-- Este es el triger que se crear desde la tabla auth para poder registrar ese usuario en la 
-- tabla de users y se dispara con el trigger que ya esta creado
create trigger on_auth_users_insert
after insert on auth.users for each row
execute procedure public.insert_user_in_public_table_for_new_user ();



-- Este el contenido de la función:
begin
  insert into public.users (id, name, user_name, avatar_url)
  values (
    new.id,
    new.raw_user_meta_data->>'name',
    new.raw_user_meta_data->>'user_name',
    new.raw_user_meta_data->>'avatar_url'
  );
  return new;
end