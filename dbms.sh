    clear
    ################################ FUNCTION DECLARATIONS ############################
    getTotalRecords()
    {
        total=`cat $dbfile | wc -l`
    	echo "Total records :"$total	
    }
    viewAllRecords()
    {
    	total=`cat $dbfile | wc -l`
    	echo "Total records :"$total
    	if [ $total -gt 0 ]
    	then
    		i=1
    		while [ $i -le $total ]
    		do
    		echo "===================================="
    			echo "Employee - "$i
    			echo "============="
    			record=`cat $dbfile | head -$i | tail -1`
    			emp_no=`echo $record | cut -d "|" -f1`
    			emp_name=`echo $record | cut -d "|" -f2`
    			emp_add=`echo $record | cut -d "|" -f3`
    			emp_age=`echo $record | cut -d "|" -f4`
    			emp_gen=`echo $record | cut -d "|" -f5`
    			emp_desg=`echo $record | cut -d "|" -f6`
    			emp_sal=`echo $record | cut -d "|" -f7`
    			echo "Employee No. :" $emp_no
    			echo "Employee Name :" $emp_name
    			echo "Employee Address :" $emp_add
    			echo "Employee Age :" $emp_age
    			echo "Employee Gender :" $emp_gen
    			echo "Employee Designation :" $emp_desg
    			echo "Employee salary :" $emp_sal
    			i=`expr $i + 1`			
    		echo "===================================="
    		done
     
    	fi
    }
    addRecord()
    {
    		echo "===================================="
    		echo "	  ENTER EMPLOYEE INFORMATION"	
    		echo "===================================="
    		echo -n "Enter employee no. :"
    		read no
    		echo -n "Enter employee name :"	
    		read name
    		echo -n "Enter employee address :"	
    		read add
    		echo -n "Enter employee age :"	
    		read age
    		echo -n "Enter employee gender :"	
    		read gen
    		echo -n "Enter employee designation :"	
    		read desc
    		echo -n "Enter employee salary :"	
    		read sal
    		record="$no|$name|$add|$age|$gen|$desc|$sal"
    		echo $record >> $dbfile
    		echo "Employee information added successfully."
    }
    getEmployeeInformation()
    {
    		echo "===================================="
    		echo "	   FIND EMPLOYEE INFORMATION"	
    		echo "===================================="
    		echo -n "Enter employee no. :"
    		read no
    		total=`cat $dbfile | grep -cwi $no`
    		if [ $total -gt 0 ]
    		then
    			record=`cat $dbfile | grep -wi $no`
    			emp_no=`echo $record | cut -d "|" -f1`
    			emp_name=`echo $record | cut -d "|" -f2`
    			emp_add=`echo $record | cut -d "|" -f3`
    			emp_age=`echo $record | cut -d "|" -f4`
    			emp_gen=`echo $record | cut -d "|" -f5`
    			emp_desg=`echo $record | cut -d "|" -f6`
    			emp_sal=`echo $record | cut -d "|" -f7`
    			echo "Employee No. :" $emp_no
    			echo "Employee Name :" $emp_name
    			echo "Employee Address :" $emp_add
    			echo "Employee Age :" $emp_age
    			echo "Employee Gender :" $emp_gen
    			echo "Employee Designation :" $emp_desc
    			echo "Employee salary :" $emp_sal
    		elif [ $total -eq 0 ]
    		then
    			echo "No record found for this id"
    		fi
    }
    deleteEmployee()
    {
    		echo "===================================="
    		echo "	   DELETE EMPLOYEE INFORMATION"	
    		echo "===================================="
    		echo -n "Enter employee no. :"
    		read no
    		total=`cat $dbfile | grep -cwi $no`
    		if [ $total -gt 0 ]
    		then
    			totalrecords=`cat $dbfile | wc -l`
    			i=1
    			while [ $i -le $totalrecords ]
    			do
    				record=`cat $dbfile | head -$i | tail -1`
    				findrecord=`echo $record | grep -wci $no`
    				if [ $findrecord -eq 0 ]
    				then
    					echo "$record" >> "tempdata"
    				fi
    				i=`expr $i + 1`			
    			done
    			mv "tempdata" "data"
    			echo "Employee with id $no deleted."
    		elif [ $total -eq 0 ]
    		then
    			echo "No record found for this id"
    		fi	
    }
    modifyRecord()
    {
    	echo "===================================="
    	echo "	   MODIFY EMPLOYEE INFORMATION"	
    	echo "===================================="
    	echo -n "Enter employee no. :"
    	read no
    	total=`cat $dbfile | grep -cwi $no`
    	if [ $total -gt 0 ]
    	then
    		record=`cat $dbfile | grep -wi $no`
    		echo "================================================="
    		echo "	   ENTER EMPLOYEE INFORMATION FOR ID : $no"	
    		echo "================================================="
    		echo -n "Enter employee name :"	
    		read name
    		echo -n "Enter employee address :"	
    		read add
    		echo -n "Enter employee age :"	
    		read age
    		echo -n "Enter employee gender :"	
    		read gen
    		echo -n "Enter employee designation :"	
    		read desc
    		echo -n "Enter employee salary :"	
    		read sal	
    		updatedrecord="$no|$name|$add|$age|$gen|$desc|$sal"
    		#updates=$(`cat $dbfile` | sed s/$record/$updatedrecord/g)
    		totalrecords=`cat $dbfile | wc -l`
    		i=1
    		while [ $i -le $totalrecords ]
    		do
    			record=`cat $dbfile | head -$i | tail -1`
    			findrecord=`echo $record | grep -wci $no`
    			if [ $findrecord -eq 0 ]
    			then
    				echo "$record" >> "tempdata"
    			else
    				echo "$updatedrecord" >> "tempdata"				
    			fi
    			i=`expr $i + 1`			
    		done
    		mv "tempdata" "data"
    		echo "Record updated successfully"
    	else
    		echo "Record with this id not found"
    	fi			
    }
    ############################ END OF FUNCTION DECLARATIONS #########################
    dbfile="data"
     
    echo "===== AVAILABLE CHOICES ====="
    echo "1 - All records display"
    echo "2 - Add record"
    echo "3 - View record"
    echo "4 - Delete record"
    echo "5 - Modify record"
    echo "6 - Count total records"
    echo "E - Exit"
    echo "=============================="
    echo -n "Enter your choice :"
    read choice
    case $choice in
    "1")
    viewAllRecords
    ;;
    "2")
    addRecord
    ;;
    "3")
    getEmployeeInformation
    ;;
    "4")
    deleteEmployee	
    ;; # this tells use the end of an alternative
    "5")
    modifyRecord
    ;;
    "6")
    getTotalRecords
    ;;
    [eE])
    	exit
    ;;
    *)
    	echo "Invalid choice"
    ;;
    esac
