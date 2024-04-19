namespace Practic.Console.DataAccess;

using System.Runtime.CompilerServices;
using System.Windows.Markup;
using Npgsql;
using Practic.Console.Domain;

public class CollegeRepository : ICollegeRepository
{
    private readonly NpgsqlDataSource _connectionDataSource;

    public CollegeRepository(string connectionString)
    {
        _connectionDataSource = NpgsqlDataSource.Create(connectionString);
    }

    public async Task<List<Employee>> GetEmployees()
    {
        List<Employee> employees = new List<Employee>();

        NpgsqlConnection connection = await _connectionDataSource.OpenConnectionAsync();

        await using (NpgsqlCommand command = new NpgsqlCommand("select * from employees", connection))
        {
            NpgsqlDataReader reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                Employee employee = new Employee()
                {
                    Id = reader.GetInt32(0),
                    LastName = reader.GetString(1),
                    FirstName = reader.GetString(2),
                    SurName = reader.GetString(3),
                    BirthDate = reader.GetDateTime(4),
                    Telephon = reader.GetString(5),
                    Gender = reader.GetChar(6),
                    EducationId = reader.GetInt32(7)
                };

                employees.Add(employee);
            }
        }

        return employees;
    }

    public async Task<List<Employee>> GetEmployeesSortedByDepartments()
    {
        List<Employee> employees = new List<Employee>();

        using NpgsqlConnection connection = await _connectionDataSource.OpenConnectionAsync();

        await using (NpgsqlCommand command = new NpgsqlCommand("select * from employees " + 
                                                                "join appointments on appointments.employee_id = employees.id " + 
                                                                "join departments on departments.id = appointments.department_id " +
                                                                "order by departments.name", connection)
                    )
        {
            NpgsqlDataReader reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                Employee employee = new Employee()
                {
                    Id = reader.GetInt32(0),
                    LastName = reader.GetString(1),
                    FirstName = reader.GetString(2),
                    SurName = reader.GetString(3),
                    BirthDate = reader.GetDateTime(4),
                    Telephon = reader.GetString(5),
                    Gender = reader.GetChar(6),
                    EducationId = reader.GetInt32(7)
                };

                employees.Add(employee);
            }            
        }

        return employees;
    }

    public async Task CreateEmployee(Employee employee)
    {
        using NpgsqlConnection connection = await _connectionDataSource.OpenConnectionAsync();

        await using (NpgsqlCommand command = new NpgsqlCommand("insert into employees (last_name, first_name, sur_name, birth_day, telephon, gender, education_id ) " +
                                                                "values (@LastName, @FirstName, @SurName, @BirthDate, @Telephon, @Gender, @EducationId)", connection)
                    )
        {
            command.Parameters.AddWithValue("LastName", employee.LastName);
            command.Parameters.AddWithValue("FirstName", employee.FirstName);
            command.Parameters.AddWithValue("SurName", employee.SurName);
            command.Parameters.AddWithValue("BirthDate", employee.BirthDate);
            command.Parameters.AddWithValue("Telephon", employee.Telephon);
            command.Parameters.AddWithValue("Gender", employee.Gender);
            command.Parameters.AddWithValue("EducationId", employee.EducationId);

            await command.ExecuteNonQueryAsync();
        }
    }

    public async Task UpdateLastEmployee(Employee employee)
    {
        using NpgsqlConnection connection = await _connectionDataSource.OpenConnectionAsync();

        await using (NpgsqlCommand command = new NpgsqlCommand("update employees " +
                                                                "set last_name = @LastName, " +
                                                                "first_name = @FirstName, " +
                                                                "sur_name = @SurName, " +
                                                                "birth_day = @BirthDate, " +
                                                                "telephon = @Telephon, " +
                                                                "gender = @Gender, " +
                                                                "education_id = @EducationId " +
                                                                "where (select id from employees order by id desc limit 1) = id", connection)
                    )
        {
            command.Parameters.AddWithValue("LastName", employee.LastName);
            command.Parameters.AddWithValue("FirstName", employee.FirstName);
            command.Parameters.AddWithValue("SurName", employee.SurName);
            command.Parameters.AddWithValue("BirthDate", employee.BirthDate);
            command.Parameters.AddWithValue("Telephon", employee.Telephon);
            command.Parameters.AddWithValue("Gender", employee.Gender);
            command.Parameters.AddWithValue("EducationId", employee.EducationId);

            await command.ExecuteNonQueryAsync();
        }
    }
} 