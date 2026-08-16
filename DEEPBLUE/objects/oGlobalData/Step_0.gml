if (frameCounter < power(2, 32)) //count up frames with overflow protection
{
	frameCounter += 1;
}
else
{
	frameCounter = 0;
}