namespace Practic.Console.DataAccess;

using Microsoft.Extensions.Configuration;
using Practic.Console.Domain;

public interface ICollegeRepository
{
    Task<List<Employee>> GetEmployees();

    Task<List<Employee>> GetEmployeesSortedByDepartments();

    Task CreateEmployee(Employee employee);

    Task UpdateLastEmployee(Employee employee);
}