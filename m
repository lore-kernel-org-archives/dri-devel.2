Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D8AC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A1910ED9C;
	Wed, 22 Jul 2026 12:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IetJodkq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB9710E3E4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784722702;
 bh=hkrp+yDQRqwNUpeTFXjADV7o+wwH+RGlwUA/SvJw0HI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IetJodkqZT8jjWJexpncST6NRGxRRena5iFVjRMs/sIB69M3KYTnqEfEsRVESwMG1
 SHsAPJP8p0J6ieVCWd7tZn92GM4hnwMVHDj9k4xkx67ES2CS7NSPiJY/Glg1735iyL
 VR5f6XtjNAmNBeoz1j2rUk0S1XFOWmaM4mVcSs2YC4thsOOVfC959Ju3PK0ZakFnzg
 kCYTrebVzz+KXzq+pUv19la6ZAfcg3yjKGCabSvdOVcboSQP0Isy2u+J3lawwfOEcQ
 dERjibTQRf55wtYuwEs6tCAbXNDk42VDyqJ9/Dkw5q+R5D/ti14jBMvg2ZEWprn9U4
 N5C8T0TjbHy0w==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C197F17E0177;
 Wed, 22 Jul 2026 14:18:21 +0200 (CEST)
Message-ID: <ba22b854-be4b-4146-9e72-1da13bf41c08@collabora.com>
Date: Wed, 22 Jul 2026 15:18:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
 <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
 <tjsidlnvswo2rdhqa6jybxrnb47lxgmxdlfrfbasuh67wjbqoy@3a45n3zawvnf>
 <17753a1c-824a-4835-ac2d-8b2796bba1eb@collabora.com>
 <534b921c-638c-4fc3-b89e-5dfc1f269f96@collabora.com>
 <20260713-statuesque-nonchalant-seagull-b9c39d@houat>
 <91c3a825-3344-4ff5-8ea0-f8f057665b3f@collabora.com>
 <20260715-ancient-zealous-eagle-b13e94@houat>
 <dfca9032-98ca-4c61-b1b1-85fd05283d77@collabora.com>
 <20260716-astute-nippy-moose-bd22b5@houat>
 <62b3bsa7ucgo2g7w75wudt3aundl3hv57qgjr6kqfteve56rf7@w42tah2fnvml>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <62b3bsa7ucgo2g7w75wudt3aundl3hv57qgjr6kqfteve56rf7@w42tah2fnvml>
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

On 7/22/26 9:51 AM, Dmitry Baryshkov wrote:
> On Thu, Jul 16, 2026 at 03:50:29PM +0200, Maxime Ripard wrote:
>> On Wed, Jul 15, 2026 at 01:46:12PM +0300, Cristian Ciocaltea wrote:
>>> On 7/15/26 11:55 AM, Maxime Ripard wrote:
>>>> On Mon, Jul 13, 2026 at 01:23:00PM +0300, Cristian Ciocaltea wrote:
>>>>> On 7/13/26 11:50 AM, Maxime Ripard wrote:
>>>>>> On Thu, Jul 09, 2026 at 10:25:54PM +0300, Cristian Ciocaltea wrote:
>>>>>>> On 7/3/26 11:54 PM, Cristian Ciocaltea wrote:
>>>>>>>> On 7/3/26 5:34 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Thu, Jul 02, 2026 at 05:46:17PM +0300, Cristian Ciocaltea wrote:
>>>>>>>>>> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
>>>>>>>>>>
>>>>>>>>>> - A scrambler_supported flag to indicate whether the source supports the
>>>>>>>>>>   scrambling capability, in which case the newly introduced
>>>>>>>>>>   .scrambler_{enable|disable}() callbacks in drm_connector_hdmi_funcs
>>>>>>>>>>   are mandatory
>>>>>>>>>
>>>>>>>>> Do we need a flag? What would it mean if the flag is set, but the
>>>>>>>>> callbacks are not? Can we drop the flag and use the presence of the
>>>>>>>>> callbacks as a way to identify that scrambler is enabled?
>>>>>>>>
>>>>>>>> The flag is intended to be set only within drmm_connector_hdmi_init_with_caps()
>>>>>>>> when drivers advertise HDMI 2.x capability, in which case it also ensures the
>>>>>>>> callbacks are provided.  
>>>>>>>>
>>>>>>>> We could drop the flag and instead have the init helper clear the callbacks if
>>>>>>>> they were provided for HDMI 1.x.  This might slightly reduce code readability,
>>>>>>>> as it relies on checking the presence of individual callbacks - especially since
>>>>>>>> we plan to extend this further with HDMI 2.1 support, providing four or five
>>>>>>>> additional FRL-specific callbacks.
>>>>>>>
>>>>>>> I tried to replace the flag with a helper that checks the presence of (one of)
>>>>>>> the callbacks, but it's not straightforward to unset those for non-HDMI 2.x
>>>>>>> cases since the hdmi_funcs argument is immutable.
>>>>>>
>>>>>> I'm not sure why we would need to unset them. If the driver states that
>>>>>> it support HDMI 2.0, then it needs to be there, if it doesn't, then who
>>>>>> cares? it's not going to be used. We can log a warning that it's
>>>>>> inconsistent I guess, but there's no need to actively remove it.
>>>>>
>>>>> I was trying to address the use case where drivers provide the scrambler
>>>>> callbacks despite not supporting HDMI 2.0.
>>>>
>>>> Scrambling got introduced with HDMI 2.0. That doesn't make sense, but
>>>> it's not a total deal breaker, it's just going to be here unused. Hence
>>>> why I was suggesting to put a warning there if you wanted to.
>>>>
>>>>> If we replace the scrambler_supported flag with a helper checking the
>>>>> presence of the scrambler callbacks, then we would need to ensure the
>>>>> callbacks do not exist in this case.
>>>>
>>>> Keep it simple:
>>>>
>>>> if (hdmi_version >= HDMI_VERSION_2_0)
>>>>    if (funcs->scrambler_enable)
>>>>       hdmi->scramblers_supported = true
>>>>    else
>>>>       return -EINVAL
>>>> else
>>>>     drm_warn(warn, "Inconsistent HDMI version");
>>>>
>>>> We don't need anything more than that.
>>>
>>> I dropped the scrambler_supported flag and introduced a helper:
>>>
>>> static inline bool
>>> drm_connector_hdmi_scrambler_supported(struct drm_connector *connector)
>>> {
>>> 	return connector->hdmi.funcs && connector->hdmi.funcs->scrambler_enable;
>>
>> I'd add disable to that test
> 
> I'd make it an error, if there is only scrambler_enable without
> scrambler_disable (or vice versa).

hdmi_init() already guaranties that both scrambler callbacks must be present
when supported_hdmi_ver indicates HDMI_VERSION_2_0, and neither of them
otherwise.

Regardless, I've already added scrambler_disable to the check above to improve
code readability.

Thanks,
Cristian
