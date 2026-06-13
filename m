Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D7ECD98CF
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 01:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD4510EB9F;
	Sat, 13 Jun 2026 01:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oRtcAJW/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791CF10EB9F
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781314204;
 bh=A0Fhtf7gjqLJuhoBRBiXhWj0GB7XnVMNfK4IpemDFWI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oRtcAJW/8KbnGXk89e/jzIq16DQOsRVAid2oW1M2rMIgNizldVcQu7EEkMJg6vaGH
 nBqkwPrnVMBUP2SEpHcJrqfX4J1PDNQYzA9i9nFfuEzjDK2oxpsX3peMPkaVLysDfs
 zl9FHuMbw5RBTkiMKYDsQHotRUDWzftvaPWIPEGiariaCMOe38XdWUAh5yPdZYsXsg
 Xr5wimHa+J1VX/GbE3AG6a4ZiUxLOZZisillPJIBZk4vyij0qsvnTIrEKETWCI1o1T
 K9RWaETDo4JbpKzY6C+PxOBdD0Q9bKQVmgP9pEX93QPDmnHFVEcbIytSpWWnr9Zj/H
 U5XoBLBqVU7oA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 30ABF17E03C6;
 Sat, 13 Jun 2026 03:30:03 +0200 (CEST)
Message-ID: <2f5ce8eb-ef47-4238-ad68-ce62981a1845@collabora.com>
Date: Sat, 13 Jun 2026 04:30:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/30] drm/display: scdc_helper: Add HDMI 2.0
 scrambling management helpers
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
 <20260602-dw-hdmi-qp-scramb-v7-4-445eb54ee1ed@collabora.com>
 <20260612-cordial-steadfast-cow-fcaf01@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260612-cordial-steadfast-cow-fcaf01@houat>
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

On 6/12/26 4:43 PM, Maxime Ripard wrote:
> On Tue, Jun 02, 2026 at 01:44:04AM +0300, Cristian Ciocaltea wrote:
>> +/**
>> + * drm_scdc_start_scrambling - activate scrambling and monitor SCDC status
>> + * @connector: connector
>> + *
>> + * Enables scrambling and high TMDS clock ratio on both source and sink sides.
>> + * Additionally, use a delayed work item to monitor the scrambling status on
>> + * the sink side and retry the operation, as some displays refuse to set the
>> + * scrambling bit right away.
>> + *
>> + * Returns:
>> + * Zero if scrambling is set successfully, an error code otherwise.
>> + */
>> +int drm_scdc_start_scrambling(struct drm_connector *connector)
>> +{
>> +	struct drm_display_info *info = &connector->display_info;
>> +	struct drm_connector_hdmi *hdmi = &connector->hdmi;
>> +	int ret;
>> +	u8 ver;
>> +
>> +	if (!hdmi->scrambler_supported) {
>> +		drm_scdc_dbg(connector, "Scrambler not supported, bailing.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!info->is_hdmi ||
>> +	    !info->hdmi.scdc.supported ||
>> +	    !info->hdmi.scdc.scrambling.supported) {
>> +		drm_scdc_dbg(connector, "Sink doesn't support scrambling.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	drm_scdc_dbg(connector, "Enabling scrambling\n");
>> +
>> +	ret = drm_scdc_readb(connector->ddc, SCDC_SINK_VERSION, &ver);
>> +	if (ret) {
>> +		drm_scdc_dbg(connector, "Failed to read SCDC_SINK_VERSION: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = drm_scdc_writeb(connector->ddc, SCDC_SOURCE_VERSION,
>> +			      min_t(u8, ver, SCDC_MAX_SOURCE_VERSION));
>> +	if (ret) {
>> +		drm_scdc_dbg(connector, "Failed to write SCDC_SOURCE_VERSION: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	hdmi->scdc_cb = drm_scdc_monitor_scrambler;
>> +	WRITE_ONCE(hdmi->scrambler_enabled, true);
>> +
>> +	ret = drm_scdc_try_scrambling_setup(connector);
>> +	if (!ret)
>> +		ret = hdmi->funcs->scrambler_enable(connector);
>> +
>> +	if (ret) {
>> +		WRITE_ONCE(hdmi->scrambler_enabled, false);
>> +		cancel_delayed_work_sync(&hdmi->scdc_work);
>> +		hdmi->scdc_cb = NULL;
>> +
>> +		drm_scdc_set_scrambling(connector, false);
>> +		drm_scdc_set_high_tmds_clock_ratio(connector, false);
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(drm_scdc_start_scrambling);
> 
> This is also pretty significantly different than what vc4 implemented. I
> don't necessarily mind, but claiming that it's functionally equivalent
> isn't true. I think it would be a much better strategy to turn the vc4
> code into helpers as is because it's been merged 4 years ago and we know
> it's solid.

As explained in patch 25, I think there's been a slight misunderstanding of how
the CRTC reset logic was actually implemented.

> Then, if you want to add additional checks and constraints (like the
> SCDC_SINK_VERSION) that's fine, but it should come on top, and with its
> own explanation.

I'll recheck if there's anything that I might have missed from the original
implementation, while moving the additional changes to separate patch(es).

Thanks,
Cristian
