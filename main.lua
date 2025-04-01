local chained_hash_table = require("hash")

local function menu()
	 print("Введіть розмір хеш-таблиці:")
	 local size = tonumber(io.read())

	print("\nВиберіть метод хешування:")
	print("1. Метод ділення (division)")
	print("2. Метод множення (multiplication)")
	io.write("Вибір: ")
	local hash_choice = tonumber(io.read())

	local hash_method
	if hash_choice == 1 then
     hash_method = "division"
	elseif hash_choice == 2 then
     hash_method = "multiplication"
	else
	   print("Неправильний вибір. Використано метод ділення за замовчуванням.")
	   hash_method = "division"
	end
    
	local ht = chained_hash_table:new(size, hash_method)
	print("Хеш-таблиця створена з методом: " .. hash_method)

    while true do
        print("\nМеню:")
        print("1. Вставити елемент")
        print("2. Знайти елемент")
        print("3. Видалити елемент")
        print("4. Відобразити таблицю")
        print("5. Вийти")

        io.write("Вибір: ")
        local choice = tonumber(io.read())

        if choice == 1 then
            io.write("Введіть ключ: ")
            local key = tonumber(io.read())
            io.write("Введіть значення: ")
            local value = io.read()
            ht:insert(key, value)
            print("Елемент додано!")

        elseif choice == 2 then
            io.write("Введіть ключ: ")
            local key = tonumber(io.read())
            local value = ht:search(key)
            if value then
                print("Знайдено: " .. value)
            else
                print("Елемент не знайдено.")
            end

        elseif choice == 3 then
            io.write("Введіть ключ: ")
            local key = tonumber(io.read())
            if ht:delete(key) then
                print("Елемент видалено!")
            else
                print("Елемент не знайдено.")
            end

        elseif choice == 4 then
            print("Хеш-таблиця:")
            ht:show()

        elseif choice == 5 then
            print("Вихід...")
            break

        else
            print("Неправильний вибір. Спробуйте ще раз.")
        end
    end
end

menu()
