create function binominal(
@PE_Total int,@PE_No int,@PE_No_in int ,@PE_Targeted int)
returns float
begin
	declare @sum float;
	declare @succeed_per float;
	declare @non_succeed_per float;
	declare @tmp float;
	
	set @sum = 1;
	set @succeed_per = CAST(@PE_Targeted as float)/@PE_Total;
	set @non_succeed_per = CAST(@PE_Total-@PE_Targeted as float)/@PE_Total;
	
	while @PE_No_in>0
	begin
		set @tmp = CAST(@PE_No as float)/@PE_No_in;
		set @sum *= @tmp*@succeed_per;
		set @PE_No -= 1;
		set @PE_No_in -= 1;
	end
	
	set @sum *= POWER(@non_succeed_per,@PE_No-@PE_No_in);
	
	return @sum;
end

#######################################################################3

update sheet set binominal = dbo.binominal(
sheet.PE_Total,sheet.PE_No,sheet.PE_No_in,sheet.PE_Targeted)
