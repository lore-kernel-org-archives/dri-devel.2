Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CBFCDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CF510E1C5;
	Thu, 25 Jun 2026 08:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ao50NhUv";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3042410E19C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782375563;
 bh=nCyO76GcZTqJ8IWlo+QkFWSRUHPwnxqO6bLkIAX5v30=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ao50NhUvUzm8tGdnsJslAfW/6WZAND9921SEJ92KLLqAo67oy0lHn16BQT2GeLIIb
 fhntkvmDwarLS9ae4u/ket3QEVFuCcVapcfKGXrvSEfuyoo6bDVbN8Wv4HWCtHYR0k
 o0d9jHUh6Ylqmcl3v2NTORcs3NQuJm2gn6A4G8e6Tb27XcvIN2v6apdjKkyyK77IzW
 61t7eoVxUpmPqYcJgi/K5pro6KA0CCMp/tC3RwgEzdkZ2hHWODB732DpEGLmLP5oCv
 DdmEpOsY6RGpDfVxVmfseW9ZO9wAtnK+9earnrKW+/S1jtMb0Xeg7UTftCNVs6HvxK
 HvYTO6M6X8IpA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DBA4717E03D7;
 Thu, 25 Jun 2026 10:19:22 +0200 (CEST)
Message-ID: <b520e77d-1ae3-4222-b442-e59442903107@collabora.com>
Date: Thu, 25 Jun 2026 11:19:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 25/30] drm/vc4: hdmi: Convert to common HDMI 2.0 SCDC
 scrambling helpers
To: Maxime Ripard <mripard@kernel.org>
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
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-25-445eb54ee1ed@collabora.com>
 <20260612-primitive-chital-of-tempering-18bc7c@houat>
 <8937d785-4daa-4246-9553-24aed7d279b5@collabora.com>
 <20260625-busy-ultra-oryx-ffb3c9@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260625-busy-ultra-oryx-ffb3c9@houat>
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

On 6/25/26 10:44 AM, Maxime Ripard wrote:
> On Sat, Jun 13, 2026 at 03:41:20AM +0300, Cristian Ciocaltea wrote:
>> Hi Maxime,
>>
>> On 6/12/26 3:04 PM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Tue, Jun 02, 2026 at 01:44:25AM +0300, Cristian Ciocaltea wrote:
>>>> Replace the vc4-local scrambling implementation with the newly
>>>> introduced DRM common SCDC scrambling infrastructure:
>>>>
>>>> - Advertise source-side scrambling support by setting
>>>>   connector->hdmi.scrambling_supported based on the variant's
>>>>   max_pixel_clock before drmm_connector_hdmi_init().
>>>>
>>>> - Provide minimal .scrambler_{enable|disable} connector callbacks that
>>>>   only toggle the VC5 HDMI_SCRAMBLER_CTL register.  Sink-side SCDC
>>>>   programming and periodic status monitoring are now delegated to
>>>>   drm_scdc_{start|stop}_scrambling().
>>>>
>>>> - Replace vc4_hdmi_enable_scrambling() with a conditional call to
>>>>   drm_scdc_start_scrambling() in post_crtc_enable, gated on
>>>>   conn_state->hdmi.scrambler_needed (computed by the HDMI state helper).
>>>>
>>>> - Replace vc4_hdmi_disable_scrambling() with drm_scdc_stop_scrambling()
>>>>   in post_crtc_disable.
>>>>
>>>> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>>>>   the .detect_ctx() path to
>>>>   drm_atomic_helper_connector_hdmi_hotplug_ctx() which internally calls
>>>>   drm_scdc_sync_status() to trigger a CRTC reset on reconnection.
>>>>
>>>> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>>>>   flag, now tracked by the common drm_connector_hdmi layer.
>>>>
>>>> - Drop vc4_hdmi_supports_scrambling() and
>>>>   vc4_hdmi_mode_needs_scrambling() helpers, inlining the remaining 4KP60
>>>>   warning with an explicit drm_hdmi_compute_mode_clock() check.
>>>>
>>>> - Seed connector->hdmi.scrambler_enabled = true in connector_init() to
>>>>   ensure drm_scdc_stop_scrambling() runs at boot and disables any stale
>>>>   scrambling state left by the bootloader.
>>>>
>>>> No functional change is expected for the supported modes.
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>
>>> I'd really like it to be broken down into several patches:
>>>
>>>> ---
>>>>  drivers/gpu/drm/vc4/vc4_hdmi.c | 265 ++++++-----------------------------------
>>>>  drivers/gpu/drm/vc4/vc4_hdmi.h |   8 --
>>>>  2 files changed, 35 insertions(+), 238 deletions(-)
>>>>

[...]

