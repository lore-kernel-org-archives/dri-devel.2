Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376CBC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9998110E285;
	Wed, 22 Jul 2026 11:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Z/8xhR+o";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742E610E285
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784721016;
 bh=OOkAMe5UF/WOH3fkqozayM8HxNs0tFDK0/zEC/ufH8I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z/8xhR+oSr7zSuITAXdjxAA6ucyaMSQK655Uy2KZ2lT0fC0DKsqcgLdtRWLT5WjaD
 /VITUpAKoGI08xb/kNwMUWuuo/TiQpR9B37Bn6/typT9rk8Yr43IZr587b576iCEfu
 Y1bjsb+esHvnMejDUKhQkg9YqyLvTV2IaOjrwLqcWpVM4Nc/IstOAdDpr3UeJopETG
 J9+B5H18F4t3WMXcho2AvATzeEdgOABsFMOj1B/MsmsHc4jJAha+Jz5HV/dJrCKWR8
 7Df3foPjjjpVPy3FREUXTu6mDh3olmK7tbMPRWCa+a4vhj2xWJzBVwl0WAOu5GNmcj
 Fm5FRP/tu2cIw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 21A5A17E0177;
 Wed, 22 Jul 2026 13:50:16 +0200 (CEST)
Message-ID: <bd03b8df-ff36-4eb3-986b-a307dfa37815@collabora.com>
Date: Wed, 22 Jul 2026 14:50:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector
 init helper
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
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
 <45113534-94ad-4a0f-8014-c04e9ab67a26@collabora.com>
 <hbnni3gonklcmfmsgsup7lcusvnqcu5jivq7hhzrus2el5c55i@kvm75nfqyntf>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <hbnni3gonklcmfmsgsup7lcusvnqcu5jivq7hhzrus2el5c55i@kvm75nfqyntf>
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

