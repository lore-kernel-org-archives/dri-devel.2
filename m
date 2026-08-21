Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9ECC5DF97
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E341810F3BC;
	Fri, 21 Aug 2026 19:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="khkXNBX6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (unknown [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFDF10F3BC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787339056;
 bh=cN5Hs9aM4CuZ8hZeHA2SARcebndBk/+YrYkHHDZUcVU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=khkXNBX6sWtLZfrhTSmeCVE3JEH9h/eGNSQrGIEje28CaGN/O5Ehrzuvnpi9+S+QX
 DKU67k24l0uiI35O8jJNN9OLZEWXoL8djBD5Be0xXmmuWckxZHckvXC4q8+bxgfbQl
 XODweuAFo902lFXPEetHqy69BKWQQ0I1kE+HlU2LMrWZmul8azParAkOYnjR/zB+oD
 rEhzLR842XhXTZjgxZMCLLbCZDczoTBEAEqyK39rhDKp7cu1vJ4RYA4YTWAsODI977
 owV9hud6LGhSo6mK9YGHoX+ithEversZiAX8zIwbnZguXrROEAS6eCPxdBCjO/QvFX
 uOUNop/4BeG4Q==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 58D9317E07FD;
 Fri, 21 Aug 2026 21:04:15 +0200 (CEST)
Message-ID: <28743613-22ec-4208-ad55-d018764bf846@collabora.com>
Date: Fri, 21 Aug 2026 22:04:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/69] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Liu Ying <victor.liu@nxp.com>, Phong LE <ple@baylibre.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
 Maud Spierings <maud_spierings@hotmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-7-294364b2cf15@collabora.com>
 <20260819-amigurumi-lorikeet-of-infinity-fd8c2d@houat>
 <ad65a396-02fb-4816-b978-e3a0c46688b2@collabora.com>
 <20260820-gorgeous-adder-of-reading-5a93f3@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260820-gorgeous-adder-of-reading-5a93f3@houat>
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

On 8/20/26 7:56 PM, Maxime Ripard wrote:
> On Wed, Aug 19, 2026 at 10:33:04PM +0300, Cristian Ciocaltea wrote:
>> On 8/19/26 1:12 PM, Maxime Ripard wrote:
>>> On Fri, Jul 31, 2026 at 07:19:14PM +0300, Cristian Ciocaltea wrote:
>>>> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
>>>>
>>>> - A drm_connector_hdmi_scrambler_supported() helper to report whether
>>>>   the source supports the scrambling capability, based on the presence
>>>>   of the newly introduced .scrambler_{enable|disable}() callbacks in
>>>>   drm_connector_hdmi_funcs are mandatory
>>>> - A scrambler_needed flag to be managed by the hdmi state helpers based
>>>>   on the negotiated TMDS character rate and the source/sink scrambling
>>>>   capabilities
>>>> - A scrambler_enabled flag to track whether scrambling is currently
>>>>   active
>>>> - A delayed work item (scdc_work) to monitor sink-side scrambling status
>>>>   and retry the setup if the sink resets it
>>>> - A scdc_work_initialized flag to support lazy initialization of the
>>>>   work item on the first scrambling enable and guard the teardown paths
>>>>
>>>> These are intended to be used by SCDC scrambling helpers to coordinate
>>>> scrambling setup and teardown between the source driver and the DRM
>>>> core.
>>>>
>>>> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
>>>> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>  drivers/gpu/drm/drm_connector.c | 31 ++++++++++++---
>>>>  include/drm/drm_connector.h     | 83 +++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 109 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>>>> index 4721cdeafc84..a18410faf040 100644
>>>> --- a/drivers/gpu/drm/drm_connector.c
>>>> +++ b/drivers/gpu/drm/drm_connector.c
>>>> @@ -622,12 +622,29 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>>>>  	 * default with the actual controller capability. A value of zero keeps
>>>>  	 * the limit inferred from supported_hdmi_ver.
>>>>  	 */
>>>> -	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0)
>>>> +	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0) {
>>>> +		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable) {
>>>> +			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>>  		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
>>>> -	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_3)
>>>> -		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
>>>> -	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_0)
>>>> -		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
>>>> +	} else {
>>>> +		/*
>>>> +		 * Scrambler callbacks are only valid for connectors advertising
>>>> +		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
>>>> +		 * relies on their presence to report scrambling support.
>>>> +		 */
>>>> +		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable) {
>>>> +			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_3)
>>>> +			connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
>>>> +		else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_0)
>>>> +			connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
>>>> +	}
>>>
>>> I'd put it into a separate test (possibly earlier). Merging both the
>>> tmds rate default and the scrambler callbacks check makes it messier
>>> than it would be if we had two separate tests.
>>
>> Ack. How about the following?
>>
>> 	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0)
>> 		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
>> 	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_3)
>> 		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
>> 	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_0)
>> 		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
>>
>> 	if (hdmi_funcs->supported_tmds_char_rate) {
>> 		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_char_rate) {
>> 			drm_err(dev, "Enforced max_tmds_char_rate exceeds %llu spec limit\n",
>> 				connector->hdmi.max_tmds_char_rate);
>> 			return -EINVAL;
>> 		}
>>
>> 		connector->hdmi.max_tmds_char_rate = hdmi_funcs->supported_tmds_char_rate;
>> 	}
>>
>> 	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0) {
>> 		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable) {
>> 			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
>> 			return -EINVAL;
>> 		}
>> 	} else {
>> 		/*
>> 		 * Scrambler callbacks are only valid for connectors advertising
>> 		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
>> 		 * relies on their presence to report scrambling support.
>> 		 */
>> 		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable) {
>> 			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
>> 			return -EINVAL;
>> 		}
>> 	}
> 
> I don't think we need the else clause at all. It's not valid, but it's
> also not creating any issue.

