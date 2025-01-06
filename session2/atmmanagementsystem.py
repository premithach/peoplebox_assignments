class Account:
    def __init__(self, account_number, pin, balance):
        self.account_number = account_number
        self.pin = pin
        self.balance = balance

class ATMService:
    def __init__(self):
        # Predefined user data
        self.accounts = {
            123456789: Account(123456789, 1234, 5000),
            987654321: Account(987654321, 5678, 1000),
            112233445: Account(112233445, 4321, 300)
        }

    def authenticate(self, account_number, pin):
        """
        Authenticate the user by account number and PIN.
        Returns the Account object if successful, or None if authentication fails.
        """
        account = self.accounts.get(account_number)
        if account and account.pin == pin:
            return account
        else:
            raise ValueError("Invalid account number or PIN.")

    def withdraw(self, account, amount):
        """
        Handles withdrawal logic.
        Checks if the account has sufficient balance and processes the withdrawal.
        """
        if amount > account.balance:
            raise ValueError("Insufficient balance.")
        
        # Deduct amount from balance
        account.balance -= amount

        # Simulate dispensing cash by breaking it into denominations
        denominations = [100, 50, 20, 10, 5]
        dispensed_cash = {}
        for denom in denominations:
            if amount >= denom:
                num_bills = amount // denom
                amount -= num_bills * denom
                dispensed_cash[denom] = num_bills

        # Output the dispensed denominations
        print("Cash dispensed:")
        for denom, count in dispensed_cash.items():
            print(f"${denom} bills: {count}")
        
        return account.balance

    def deposit(self, account, amount):
        """
        Handles deposits into the account.
        Adds the deposit amount to the account balance.
        """
        if amount <= 0:
            raise ValueError("Deposit amount must be greater than zero.")
        
        account.balance += amount
        print(f"Deposited ${amount}. New balance: ${account.balance}")
        return account.balance

    def check_balance(self, account):
        """
        Returns the current balance of the account.
        """
        return account.balance



def main():
    atm_service = ATMService()

    try:
        account_number = int(input("Enter your account number: "))
        pin = int(input("Enter your PIN: "))
        
        account = atm_service.authenticate(account_number, pin)
        print(f"Welcome! Your current balance is ${account.balance}")

        while True:
            print("\nATM Menu:")
            print("1. Withdraw")
            print("2. Deposit")
            print("3. Check Balance")
            print("4. Exit")
            choice = input("Select an option: ")

            if choice == '1':
                try:
                    amount = float(input("Enter the amount to withdraw: "))
                    new_balance = atm_service.withdraw(account, amount)
                    print(f"New balance: ${new_balance}")
                except ValueError as e:
                    print(e)

            elif choice == '2':
                try:
                    amount = float(input("Enter the amount to deposit: "))
                    new_balance = atm_service.deposit(account, amount)
                    print(f"New balance: ${new_balance}")
                except ValueError as e:
                    print(e)

            elif choice == '3':
                balance = atm_service.check_balance(account)
                print(f"Your current balance is: ${balance}")

            elif choice == '4':
                print("Thank you for using the ATM. Goodbye!")
                break
            else:
                print("Invalid choice. Please try again.")

    except ValueError as e:
        print(f"Authentication failed: {e}")

if __name__ == "__main__":
    main()
