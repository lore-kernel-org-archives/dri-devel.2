Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AD4C531C9
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B5510E17E;
	Mon, 27 Jul 2026 15:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YFUuvbNi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817CB10E17E
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785167644;
 bh=m/4LIVR30IBua4ghe8uxIwH1JxrU1wTrekYPUFn2Rys=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YFUuvbNi1+0GTNVtDtnF6tPnEvMf1kZ5wTgo6KSmp6GDFgDPMzihJY4SDrMy45HoG
 aRZ3F4h7/V6GaB0/8ER5EZ3ZaCfBB1Q4ixiiH1uyO7spXsuqy+V8g0LHDHULPIs/Wp
 TD9y6ioYsW241FwuDcOheZtyTOc/80dwwnsjSMVZNtvMEy08GzI05F9Ii4NqCuOwUB
 y5qe00SBfnl1jfwDJg68XZM3z3oovC1ki9DtwOHuHa0ANWrHBikwhJfmFrUw4jQj9t
 1RcXKUTdWU7/4QpIu8l0nlGEnD5M4Hg0LXs9d5LCF0pOkT+zFW0y9/rBdh4bd8jDh0
 CbYVoG9jTp2FQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7ACC617E051A;
 Mon, 27 Jul 2026 17:54:03 +0200 (CEST)
Message-ID: <5c7e81e7-28e1-4993-ac4e-724ec7664ebf@collabora.com>
Date: Mon, 27 Jul 2026 17:54:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Gary Bisson <bisson.gary@gmail.com>, Adam Thiede <me@adamthiede.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Esben Haabendal <esben@geanix.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <8733xko1ms.fsf@geanix.com>
 <0f719c00-3cf5-4403-afbf-713b07255981@collabora.com> <aleM9Wy9otpd6Je3@owl5>
 <aRN3_2FHX8XmTcwduTAPwz4UFde4B0tbB09ajyeUg5qZxiIYMmbvMkG7CPoNTl4iySYMZawbLMWijO47R22gkg==@protonmail.internalid>
 <65558ccc-4f2c-492d-8c74-627d27dce864@collabora.com>
 <87h5m0mkca.fsf@geanix.com> <alpTEPsy-SIQv_Oc@owl5>
 <b26a4890-12e9-4995-a71d-d0b7458b1570@leemhuis.info> <amdTnudq48tZUTG2@owl5>
 <1826ddd9-6edd-4481-a31d-6cbb083b3a56@leemhuis.info>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <1826ddd9-6edd-4481-a31d-6cbb083b3a56@leemhuis.info>
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

On 7/27/26 16:23, Thorsten Leemhuis wrote:
> On 7/27/26 14:48, Gary Bisson wrote:
>> On Mon, Jul 27, 2026 at 02:28:56PM +0200, Thorsten Leemhuis wrote:
>>> [top-posting to facilitate]
>>>
>>> Gary, Angelo, what's the status here? It looks like this fell through
>>> the cracks -- or was this issue fixed in between somehow? If yes: great!
>>> If not: Would be good to finally resolve this, as we are long past "fix
>>> within a week" rule of thumb from Linus:
>>> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed
>>
>> Not much happened I'm afraid. The status as I see is:
>> - this patch is necessary to have TI SN65DSI83 working
>> - this patch also follows the DRM guidelines saying that HS clock must
>>    be enabled during pre_enable (see previous answer / [1])
>> - this patch has been successfully tested against MIPI-DSI panels (by
>>    Angelo) and LVDS panels via TI bridge (by myself)
>> - Adam reported an issue with another bridge (PS8640) where resume is
>>    broken
>> - Esben offered a patch to the TI bridge that would fix the issue we
>>    were seeing in the first place.
>>
>> But for the last two points, I'm not sure this calls for a revert yet:
>> - enabling HS clock in pre_enable still is what should be done [1]
>> - maybe the issue Adam is facing is due to the bridge driver instead as
>>    it could not be reproduced with another setup
>> - Esben patch would break the SN65DSI83 init sequence, suggesting that
>>    the culprit really is the MIPI bridge for not following the HS clock
>>    requirement in pre_enable instead [2]
> It's tricky, yes, but I suspect the right time for a revert was weeks
> ago. What Linus afaics basically wants in situations like this (espe.
> with two reporters) boils down to "something broke recently, no fix was
> found within a week or maybe two, so we go back to the previous state to
> restart from there -- and this is nothing bad, that's just done to buy
> us time."
> 
> If something is right by some hardware or DRM specs often doesn't matter
> much. What makes this tricky is the fact that the revert might cause a
> regression for those that relied on the functionally the change brought.
> But I suspect even then Linus prefers a revert, as it's a recent change
> that only went into 7.1. The quoted from Linus on this page cover this iirc:
> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#quotes-from-linus-about-regression
> 
> If we can't agree on this, we maybe should ask Simona or Airlied for advice.
> 
> Ciao, Thorsten

Thorsten,
I agree with you, and it's fine for me to get this commit reverted, for the sake
of following the rule (which is something I agree about: as a user, the last thing
that should happen is to be afraid of what breaks if I update my system!!!!),
even though reverting this actually breaks anything that is not PS8640.

......though......

Everyone, please, look at how fundamentally broken PS8640 is... Qualcomm people had
the same issue as what is currently happening here.

They had to fix their DSI driver, as it was kind-of broken in a vagualy similar way
compared to MediaTek - and then they found out that they needed (and upstreamed) a
*hack* that had to be done specifically for the PS8640 Bridge [1]: their issue was
never really resolved, as then the same bridge started casually working for unknown
reasons (is it still working?), so they removed the hack [2] and called it a day.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/msm/dsi/dsi_manager.c?h=next-20260726&id=ec7981e6c614254937b37ce0af9eac09901c05c5
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/msm/dsi/dsi_manager.c?h=next-20260726&id=9e15123eca7942caa8a3e1f58ec0df7d088df149

Especially in [2], the assmption from Dmitry sadly isn't correct, because this is
happening now on MediaTek, and here Runtime PM makes sure that the PS8640 is also
being enabled "a wee bit" earlier than DSI... but that doesn't seem to be enough.


Now, here I'm kind of shotgunning at the driver, but I wonder if anyone can try
the following patch before reverting this commit in mtk_dsi? Adam?

---
  drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c 
b/drivers/gpu/drm/bridge/parade-ps8640.c
index 96332721cb69..54ebf2fc8d1c 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -665,6 +665,7 @@ static int ps8640_probe(struct i2c_client *client)

  	ps_bridge->bridge.of_node = dev->of_node;
  	ps_bridge->bridge.type = DRM_MODE_CONNECTOR_eDP;
+	ps_bridge->bridge.pre_enable_prev_first = true;

  	/*
  	 * Get MIPI DSI resources early. These can return -EPROBE_DEFER so
-- 
2.55.0

Cheers,
Angelo
