
//-------------------------------------------------------------------
void write_uart(unsigned int);

//-------------------------------------------------------------------
typedef unsigned int fix4_28;
void itoa(char *buf, unsigned int val)
{
    fix4_28 const f1_10000 = (1 << 28) / 10000;
    fix4_28 tmplo, tmphi;
    unsigned int i;

    unsigned int lo = val % 100000;
    unsigned int hi = val / 100000;

    tmplo = lo * (f1_10000 + 1) - (lo / 4);
    tmphi = hi * (f1_10000 + 1) - (hi / 4);

    for(i = 0; i < 5; i++)
    {
        buf[i + 0] = '0' + (char)(tmphi >> 28);
        buf[i + 5] = '0' + (char)(tmplo >> 28);
        tmphi = (tmphi & 0x0fffffff) * 10;
        tmplo = (tmplo & 0x0fffffff) * 10;
    }
    buf[10] = '\0';
}

//-------------------------------------------------------------------
void printString(char *str)
{
	while(*str != '\0')
		write_uart(*str++);
}

//-------------------------------------------------------------------
void printInt(unsigned int val)
{
	char str[11];
	itoa(str, val);
	printString(str);
}


