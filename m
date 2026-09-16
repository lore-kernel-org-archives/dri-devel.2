Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19498C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F19310E3AF;
	Wed, 16 Sep 2026 10:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PV/0fH3I";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ECC110E784
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789556246;
 bh=M3Q8PsaLkKHlvIUr5hlqxV84+L4Iq4K5flIJuMgtdOA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PV/0fH3IdcGxbWl15FphMuau4ZVGT+IxC3hWi+8R0uiO9UpOOAf0ZLDvzZzWQSlvK
 i3gXWo0G/iipFPEelkQVrryw9kIlUyFTWMtRExKcrxVhwNUq4HCySvdnZtMu8ify0t
 M/VbhYT9Tjy7zaZ6dCj3XnnG1cjrcPO2Kn7D88RN1uS8UvFSkvi1U+fjlyclXR/TXl
 8Te76d9Rw8JwzYbsmeN3vV5qQalIygyz/ZXKwv50F58Agbwstzs8RulPlUzd7bN72v
 DBNSYhl6XU2IZ6+2T9htMgAqRErw8GGrFX1QSs9HSMGIGz7vRiZID5qtCfXXHk6iq8
 7J6evp+G2Uxfw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E035B17E0420;
 Wed, 16 Sep 2026 12:57:25 +0200 (CEST)
Message-ID: <1b7438ba-69c3-4c3d-b79b-2879b90fabc1@collabora.com>
Date: Wed, 16 Sep 2026 12:57:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/13] drm/mediatek: Implement Display Stream
 Compression support
To: Nikolai Burov <nikolai.burov@jolla.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "jitao.shi@mediatek.com" <jitao.shi@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "justin.yeh@mediatek.com" <justin.yeh@mediatek.com>,
 "jason-jh.lin@mediatek.com" <jason-jh.lin@mediatek.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-3-angelogioacchino.delregno@collabora.com>
 <GV1PR06MB8417DED4A9C82CE84248F5F5E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
 <14b99e0a-e08a-42af-b982-471cae869149@collabora.com>
 <GV1PR06MB841771AF67A658BF71D4F479E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <GV1PR06MB841771AF67A658BF71D4F479E4BA2@GV1PR06MB8417.eurprd06.prod.outlook.com>
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

On 9/15/26 20:51, Nikolai Burov wrote:
> On 9/15/26 6:05 PM, AngeloGioacchino Del Regno wrote:
> [...]
>>>> +    ret = drm_dsc_setup_rc_params(dsc, DRM_DSC_1_1_PRE_SCR);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Cannot find DSC RC params\n");
>>>> +        return ret;
>>>> +    }
>>>
>>> The defaults in MediaTek's downstream driver match DRM_DSC_1_2_444, not
>>> DRM_DSC_1_1_PRE_SCR, and the panel on my test device requires that even
>>> though it uses DSC v1.1. This may be a panel-specific problem, but have
>>> you tested this with any actual panels that need 1_1_PRE_SCR?
>>>
>>
>> My downstream uses 1_1_PRE_SCR... that's why it is like this.
>>
>> I can resolve it like
>>
>>       if (dsc->dsc_version_major == 1 && dsc->dsc_version_minor == 1)
>>           type = DRM_DSC_1_1_PRE_SCR;
>>       else
>>           type = DRM_DSC_1_2_444;
>>
>>       ret = drm_dsc_setup_rc_params(dsc, type);
>>
>> ...that will work, granted that the panel declares the correct DSC version.
>>
> 
> Unfortunately not, because DRM_DSC_1_2_444 is also needed for some v1.1
> panels. From drivers/gpu/drm/drm_dsc_helper.c:
> 
> /*
>   * Selected Rate Control Related Parameter Recommended Values from DSC v1.2, v1.2a, v1.2b and
>   * DSC_v1.1_E1 specs.
>   *
>   * Cross-checked against C Model releases: DSC_model_20161212 and 20210623
>   */
> static const struct rc_parameters_data rc_parameters_1_2_444[] = {
> ...
> 
> I'm pretty sure that my device is not using DSC v1.2.
> 
> Since this is definitely panel-specific and there seems to be no good
> way to detect the required parameters at the moment, this is probably
> something to fix later.
> 

Ok, let's just go with 1_2_444 then - makes sense... that's something
that must be accounted at the API level, because I know of some panels
that need the PRE_SCR set... and that's even if they're using v1.2, just
because - for whatever reason - some of the DSC params are stored in and
read from an OTP area of the DriverIC (and that would mismatch then with
the other params that are runtime-programmable from the DrIC view, which
results in pixel-garbage artifacts).

Not sure how many panels are doing that, but this is of course not a MTK
specific thing... I looked around, and apparently there's a mention of
that in the Intel driver as well - yay I'm not the only one who knows, lol.

(And I definitely didn't expect that to be the case anyway).

> [...]
>>> I don't quite understand what is going on here, even in the original
>>> driver before this patch. What is the point of setting VACT_NL twice?
>>> Does mtk_dsi_ps_control() really need to be called in mtk_dsi_poweron()
>>> if mtk_dsi_config_vdo_timing() ends up calling it a second time?
>>
>> I didn't do much research, but MT8173 and 8192 if I remember correctly
>> won't work
>> without this sequence. I saw that 2 years ago or something, so I don't
>> remember
>> all that clearly.
>>
> 
> Okay, it's fine to keep it as-is then to avoid breaking older SoCs. One
> change I would definitely recommend though is to move
> mtk_dsi_set_dsc_params() to the very beginning of the sequence, maybe
> even into mtk_dsi_host_attach().
> 
> Otherwise some parts of the code might end up relying on unpopulated
> parameters by accident, and it's harder to debug if they change in the
> middle of the sequence.
> 

Honestly, since it works right now, I would be happier to push this upstream
as-is, and then shuffle things around (for an optimization, or else) after
the fact.

The point is to have a working baseline upstream, then if needed improve it
later when further testing can be done - point is that there's a huge set
of patches that is restructuring everything, so I want to play safe as much
as I can in this moment - I think (and hope) you understand my feeling here.

> [...]
>> We can always come back to this in the future with a separate patch, and
>> we should
>> do just that, otherwise series versions will never come to an end :-)
>>
> 
> Agreed. My work is currently also based on the restructured mediatek-drm
> driver, but I will try to send follow-up patches for MT6858 support once
> some of this stuff lands upstream.
> 

That's... a w e s o m e !

This is a practical test of the restructured code on yet another platform,
and I'm happier now because it's a different type of device (as in, not a
laptop and not an aiot board).

Thanks for that, highly appreciated.

Cheers,
Angelo
