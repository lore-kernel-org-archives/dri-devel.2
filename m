Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5D7F9B5E8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF6110E98B;
	Wed, 22 Apr 2026 08:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.b="E4YVpead";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E892210E94F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:55:41 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso3535873f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuxon.dev; s=google; t=1776848140; x=1777452940; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uugn1Iy/EUw8QWPEjCkPMfHWiB+g/iglcdvhK7LYU78=;
 b=E4YVpeadwQD9f+DxKRSlNGrpdmwgTr8fReP7A/1bM+5Tw0fMLUEFJSKomKMdpNGyn0
 LChVnS/7GV1HUzfDD9sEtoMez6hpdTH6MI0wl6+d6ql1skgUnhmpaByFAw6iCifhVb12
 HhrX7NrNW8aJYYnPe5sfhxH7lc3sKIVKI7dPp3DlGBUJ2VPnF8GwTbDyduxsgQK95kxE
 YMEtKG16IJui08eyREGNxMZGku+lUfLOKP9s3Fgi34xV3Luqcg07TwAtQhjVcRbf1Q6Z
 +MA9WqKw85c117WCmxp98dKHegA6v9JvESyVCDry3Fk+n4ryZgDe/G9JXzKLCrzCR9CA
 p9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776848140; x=1777452940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uugn1Iy/EUw8QWPEjCkPMfHWiB+g/iglcdvhK7LYU78=;
 b=baV7Adr/htr+hZyTFWiVLA1cPr1gA9QDm29QjmD3h57ENtkR3RIRi4MdquGDE5DbHK
 76dDQBhJlF/OAUMACe9W/U/zV+Ud319ClmTMWPnwYVnWJc4RH6jbT/oPg5NiXuJhGKci
 sXTSv086cwKQ9OzXfqzQ0oj3ze19ZkdUnjwzahis5TpXI9woXrTYRQSjXsUQpV35WUtX
 2enDc+LAgBxtiOpj81vhm9mO+eVw7KjYqBIW3lvP+MiQH83nVtXRg7Ci149+g8yUIjuy
 QteXqNPFEKh4g49aRajL3Gfhm+1Uv0tPc7V54Kiw4R8Awt5VDdMltf4lzj5iexNcJalX
 DiBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Nohdvt/FN5jUhI4gvuyKpsXsRBcvrksAK9p8t4XzqH/ro1eEbOn+ngGhr3W4Z/Nox6A+3UYuCHBg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywh+6SsGzqqv1/Z6FMNxfJaJNHZNkzB5VQrOSn4VzhRNWLFhI2v
 CGA0vMXA6Pz9zDo6g4hirOURy+SNVjrqiDBiztACfEE2M0WJYdOBjz64CkBUgzo/o3Q=
X-Gm-Gg: AeBDiesTCqbyEqJOjI+hhGvfafV6qK/398gosSGa9k7X6A/jPAxQq2rHPoV08uAGo4K
 l3MHS6kKy+O/m9/pyoAu1PlA/g6SDkBl3+o3fAnyMBhQ49widvhZBBbvwL+iaobNDozIV2lHZme
 lUBsbXRfMEuFgWq8GpKDzWhWicixzhHvvwQjKj7arotXR5W+fQqhfki2V2470P+Taoy+j7fxBbi
 aBDjGr9Ub9Zgm6APYj8tjsMS9yUUJInFBtZzxgR2ZYkTIMioxn+6oT8KyAN4PuD7KcmRbB3cRE2
 pXn+0hktOcXskn7VLT2GlTwp8fAottOe1KLNhjPm3Zk4SZCbtpbP22kTR5IEdKd03jO1AaPdJGh
 VpK59c7hDhCIU6hu2//oPWZjrQVYm968w/BJTPp6mNWxfqSirybxaLeAhejr3SWButetVgMYLsY
 dAs/HADg2iVDrsNrilJz4nfzCnWi1kqzk9HemYWVvE5w==
