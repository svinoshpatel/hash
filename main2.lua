local hash_open = require("hash_open")

local function menu()
    print("Введіть розмір хеш-таблиці:")
    local size = tonumber(io.read())

    print("\nВиберіть метод хешування:")
    print("1. Метод ділення (division)")
    print("2. Метод множення (multiplication)")
    io.write("Вибір: ")
    local hash_choice = tonumber(io.read())
    local hash_method = (hash_choice == 2) and "multiplication" or "division"
    if hash_choice ~= 1 and hash_choice ~= 2 then
        print("Неправильний вибір. Використано метод ділення за замовчуванням.")
    end

    print("\nВиберіть метод пробування:")
    print("1. Лінійне пробування (linear)")
    print("2. Квадратичне пробування (quadratic)")
    io.write("Вибір: ")
    local probe_choice = tonumber(io.read())
    local probe_method = (probe_choice == 2) and "quadratic" or "linear"
    if probe_choice ~= 1 and probe_choice ~= 2 then
        print("Неправильний вибір. Використано лінійне пробування за замовчуванням.")
    end

    local ht = hash_open:new(size, hash_method, probe_method)
    print("Хеш-таблиця створена з методом хешування: " .. hash_method .. ", пробування: " .. probe_method)

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
            if ht:HashInsert(key, value) then
                print("Елемент додано!")
            else
                print("Не вдалося додати елемент (таблиця заповнена).")
            end

        elseif choice == 2 then
            io.write("Введіть ключ: ")
            local key = tonumber(io.read())
            local value = ht:HashSearch(key)
            if value then
                print("Знайдено: " .. value)
            else
                print("Елемент не знайдено.")
            end

        elseif choice == 3 then
            io.write("Введіть ключ: ")
            local key = tonumber(io.read())
            if ht:HashDelete(key) then
                print("Елемент видалено!")
            else
                print("Елемент не знайдено.")
            end

        elseif choice == 4 then
            print("Хеш-таблиця:")
            ht:HashShow()

        elseif choice == 5 then
            print("Вихід...")
            break

        else
            print("Неправильний вибір. Спробуйте ще раз.")
        end
    end
end

menu()
