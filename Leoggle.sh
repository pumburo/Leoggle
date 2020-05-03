# !/bin/bash

# Leoggle By Pumburo

whois --version > /dev/null
	whoissorgu=$( echo $? )
dig -h > /dev/null 
	digsorgu=$( echo $? )
crunch --version > /dev/null
	clear
	crunchsorgu=$( echo $? )	
shuf --version > /dev/null	
	shufsorgu=$(echo $?)

if [[ $shufsorgu == 0 ]]; then
	echo "Shuf: OK"
elif [[ $shufsorgu > 0 ]]; then	
	echo "Programın çalışması için shuf yüklü olmalıdır. Yüklensin mi? "
	echo "1. Evet"
	echo "2. Hayır"
	read shufreq

	if [[ $shufreq == 1 ]]; then
		apt-get install shuf
		shufdurum=$( echo $? )
			if [[ $shufdurum > 0 ]]; then
				echo "Shuf yüklenemedi. Lütfen shuf yükleyip tekrar deneyiniz."
			elif [[ $shufsdurum == 0 ]]; then
				echo "Shuf yüklendi."
			fi
	fi		
fi	


if [[ $whoissorgu == 0 ]]; then
	echo "Whois: OK"
elif [[ $whoissorgu > 0 ]]; then	
	echo "Programın çalışması için whois yüklü olmalıdır. Yüklensin mi? "
	echo "1. Evet"
	echo "2. Hayır"
	read whoisreq

	if [[ $whoisreq == 1 ]]; then
		apt-get install whois
		whoisdurum=$( echo $? )
			if [[ $whoisdurum > 0 ]]; then
				echo "Whois yüklenemedi. Lütfen Whois yükleyip tekrar deneyiniz."
			elif [[ $whoisdurum == 0 ]]; then
				echo "Whois yüklendi."
			fi
	fi		
fi

if [[ $digsorgu == 0 ]]; then
	echo "Dig: OK"
elif [[ $digsorgu > 0 ]]; then	
	echo "Programın çalışması için dig yüklü olmalıdır. Yüklensin mi? "
	echo "1. Evet"
	echo "2. Hayır"
	read digreq

	if [[ $digreq == 1 ]]; then
		apt-get install dig
		digdurum=$( echo $? )
			if [[ $digdurum > 0 ]]; then
				echo "Dig yüklenemedi. Lütfen dig yükleyip tekrar deneyiniz."
			elif [[ $digdurum == 0 ]]; then
				echo "Dig yüklendi."
			fi
	fi				

fi

if [[ $crunchsorgu == 0 ]]; then
	echo "Crunch: OK"
elif [[ $crunchsorgu > 0 ]]; then	
	echo "Programın çalışması için crunch yüklü olmalıdır. Yüklensin mi? "
	echo "1. Evet"
	echo "2. Hayır"
	read crunchreq

	if [[ $crunchreq == 1 ]]; then
		apt-get install crunch
		crunchdurum=$( echo $? )
			if [[ $crunchdurum > 0 ]]; then
				echo "Crunch yüklenemedi. Lütfen crunch yükleyip tekrar deneyiniz."
			elif [[ $crunchdurum == 0 ]]; then
				echo "Crunch yüklendi."
			fi
	fi		
fi





x=0
y=0
z=0

echo "Domain uzantısını seçin."
echo "1. .com"
echo "2. .net"
echo "3. .org"
echo "4. Başka bir şey. "
read uza
if [[ $uza == 1 ]]; then
	uzanti="com"
elif [[ $uza == 2 ]]; then
	uzanti="net"
elif [[ $uza == 3 ]]; then
	uzanti="org"
elif [[ $uza == 4 ]]; then
	echo "Taramak istediğiniz domain uzantısını başında nokta olmadan girin. (Örn: gov.tr )"
	read uzanti
else
	echo "Hatalı giriş."
	exit
fi		
echo "Minimum digit girin."
read d1
echo "Maksimum digit girin."
read d2
echo "Domain sayı içersin mi?"
echo "1. Evet"
echo "2. Hayır"
read sayi
echo "Boş domain listesi kaydedilsin mi?"
echo "1. Evet"
echo "2. Hayır"
read save1 
echo "Dolu ve muamma listeleri kaydedilsin mi?"
echo "1. Evet"
echo "2. Hayır"
read save2