X-Received: by 2002:a05:6000:2510:b0:43d:7508:c9c9 with SMTP id
 ffacd0b85a97d-43fe3e0984bmr34562736f8f.27.1776848139576; 
 Wed, 22 Apr 2026 01:55:39 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm43898728f8f.10.2026.04.22.01.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:55:39 -0700 (PDT)
Message-ID: <d087c4f0-024d-480d-8711-5a47610b99b4@tuxon.dev>
Date: Wed, 22 Apr 2026 11:55:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
 <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
 <td55nrjrchomtatyx5phbojvjipwh64gnlnydqame5xakviafp@ixzaju2lnkpm>
 <9523bd97-2730-4b99-b3d0-6accc7622478@tuxon.dev>
 <m225f2xw3xkzacscycaifnc4hb3mv3o6ezaxjyhtphnjo5cfw3@6smswij3txnc>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <m225f2xw3xkzacscycaifnc4hb3mv3o6ezaxjyhtphnjo5cfw3@6smswij3txnc>
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



On 4/21/26 14:22, Dmitry Baryshkov wrote:
> On Tue, Apr 21, 2026 at 12:11:28PM +0300, Claudiu Beznea wrote:
>> Hi,
>>
>> On 4/19/26 18:58, Dmitry Baryshkov wrote:
>>> On Fri, Apr 17, 2026 at 06:52:30PM +0100, Biju wrote:
>>>> From: Biju Das <biju.das.jz@bp.renesas.com>
>>>>
>>>> Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
>>>> mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
>>>> from 25 to 87 MHz. The LVDS module cannot be used at the same time as
>>>> MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
>>>> the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
>>>> MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
>>>> module.
>>>>
>>>> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>> ---
>>
>> [ ...]
>>
>>>> +/* -----------------------------------------------------------------------------
>>>> + * Bridge
>>>> + */
>>>> +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
>>>> +				     struct drm_atomic_state *state)
>>>> +{
>>>> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
>>>> +	const struct drm_bridge_state *bridge_state;
>>>> +	int ret;
>>>> +	u32 fmt;
>>>> +
>>>> +	/* Get the LVDS format from the bridge state. */
>>>> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
>>>> +	if (!bridge_state) {
>>>> +		dev_err(lvds->dev, "failed to get bridge state\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	switch (bridge_state->output_bus_cfg.format) {
>>>> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
>>>> +		fmt = RZG3L_LVDS_MODE_JEIDA;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
>>>> +		fmt = RZG3L_LVDS_MODE_VESA;
>>>> +		break;
>>>> +	default:
>>>> +		fmt = RZG3L_LVDS_MODE_VESA;
>>>> +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
>>>> +			 bridge_state->output_bus_cfg.format);
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	ret = pm_runtime_resume_and_get(lvds->dev);
>>>
>>> If this  fails for any reason, the atomic_disable() would still be
>>> called and it will decrement the counter, potentially undeflowing it.
>>> Consider switching to pm_runtime_get_sync(), which suits better here.
>>
>> AFAIK, the clocks of this HW blocks have MSTOP functionality. HW manual of
>> RZ/G3S [1] (should be the same for RZ/G3L as well) mentions the following in
>> the chapter 41.2.1. "If the master accesses a module that has the clock
>> stopped and the MSTOP bit set, a bus error will occur". [1]
>> MSTOP is set though the clock enable/disable APIs.
>>
>> The clocks on RZ/G3L are part of clock power domains. If the
>> pm_runtime_resume_and_get() fails (or any runtime PM resume calls), the
>> clocks will be off and MSTOP set. In this case, calling atomic_disable() or
>> any API setting HW registers will lead to sync aborts.
> 
> Then you've identified a bug in the code. The atomic_enable() doesn't
> fail, so for each enable there always will be an atomic_disable() call.
> 

Is this something that should be solved by individual drivers providing struct 
drm_bridge_funcs to the upper layers or by the subsystem itself?

Accessing HW w/o its power being on (whatever power means here, e.g. clocks, 
resets, regulators) seems odd and may lead to critical failures.

On some Renesas SoCs this used to work previously but it is not anymore with the 
addition of the so called MSTOP functionality.

Thank you,
Claudiu
