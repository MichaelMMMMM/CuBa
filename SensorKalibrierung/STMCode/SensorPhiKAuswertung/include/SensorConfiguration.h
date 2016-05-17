// Autor : Michael Meindl
// Datum : 17.05.2016
// Fixwerte wie Sensor Offsets und Umrechnungsfaktoren
#ifndef SENSORCONFIGURATION_H
#define SENSORCONFIGURATION_H
#include "Global.h"
#include "math.h"


namespace SensorConfig
{
	constexpr Int16 accX1Offset = -3141;
	constexpr Int16 accY1Offset = -813;
	constexpr Int16 accZ1Offset = -380;
	constexpr Int16 accX2Offset = -1794;
	constexpr Int16 accY2Offset = 781;
	constexpr Int16 accZ2Offset = 807;
	constexpr Int16 gyroZ1Offset = -55;

	constexpr float accIntToGFactor    = 0.000061;
	constexpr float gyroIntToDPSFactor = 0.00875;
	constexpr float pi				   = 3.14159265358979323846;
	constexpr float degToRadFactor     = 2 * pi / 360;
	constexpr float g = 9.81;

	constexpr float r_1 = 0.168;
	constexpr float r_2 = 0.0155;
	constexpr float mu  = r_1 / r_2;
}

#endif
