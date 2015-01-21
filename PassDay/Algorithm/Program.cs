/*
 * Arris TM602A password of the day generator
 * 
 * Author of Original JavaScript Version: Raul Pedro Fernandes Santos
 * Author of this C# Code: Marcel Valdez Orozco
 * Project homepage for JavaScript Version: http://www.borfast.com/projects/arrispwgen
 * 
 * This software is distributed under the Simplified BSD License.
 * 
 * Copyright 2012 Marcel Valdez Orozco. All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */		 
namespace PasswordOfTheDay
{
	using System;
	
	public class Program
	{
	
		public static void Main(string[] args)
		{
			Console.WriteLine("Arris password of today: {0}", GeneratePassword(DateTime.Now));			
		}

		// TODO: Add some unit testing, just for fun.

		public static string GeneratePassword(DateTime date) {
			string seed = "MPSJKMDHAI";
			string seedeight = seed.Substring(0, 8);
			string seedten = seed;

			int[][] table1 = {
				new[] { 15, 15, 24, 20, 24 },
				new[] {13, 14, 27, 32, 10},
				new[] {29, 14, 32, 29, 24},
				new[] {23, 32, 24, 29, 29},
				new[] {14, 29, 10, 21, 29},
				new[] {34, 27, 16, 23, 30},
				new[] {14, 22, 24, 17, 13}
			};

			int[][] table2 = {
				new[] {0, 1, 2, 9, 3, 4, 5, 6, 7, 8},
				new[] {1, 4, 3, 9, 0, 7, 8, 2, 5, 6},
				new[] {7, 2, 8, 9, 4, 1, 6, 0, 3, 5},
				new[] {6, 3, 5, 9, 1, 8, 2, 7, 4, 0},
				new[] {4, 7, 0, 9, 5, 2, 3, 1, 8, 6},
				new[] {5, 6, 1, 9, 8, 0, 4, 3, 2, 7}
			};

			char[] alphanum = {
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D',
				'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
				'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
			};

			int[] list1 = new int[10];
			int[] list2 = new int[10];
			int[] list3 = new int[10];
			int[] list4 = new int[10];
			int[] list5 = new int[10];    
			int year;
			int month;
			int dayOfMonth;
			int dayOfWeek;	
			// Now let's generate one password for each day
			// For each iteration advance the date one day		

			// Last two digits of the year		
			year = date.Year % 100;

			// Number of the month (no leading zero; January == 0)
			month = date.Month;

			// Day of the month
			dayOfMonth = date.Day;

			// Day of the week. Normally 0 would be Sunday but we need it to be Monday.
			dayOfWeek = (int)date.DayOfWeek - 1;
			if (dayOfWeek < 0) {
				dayOfWeek = 6;
			}

			// Now build the lists that will be used by each other.
			// list1
			for (int i = 0; i <= 4; i++) {
				list1[i] = table1[dayOfWeek][i];
			}
			
			list1[5] = dayOfMonth;
			if (((year + month) - dayOfMonth) < 0) {
				list1[6] = (((year + month) - dayOfMonth) + 36) % 36;
			} else {
				list1[6] = ((year + month) - dayOfMonth) % 36;
			}
			
			list1[7] = (((3 + ((year + month) % 12)) * dayOfMonth) % 37) % 36;

			// list2
			for (int i = 0; i <= 7; i++) {
				list2[i] = (seedeight.Substring(i, 1)[0]) % 36;
			}

			// list3
			for (int i = 0; i <= 7; i++) {
				list3[i] = (((list1[i] + list2[i])) % 36);
			}
			
			list3[8] = (list3[0] + list3[1] + list3[2] + list3[3] + list3[4] +
			list3[5] + list3[6] + list3[7]) % 36;
			int num8 = list3[8] % 6;
			list3[9] = (int)Math.Round(Math.Pow(num8, 2));

			// list4
			for (int i = 0; i <= 9; i++) {
				list4[i] = list3[table2[num8][i]];
			}

			// list5
			for (int i = 0; i <= 9; i++) {
				list5[i] = ((seedten.Substring(i, 1)[0]) + list4[i]) % 36;
			}

			// Finally, build the password of the day.
			int len = list5.Length;
			char[] passwordOfTheDay = new char[len];
			for (int i = 0; i < len; i++) {
				passwordOfTheDay[i] = alphanum[list5[i]];
			}
			
			return new String(passwordOfTheDay);
		}
	}
}