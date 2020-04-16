pageextension 50200 "Gen. Journal - Guess" extends "General Journal"
{

    actions
    {
        addlast(processing)
        {
            action(GuessGLAccounts)
            {
                Caption = 'Guess G/L Accounts';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    GuessGLAccount: Codeunit "Guess G/L Account";
                begin
                    GuessGLAccount.GuessForBatch("Journal Template Name", "Journal Batch Name");
                end;

            }
        }
    }

}