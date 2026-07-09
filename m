Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9082DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0044510E6D3;
	Thu,  9 Jul 2026 12:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="c0Pu35mq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0DD10E6D3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783599422;
 bh=OR9YHbLNwYMQoOxdPeb/MsgoI/x7bUyfQ2QYnIgwfR4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c0Pu35mqDk9AFzlp/gU0iUqO8fNQrJXsNNdwxgCOPCSzwqmhZoyoNhVPLlZiP13bo
 T11/mwXeriXUv09Cr1eusdOLyxS9wyIbFyLTzw8biGL89Ej7fljGY2sK2dk+GEkLuI
 RKBZD9SSwPDRcNgCRlo/AYW4YAz+tymVZshHcUislhRlwiH6gQDVTdG3+z0LlfV2om
 7zC9hbExStQY5yRqi9r/HKu5s3BXS0gIKI3gou9JcM0Qbi/8g2WXNFD9jd0mMhmH1/
 GqW/o0iTK9OBRwrB+WhShtLfHUS8AnhBrx5sIMA44Wc214VNm2j8XnuhkqYcSRQror
 H6m1yh4bCvCMw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9DAEF17E062C;
 Thu, 09 Jul 2026 14:17:02 +0200 (CEST)
Message-ID: <cf19aa15-9253-40c3-b86b-c803b3deed84@collabora.com>
Date: Thu, 9 Jul 2026 14:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] drm/mediatek: mtk_dp: Add support for eDP1.5 IPs
 and MT8196 SoC
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-12-angelogioacchino.delregno@collabora.com>
 <20260709121111.23CC71F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709121111.23CC71F000E9@smtp.kernel.org>
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

On 7/9/26 14:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Flawed hardware reset sequence and register mask conflict for the new IP (hwip_v1p4) in mtk_dp_encoder_reset().
> - [High] Uninitialized calibration data is applied to PHY registers on MT8196 if a legacy device tree is used.
> 
> Pre-existing issues:
> - [High] Sleeping functions called from atomic context in bridge atomic callbacks.

None of those are valid, if you want more context, check below.

> --
> 
> --- Patch [11]: [PATCH v4 11/12] drm/mediatek: mtk_dp: Add support for eDP1.5 IPs and MT8196 SoC ---
> commit 21e6cb76ec5d736e41c62351d0dcc4f501bc644f
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> drm/mediatek: mtk_dp: Add support for eDP1.5 IPs and MT8196 SoC
> 
> Add support for MediaTek's Embedded DisplayPort (eDP) v1.5 IP as
> found in the MT8196 SoC and other variants, and enclose some of
> the new register writes in specific platform data booleans.
> 
>> --- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
>> +++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> [ ... ]
>> +#define REG_3FF8_DP_ENC_P0_3			0x1ff8
>> +#define ENC_PHY_STATE_RESET_ALL_MASK			GENMASK(7, 0)
>> +#define PHY_STATE_W_1_DP_ENC_P0_3			BIT(6)
>> +#define DP_ENCODER_DVO_ON_W_1				BIT(5)
>> +#define DP_ENCODER_PSR_XTAL_FREQ_MHZ_MASK		GENMASK(13, 9)
> 
> [ ... ]
> 
>> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> [ ... ]
>> +static void mtk_dp_encoder_reset(struct mtk_dp *mtk_dp)
>> +{
>>   	/* dp tx encoder reset all sw */
>>   	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
>>   			   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0,
>>   			   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
>>   
>> +	if (mtk_dp->data->hwip_v1p4) {
>> +		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004, 0,
>> +				   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
>> +		mtk_dp_update_bits(mtk_dp, REG_3FF8_DP_ENC_P0_3,
>> +				   ENC_PHY_STATE_RESET_ALL_MASK,
>> +				   ENC_PHY_STATE_RESET_ALL_MASK);
>> +	}
>> +
>>   	/* Wait for sw reset to complete */
>>   	usleep_range(1000, 5000);
>> -	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
>> -			   0, DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
>> +
>> +	if (!mtk_dp->data->hwip_v1p4)
>> +		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
>> +				   0, DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
>> +}
> 
> [Severity: High]
> Does ENC_PHY_STATE_RESET_ALL_MASK overlap with functional state bits
> like PHY_STATE_W_1_DP_ENC_P0_3 and DP_ENCODER_DVO_ON_W_1 defined in
> mtk_dp_reg.h?
> 

That's trolling!!! :-P

Yes, and that's on purpose.

> Also, could the new hwip_v1p4 sequence in mtk_dp_encoder_reset() leave the
> encoder PHY stuck in reset? The code asserts ENC_PHY_STATE_RESET_ALL_MASK
> before the wait, but there does not appear to be a step to deassert it after
> the sleep finishes.
> 

It's ok, because it's auto-cleared by HW.

>> @@ -2860,7 +3079,8 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_dp)
> [ ... ]
>>   	/* PHY calibration data is in mtk_dp only for legacy devicetree */
>> -	mtk_dp_get_calibration_data(mtk_dp);
>> +	if (mtk_dp->data->efuse_fmt)
>> +		mtk_dp_get_calibration_data(mtk_dp);
>>   
>>   	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
> 
> [ ... ]
> 
>> @@ -1359,8 +1550,10 @@ static int mtk_dp_phy_configure(struct mtk_dp *mtk_dp,
> [ ... ]
>>   	/*
>>   	 * For legacy, deprecated strategy, set partial PHY calibration here.
>>   	 * New-style will set all PHY calibrations with phy ops instead.
>>   	 */
>>   	if (mtk_dp->phy_dev)
>>   		mtk_dp_set_calibration_data(mtk_dp);
> 
> [Severity: High]
> If a legacy device tree is used on an MT8196 device, could this configuration
> apply uninitialized zeros to the PHY hardware?

If a legacy device tree is used on MT8196, this MediaTek maintainer (me) needs
a big vacation :-D

This is an impossible scenario.

> 
> In mtk_dp_register_phy(), mtk_dp_get_calibration_data() is skipped because
> efuse_fmt is NULL for mt8196_edp_data. However, mtk_dp_phy_configure() will
> still call mtk_dp_set_calibration_data() if the legacy phy_dev was created,
> potentially writing an unpopulated cal_data array directly to the registers.
> 

The legacy phy_dev can't be created, unless the DT is very-very-very wrong, and
if it is, this driver can't get a magic 8 ball.

>> +static void mtk_dp_encoder_force_bias_power_on(struct mtk_dp *mtk_dp)
>> +{
> [ ... ]
>> +	/* Wait for the MCU to get LDO ready in PHYD */
>> +	msleep(50);
> [ ... ]
>> +}
> 
> [ ... ]
> 
>> @@ -2580,6 +2795,10 @@ static void mtk_dp_bridge_atomic_disable(struct drm_bridge *bridge,
> [ ... ]
>>   	/* SDP path reset sw*/
>>   	mtk_dp_sdp_path_reset(mtk_dp);
>>   
>> +	/* Make sure BIAS is powered on after reset even when disabled */
>> +	if (mtk_dp->data->force_pwr_states)
>> +		mtk_dp_encoder_force_bias_power_on(mtk_dp);
>> +
>>   	/* Ensure the sink is muted */
>>   	msleep(20);
>>   }
> 
> [Severity: High]
> This is a pre-existing issue, but does this introduce an additional sleeping
> function into an atomic context path?
> 
> Since mtk_dp_bridge_atomic_disable() operates in an atomic context during
> modesetting, calling mtk_dp_encoder_force_bias_power_on() uses msleep(50),
> which could result in kernel warnings or system instability.
> 

It's not atomic context....
