import uni;
import std.conv, std.string, std.stdio, std.range, std.algorithm;

void main()
{
	dchar[] chars;
	bool[] splits;
	size_t count;
    foreach(line; stdin.byLine)
    {
    	count++;
    	line = findSplitBefore(line, "#")[0];
    	if(line.empty)
    		continue;
    	for(; !line.empty; line.popFront())
    	{
    		dchar ch = line.front;
    		if(ch == '÷')
				splits ~= true;
    		else if(ch == '\u00D7')
    			splits ~= false;
    		else if(!isWhite(ch))
    		{
    			chars ~= cast(dchar)parse!int(line, 16);
    		}
    	}
    	size_t idx = 0;
    	//split at 0 is not interesting
    	while(idx < chars.length){
    		idx += graphemeStride(chars, idx);
    		assert(splits[idx], text("failed on line ",count) );
    	}
    	splits.length = 0;
    	chars.length = 0;
    }
}