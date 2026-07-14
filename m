Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458BEC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEE410EC81;
	Tue, 14 Jul 2026 08:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aT/ee9yE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D291810EC80
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784017793;
 bh=0z1IK69pS9jc49SbkL5azQzEAF3MoW806mjpXyXyOvI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aT/ee9yEREkPyq59qQsKaO0Vne6ZLmp13nINGbI8/uV2dAIPHDktBHnWzc/CMpXLU
 xhhmirWSLZyi+08ZXfv2yvLLfIGDhR2aDKvTS39oNRbZUgHR8rwxFsOpsxGmfSFLmP
 NKDXADPU9/dn8CQ7Aup2SnrqrL3g8TL7sY8r4WG6dJr20lXzz1NDLWuaB/KGrcAkZY
 /i88igMVpH/U0E8Ml4FRFjsgZ03xte5LaUJb3R/Pa4h9ojkd1DEga2JbnwLoSlwmsC
 oiIicGGV4+Q5K52yTNSITTjT0PdVtahyv94m9C6qzD0HuPZZehyEhuN3svvXVOjOgd
 m45Gyll8PpqQA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 23AB017E07AA;
 Tue, 14 Jul 2026 10:29:53 +0200 (CEST)
Message-ID: <cd633f0b-7f6b-42cf-b1e5-79ca56d62716@collabora.com>
Date: Tue, 14 Jul 2026 10:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: mediatek: Add support for MT8196 MIPI DSI PHY
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, vkoul@kernel.org, robh@kernel.org,
 olteanv@gmail.com
References: <20260713103805.23030-1-angelogioacchino.delregno@collabora.com>
 <20260713103805.23030-3-angelogioacchino.delregno@collabora.com>
 <20260713104835.B14401F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260713104835.B14401F000E9@smtp.kernel.org>
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

On 7/13/26 12:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Signaling voltage boost is exclusively tied to the absolute maximum clamped frequency, preventing high data rates from receiving the boost.
> --
> 
> --- Patch [2]: [PATCH v3 2/2] phy: mediatek: Add support for MT8196 MIPI DSI PHY ---
> commit a6b40caad1ac266a0481ef7b26baffceb672008c
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> phy: mediatek: Add support for MT8196 MIPI DSI PHY
> 
> This commit adds support for the MIPI DSI PHY found in the MediaTek MT8196
> SoC and its variants. It introduces a new register layout and basic D-PHY
> functionality needed to drive MIPI DSI displays.
> 
>> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c
>> new file mode 100644
>> index 0000000000000..eac3db9922dba
>> --- /dev/null
>> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c
> 
> [ ... ]
> 
>> +static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
>> +{
>> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
>> +	void __iomem *base = mipi_tx->regs;
>> +	u32 voltage = RG_DSI_PRD_REF_MINI;
>> +	u32 pres = MIPITX_PRESERVED_MINI;
>> +	unsigned long long pcw_calc;
>> +	unsigned int txdiv, txdiv0;
>> +	u32 pcw;
>> +
>> +	dev_dbg(mipi_tx->dev, "enable: %u bps\n", mipi_tx->data_rate);
>> +
>> +	if (mipi_tx->data_rate >= DSI_PHY_PLL_MAX_RATE_HZ) {
>> +		/* Select higher signaling voltage for fast data rates */
>> +		voltage = RG_DSI_PRD_REF_DEF;
>> +		pres = MIPITX_PRESERVED_DEF;
>> +		txdiv = 1;
>> +		txdiv0 = 0;
>> +	} else if (mipi_tx->data_rate >= 1000000000) {
> 
> [Severity: Medium]
> Does this logic unintentionally restrict the higher signaling voltage to only
> exact matches of the maximum PLL rate?
> 

Yes, it does. It's fine. This is on purpose.

There's a way to scale voltages a bit differently (for 4 different freq ranges)
but it's a bit messy to implement, needs me to have different displays to test
all different frequencies (which I don't have), and a bit more code.

The only frequencies that really need the higher signaling voltage are the ones
from 2GHz (which is currently the max frequency, but can be expanded later, as
there will be new HW supporting higher freqs, with the same signaling voltage
increase and the same code for it) onwards.


> Since mtk_mipi_tx_pll_determine_rate() clamps the clock rate to
> DSI_PHY_PLL_MAX_RATE_HZ (2.0 GHz), mipi_tx->data_rate can never exceed this
> value. Consequently, panels requesting data rates slightly below 2.0 GHz
> (for example, 1.99 GHz) will fall through to the 1.0 GHz branch instead of
> receiving the voltage boost and correct PLL dividers intended for fast data
> rates.
> 
> Could this conflation between the PLL octave band threshold and the maximum
> frequency clamp macro also break the PLL divider logic if the maximum
> supported rate limit is increased in the future?
> 
