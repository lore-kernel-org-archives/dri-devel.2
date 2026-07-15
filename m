Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28C1C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2500310E172;
	Wed, 15 Jul 2026 10:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CxCfyxWQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E606010E172
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784111660;
 bh=IkJnX4Q0f685MGMac/EYnUgIc/6fHPJFWwoic2nfCBc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CxCfyxWQoK2fMzcMWdxysiIbfEO8pWawDkEtOLsZZ0z/6FsDYUX9OULxrqC34oZBH
 N68/5SZtUEdYAw4scbkcZjpFg/Id+Eby8XuPmPeFHpm/q3EJX+NbmL0H1pjqvmWRw2
 gf/OEkv50g2ICcYVGLdLUgXivS9ZmP2fSOAxiHnTSWtIZyI4LK0n/p8oHW1qk3223k
 SRVRWYRp3xksrLBDUA/s2i7yxt8IetEFDamBHOYIJdxDpqlXBfdfDAKx4HrQ79DXi2
 W34Lpeah3JDsmGJLzVLIx1MxfDGrHbcBiVl8234GCfyq2FhRBGRDObQEGoUqUb2s9/
 JfJBXjRblX3zg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BAB4A17E0076;
 Wed, 15 Jul 2026 12:34:19 +0200 (CEST)
Message-ID: <45113534-94ad-4a0f-8014-c04e9ab67a26@collabora.com>
Date: Wed, 15 Jul 2026 13:34:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector
 init helper
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-2-d79890d00b6a@collabora.com>
 <i4tjtsf5rsckfcayo5nuhlger5wqxn3ujeaubm4g2fgrwvhzb2@hf4uhgq3ja5p>
 <ad75cf26-9437-47d0-864d-d71263401615@collabora.com>
 <20260707-illegal-tuna-of-force-1c06e3@houat>
 <737678ab-f082-4a0e-b453-f403ba141437@collabora.com>
 <80374deb-3246-413f-a043-66bcdb438ab1@collabora.com>
 <20260715-fair-opalescent-rhino-c6407b@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260715-fair-opalescent-rhino-c6407b@houat>
Content-Type: text/plain; charset=UTF-8
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

On 7/15/26 11:50 AM, Maxime Ripard wrote:
> On Fri, Jul 10, 2026 at 01:27:37PM +0300, Cristian Ciocaltea wrote:
>> On 7/8/26 1:11 PM, Cristian Ciocaltea wrote:
>>> Hi Maxime,
>>>
>>> On 7/7/26 7:10 PM, Maxime Ripard wrote:
>>>> On Fri, Jul 03, 2026 at 10:31:55PM +0300, Cristian Ciocaltea wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>> Thanks for your quick review!
>>>>>
>>>>> On 7/3/26 5:05 PM, Dmitry Baryshkov wrote:
>>>>>> On Thu, Jul 02, 2026 at 05:46:15PM +0300, Cristian Ciocaltea wrote:
>>>>>>> In preparation for adding HDMI 2.x source capabilities, introduce struct
>>>>>>> drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_caps()
>>>>>>> helper.
>>>>>>>
>>>>>>> The existing drmm_connector_hdmi_init() helper currently takes
>>>>>>> individual capability arguments such as supported_formats and max_bpc.
>>>>>>> Adding more HDMI-specific arguments to that function would not scale
>>>>>>> well, so move those values into a dedicated capabilities structure and
>>>>>>> implement the existing helper as a wrapper around the new caps-based
>>>>>>> interface.
>>>>>>
>>>>>> I think, it was an intention of Maxime: make sure that every driver is
>>>>>> forced to provide some values here. With the struct-based init it is
>>>>>> easy to overlook or to ommit a value.
>>>>>
>>>>> Agreed that the struct-based init loses the compile-time guarantee that every
>>>>> argument is explicitly provided - that's a real downside.  
>>>>>
>>>>> I'd argue it's recoverable, though: the init helper validates the mandatory
>>>>> fields, so a driver that omits a required value gets rejected at init time
>>>>> rather than silently misconfigured.  The "you must provide sane values" property
>>>>> is expected to be preserved, just enforced at runtime instead of by the
>>>>> compiler. 
>>>>
>>>> Yeah, I don't think we can win with C here. Rust might, but we're
>>>> probably a long way from that.
>>>>
>>>>> The main motivation for the struct is scalability/maintainability as we add HDMI
>>>>> 2.x capabilities: new fields go into the struct rather than growing the helper's
>>>>> argument list, so existing callers don't need churny signature updates on every
>>>>> extension.
>>>>>
>>>>> FWIW, in the previous revision we discussed addressing the concern with a
>>>>> callback instead.  Sadly, I had to discard that approach, as it proved not
>>>>> flexible enough, e.g. drm_bridge_connector_init() computes caps dynamically, and
>>>>> would have required either stateful callbacks, or storing redundant/temporary
>>>>> cap data in driver-private structures just to satisfy the callback.
>>>>
>>>> I just realized something reviewing your patch: we don't necessarily
>>>> need an extra argument or a callback, we can just put these fields into
>>>> drm_hdmi_connector_funcs directly, and then validate them in init.
>>>
>>> If I understand correctly, we should drop the drm_connector_hdmi_caps struct
>>> introduced by this patch and move all its fields into drm_hdmi_connector_funcs.
>>>
>>> In that case, how should we proceed with drmm_connector_hdmi_init()? 
>>
>> Actually, this brings us to the callback issue: we cannot compute caps
>> dynamically, as it only works with static data, since funcs is supposed to be
>> immutable.
> 
> Does it? The core and helpers must consider it immutable but it doesn't
> have to. drm_bridge_connector for example could totally allocate it and
> dynamically create it based on the bridge capabilities.

If we take the VC4 case, is it fine to drop the const from the static
drm_connector_hdmi_funcs to allow dynamically setting up supported_hdmi_ver and
max_bpc in vc4_hdmi_connector_init()?

static struct drm_connector_hdmi_funcs vc4_hdmi_hdmi_connector_funcs = {
	.tmds_char_rate_valid	 = vc4_hdmi_connector_clock_valid,
	...
}

static int vc4_hdmi_connector_init() 
{
	...
    
	if (vc4_hdmi->variant->supports_hdr)
		vc4_hdmi_hdmi_connector_funcs.max_bpc = 12;

	if (vc4_hdmi->variant->max_pixel_clock >= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ)
		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_2_0;
	else if (vc4_hdmi->variant->max_pixel_clock >= HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
	...
}

>> Moreover, we would end up with some redundancy, as most of these input fields,
>> after validation, would be stored (altered or not) directly in
>> drm_connector/drm_connector_hdmi structs.
> 
> I mean, part of the conversion would obviously be to remove the
> redundant fields.

Ack.
