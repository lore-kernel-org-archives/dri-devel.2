Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5783ECD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 10:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58F110E385;
	Thu, 21 May 2026 10:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZjKPykS4";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03D310E385
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 10:51:10 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso1243525e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1779360669; x=1779965469; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrQepb21ThYa5H25zJ7qisKCLfnMdtrz9jtuaFuhKz4=;
 b=ZjKPykS415ju4D99XG1Ivbdk7+FOsTqzhs5jouRYMEKYV3Z8by2Eb1n9rsFi4cERL6
 xKf5k72bmc/xRuKiJez01hatLIkrOLLQ+Pn2EOQniYe7DH+q0PI7FkPLLeWY4c8WJDae
 KxfiukyiiqZl6oS82kH/jvw2qUYOkVDQcVr1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779360669; x=1779965469;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrQepb21ThYa5H25zJ7qisKCLfnMdtrz9jtuaFuhKz4=;
 b=sNidnZs3Tb1zqrTHTo4lmWCfTNOgmtp2zx8skoX3DSwH1LavIEy/03wCOtuNQO/VLK
 eG3Nok7JKqueZPRv6uBcO4Oipd9Jr8NaMVv2kGaJjYASn1YXX9iwnSiU4hthJlYi6Hsw
 wUzwHPvkBM6yu4LxYCWoyFJbGV09mT/2s3BFN8V8CiSW4bTZq9RNeq+AKfhONy/UAqUR
 GgVNop/YE84RgRZUHECNinu1+kKc9clhiUudol+Pj11pw9xlGn03eavGSlwo4OlxxAHi
 rITymEP7KW3G28Wi+iEmFY3wqojsP34tf/VgMRbRHjeojsCAn9cZVRu0KwgIMxBRKWiR
 G8/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fAaDdZNhlLcC5RT8/zT40tPBLb8FEmsmXuX1hbGeobjbV+RMFikdhp9GF/3YrJdeuYdDFukfOS1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeReUiG6mLguHGDCp741gT38wyhZ12UVmo8adXz4BkhjtnEpOK
 U4EyyPQidhm1wB2e13GqcoKV1PLY05IDXQyVsnmUOoDWz9qrN5BQNJzkrLSMt74NuKg=
X-Gm-Gg: Acq92OE1S8grasR1LVL82MB3MGO1cUVcxdJp1jjiF0JRgJjgAfd0MiXw6l9plmDSZlZ
 LJmtzNic0SefTQ+7XmIFzBpzMUlLyvfJvA0MZ+Kz6hL0DEJoI1eEvPe4rNLiyIctT0xg5QhicbQ
 HRzABp0eA1cvfRdb/aRWEfgXX46c7rpEmNVwJ+ldG73EtxhGXLFC7Y8gR4d1vv4zcs6W1ZaaGz9
 WzgTJsDBKxafePnsN0sM4SJTQMt//gWXDSrZ9vIIrje2nymLdcQjJ4SF7J5sz7+3osENPefVobQ
 e8XOkaQZYR48W5y8a2Ha2ujfOljBXvDCCKTLut4AjHXBE0CMBHE77aSFj/B64ImMziux2A7PShW
 j2zQEKrQr2sJRMrNbhuIBCTSFQuvf2LozcMuSmPThgel2WlXYCdeemSnuqtAMDzgs7Xw+Npq4EF
 z2/r6mhRXaWiT4XLBgBHS2KqlSjgBFfHCvmd4=
X-Received: by 2002:a05:600c:4f16:b0:48f:e230:2a26 with SMTP id
 5b1f17b1804b1-490360e786bmr36579265e9.33.1779360669426; 
 Thu, 21 May 2026 03:51:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c1dad3sm20540925e9.1.2026.05.21.03.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 03:51:08 -0700 (PDT)
Date: Thu, 21 May 2026 12:51:06 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/28] drm/atomic_sro: Create kernel parameter to
 force or disable readout
Message-ID: <ag7jmuHUd7qqzXBu@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
 <20260423-drm-state-readout-v2-11-8549f87cb978@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-drm-state-readout-v2-11-8549f87cb978@kernel.org>
X-Operating-System: Linux phenom 6.19.10+deb14-amd64 
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

On Thu, Apr 23, 2026 at 12:18:24PM +0200, Maxime Ripard wrote:
> The hardware state readout is useful, but might need to be disabled
> in case of bugs, or its checks relaxed during development when not
> all hooks are implemented yet.
> 
> Add a module parameter to control the readout behavior: it can be
> disabled entirely, or the checks for missing compare or readout hooks
> can be skipped independently.
> 
> Suggested-by: Simona Vetter <simona@ffwll.ch>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_sro.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic_sro.h     |  2 ++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
> index 177b97d451f5..a46f06e75c4e 100644
> --- a/drivers/gpu/drm/drm_atomic_sro.c
> +++ b/drivers/gpu/drm/drm_atomic_sro.c
> @@ -11,10 +11,46 @@
>  #include <linux/module.h>
>  
>  #include "drm_internal.h"
>  #include "drm_crtc_internal.h"
>  
> +enum drm_atomic_readout_status {
> +	DRM_ATOMIC_READOUT_DISABLED = 0,
> +	DRM_ATOMIC_READOUT_ENABLED,
> +	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
> +	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
> +};
> +
> +static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
> +module_param_unsafe(atomic_readout, uint, 0);

Default is actually 0 here. I agree with the docs that it should be 1,
since drivers have an explicit opt-in through setting the main entry point
in drm_mode_config_funcs.

I was also pondering whether we should have a compare-only mode, but the
issue is that once you build a driver on readout being a thing, that could
blow up. So I think that should be left as a per-driver tunable.

That's also why this must be a unsafe debug option, it might actually
break the driver.

> +MODULE_PARM_DESC(atomic_readout,
> +		 "Enable Hardware State Readout (0 = disabled, 1 = enabled, 2 = ignore missing compares, 3 = ignore missing readouts and compares, default = 1)");
> +
> +/**
> + * drm_atomic_sro_device_can_readout - check if a device supports hardware state readout
> + * @dev: DRM device to check
> + *
> + * Verifies that the device is an atomic driver, that readout is
> + * enabled, and that all KMS objects implement the relevant hooks.
> + *
> + * RETURNS:
> + *
> + * True if the device supports full hardware state readout, false
> + * otherwise.
> + */
> +bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
> +{
> +	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))

I think this should be drm_drv_uses_atomic_modeset() since it's an
internal check, not an uapi check.

With the two issues addressed:

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> +		return false;
> +
> +	if (atomic_readout == DRM_ATOMIC_READOUT_DISABLED)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
> +
>  struct __drm_atomic_sro_plane {
>  	struct drm_plane *ptr;
>  	struct drm_plane_state *state;
>  };
>  
> diff --git a/include/drm/drm_atomic_sro.h b/include/drm/drm_atomic_sro.h
> index 5a9333a05796..6e5262384c71 100644
> --- a/include/drm/drm_atomic_sro.h
> +++ b/include/drm/drm_atomic_sro.h
> @@ -13,10 +13,12 @@ struct drm_plane;
>  struct drm_plane_state;
>  struct drm_printer;
>  struct drm_private_obj;
>  struct drm_private_state;
>  
> +bool drm_atomic_sro_device_can_readout(struct drm_device *dev);
> +
>  struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev);
>  void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state);
>  void drm_atomic_sro_state_print(const struct drm_atomic_sro_state *state,
>  				struct drm_printer *p);
>  
> 
> -- 
> 2.53.0
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
