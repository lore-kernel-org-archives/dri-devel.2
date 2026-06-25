Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F019CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA5510E194;
	Thu, 25 Jun 2026 08:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="limYh9jL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4D110E194
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:05:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DABF860217;
 Thu, 25 Jun 2026 08:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202D91F000E9;
 Thu, 25 Jun 2026 08:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782374739;
 bh=OOHFW3I2Mozg+pjgDGKqgRV1x2xRqQMXQpGRSpXK4io=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=limYh9jLuZbDS0F4wqXmQcmJzzAl0ZT1GX9Zkx5qVp/aCXAIQUPUa18WnwW7R3WZK
 kQ5vKUuac/Zo/yDcGdWsAqJnGl+iw2wUP/riOqaCII8ev7j14qmeoHKaiTCMsK7Moh
 rhD1eyUwPgisJwmfInNcanC383PRSDdT/FMDMDSfb+H2U3Oa0ivl802JCT8M5KBsoi
 QHOAp32ev5gIcbTqHYtD0OexS0BVQIkYbkU6m9NZcjyLIQ8nf4CMEvG9N4OECiIpLD
 Eh+AsEyGt2KKIuwGdO+5EA6KwotfveVN1Z03wKcuXFWeORCZBAMuGQO1w35mImGoEE
 ZR1YIyEfLHYgA==
Date: Thu, 25 Jun 2026 10:05:36 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 04/30] drm/display: scdc_helper: Add HDMI 2.0
 scrambling management helpers
Message-ID: <20260625-screeching-uptight-elephant-5bdaed@houat>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-4-445eb54ee1ed@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="uqkyfjdf52yhangd"
Content-Disposition: inline
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-4-445eb54ee1ed@collabora.com>
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


--uqkyfjdf52yhangd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 04/30] drm/display: scdc_helper: Add HDMI 2.0
 scrambling management helpers
MIME-Version: 1.0

On Tue, Jun 02, 2026 at 01:44:04AM +0300, Cristian Ciocaltea wrote:
> +static int drm_scdc_reset_crtc(struct drm_connector *connector,
> +			       struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_crtc *crtc;
> +	u8 config;
> +	int ret;
> +
> +	if (!ctx)
> +		return 0;
> +
> +	/*
> +	 * This is normally part of .detect_ctx() call path, which already holds
> +	 * connection_mutex through @ctx.  However, re-acquiring it with the
> +	 * same context is a no-op and makes the helper safe under any caller.
> +	 */
> +	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> +	if (ret)
> +		return ret;
> +
> +	if (!connector->state)
> +		return 0;
> +
> +	crtc = connector->state->crtc;
> +	if (!crtc)
> +		return 0;
> +
> +	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
> +	if (ret) {
> +		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((config & SCDC_SCRAMBLING_ENABLE) &&
> +	    (config & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40))
> +		return 0;

I don't think we should care about the bit clock ratio here. From a
technical standpoint, and since you ignore low rates for the scrambler
for now, they are indeed equivalents. But semantically, scrambler can be
enabled for any rate, and the bit clock ratio should be changed only for
rates higher than 340MHz.

This function makes sure to trigger a modeset when the scrambler is
enabled or not. From a spec point of view, it's somewhat orthogonal to
the bit clock ratio. From a function name point of view, it's
misleading.

So yeah, I'd just drop the check on the bit clock ratio here. Drivers
will then get to enable either when the commit actually happens.

Maxime

--uqkyfjdf52yhangd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajzhUAAKCRAnX84Zoj2+
dj3SAX0SNhtnQQwwUwEqFVWo858enoiUhStjnPWPl67++vzJWDs7nJ3DUfg6e2d7
4b54sboBfA/hKC5JoGp+7bbCtDq/Ux03xRKPTLqiT3+2m9OvF5Kp3NZF00tPzQus
N7RdxaxujA==
=2INP
-----END PGP SIGNATURE-----

--uqkyfjdf52yhangd--
