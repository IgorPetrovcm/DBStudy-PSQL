namespace Practic.Console;

using Practic.Console.DataAccess;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Npgsql;
using System;
using System.Collections;
using System.ComponentModel.DataAnnotations;
using System.Text;
using Practic.Console.Domain;

public class Program
{
    private static ICollegeRepository _repository;

    private static StringBuilder ActionOptionsInConsole;

    private static StringBuilder AnswerInConsole;

    static async Task Main()
    {
        IConfigurationRoot config = new ConfigurationBuilder()
                            .AddJsonFile("appsettings.json")
                            .Build();

        string? connectionString = config.GetConnectionString("DefaultConnection");

        try 
        {
            _repository = new CollegeRepository(connectionString ?? string.Empty);

            Console.ForegroundColor = ConsoleColor.Green;
            System.Console.WriteLine("Connection is open!\n");

            IEnumerable<ConsoleKey>? keysInConsole = UserInput(new ConsoleKey[] {ConsoleKey.D1,ConsoleKey.D2,ConsoleKey.D3,ConsoleKey.D4});

            Console.ForegroundColor = ConsoleColor.White;

            ActionOptionsInConsole = new StringBuilder();

            ActionOptionsInConsole.Append("\n1. Напечатать список работающих сотрудников");
            ActionOptionsInConsole.Append("\n2. Напечатать список работающих сотрудников, отсортированный по названию подразделений");
            ActionOptionsInConsole.Append("\n3. Добавить случайно созданного сотрудника");
            ActionOptionsInConsole.Append("\n4. Обновить последнюю запись в таблице сотрудников");

            System.Console.WriteLine(ActionOptionsInConsole);

            foreach (ConsoleKey keyInConsole in keysInConsole)  
            {
                Console.Clear();
                switch (keyInConsole)
                {
                    case ConsoleKey.D1: {
                        List<Employee> employees = await _repository.GetEmployees();

                        AnswerInConsole = new StringBuilder();
                        System.Console.WriteLine("Id\tLast Name\tFirst Name\tSur Name\tBirth Date\tTelephon\tGender\tEducationId\n");

                        foreach (Employee employee in employees)
                        {
                            AnswerInConsole.Append(employee.Id + "\t" + employee.LastName + "\t" + employee.FirstName + "\t" + employee.SurName + "\t" + employee.BirthDate + "\t" + employee.Telephon + "\t" + employee.Gender + "\t" + employee.EducationId + "\n\n");
                        }

                        System.Console.WriteLine(AnswerInConsole);
                    } break;

                    case ConsoleKey.D2: {
                        List<Employee> employees = await _repository.GetEmployeesSortedByDepartments();

                        AnswerInConsole = new StringBuilder();
                        System.Console.WriteLine("Id\tLast Name\tFirst Name\tSur Name\tBirth Date\tTelephon\tGender\tEducationId\n");

                        foreach (Employee employee in employees)
                        {
                            AnswerInConsole.Append(employee.Id + "\t" + employee.LastName + "\t" + employee.FirstName + "\t" + employee.SurName + "\t" + employee.BirthDate + "\t" + employee.Telephon + "\t" + employee.Gender + "\t" + employee.EducationId + "\n\n");
                        }

                        System.Console.WriteLine(AnswerInConsole);                       
                    } break;

                    case ConsoleKey.D3: {
                        AnswerInConsole = new StringBuilder();
                        await _repository.CreateEmployee(
                            new Employee 
                            {
                                LastName = Guid.NewGuid().ToString().Remove(10),
                                FirstName = Guid.NewGuid().ToString().Remove(10),
                                SurName = Guid.NewGuid().ToString().Remove(10),
                                BirthDate = DateTime.Now,
                                Telephon = Guid.NewGuid().ToString().Remove(10),
                                Gender = 'f',
                                EducationId = 1
                            }
                        ) ;

                        AnswerInConsole.Append("OK!\n\n");
                        System.Console.WriteLine(AnswerInConsole);
                    } break;

                    case ConsoleKey.D4: {
                        AnswerInConsole = new StringBuilder();
                        await _repository.UpdateLastEmployee(
                            new Employee{
                                LastName = Guid.NewGuid().ToString().Remove(10),
                                FirstName = Guid.NewGuid().ToString().Remove(10),
                                SurName = Guid.NewGuid().ToString().Remove(10),
                                BirthDate = DateTime.Now,
                                Telephon = Guid.NewGuid().ToString().Remove(10),
                                Gender = 'm',
                                EducationId = 3
                            }
                        );
                        AnswerInConsole.Append("OK!\n\n");
                        System.Console.WriteLine(AnswerInConsole);
                    } break;
                }

                System.Console.WriteLine(ActionOptionsInConsole);
            }
        }
        catch (Exception ex) 
        {
            System.Console.WriteLine(ex);
        }
    }

    private static IEnumerable<ConsoleKey> UserInput(ConsoleKey[] validValues)
    {
        while (true)
        {
            ConsoleKey key = Console.ReadKey(intercept: true).Key;

            if ( validValues.Any( x => x == key ) ){
                yield return key;
            }
            else if (key == ConsoleKey.Enter) {
                Environment.Exit(0);
            }
            else {
                continue;
            }
        }
    }
}