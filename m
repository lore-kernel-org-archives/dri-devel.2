Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31101C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A9910F3A6;
	Thu, 10 Sep 2026 09:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Hpwx1d6K";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C137310F3A6
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789031140;
 bh=ENZtiC11cN8l9AXK3zwCWvbeBdYrcIe4dNlUeqoNVa4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Hpwx1d6KkcuuuuFphNt/pZ/VR8BjoOH5fv8MXS0R+5rm9HjX1Cd2liAZ6onBYK+la
 UCLg7HGxELLEciRfhop14a1zKwPvk4B1xFRtWouRB3QLlfH2jhCvXyDVRwRHOiQLvh
 uwUxJuCEdaRV/rfQnFmoZtEbxu3712xOozfhdI5whCMvB+k1i0Uzoe9LYbsdP9jq4o
 e70XRYF4vOLRWRqNCenNscEKPoAXHCqW5DN8G8npBiSAmWZr0RXmhT30HttnlubQwn
 aT0JDEf88wFwKzfSR1HiWUZlDIGJ0hdVnAA6cREzbbhtn1EpOwH3f4ra3pYe2PwY/l
 kgC7V9GLK8t0g==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C301817E05D3;
 Thu, 10 Sep 2026 11:05:39 +0200 (CEST)
Message-ID: <4e658914-7a17-444b-b20b-8d8b647238b5@collabora.com>
Date: Thu, 10 Sep 2026 11:05:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] phy: phy-mtk-dp: Add PHYD Lane EN register mask
 to SoC data
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 justin.yeh@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-12-angelogioacchino.delregno@collabora.com>
 <cydeh263kd5o2un27oeplqx2phe7vzhxvk53kr7dbvtplazafv@rs37qtkhguhj>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <cydeh263kd5o2un27oeplqx2phe7vzhxvk53kr7dbvtplazafv@rs37qtkhguhj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/9/26 19:25, Manivannan Sadhasivam wrote:
> On Tue, Jul 07, 2026 at 05:42:44PM +0200, AngeloGioacchino Del Regno wrote:
>> In preparation for adding support for the eDP PHY found in newer
>> SoCs, transfer the register mask for PHYD_TX_LN_EN to SoC specific
>> data.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/phy/mediatek/phy-mtk-dp.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
>> index 4603f28d1466..f5aadc5fdc42 100644
>> --- a/drivers/phy/mediatek/phy-mtk-dp.c
>> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
>> @@ -220,6 +220,7 @@ struct mtk_dp_phya_imp_sel {
>>    * @regs_ana_lane:  Register (layout) offsets for ana_lan
>>    * @regs_dig_glb:   Register (layout) offsets for dig_glb
>>    * @regs_dig_lane:  Register (layout) offsets for dig_lan
>> + * @mask_dig_tx_ln: Register mask for PHYD_TX_LN_EN field
>>    * @val_dig_bitrate:IP Version specific register values for Bit Rate setting
>>    * @ana_bias_r:     Internal resistance "R" Selection Settings (global)
>>    * @ana_cktx_imp:   TX Clock Impedance Selection Settings (global)
>> @@ -239,6 +240,9 @@ struct mtk_dp_phy_pdata {
>>   	const u8 *regs_dig_glb;
>>   	const u8 *regs_dig_lane;
>>   
>> +	/* Register masks */
> 
> Duplicate comment. With this removed,
> 

Sorry but I think you didn't understand what the comments are there: the kerneldoc
is used to describe the structure, of course, but the comments in between are used
as a way to describe (and kind of enforce) the order of members.

/* Register offsets */
u16 member1;
u16 member2;
....

/* Register maps */
const u8 *regs1;
const u8 *regs2;
...

/* Register masks */
u32 mask1;
u32 mask2;
....

etc.

Does that make sense now? :-)

Cheers,
Angelo


> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> - Mani
> 
