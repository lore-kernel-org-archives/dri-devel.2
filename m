Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD6BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 12:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB77310E0A9;
	Sat, 11 Jul 2026 12:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="Z4ZOCfVa";
	dkim-atps=neutral
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1497910E0A9
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1783772805; x=1784032005;
 bh=DtiWi6MODkSCkd9+MM7sUob/C9gfrkcTdQDOCr3HaVg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Z4ZOCfVagGLzb7NmPR5unZKbVzq7KvCOf4SkGgYZBXLLlUGfS6ZELqyIIkH2HPyz+
 /ZoOd1XXK6Qc6S0KwGuPt9ql7JT1eUdu1E1vsvvw9KhwVLq3rNNLDbQAFiKcdohCZQ
 BB9U+NHAN1uatfLZ5Lcb786L8tz229jYuN/PzEWzealC/ByD35Dp7RLCPG6MGWrdV2
 Ghl1I0oqZvsx+GEOa4rQX63yjwKy7YAYHu7vK1QYMoA4Cau6KHAoBjy+76F9hWl1Ot
 MK59kGy/6V2BIH6qGG8Xo5dqNyg83RGsKbIM/OiljQ5Q739M3c0NIb5zEFI0z2ejyl
 hOUkecvKbs+Iw==
X-Pm-Submission-Id: 4gy7H80M2nz1DDrP
From: Esben Haabendal <esben@geanix.com>
To: <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>,  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with
 premature PLL locking
In-Reply-To: <20260711115901.776051F000E9@smtp.kernel.org>
 (sashiko-bot@kernel.org's message of "Sat, 11 Jul 2026 11:59:01
 +0000")
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
 <chBX3JDWouBBGINJdo11hbT-ASZLlDvZuU0gaNJp0MVS_1e6FqR3vrBdulsfPr7_YeAVR4DaEwA3bEJ-sExo8Q==@protonmail.internalid>
 <20260711115901.776051F000E9@smtp.kernel.org>
Date: Sat, 11 Jul 2026 14:26:43 +0200
Message-ID: <87bjcdempo.fsf@geanix.com>
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

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Missing SRCU read lock release in error path of sn65dsi83_atomic_enable().
>
> Pre-existing issues:
> - [High] Missing SRCU read lock release in error path of sn65dsi83_reset_work().
> --
>
> --- Patch [2]: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with premature PLL locking ---
> commit 0c69248e520fff24e51d45bfab961991fbdb4267
> Author: Esben Haabendal <esben@geanix.com>
>
> drm/bridge: ti-sn65dsi83: Fix problem with premature PLL locking
>
> This patch moves the PLL locking sequence from atomic_pre_enable to
> atomic_enable. This ensures the DSI HS clock is running before attempting to
> lock the PLL.
>
> Link: https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com/
>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> index 32e9eadd7452f..e87bed3a6640b 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
>
> [ ... ]
>
>> @@ -712,11 +697,24 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
>>  {
>>  	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
>>  	unsigned int pval;
>> -	int idx;
>> +	int idx, ret;
>>
>>  	if (!drm_bridge_enter(bridge, &idx))
>>  		return;
>>
>> +	/* Enable PLL */
>> +	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);
>> +	usleep_range(3000, 4000);
>> +	ret = regmap_read_poll_timeout(ctx->regmap, REG_RC_LVDS_PLL, pval,
>> +				       pval & REG_RC_LVDS_PLL_PLL_EN_STAT,
>> +				       1000, 100000);
>> +	if (ret) {
>> +		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
>> +		/* On failure, disable PLL again and exit. */
>> +		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
>> +		return;
>
> [Severity: High]
> Does this error path leak the SRCU read lock acquired by drm_bridge_enter()?
>
> If the PLL lock fails and regmap_read_poll_timeout() returns an error, the
> function returns immediately without calling drm_bridge_exit(idx).
>
> This unreleased lock could cause subsequent calls to synchronize_srcu() to
> hang during module unload or bridge unplug.

Yes, that does look like a bug. I will fix it for v2.

>> +	}
>> +
>>  	/* Clear all errors that got asserted during initialization. */
>>  	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);
>
> [Severity: High]
> This is a pre-existing issue, but I noticed a similar pattern in another
> function in this file. Does sn65dsi83_reset_work() also leak the SRCU read
> lock on failure?
>
> drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_reset_work() {
>     if (!drm_bridge_enter(&ctx->bridge, &idx))
>         return;
>     ...
>     ret = sn65dsi83_reset_pipe(ctx);
>     if (ret) {
>         dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
>         return;
>     }
>     ...
>     drm_bridge_exit(idx);
> }
>
> Like the atomic_enable path, if sn65dsi83_reset_pipe() fails, it appears to
> return early without calling drm_bridge_exit(idx).

Yes.

But is it enough to call drm_bridge_exit(idx), or do we want to
enable_irq() also? We are calling disable_irq_nosync() before scheduling
reset_ork, so if don't enable it again in case of error, it will be
stuck disabled. But what is supposed to happen if/when
sn65dsi83_reset_pipe() fails?

If we enable_irq() again, are we just going to endure endless pain?

/Esben
