Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C4CC531C9
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC8710E301;
	Mon, 27 Jul 2026 16:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=adamthiede.com header.i=@adamthiede.com header.b="JwB7z/Gg";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FD610E301
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 16:34:51 +0000 (UTC)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h841z4v4WzMlJ8;
 Mon, 27 Jul 2026 18:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamthiede.com;
 s=MBO0001; t=1785170087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kO0CRx78Juq8i70OvsJ65ekpU28ajV9WCXKuSv7yYuA=;
 b=JwB7z/GgtbpAZgbjRhiyHgGQw+8bk/z7K6PVXDz4naudWDvb4OyZyUtOBCuJGJNLXLXk1i
 zvRtB6AxTWt/CIIGPT2UYIs5hEWM3U7pXX+gHMOlXz9DIZRCrP0yfTotaXI1W+uD/olWOm
 sPq9YmPD8C/QwH0MSJRSzukKs7SgxC6baJIsdKjaXNydj0hZRx662zd67ARiUBGgvKvfRv
 8e+19PyxjZ+qxH/EjfOykwFn7/GZ+CrwLDRVNZy/Tnq77jVVZ86DM5ewPSBgXZXrL/BEwx
 KTjgSvUvrhLZfklvtxd4tgPhVq68as3jEJXVzG+9+sdbvVuJ5YiL1b6yw7AW1Q==
Message-ID: <806f042f-cf40-451a-8412-eb4a5e31963f@adamthiede.com>
Date: Mon, 27 Jul 2026 11:34:40 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Gary Bisson <bisson.gary@gmail.com>
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
 <5c7e81e7-28e1-4993-ac4e-724ec7664ebf@collabora.com>
Content-Language: en-US
From: Adam Thiede <me@adamthiede.com>
Autocrypt: addr=me@adamthiede.com; keydata=
 xsBNBF+n+90BCAC2ZRLVcvdXDgfY7EppN05eNor3U7/eeiNCCEIWZkYLhikUEP1ReLGBkXpK
 Pc70hfnKAKkCoth3IwhDty9WXMNU+iLNei4ieb2luW+UqluR6xIUIA+txahMU9YcjVaQTKf/
 yZWO4yl6pfBPCxC2UdPZKBAdGoi5NnE0ABFNbhBETQhhBic533lZn33ByupfI3acECnQdjgQ
 llCUpDbw4I+S/N1iFiEHcbMXH7ZB00e3IYNorZ1E9v7p++5rDY1fQ9gXpieg1vFKwSq1NJWo
 9xx336YjaTUbX0EwrdKd9l8AktA3yRjckaK5TAcwSQaDtHvhpbl4ebvPhtwHh699MroXABEB
 AAHNH0FkYW0gVGhpZWRlIDxtZUBhZGFtdGhpZWRlLmNvbT7CwI4EEwEIADgCGwMFCwkIBwIG
 FQoJCAsCBBYCAwECHgECF4AWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1HxQAKCRAC7fV9
 o/vRzgyRB/wLqRCvvWhQCMgvzeKvru9wcXquhb77K8H/ByLbfiT8YBuP3lZFVh0IQhgO9Ylk
 fIoOJE4V+jjxyOnO2d9xjGbvAmmR6yT0gfLzSVWqrC4k+V9MWLv43nrNzxt41dvo5j824FAl
 X+zaiRZCdO8Jtxg5Elpiop2SKLi1utX1Z8i6YZh+ccJZlchUBAGUTk+D4UjK7vUcjLWT96ya
 CtdtTfXyw36CvGOPEWfc6++Kkl/5sgej1i7biPYzu/r0vssaQYTXKSrv6Cfa3Maa89ASiTtv
 q4qmhLnJeCrPxWlRAf6LEizeBEkOasYni2u8sp4wBezEq45Ozu45sfPkqLpPolG7zsBNBF+n
 +90BCADBRt+vrToRBEG580n77S99qSEkbKD+oJtCVyovnjMNkg0K9UG68LIeCX/ezngiV1M8
 JISvw5iFOuUFqGX/1hLl9wgt/YpuIrgWOp8XxkotavTCloLDvQmufJPO1L8bnnA+WgP2YgVZ
 5MJTj/t4DI+yQgysEjsH8aurHO2uuqgJE+xK+2dy6Cl/wskuGxObksSPmmFH5PH0Joziwrtl
 61ouLE2XwKbkMgIGEKkbFgbfwz3/QuLZGBni+OOtLzXeZ9wNTW/AHUPy6S9U4F+5z6/09fVT
 tTH0cvrgAGjbASlYx2VqGONXAsxCfjulq6ryJBFlPLp949c/JTTgOojukCSbABEBAAHCwHYE
 GAEIACACGwwWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1H0gAKCRAC7fV9o/vRzlamCACs
 vHw+0heTm+BfC3S8DUST6889gidIIwdqBep1ByzetCph7Bq8Y8BlT5YTX0u/bSKkxCzFgeTm
 vC341Q09ST2XjLAl1ZTdzGhH9gcgYyOw34pr5fPQRJLB392mPzD8YReRzciNbhWzj+DLgeVe
 ouyfGajd6jDjkf4FEq+trQLGZhpfsKn3JnDbzBUs945D50l/vz9q/QN3qZO+H4F6g8ZeMnqo
 FOEFN26xVtdEDr+0DNFsbgKmEzs675kdAY78ZZdbEetX/FSknxJ+FK1ZW3J7Yswwulj34AXP
 LB49Mk8Ot7fo6mdt0DkV11JS9LmKxKvpY+KTlrKG+i7pVCSZvVUx
