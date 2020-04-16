codeunit 50200 "Guess G/L Account"
{
    procedure GuessForBatch(JnlTemplateName: Code[20]; JnlBatchName: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.SetRange("Journal Template Name", JnlTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JnlBatchName);
        GenJnlLine.SetRange("Account No.", '');
        if GenJnlLine.FindSet() then begin
            repeat
                Guess(GenJnlLine);
            until GenJnlLine.Next() = 0;
        end;

    end;

    procedure Guess(var GenJnlLine: Record "Gen. Journal Line")
    var
        GLEntry: Record "G/L Entry";
        Desc: Text;
    begin
        Desc := GenJnlLine.Description;
        GLEntry.SetRange("Bal. Account Type", GenJnlLine."Bal. Account Type");
        GLEntry.SetRange("Bal. Account No.", GenJnlLine."Bal. Account No.");
        GLEntry.SetRange(Description, GenJnlLine.Description);
        if GLEntry.FindLast() then begin
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
            GenJnlLine.Validate("Account No.", GLEntry."G/L Account No.");
            GenJnlLine.Validate(Description, desc);
            GenJnlLine.Modify(true);
        end;

        GLEntry.reset;
        GLEntry.SetRange("Bal. Account Type", GenJnlLine."Bal. Account Type");
        GLEntry.SetRange("Bal. Account No.", GenJnlLine."Bal. Account No.");
        GLEntry.SetRange(Amount, GenJnlLine.Amount);
        if GLEntry.FindLast() then begin
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
            GenJnlLine.Validate("Account No.", GLEntry."G/L Account No.");
            GenJnlLine.Validate(Description, desc);
            GenJnlLine.Modify(true);
        end;
    end;
}