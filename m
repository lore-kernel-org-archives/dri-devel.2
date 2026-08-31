Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23B6C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C966910E27D;
	Mon, 31 Aug 2026 13:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="PiP6A4d1";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED54810E27D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1788181970; x=1788441170;
 bh=PD8ylREOH/STTl+VwOLFllFTP2Iaf1nif5PoLXQ6+Vc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=PiP6A4d1/z+qvt0uLv4MtLU0qiID2lWEb/rgc4fbWrWRLXUlffQTr2NfPgJRTnrCd
 4daaTdp1642C3ffqU73I8PXQ2XqhRBAvVgLzCjSrdSnc5bsLWiASnzUA8htQ0Yuvh/
 M6AqwPUQFV5V5JbUA/HvXNbVqqYz058O/mtzaC6/WBq0zcaucPlu+xrvgcDh02O4Kw
 sgQ0GyU7DU0hWxos77KbznvJisxIoe4rJO5JMrSi6cu/bpFdmW+pBZikQyFdngGwHi
 7cT4cwd8dZdPjVpt9wiLpw54ghQ+qu25dv8f2uicDVxkE5AqtRGCsFT5FQaRr3tNN0
 J0PDU9bXpcz3g==
X-Pm-Submission-Id: 4hYTtl3ZLjz2ScWc
From: Esben Haabendal <esben@geanix.com>
To: <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>,  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 5/5] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal
 sync timing
In-Reply-To: <20260810072653.515921F00A3A@smtp.kernel.org>
 (sashiko-bot@kernel.org's message of "Mon, 10 Aug 2026 07:26:52
 +0000")
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
 <20260810-nwl-dsi-fixes-v3-5-256da9d672e1@geanix.com>
 <mcSGy7EoSsDpaVsJfV5nJkv5f6NekcgqWjEc2a3y2pu4msCAOuHkbW_dOtdeGcj9_RY7DxBTu8Q1UxmtQYxR9w==@protonmail.internalid>
 <20260810072653.515921F00A3A@smtp.kernel.org>
Date: Mon, 31 Aug 2026 15:12:46 +0200
Message-ID: <87qzjev3g1.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

<sashiko-bot@kernel.org> writes:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Implicit 64-bit division using the `/` operator causes link errors on 32-bit architectures.
> - [Low] Integer overflow in `dsi->mode.clock * 1000` for high pixel clocks.
> - [Low] Redundant picosecond period conversion introduces precision loss and forces 64-bit math.
> --
>
> --- Patch [5]: [PATCH v3 5/5] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing ---
> commit 54cf1e5377e7b6795c12c78939b18d1607d54031
> Author: Esben Haabendal <esben@geanix.com>
>
> drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing
>
> The commit updates the NWL MIPI Host controller's horizontal sync timing
> calculations. It converts hfp, hsa, and hbp to DSI packet bytes and
> subtracts the packet header size. This aligns the timing configuration
> with the i.MX 8M reference manual.
>
>> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
>> index e90588299c5ea..87d22b3bd79c7 100644
>> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
>> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> [ ... ]
>> @@ -317,9 +322,62 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
>>  			      dsi->mode.hdisplay);
>>  	}
>>
>> -	nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
>> -	nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
>> -	nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
>> +	pclk_period = DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->mode.clock * 1000);
>
> [Severity: Low]
> Could this multiplication overflow on high pixel clocks? dsi->mode.clock is a
> signed 32-bit integer, so multiplying by 1000 could overflow if the clock
> exceeds roughly 2.147 GHz. The resulting negative number would then be
> sign-extended into a large unsigned long long for DIV_ROUND_UP_ULL(). Perhaps
> casting to 1000ULL would avoid this?

There is no 32-bit platform using this driver. Should/could we mark this
driver in some way to make it clear for sashiko-bot and others that it
is not relevant to consider 32-bit integer calculations for this driver?

>> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "pclk_period: %llu\n", pclk_period);
>> +
>> +	hs_period = DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->phy_cfg.mipi_dphy.hs_clk_rate);
>> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "hs_period: %llu\n", hs_period);
>> +
>> +	/*
>> +	 * Calculate the bytes needed, according to the RM formula:
>> +	 * Time of DPI event = time to transmit x number of bytes on the DSI
>> +	 * interface
>> +	 * dpi_event_size * dpi_pclk_period = dsi_bytes * 8 * hs_bit_period /
>> +	 * num_lanes
>> +	 * ===>
>> +	 * dsi_bytes = dpi_event_size * dpi_pclk_period * num_lanes /
>> +	 * (8 * hs_bit_period)
>> +	 */
>> +	hfp = hfront_porch * pclk_period * dsi->lanes / (8 * hs_period);
>> +	hbp = hback_porch * pclk_period * dsi->lanes / (8 * hs_period);
>> +	hsa = hsync_len * pclk_period * dsi->lanes / (8 * hs_period);
>
> [Severity: Low]
> Does calculating the period in picoseconds introduce unnecessary precision loss?
> By calculating pclk_period and hs_period first and then dividing them, the
> math effectively does (10^12 / pclk) / (10^12 / hs_clk). For example, 148.5MHz
> becomes 6735ps instead of 6734.0067ps. Using the raw clock rates directly
> might eliminate intermediate rounding errors.

I change the calculation to use the raw clock rates directly for next version.

> [Severity: High]
> Will this standard division operator cause build failures on 32-bit platforms?
> pclk_period and hs_period are 64-bit variables, so using the / operator here
> will result in undefined reference to __udivdi3 during linking on 32-bit
> architectures. Using div64_u64() or refactoring to use a 32-bit denominator
> would prevent this link error.

As mentioned above, there is no use of this driver on 32-bit platforms.

/Esben