if [[ $sayi == 1 ]]; then
	data="1234567890qwertyuopasdfghjklizxcvbnm"
elif [[ $sayi == 2 ]]; then
	data="qwertyuopasdfghjklizxcvbnm"
else	
	echo "Hatalı giriş."
	exit 
fi		



zaman=$(date "+%s")
mkdir $zaman
cd $zaman


crunch $d1 $d2 $data | sed "s/$/.$uzanti/" | shuf > domainliste$zaman.txt 
echo "$zaman" >> domainliste$zaman.txt
clear

	echo "Taranacak domain listesi $zaman klasörü içinde, domainliste$zaman.txt ismi ile kaydedilmiştir."

satiro=$( cat domainliste$zaman.txt | wc -l )
satir=`expr $satiro - 1`

for (( i=1; i<=$satir; i++ )); do
	
	whois $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
		wi=$(echo $?)
	dig $( cat domainliste$zaman.txt | head -n $i | tail -1 ) +noall +answer | grep IN > /dev/null
		di=$(echo $?)

	if [[ $wi == 0 ]] && [[ $di == 0 ]]; then

		echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain dolu."

		if [[ $save2 == 1 ]]; then

			let y++

		fi

			if [[ $y == 1 ]]; then

				touch doludomainler$zaman.txt
				echo "Dolu domain listesi doludomainler$zaman.txt ismi ile hazırlanıyor..."
				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 )" >> doludomainler$zaman.txt
				
			

			elif [[ $y>1 ]]; then
			
				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 )" >> doludomainler$zaman.txt

			fi
	
	elif [[ $wi == 1 ]] && [[ $di == 0 ]]; then
		
		echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) Domain yüksek ihtimalle dolu. dig: $di whois: $wi "
	
		
		if [[ $save2 == 1 ]]; then
			
			let z++
		
		fi

			if [[ $z = 1 ]]; then

				touch muamma$zaman.txt
			 	echo "Muamma domain listesi muamma$zaman.txt ismi ile oluşturuuyor."
			 	cat domainliste$zaman.txt | head -n $i | tail -1 >> muamma$zaman.txt
			 	let z++ 

			elif [[ $z > 1 ]]; then
				
				cat domainliste$zaman.txt | head -n $i | tail -1 >> muamma$zaman.txt
			
			fi	
					
		
	elif [[ $wi == 0 ]] && [[ $di == 1 ]]; then
	
		echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) Domain yüksek ihtimalle dolu. dig: $di whois: $wi"
		echo "Domain yüksek ihtimalle dolu."

		if [[ $save2 == 1 ]]; then
			
			let z++
		
		fi

			if [[ $z = 1 ]]; then

				touch muamma$zaman.txt
			 	echo "Muamma domain listesi muamma$zaman.txt ismi ile oluşturuuyor."
			 	cat domainliste$zaman.txt | head -n $i | tail -1 >> muamma$zaman.txt
			 	let z++ 

			elif [[ $z > 1 ]]; then
				
				cat domainliste$zaman.txt | head -n $i | tail -1 >> muamma$zaman.txt
			
			fi	

	elif [[ $wi == 1 ]] && [[ $di == 1 ]]; then	

		echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş."

		if [[ $save1 == 1 ]]; then

		let x++

		fi

			if [[ $x == 1 ]]; then

				touch bosdomainler$zaman.txt
				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 )" >> bosdomainler$zaman.txt
				echo "Boş domain listesi bosdomainler$zaman.txt ismi ile oluşturuluyor."
				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) Domain boş. "	
				echo "Kesinlikle boş olduğuna emin olunamayan domainlerin dig ve whois kodları domainin yanında mevcuttur. Lütfen kontrol ediniz." >> bosdomainler$zaman.txt
			

			elif [[ $x>1 ]]; then
			
				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 )" >> bosdomainler$zaman.txt
				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) Domain boş. "

			fi	

			

	else

		echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) dig: $di whois: $wi"
		

		if [[ $di > 1 ]]; then
			
			if [[ $wi > 1 ]]; then
				
				whois $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					swi=$( echo $? )
				dig $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					sdi=$( echo $? )
				
				if [ $swi -ge 1 ] && [ $sdi -ge 1 ]; then 	

					if [[ $save1 == 1 ]]; then

						let x++

					fi	

					if [[ $x == 1 ]]; then
						touch bosdomainler$zaman.txt
						let x++
					fi	

					if [[ $swi == 1 ]] && [[ $sdi == 1 ]]; then
						echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş."
					
						if [[ $x > 1 ]]; then

						echo $( cat domainliste$zaman.txt | head -n $i | tail -1 ) >> bosdomainler$zaman.txt
						let x++

						fi
					
					fi	

				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş olabilir. dig: $sdi whois: $swi " 
				
				if [[ $x > 1 ]]; then

				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) dig: $sdi whois: $swi " >> bosdomainler$zaman.txt
				let x++

				fi

				fi
				
			elif [[ $wi == 1 ]]; then
				
				whois $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					swi=$( echo $? )
				dig $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					sdi=$( echo $? )
				
				if [ $swi -ge 1 ] && [ $sdi -ge 1 ]; then 	

					if [[ $save1 == 1 ]] ; then
						
						let x++
					
					fi	

					if [[ $x == 1 ]]; then

						touch bosdomainler$zaman.txt
						let x++
					fi		

					if [[ $swi == 1 ]] && [[ $sdi == 1 ]]; then
						echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş."
						
						if [[ $x > 1 ]]; then
							
							echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 )" >> bosdomainler$zaman.txt
						
						fi

					fi	

				echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş olabilir. dig: $sdi whois: $swi " 
				
					if [[ $x > 1 ]]; then

						echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) dig: $sdi whois: $swi " >> bosdomainler$zaman.txt

					fi

				fi
			fi
		
		elif [[ $wi > 1 ]]; then
			 
			 if [[ $di > 1 ]]; then
				
				whois $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					swi=$( echo $? )
				dig $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					sdi=$( echo $? )
				
				if [ $swi -ge 1 ] && [ $sdi -ge 1 ]; then

					if [[ $save1 == 1 ]]; then

						let x++

					fi	

					if [[ $x == 1 ]]; then

						touch bosdomainler$zaman.txt
						let x++			
					fi	

					if [[ $swi == 1 ]] && [[ $sdi == 1 ]]; then
						echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş."
					
						if [[ $x > 1 ]]; then

							echo $( cat domainliste$zaman.txt | head -n $i | tail -1 ) >> bosdomainler$zaman.txt
						fi

					fi	 	

					echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş olabilir. dig: $sdi whois: $swi " 
				
					if [[ $x > 1 ]]; then

						echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) dig: $sdi whois: $swi " >> bosdomainler$zaman.txt				

					fi

				fi
			
			elif [[ $di == 1 ]]; then
				
				whois $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					swi=$( echo $? )
				dig $( cat domainliste$zaman.txt | head -n $i | tail -1 ) > /dev/null
					sdi=$( echo $? )
				
				if [ $swi -ge 1 ] && [ $sdi -ge 1 ]; then 

					if [[ $save1 == 1 ]]; then

						let x++
					fi	

					if [[ $x == 1 ]]; then
						
						touch bosdomainler$zaman.txt

						let x++
					
					fi	

					if [[ $swi == 1 ]] && [[ $sdi == 1 ]]; then
						echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş."
						if [[ $x > 1 ]]; then
						
							echo $( cat domainliste$zaman.txt | head -n $i | tail -1 ) >> bosdomainler$zaman.txt
						
							fi
					
					fi		

					echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) isimli domain boş olabilir. dig: $sdi whois: $swi " 
					
					if [[ $x > 1 ]]; then

						echo "$( cat domainliste$zaman.txt | head -n $i | tail -1 ) dig: $sdi whois: $swi " >> bosdomainler$zaman.txt				

					fi
				fi
			
			fi

		
		fi	



	fi		

	



done	