On 7/22/26 9:46 AM, Dmitry Baryshkov wrote:
> On Wed, Jul 15, 2026 at 01:34:19PM +0300, Cristian Ciocaltea wrote:
>> On 7/15/26 11:50 AM, Maxime Ripard wrote:
>>> On Fri, Jul 10, 2026 at 01:27:37PM +0300, Cristian Ciocaltea wrote:
>>>> On 7/8/26 1:11 PM, Cristian Ciocaltea wrote:
>>>>> Hi Maxime,
>>>>>
>>>>> On 7/7/26 7:10 PM, Maxime Ripard wrote:
>>>>>> On Fri, Jul 03, 2026 at 10:31:55PM +0300, Cristian Ciocaltea wrote:
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> Thanks for your quick review!
>>>>>>>
>>>>>>> On 7/3/26 5:05 PM, Dmitry Baryshkov wrote:
>>>>>>>> On Thu, Jul 02, 2026 at 05:46:15PM +0300, Cristian Ciocaltea wrote:
>>>>>>>>> In preparation for adding HDMI 2.x source capabilities, introduce struct
>>>>>>>>> drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_caps()
>>>>>>>>> helper.
>>>>>>>>>
>>>>>>>>> The existing drmm_connector_hdmi_init() helper currently takes
>>>>>>>>> individual capability arguments such as supported_formats and max_bpc.
>>>>>>>>> Adding more HDMI-specific arguments to that function would not scale
>>>>>>>>> well, so move those values into a dedicated capabilities structure and
>>>>>>>>> implement the existing helper as a wrapper around the new caps-based
>>>>>>>>> interface.
>>>>>>>>
>>>>>>>> I think, it was an intention of Maxime: make sure that every driver is
>>>>>>>> forced to provide some values here. With the struct-based init it is
>>>>>>>> easy to overlook or to ommit a value.
>>>>>>>
>>>>>>> Agreed that the struct-based init loses the compile-time guarantee that every
>>>>>>> argument is explicitly provided - that's a real downside.  
>>>>>>>
>>>>>>> I'd argue it's recoverable, though: the init helper validates the mandatory
>>>>>>> fields, so a driver that omits a required value gets rejected at init time
>>>>>>> rather than silently misconfigured.  The "you must provide sane values" property
>>>>>>> is expected to be preserved, just enforced at runtime instead of by the
>>>>>>> compiler. 
>>>>>>
>>>>>> Yeah, I don't think we can win with C here. Rust might, but we're
>>>>>> probably a long way from that.
>>>>>>
>>>>>>> The main motivation for the struct is scalability/maintainability as we add HDMI
>>>>>>> 2.x capabilities: new fields go into the struct rather than growing the helper's
>>>>>>> argument list, so existing callers don't need churny signature updates on every
>>>>>>> extension.
>>>>>>>
>>>>>>> FWIW, in the previous revision we discussed addressing the concern with a
>>>>>>> callback instead.  Sadly, I had to discard that approach, as it proved not
>>>>>>> flexible enough, e.g. drm_bridge_connector_init() computes caps dynamically, and
>>>>>>> would have required either stateful callbacks, or storing redundant/temporary
>>>>>>> cap data in driver-private structures just to satisfy the callback.
>>>>>>
>>>>>> I just realized something reviewing your patch: we don't necessarily
>>>>>> need an extra argument or a callback, we can just put these fields into
>>>>>> drm_hdmi_connector_funcs directly, and then validate them in init.
>>>>>
>>>>> If I understand correctly, we should drop the drm_connector_hdmi_caps struct
>>>>> introduced by this patch and move all its fields into drm_hdmi_connector_funcs.
>>>>>
>>>>> In that case, how should we proceed with drmm_connector_hdmi_init()? 
>>>>
>>>> Actually, this brings us to the callback issue: we cannot compute caps
>>>> dynamically, as it only works with static data, since funcs is supposed to be
>>>> immutable.
>>>
>>> Does it? The core and helpers must consider it immutable but it doesn't
>>> have to. drm_bridge_connector for example could totally allocate it and
>>> dynamically create it based on the bridge capabilities.
>>
>> If we take the VC4 case, is it fine to drop the const from the static
>> drm_connector_hdmi_funcs to allow dynamically setting up supported_hdmi_ver and
>> max_bpc in vc4_hdmi_connector_init()?
>>
>> static struct drm_connector_hdmi_funcs vc4_hdmi_hdmi_connector_funcs = {
>> 	.tmds_char_rate_valid	 = vc4_hdmi_connector_clock_valid,
>> 	...
>> }
>>
>> static int vc4_hdmi_connector_init() 
>> {
>> 	...
>>     
>> 	if (vc4_hdmi->variant->supports_hdr)
>> 		vc4_hdmi_hdmi_connector_funcs.max_bpc = 12;
>>
>> 	if (vc4_hdmi->variant->max_pixel_clock >= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ)
>> 		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_2_0;
>> 	else if (vc4_hdmi->variant->max_pixel_clock >= HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
>> 		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
>> 	...
>> }
> 
> I'm sorry for the late response, I was OoO. Why do we want to put data
> into the funcs part? My suggestion would be to put the data into the
> drm_connector_hdmi itself.
> 
> 
> Setting connector->hdmi.supported_hdmi_ver = HDMI_VERSION_1_4; is more
> idiomatic than passing it through the funcs.
On 7/22/26 9:46 AM, Dmitry Baryshkov wrote:
> On Wed, Jul 15, 2026 at 01:34:19PM +0300, Cristian Ciocaltea wrote:
>> On 7/15/26 11:50 AM, Maxime Ripard wrote:
>>> On Fri, Jul 10, 2026 at 01:27:37PM +0300, Cristian Ciocaltea wrote:
>>>> On 7/8/26 1:11 PM, Cristian Ciocaltea wrote:
>>>>> Hi Maxime,
>>>>>
>>>>> On 7/7/26 7:10 PM, Maxime Ripard wrote:
>>>>>> On Fri, Jul 03, 2026 at 10:31:55PM +0300, Cristian Ciocaltea wrote:
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> Thanks for your quick review!
>>>>>>>
>>>>>>> On 7/3/26 5:05 PM, Dmitry Baryshkov wrote:
>>>>>>>> On Thu, Jul 02, 2026 at 05:46:15PM +0300, Cristian Ciocaltea wrote:
>>>>>>>>> In preparation for adding HDMI 2.x source capabilities, introduce struct
>>>>>>>>> drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_caps()
>>>>>>>>> helper.
>>>>>>>>>
>>>>>>>>> The existing drmm_connector_hdmi_init() helper currently takes
>>>>>>>>> individual capability arguments such as supported_formats and max_bpc.
>>>>>>>>> Adding more HDMI-specific arguments to that function would not scale
>>>>>>>>> well, so move those values into a dedicated capabilities structure and
>>>>>>>>> implement the existing helper as a wrapper around the new caps-based
>>>>>>>>> interface.
>>>>>>>>
>>>>>>>> I think, it was an intention of Maxime: make sure that every driver is
>>>>>>>> forced to provide some values here. With the struct-based init it is
>>>>>>>> easy to overlook or to ommit a value.
>>>>>>>
>>>>>>> Agreed that the struct-based init loses the compile-time guarantee that every
>>>>>>> argument is explicitly provided - that's a real downside.  
>>>>>>>
>>>>>>> I'd argue it's recoverable, though: the init helper validates the mandatory
>>>>>>> fields, so a driver that omits a required value gets rejected at init time
>>>>>>> rather than silently misconfigured.  The "you must provide sane values" property
>>>>>>> is expected to be preserved, just enforced at runtime instead of by the
>>>>>>> compiler. 
>>>>>>
>>>>>> Yeah, I don't think we can win with C here. Rust might, but we're
>>>>>> probably a long way from that.
>>>>>>
>>>>>>> The main motivation for the struct is scalability/maintainability as we add HDMI
>>>>>>> 2.x capabilities: new fields go into the struct rather than growing the helper's
>>>>>>> argument list, so existing callers don't need churny signature updates on every
>>>>>>> extension.
>>>>>>>
>>>>>>> FWIW, in the previous revision we discussed addressing the concern with a
>>>>>>> callback instead.  Sadly, I had to discard that approach, as it proved not
>>>>>>> flexible enough, e.g. drm_bridge_connector_init() computes caps dynamically, and
>>>>>>> would have required either stateful callbacks, or storing redundant/temporary
>>>>>>> cap data in driver-private structures just to satisfy the callback.
>>>>>>
>>>>>> I just realized something reviewing your patch: we don't necessarily
>>>>>> need an extra argument or a callback, we can just put these fields into
>>>>>> drm_hdmi_connector_funcs directly, and then validate them in init.
>>>>>
>>>>> If I understand correctly, we should drop the drm_connector_hdmi_caps struct
>>>>> introduced by this patch and move all its fields into drm_hdmi_connector_funcs.
>>>>>
>>>>> In that case, how should we proceed with drmm_connector_hdmi_init()? 
>>>>
>>>> Actually, this brings us to the callback issue: we cannot compute caps
>>>> dynamically, as it only works with static data, since funcs is supposed to be
>>>> immutable.
>>>
>>> Does it? The core and helpers must consider it immutable but it doesn't
>>> have to. drm_bridge_connector for example could totally allocate it and
>>> dynamically create it based on the bridge capabilities.
>>
>> If we take the VC4 case, is it fine to drop the const from the static
>> drm_connector_hdmi_funcs to allow dynamically setting up supported_hdmi_ver and
>> max_bpc in vc4_hdmi_connector_init()?
>>
>> static struct drm_connector_hdmi_funcs vc4_hdmi_hdmi_connector_funcs = {
>> 	.tmds_char_rate_valid	 = vc4_hdmi_connector_clock_valid,
>> 	...
>> }
>>
>> static int vc4_hdmi_connector_init() 
>> {
>> 	...
>>     
>> 	if (vc4_hdmi->variant->supports_hdr)
>> 		vc4_hdmi_hdmi_connector_funcs.max_bpc = 12;
>>
>> 	if (vc4_hdmi->variant->max_pixel_clock >= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ)
>> 		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_2_0;
>> 	else if (vc4_hdmi->variant->max_pixel_clock >= HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
>> 		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
>> 	...
>> }
> 
> I'm sorry for the late response, I was OoO. Why do we want to put data
> into the funcs part? My suggestion would be to put the data into the
> drm_connector_hdmi itself.
> 
> 
> Setting connector->hdmi.supported_hdmi_ver = HDMI_VERSION_1_4; is more
> idiomatic than passing it through the funcs.

I've already done the conversion so that vendor, product, supported_formats and
max_bpc values previously passed as arguments are now provided through
drm_connector_hdmi_funcs, along with the additional supported_hdmi_ver and
supported_tmds_char_rate fields.

In most cases it wasn't necessary to pass this data dynamically (with the
exception of the bridge connector and some kunit tests), so it was just a matter
of extending the immutable hdmi_funcs structs.

I'll send v9 a bit later today so we can discuss directly on the code changes.

FWIW, in the VC4 case, I followed Maxime's suggestion and introduced three 
hdmi_funcs instances (+ a macro to avoid duplication) and assigned them to the
corresponding vc4_hdmi_variant entries:

#define VC4_HDMI_CONNECTOR_FUNCS_COMMON						\
	.vendor			 = "Broadcom",					\
	.product		 = "Videocore",					\
	.supported_formats	 = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |	\
				   BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |	\
				   BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),	\
	.tmds_char_rate_valid	 = vc4_hdmi_connector_clock_valid,		\
	.avi = {								\
		.clear_infoframe = vc4_hdmi_clear_avi_infoframe,		\
		.write_infoframe = vc4_hdmi_write_avi_infoframe,		\
	},									\
	.hdmi = {								\
		.clear_infoframe = vc4_hdmi_clear_hdmi_infoframe,		\
		.write_infoframe = vc4_hdmi_write_hdmi_infoframe,		\
	},									\
	...

