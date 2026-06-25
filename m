Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDC2CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ACE310F1A7;
	Thu, 25 Jun 2026 08:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lpwEnTR6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92EA10F1A7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782376041;
 bh=3/LY8KlTihlMDpw21vo/W499ESW2H40mbT2W0+IKHaE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lpwEnTR69cAw6BGZ8RcZ1Y0OKSSYaUSXjXIwI1l5nxNRP0Lldb+D9gIul57l6dhRu
 040xDbSq8R70JI2jTOjWwi6hrSvb1AI5W1EP9G74ykG7Brusm1zEiIGnMWVG5KMQ9o
 FxPRFv0/lCmeVlEoba4KDbhxqpQ8mm8uo92G9b3B+egsmOgOlXgyUSG11gDRoKgHSb
 WlE8NkQmscThLBWOx9Zjj4OrjN0xCunXHlz1+nlwaNgBNyyltBjGUMtJ3zERFNxgOQ
 3N0gjN604GcjfnkEW6Xs5OYvwPIn4bePFmHhn0k3SjULJAYtniYPtoso6EYLLPomh8
 BR04vvdB51zuQ==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9355B17E02B5;
 Thu, 25 Jun 2026 10:27:20 +0200 (CEST)
Message-ID: <0e8ae8b8-3a6e-49e1-acdd-27ce4921bd21@collabora.com>
Date: Thu, 25 Jun 2026 11:27:20 +0300
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
 <20260625-screeching-uptight-elephant-5bdaed@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260625-screeching-uptight-elephant-5bdaed@houat>
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

On 6/25/26 11:05 AM, Maxime Ripard wrote:
> On Tue, Jun 02, 2026 at 01:44:04AM +0300, Cristian Ciocaltea wrote:
>> +static int drm_scdc_reset_crtc(struct drm_connector *connector,
>> +			       struct drm_modeset_acquire_ctx *ctx)
>> +{
>> +	struct drm_device *dev = connector->dev;
>> +	struct drm_crtc *crtc;
>> +	u8 config;
>> +	int ret;
>> +
>> +	if (!ctx)
>> +		return 0;
>> +
>> +	/*
>> +	 * This is normally part of .detect_ctx() call path, which already holds
>> +	 * connection_mutex through @ctx.  However, re-acquiring it with the
>> +	 * same context is a no-op and makes the helper safe under any caller.
>> +	 */
>> +	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!connector->state)
>> +		return 0;
>> +
>> +	crtc = connector->state->crtc;
>> +	if (!crtc)
>> +		return 0;
>> +
>> +	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
>> +	if (ret) {
>> +		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if ((config & SCDC_SCRAMBLING_ENABLE) &&
>> +	    (config & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40))
>> +		return 0;
> 
> I don't think we should care about the bit clock ratio here. From a
> technical standpoint, and since you ignore low rates for the scrambler
> for now, they are indeed equivalents. But semantically, scrambler can be
> enabled for any rate, and the bit clock ratio should be changed only for
> rates higher than 340MHz.
> 
> This function makes sure to trigger a modeset when the scrambler is
> enabled or not. From a spec point of view, it's somewhat orthogonal to
> the bit clock ratio. From a function name point of view, it's
> misleading.
> 
> So yeah, I'd just drop the check on the bit clock ratio here. Drivers
> will then get to enable either when the commit actually happens.

Ack.

Thanks,
Cristian
