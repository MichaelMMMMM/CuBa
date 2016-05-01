/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef SCONTROLCOMPONENT_H
#define SCONTROLCOMPONENT_H
#include "AComponent.h"
#include "CControlFSM.h"

class CControlActionHandler;

class SControlComponent : public AComponent
{
public:
	static SControlComponent& getInstance();
	bool dispatch(const CMessage& msg) override;
public:
	SControlComponent(const SControlComponent&) = delete;
	SControlComponent& operator=(const SControlComponent&) = delete;
	~SControlComponent() override = default;
private:
	SControlComponent();
private:
	static SControlComponent* sInstance;
	CControlFSM mFSM;
};

#endif