>>>> -
>>>> -	/*
>>>> -	 * HDMI 2.0 says that one should not send scrambled data
>>>> -	 * prior to configuring the sink scrambling, and that
>>>> -	 * TMDS clock/data transmission should be suspended when
>>>> -	 * changing the TMDS clock rate in the sink. So let's
>>>> -	 * just do a full modeset here, even though some sinks
>>>> -	 * would be perfectly happy if were to just reconfigure
>>>> -	 * the SCDC settings on the fly.
>>>> -	 */
>>>> -	return drm_atomic_helper_reset_crtc(crtc, ctx);
>>>> -}
>>>
>>> This one doesn't look functionally equivalent to me to
>>> drm_scdc_reset_crtc: this part was, in part, making sure we would only
>>> reset the scrambler if it was enabled in the first place.
>>> drm_scdc_reset_crtc() doesn't and will always trigger a modeset on
>>> hotplug. That's unnecessary and a significant functional different.
>>
>> drm_scdc_reset_crtc() alone was not meant to be an equivalent of
>> vc4_hdmi_reset_link(), as it only checks the sink side and it serves as an
>> internal helper used exclusively by drm_scdc_sync_status().  
>>
>> As a matter of fact, the latter is the one responsible for verifying if the
>> scrambler was enabled on the controller side before attempting to invoke the
>> reset logic, hence we should get the same behavior.  But we don't invoke it
>> directly either, it's part of the drm_atomic_helper_connector_hdmi_hotplug_ctx()
>> call path.
> 
> Oh, right, sorry.
> 
>>> I'd argue that it's drm_scdc_reset_crtc() that needs to align to what
>>> vc4 was doing, not the opposite.
>>
>> The only difference consists in dropping the crtc state check:
>>
>>     ret = drm_modeset_lock(&crtc->mutex, ctx);
>>     if (ret)
>>             return ret;
>>
>>     crtc_state = crtc->state;
>>     if (!crtc_state->active)
>>             return 0;
>>
>> The rationale was that when CRTC is inactive, drm_atomic_helper_reset_crtc()
>> should result in a no-op commit anyway.
> 
> A commit is expensive, so I'd skip it if we can.
> 
>> And the one for the in-flight commit:
>>
>>     if (conn_state->commit &&
>>         !try_wait_for_completion(&conn_state->commit->hw_done)) {
>>             mutex_unlock(&vc4_hdmi->mutex);
>>             return 0;
>>     }
> 
> And yeah, we'll need this one too.
> 
>> Both checks are also missing in drm_bridge_helper_reset_crtc(), taken as an
>> initial reference. Should we still keep any/both and sync the bridge helper
>> accordingly?
> 
> Yes, but I'd expect the bridge helpers to converge / reuse your helpers
> eventually anyway?

Ack.

[...]

>>>> -	vc4_hdmi_disable_scrambling(encoder);
>>>> +	drm_scdc_stop_scrambling(&vc4_hdmi->connector);
>>>
>>> I don't think the names here are right. It's not *only* related to scdc
>>> but also to the HDMI controller. I'm fine with using a scdc prefix but
>>> only for the things related to scdc. This is related (in part) to the
>>> HDMI controller, so it should use a drm_connector_hdmi prefix.
>>
>> Ack. I guess we should also move these helpers out of drm_scdc_helper.c, but
>> unsure where.  FWIW I'm currently working on adding HDMI 2.1 FRL support, and
>> implemented the link training in a dedicated drm_hdmi_frl_helper.c.  
>>
>> Should we create drm_hdmi_scrambler_helper.c?  Or maybe have a common one to
>> hold both - any suggestion for the naming?
> 
> display/drm_hdmi_helper.c sounds like a great place for both?

Indeed, let's move all the stuff there.

>>>>  	drm_dev_exit(idx);
>>>>  
>>>> @@ -1625,6 +1434,7 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
>>>>  	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
>>>>  	bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
>>>>  	bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
>>>> +	struct drm_connector_state *conn_state;
>>>>  	unsigned long flags;
>>>>  	int ret;
>>>>  	int idx;
>>>> @@ -1693,7 +1503,10 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
>>>>  	}
>>>>  
>>>>  	vc4_hdmi_recenter_fifo(vc4_hdmi);
>>>> -	vc4_hdmi_enable_scrambling(encoder);
>>>> +
>>>> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
>>>> +	if (conn_state && conn_state->hdmi.scrambler_needed)
>>>> +		drm_scdc_start_scrambling(connector);
>>>
>>> And the nice thing with a drm_connector_hdmi_* prefix is that you don't
>>> have to shoehorn it into SCDC support anymore, so you can take a state
>>> as an argument, and do the check in the helper instead of doing it in
>>> every driver and hoping they get it right.
>>
>> I was about to consider a similar approach before deciding to let drivers manage
>> the logic, i.e. to prevent loosing flexibility later when dealing with HDMI 2.1.
>> That was mostly in the context of supporting drivers to define if/when a display
>> mode that fits in TMDS should be sent over FRL. 
>>
>> Thinking again, that's not really a valid concern right now, e.g. will use TMDS
>> by default for all supported modes, and switch to FRL only when absolutely
>> required.  Later we might consider extending the infrastructure to support
>> dynamic control if required.
> 
> Thanks for working on FRL as well :)
> 
> I agree, let's focus on getting HDMI 2.0 right, and then we'll try to
> make 2.1 the easiest to work with for drivers.

Thanks for clarifying the remaining details — I should now have everything I
need to prepare a new revision. :)

Regards,
Cristian
