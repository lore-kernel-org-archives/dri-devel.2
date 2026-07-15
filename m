Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723DCC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD80B10E17A;
	Wed, 15 Jul 2026 10:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="a1x7CCuY";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E63610EFB8
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784112374;
 bh=Y/KBs2j+URnHAEFXdxv03n1EZjRY256pe45tY92sp2A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a1x7CCuYOFQ0iFeG0/UdjnHbh3eoJCpjm3qpcJNSz6pqh0gYK8zjgWWPNJINuvLUI
 JXIhkqi195vQiLdzXBr8aY2vD9wAsZTQt6zrAQcHlGu38BqZW4XaalyT5qHiR01yDF
 5eExmNkKD6ST1/u5EmqzkmBuBOlqZoBoo7LucB3aOgH5icFd044Cr2gedClUTmY48A
 UfE5IlkxUUDCWr4awcYEtbOvbBHBkx8P2TZw8+hrEyuM0FJhmalvxqeOigYw5NEr5q
 o+DlN8esrjrwddTbyfPCfupHMkHjcKDVuNqaF5KjE06KIJIMKwOdHlyYn7XJ4QhLua
 a7yyTuYE3LoWw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B15E17E00F6;
 Wed, 15 Jul 2026 12:46:13 +0200 (CEST)
Message-ID: <dfca9032-98ca-4c61-b1b1-85fd05283d77@collabora.com>
Date: Wed, 15 Jul 2026 13:46:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
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
 <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
 <tjsidlnvswo2rdhqa6jybxrnb47lxgmxdlfrfbasuh67wjbqoy@3a45n3zawvnf>
 <17753a1c-824a-4835-ac2d-8b2796bba1eb@collabora.com>
 <534b921c-638c-4fc3-b89e-5dfc1f269f96@collabora.com>
 <20260713-statuesque-nonchalant-seagull-b9c39d@houat>
 <91c3a825-3344-4ff5-8ea0-f8f057665b3f@collabora.com>
 <20260715-ancient-zealous-eagle-b13e94@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260715-ancient-zealous-eagle-b13e94@houat>
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

On 7/15/26 11:55 AM, Maxime Ripard wrote:
> On Mon, Jul 13, 2026 at 01:23:00PM +0300, Cristian Ciocaltea wrote:
>> On 7/13/26 11:50 AM, Maxime Ripard wrote:
>>> On Thu, Jul 09, 2026 at 10:25:54PM +0300, Cristian Ciocaltea wrote:
>>>> On 7/3/26 11:54 PM, Cristian Ciocaltea wrote:
>>>>> On 7/3/26 5:34 PM, Dmitry Baryshkov wrote:
>>>>>> On Thu, Jul 02, 2026 at 05:46:17PM +0300, Cristian Ciocaltea wrote:
>>>>>>> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
>>>>>>>
>>>>>>> - A scrambler_supported flag to indicate whether the source supports the
>>>>>>>   scrambling capability, in which case the newly introduced
>>>>>>>   .scrambler_{enable|disable}() callbacks in drm_connector_hdmi_funcs
>>>>>>>   are mandatory
>>>>>>
>>>>>> Do we need a flag? What would it mean if the flag is set, but the
>>>>>> callbacks are not? Can we drop the flag and use the presence of the
>>>>>> callbacks as a way to identify that scrambler is enabled?
>>>>>
>>>>> The flag is intended to be set only within drmm_connector_hdmi_init_with_caps()
>>>>> when drivers advertise HDMI 2.x capability, in which case it also ensures the
>>>>> callbacks are provided.  
>>>>>
>>>>> We could drop the flag and instead have the init helper clear the callbacks if
>>>>> they were provided for HDMI 1.x.  This might slightly reduce code readability,
>>>>> as it relies on checking the presence of individual callbacks - especially since
>>>>> we plan to extend this further with HDMI 2.1 support, providing four or five
>>>>> additional FRL-specific callbacks.
>>>>
>>>> I tried to replace the flag with a helper that checks the presence of (one of)
>>>> the callbacks, but it's not straightforward to unset those for non-HDMI 2.x
>>>> cases since the hdmi_funcs argument is immutable.
>>>
>>> I'm not sure why we would need to unset them. If the driver states that
>>> it support HDMI 2.0, then it needs to be there, if it doesn't, then who
>>> cares? it's not going to be used. We can log a warning that it's
>>> inconsistent I guess, but there's no need to actively remove it.
>>
>> I was trying to address the use case where drivers provide the scrambler
>> callbacks despite not supporting HDMI 2.0.
> 
> Scrambling got introduced with HDMI 2.0. That doesn't make sense, but
> it's not a total deal breaker, it's just going to be here unused. Hence
> why I was suggesting to put a warning there if you wanted to.
> 
>> If we replace the scrambler_supported flag with a helper checking the
>> presence of the scrambler callbacks, then we would need to ensure the
>> callbacks do not exist in this case.
> 
> Keep it simple:
> 
> if (hdmi_version >= HDMI_VERSION_2_0)
>    if (funcs->scrambler_enable)
>       hdmi->scramblers_supported = true
>    else
>       return -EINVAL
> else
>     drm_warn(warn, "Inconsistent HDMI version");
> 
> We don't need anything more than that.

I dropped the scrambler_supported flag and introduced a helper:

static inline bool
drm_connector_hdmi_scrambler_supported(struct drm_connector *connector)
{
	return connector->hdmi.funcs && connector->hdmi.funcs->scrambler_enable;
}

Therefore we need to ensure the callbacks are not set in the HDMI 1.x cases:

int drmm_connector_hdmi_init_with_caps()
{
	...
	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0) {
		if (!hdmi_funcs->scrambler_enable ||
		    !hdmi_funcs->scrambler_disable)
			return -EINVAL;

		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
	} else {
		/*
		 * Scrambler callbacks are only valid for connectors advertising
		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
		 * relies on their presence to report scrambling support.
		 */
		if (hdmi_funcs->scrambler_enable ||
		    hdmi_funcs->scrambler_disable)
			return -EINVAL;

		if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3) {
			connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
		} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0) {
			connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
		}
	}
	...
}