In-Reply-To: <5c7e81e7-28e1-4993-ac4e-724ec7664ebf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/27/26 10:54, AngeloGioacchino Del Regno wrote:
> On 7/27/26 16:23, Thorsten Leemhuis wrote:
>> On 7/27/26 14:48, Gary Bisson wrote:
>>> On Mon, Jul 27, 2026 at 02:28:56PM +0200, Thorsten Leemhuis wrote:
>>>> [top-posting to facilitate]
>>>>
>>>> Gary, Angelo, what's the status here? It looks like this fell through
>>>> the cracks -- or was this issue fixed in between somehow? If yes: 
>>>> great!
>>>> If not: Would be good to finally resolve this, as we are long past "fix
>>>> within a week" rule of thumb from Linus:
>>>> https://www.kernel.org/doc/html/latest/process/handling- 
>>>> regressions.html#on-how-quickly-regressions-should-be-fixed
>>>
>>> Not much happened I'm afraid. The status as I see is:
>>> - this patch is necessary to have TI SN65DSI83 working
>>> - this patch also follows the DRM guidelines saying that HS clock must
>>>    be enabled during pre_enable (see previous answer / [1])
>>> - this patch has been successfully tested against MIPI-DSI panels (by
>>>    Angelo) and LVDS panels via TI bridge (by myself)
>>> - Adam reported an issue with another bridge (PS8640) where resume is
>>>    broken
>>> - Esben offered a patch to the TI bridge that would fix the issue we
>>>    were seeing in the first place.
>>>
>>> But for the last two points, I'm not sure this calls for a revert yet:
>>> - enabling HS clock in pre_enable still is what should be done [1]
>>> - maybe the issue Adam is facing is due to the bridge driver instead as
>>>    it could not be reproduced with another setup
>>> - Esben patch would break the SN65DSI83 init sequence, suggesting that
>>>    the culprit really is the MIPI bridge for not following the HS clock
>>>    requirement in pre_enable instead [2]
>> It's tricky, yes, but I suspect the right time for a revert was weeks
>> ago. What Linus afaics basically wants in situations like this (espe.
>> with two reporters) boils down to "something broke recently, no fix was
>> found within a week or maybe two, so we go back to the previous state to
>> restart from there -- and this is nothing bad, that's just done to buy
>> us time."
>>
>> If something is right by some hardware or DRM specs often doesn't matter
>> much. What makes this tricky is the fact that the revert might cause a
>> regression for those that relied on the functionally the change brought.
>> But I suspect even then Linus prefers a revert, as it's a recent change
>> that only went into 7.1. The quoted from Linus on this page cover this 
>> iirc:
>> https://www.kernel.org/doc/html/latest/process/handling- 
>> regressions.html#quotes-from-linus-about-regression
>>
>> If we can't agree on this, we maybe should ask Simona or Airlied for 
>> advice.
>>
>> Ciao, Thorsten
> 
> Thorsten,
> I agree with you, and it's fine for me to get this commit reverted, for 
> the sake
> of following the rule (which is something I agree about: as a user, the 
> last thing
> that should happen is to be afraid of what breaks if I update my 
> system!!!!),
> even though reverting this actually breaks anything that is not PS8640.
> 
> ......though......
> 
> Everyone, please, look at how fundamentally broken PS8640 is... Qualcomm 
> people had
> the same issue as what is currently happening here.
> 
> They had to fix their DSI driver, as it was kind-of broken in a vagualy 
> similar way
> compared to MediaTek - and then they found out that they needed (and 
> upstreamed) a
> *hack* that had to be done specifically for the PS8640 Bridge [1]: their 
> issue was
> never really resolved, as then the same bridge started casually working 
> for unknown
> reasons (is it still working?), so they removed the hack [2] and called 
> it a day.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux- 
> next.git/commit/drivers/gpu/drm/msm/dsi/dsi_manager.c? 
> h=next-20260726&id=ec7981e6c614254937b37ce0af9eac09901c05c5
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux- 
> next.git/commit/drivers/gpu/drm/msm/dsi/dsi_manager.c? 
> h=next-20260726&id=9e15123eca7942caa8a3e1f58ec0df7d088df149
> 
> Especially in [2], the assmption from Dmitry sadly isn't correct, 
> because this is
> happening now on MediaTek, and here Runtime PM makes sure that the 
> PS8640 is also
> being enabled "a wee bit" earlier than DSI... but that doesn't seem to 
> be enough.
> 
> 
> Now, here I'm kind of shotgunning at the driver, but I wonder if anyone 
> can try
> the following patch before reverting this commit in mtk_dsi? Adam?
> 
> ---
>   drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/ 
> bridge/parade-ps8640.c
> index 96332721cb69..54ebf2fc8d1c 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -665,6 +665,7 @@ static int ps8640_probe(struct i2c_client *client)
> 
>       ps_bridge->bridge.of_node = dev->of_node;
>       ps_bridge->bridge.type = DRM_MODE_CONNECTOR_eDP;
> +    ps_bridge->bridge.pre_enable_prev_first = true;
> 
>       /*
>        * Get MIPI DSI resources early. These can return -EPROBE_DEFER so
This does not fix the issue. I built 7.1.5 with this patch applied, and 
without the revert.
