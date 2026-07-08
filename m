Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F2AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5354A10E108;
	Wed,  8 Jul 2026 10:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kYkhLOvM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6510210E108
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783506890;
 bh=r38RUfSMl071/WepmzPL1q5pZgDe09Mk7WtRRJTfhHY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kYkhLOvMuTOGRJo+VJHLXfzQrpNjqggw7D6lMlKQ5U2w5dVLU5nK8KJ3HlfhvYzPl
 k4WwEhDr1QmAtq5t1HAUHbK4E7x4QBt9fb5qR3ZxwHCz3DFvYWxugkKpbafJ80SUUk
 pN8CncCK8xe+cWRNGOzTOMw695eFQLb7mchp8EvvPA4wbVLr56Oju69UdNxFWaCX3o
 tyukUUsnsmC7bP3ErxyeaYwl/XNF378msdCKIlvA3L8PpgklSnCpjiE6c4+fILaJ19
 S6y1kpq009EHjB9+BZttFi9qyFtyPlYAj2l4YAWdYVQM7ZKM8VTNGKwkvkcaUScEY/
 H/Km9U2SbKMvg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3576E17E071A;
 Wed, 08 Jul 2026 12:34:49 +0200 (CEST)
Message-ID: <20de8b44-c27d-4471-ac36-931893f6ffd5@collabora.com>
Date: Wed, 8 Jul 2026 13:34:48 +0300
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
 <20260707-tested-alpaca-of-patience-e38d7c@penduick>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260707-tested-alpaca-of-patience-e38d7c@penduick>
Content-Type: text/plain; charset=UTF-8
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

On 7/7/26 3:30 PM, Maxime Ripard wrote:
> On Fri, Jul 03, 2026 at 11:54:33PM +0300, Cristian Ciocaltea wrote:
>>>>> -	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0)
>>>> +	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0) {
>>>> +		if (!hdmi_funcs->scrambler_enable ||
>>>> +		    !hdmi_funcs->scrambler_disable)
>>>> +			return -EINVAL;
>>>> +
>>>> +		connector->hdmi.scrambler_supported = true;
>>>>  		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
>>>> -	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3)
>>>> +	} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3) {
>>>>  		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
>>>> -	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0)
>>>> +	} else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0) {
>>>>  		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
>>>> +	}
>>>>  
>>>>  	if (caps->max_tmds_char_rate) {
>>>>  		if (caps->max_tmds_char_rate > connector->hdmi.max_tmds_char_rate)
>>>> +
>>>> +	/** @scdc_cb: Callback to be invoked as part of @scdc_work.
>>>> +	 *
>>>> +	 * Currently used to monitor sink-side scrambling status and retry
>>>> +	 * setup if the sink resets it.
>>>> +	 *
>>>> +	 * This is assigned by the framework when making use of
>>>> +	 * drm_connector_hdmi_enable_scrambling() helper.
>>>
>>> No such helper. 
>>
>> Right, I'll drop the reference to the helper name, as that's added later in the
>> series.
>>
>>> Also, please explain in the commit message, why do we
>>> need to keep it configurable. Why the default is not enough?
>>
>> We will need a separate callback to support HDMI 2.1, i.e. for link training
>> management.  I’ll update the commit message accordingly.
> 
> I think I'm equally confused as Dmitry here. If scdc_cb is only called
> if we're sending scrambled pixels but the monitor doesn't acknowledge it
> initially, then the only thing we need to do is "if the scrambler's
> enabled, call drm_scdc_set_scrambling()", then we don't need to set a
> callback. And even if we ever need to deal with HDMI link training, then
> we can still have the same function but with a couple of branches more.
I think I overengineered this by trying to keep the SCDC-related bits as much as
possible in drm_hdmi_helper.c.  I’ll drop this callback and move the logic into
drm_connector_hdmi_scdc_work().

Cristian
