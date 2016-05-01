/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef SCOMMCOMPONENT_H
#define SCOMMCOMPONENT_H
#include "Config.h"
#include "CTxBufferList.h"
#include "CRxBufferList.h"
#include "AComponent.h"
#include "CMessage.h"
#include "TUSART.h"

class SCommComponent : public AComponent
{
public:
	static SCommComponent& getInstance();
	void onUSARTIRQ();
	bool dispatch(const CMessage& msg) override;
public:
	SCommComponent(const SCommComponent&) = delete;
	SCommComponent& operator=(const SCommComponent&) = delete;
	~SCommComponent() = default;
private:
	SCommComponent();
private:
	static SCommComponent* sInstance;
	TUSART<ERegister::rUSART1> mUSART;
	CRxBufferList mRxBuffer;
	CTxBufferList mTxBuffer;
};

#endif