static const struct drm_connector_hdmi_funcs vc4_hdmi_connector_funcs_hdmi14 = {
	VC4_HDMI_CONNECTOR_FUNCS_COMMON,
	.max_bpc		= 12,
	.supported_hdmi_ver	= HDMI_VERSION_1_4,
};

static const struct drm_connector_hdmi_funcs vc4_hdmi_connector_funcs_hdmi20 = {
	VC4_HDMI_CONNECTOR_FUNCS_COMMON,
	.max_bpc		= 12,
	.supported_hdmi_ver	= HDMI_VERSION_2_0,
	.scrambler_enable	= vc4_hdmi_scrambler_enable,
	.scrambler_disable	= vc4_hdmi_scrambler_disable,
};


static const struct vc4_hdmi_variant bcm2712_hdmi0_variant = {
	...
	.hp_detect		= vc5_hdmi_hp_detect,
	.hdmi_funcs		= &vc4_hdmi_connector_funcs_hdmi20,
};

vc4_hdmi_connector_init()
{
	...
	ret = drmm_connector_hdmi_init(dev, connector,
				       &vc4_hdmi_connector_funcs,
				       vc4_hdmi->variant->hdmi_funcs,
				       DRM_MODE_CONNECTOR_HDMIA,
				       vc4_hdmi->ddc);
	...
}

