--Overlay Barrage
function c511001760.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001760.cost)
	e1:SetTarget(c511001760.target)
	e1:SetOperation(c511001760.operation)
	c:RegisterEffect(e1)
end
function c511001760.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c511001760.filter(c,cst)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and (not cst or c:GetOverlayCount()~=0)
end
function c511001760.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local chkcost=e:GetLabel()==1 and true or false
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001672.filter(chkc,chkcost) end
	if chk==0 then
		e:SetLabel(0)
		return Duel.IsExistingTarget(c511001760.filter,tp,LOCATION_MZONE,0,1,nil,chkcost)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001760.filter,tp,LOCATION_MZONE,0,1,1,nil,chkcost)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c511001760.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local og=tc:GetOverlayGroup()
		local ct=og:GetCount()
		if Duel.SendtoGrave(og,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,ct*500,REASON_EFFECT)
		end
	end
end