As discussed a while ago, we used to have a scrambler_supported flag, inferred
from supported_hdmi_ver, which allowed helpers to verify the capability when
needed.  That flag has now been removed and replaced by
drm_connector_hdmi_scrambler_supported(), which relies exclusively on the
presence of the scrambler callbacks to report whether the capability is
supported. 

If we don't ensure that these callbacks are *not* set for HDMI 1.x cases, one
could set supported_hdmi_ver to HDMI_VERSION_1_4, for example, while still
providing the scrambler_{enable,disable} funcs.  This would lead to an
inconsistency between the maximum TMDS character rate inferred from
supported_hdmi_ver and the capability reported by
drm_connector_hdmi_scrambler_supported().

> I'd move that second check earlier together with the infoframe callbacks
> checks and so on too.

Ack.

>>>>  	if (hdmi_funcs->supported_tmds_char_rate) {
>>>>  		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_char_rate) {
>>>> @@ -635,6 +652,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>>>>  				connector->hdmi.max_tmds_char_rate);
>>>>  			return -EINVAL;
>>>>  		}
>>>> +
>>>>  		connector->hdmi.max_tmds_char_rate = hdmi_funcs->supported_tmds_char_rate;
>>>>  	}
>>
>> [...]
>>
>>>> +	/**
>>>> +	 * @scdc_work: Work item currently used to monitor sink-side scrambling
>>>> +	 * status and retry setup if the sink resets it.
>>>> +	 */
>>>> +	struct delayed_work scdc_work;
>>>> +
>>>> +	/**
>>>> +	 * @scdc_work_initialized: Tracks whether @scdc_work has been set up via
>>>> +	 * INIT_DELAYED_WORK(). The work item is initialized lazily on the first
>>>> +	 * scrambling enable, so this guards the teardown paths against touching
>>>> +	 * an uninitialized work item.
>>>> +	 */
>>>> +	bool scdc_work_initialized;
>>>> +
>>>
>>> Why should we track whether it's initialized or not? I'd always
>>> initialize it, but only ever schedule something if we're using the
>>> scrambler.
>>
>> Having this initialized in the connector would lead to a module dependency
>> cycle.
>>
>> Currently the work function lives in drm_hdmi_helper.c, which is built into
>> drm_display_helper module:
>>
>> static void drm_connector_hdmi_scdc_work(struct work_struct *work)
>> {
>> 	[...]
>> 	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
>> 	    !drm_scdc_get_scrambling_status(connector))
>> 		drm_connector_hdmi_try_scrambling_setup(connector);
>> 	[...]
>> }
>>
>> int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
>> 					 const struct drm_connector_state *conn_state)
>> {
>>
>> 	[...]
>> 	if (!hdmi->scdc_work_initialized) {
>> 		INIT_DELAYED_WORK(&hdmi->scdc_work,
>> 				  drm_connector_hdmi_scdc_work);
>> 		hdmi->scdc_work_initialized = true;
>> 	}
>> 	[...]
>> }
>>
>> If we move INIT_DELAYED_WORK() into the connector (i.e. in drm.ko), the work
>> function has to be reachable from there.  The following attempts to accomplish
>> that would fail:
>>
>> - Keep the work function in drm_hdmi_helper.c and export it from
>>   drm_display_helper.
>>
>> - Move the work function into drm_connector.c and export 
>>   drm_connector_hdmi_try_scrambling_setup(), or a wrapper function, from 
>>   drm_display_helper.
> 
> An alternative could be to move drm_connector_hdmi_init to
> drm_hdmi_helper.c, no?

I haven't considered this option so far, as I believe it would also require some
refactoring to get right - for example, moving HDMI-related initialization from
the generic drm_connector_init_only() to drm_connector_hdmi_init(), and
splitting drm_connector_cleanup() into a dedicated drm_connector_hdmi_cleanup()
utility.

> But yeah, if we can't let's keep it like that

Should I proceed with this refactoring, or would it be better to postpone it
until I send out the HDMI 2.1 patches, to avoid expanding this series even
further?

Thanks,
Cristian
