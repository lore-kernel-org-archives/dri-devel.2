Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3117C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B33F10E6DF;
	Thu,  9 Jul 2026 12:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bw4QuRx4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78ED310E6DF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783598717;
 bh=1yberYinq6zyUgvSxbhajG7UeHKw44InEUPFxLdWH90=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bw4QuRx4pKMiH1tit3u16NFSSAVpeNjCAa3/qrSfjL/Sxz9ll4M3j3nXwgHByoBGY
 1XIiVJAC0XRCfEoQc7Oj3Iy5I8b8ytPeVkwGL8bItk91vhtcZ/0KGsoSLgOaPWkMe0
 2Im0cIGstpERf/YkyTB9vaRXNTbrexcqpZrYZwzLjE+3S7P9eB731onkRBBm3Y3eUo
 BaB99g0IieBh2zDKvH4l6gC2aoiy83ZzmPGXy97ArauStPuix5JAAQWavgXm/leQC8
 XJUBh00WVx7onHt1zU22Si51ymvx1d4mePteuOdduZwyOWgCjoQJEOFwP0aaP2eBOM
 kBk8TrxUNMG/A==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 95AF117E05D3;
 Thu, 09 Jul 2026 14:05:17 +0200 (CEST)
Message-ID: <7989f202-05d4-4c76-afe1-830ad0b44337@collabora.com>
Date: Thu, 9 Jul 2026 14:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] drm/mediatek: mtk_dp: Add support for HotPlug
 Detection in DP AUX
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-11-angelogioacchino.delregno@collabora.com>
 <20260709120033.123891F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709120033.123891F000E9@smtp.kernel.org>
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

On 7/9/26 14:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Unhandled interrupt storm due to unconditional unmasking of AUX HPD interrupts on older SoCs.

Older SoCs can't trigger this path at all, as these have *non* functional AUX HPD
hence the AUX specific hpd interrupt can never be triggered.

> - [High] Unsafe read-modify-write on the interrupt clear register `MTK_DP_AUX_TX_P0_INT_CLR` causes lost interrupts.

No. That's the exact reason why MediaTek has a SETCLR strategy for many registers.
Interrupts can't be lost this way, and whatever I wrote there is indeed safe.

> - [Medium] Missing `legacy_regoff` addition when polling the AUX HPD status register `MTK_DP_AUX_P0_364C`.

It's missing on purpose. Old SoCs can't reach that code path.

> --
> 
> --- Patch [10]: [PATCH v4 10/12] drm/mediatek: mtk_dp: Add support for HotPlug Detection in DP AUX ---
> commit d87425adb9b3f30b1f231894a984a344e048ae99
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> drm/mediatek: mtk_dp: Add support for HotPlug Detection in DP AUX
> 
> This patch adds support for hotplug detection via DP AUX in MediaTek DP IP,
> avoiding the need to power up the entire eDP/DP IP. It introduces a new
> flag to select the HPD strategy.
> 
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
>> index ea970a9bfe936..772ba311a34a7 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>> @@ -1047,7 +1048,30 @@ static u32 mtk_dp_swirq_get_clear(struct mtk_dp *mtk_dp)
>>   	return irq_status;
>>   }
>>   
>> -static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
>> +static u32 mtk_dp_aux_hwirq_get_clear(struct mtk_dp *mtk_dp)
>> +{
>> +	u32 irq_status = mtk_dp_read(mtk_dp, MTK_DP_AUX_TX_P0_INT_STA);
>> +	u32 ret = 0;
>> +
>> +	if (irq_status) {
>> +		mtk_dp_update_bits(mtk_dp, MTK_DP_AUX_TX_P0_INT_CLR,
>> +				   irq_status, irq_status);
> 
> [Severity: High]
> Can this read-modify-write operation drop newly arrived interrupts?
> 
> mtk_dp_update_bits() uses regmap_update_bits() which performs a
> read-modify-write. By using irq_status as the mask, if the clear register
> reads back with new interrupt bits set (that arrived after the INT_STA read),
> the read-modify-write will preserve those new bits and write them back as 1s,
> unintentionally clearing them before they are handled.
> 
> Should a full mask (like DP_TX_AUX_INT_MASK) be used here instead to ensure
> non-target bits are zeroed out?
> 
>> +		mtk_dp_update_bits(mtk_dp, MTK_DP_AUX_TX_P0_INT_CLR,
>> +				   0, irq_status);
>> +	}
>> +
> 
> [ ... ]
> 
>> @@ -1062,8 +1086,28 @@ static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
>>   	return irq_status;
>>   }
>>   
>> +static inline u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
>> +{
>> +	if (mtk_dp->data->aux_hpd_supported)
>> +		return mtk_dp_aux_hwirq_get_clear(mtk_dp);
>> +
>> +	return mtk_dp_trans_hwirq_get_clear(mtk_dp);
>> +}
>> +
>>   static void mtk_dp_hwirq_enable(struct mtk_dp *mtk_dp, bool enable)
>>   {
>> +	u32 mask, val;
>> +
>> +	/* On SoCs with working AUX HPD, the transmitter HPD register is ignored by HW */
>> +	if (enable) {
>> +		mask = HPD_CONNECT_EVENT | HPD_INTERRUPT_EVENT | HPD_DISCONNECT_EVENT;
>> +		val = 0;
>> +	} else {
>> +		mask = DP_TX_AUX_INT_MASK;
>> +		val = DP_TX_AUX_INT_MASK;
>> +	}
>> +	mtk_dp_update_bits(mtk_dp, MTK_DP_TX_AUX_INT_MASKING, val, mask);
>> +
> 
> [Severity: High]
> Does this code risk causing an unhandled interrupt storm on older SoCs?
> 
> Since MTK_DP_TX_AUX_INT_MASKING is updated unconditionally, the AUX HPD
> interrupts are unmasked even if aux_hpd_supported is false.
> 
> If an older SoC triggers an AUX HPD interrupt, mtk_dp_hwirq_get_clear()
> will branch to mtk_dp_trans_hwirq_get_clear() and ignore the AUX interrupt,
> causing it to remain asserted and repeatedly trigger.
> 
> Should this unmasking be guarded by the aux_hpd_supported flag?
> 
>>   	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3418,
>>   			   enable ? 0 :
>>   			   IRQ_MASK_DP_TRANS_P0_DISC_IRQ |
> 
> [ ... ]
> 
>> @@ -2113,10 +2191,15 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp_aux *mtk_aux, unsigned long wa
>>   	u32 val;
>>   	int ret;
>>   
>> -	ret = regmap_read_poll_timeout(mtk_dp->regs,
>> -				       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
>> -				       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
>> -				       wait_us / 100, wait_us);
>> +	if (mtk_dp->data->aux_hpd_supported)
>> +		ret = regmap_read_poll_timeout(mtk_dp->regs, MTK_DP_AUX_P0_364C,
>> +					       val, !!(val & HPD_STATUS_DP_AUX_TX_P0_MASK),
>> +					       wait_us / 100, wait_us);
> 
> [Severity: Medium]
> Is the register address missing the legacy_regoff addition here?
> 
> Unlike mtk_dp_read() which automatically adds mtk_dp->legacy_regoff,
> regmap_read_poll_timeout() operates directly on the regmap.
> 
> If a platform with aux_hpd_supported also uses a non-zero legacy_regoff, this
> will poll the wrong physical register address. The fallback path for older
> SoCs correctly applies the offset manually.
> 
>> +	else
>> +		ret = regmap_read_poll_timeout(mtk_dp->regs,
>> +					       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
>> +					       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
>> +					       wait_us / 100, wait_us);
> 
