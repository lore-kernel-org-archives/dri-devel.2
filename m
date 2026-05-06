Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D83ACD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788F410E1D8;
	Wed,  6 May 2026 15:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D+60ZAYp";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30ADA10E1D8
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:23:27 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-38e7d983f79so67526981fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778081005; x=1778685805; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=az24m6lFf/0S0zdSQIJvRICpQO+S19ShbYuWlJJ8fe0=;
 b=D+60ZAYpUiwdgfmHMQPy1p+Hoo6rR1AGdeFU0YI+b2iZFUehpEHSLKBCUKMKqWlwTp
 uJUvVq94vfaOlyckX9oyD9Pti756TYds80J3xDWiJafk9NxTUMlLaSIwCQvhAUpOI1LO
 vXtF/NsB4IKD5ew5XXUZvhfc9Mqm6LyiBkpOUyFemTApHmKKmNEhSmXrarf/KPhGv03g
 SDLXfzZoYekMeFuRF9X+yMR8F4T9BMeaEAhdaSve4JWG1f/xxXdlOJb9txpD/0zthO/B
 VhQWEtR72nnScA5gBpgmEb5RglDYfuyzIunyBM+2ngvY2gQByIBPSG7XAQ8p22Wn/6Dd
 X+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778081005; x=1778685805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=az24m6lFf/0S0zdSQIJvRICpQO+S19ShbYuWlJJ8fe0=;
 b=EmjNx7F6U6WAwThH/NFJviot2CZcjsiGpCmADBimf4Psie1+d/L2Cs9ZYqpRGS47Hn
 a5Ck9WEHXZnPFh61SrIPaH2XbgV2lMolKjL8bzRWwz3PG3zTQrfUCkiTB9akMM1oh91o
 5rXbcwcIjeMAm+ayckQNEiGBdMpaB8pAw9LEVsJiMkWpwUjSNPHLtGTiEHaOJrQfWhKR
 szELbJtGHRCpDP2TZKhR5Q/oZCMk3hCUJamdsO0JjTnEbyy75IUiAF0HI+LkFi3v/OOF
 emxaROLpIHgTz20jqTmu1DduHlqu91QDrBrHXWcTMXfWcXrn9Af+ZELxQgsB++YB7L2D
 ACrg==
X-Gm-Message-State: AOJu0Yxm0ryg+UcrPRZ3eSxUj94fzNTIyDXnPip/YqIbUQ/Ax5QCqSqA
 fXn7UAbV+EVvGe0NmSp3GYtVgusI8AgMBp3BHLlMO30wW5Tzu4LZ1Snk
X-Gm-Gg: AeBDiesu+J8mWqnRvxlaFYa8OdEIq+lij+wCXJ1GtJ3Y5Cck/59Zkb7NiQgGA7uBkLI
 W2pTj+9ewzGhKFYzZ58zlFIm/FjvE2CWy2w+37rJ7NgcG0vKsfrQgr2b7cA3Pp2SGq5vbzB2RK1
 LmE0coRTGqi/uZ28/LnMSLuGaiZdqdNKfX4M9S19Z1DiXlL01OV5XkBeRdF+WzeTRvbIMKKVAtP
 d5iMcl9M++kQl6tkpVYW3zl8xXkQ3+T/vB6SkNASbiVR1EHfTTIw7d2vsENCK410N6qQc4d4O9w
 g3zYk7llzHO4FzFU6YdEHuLzeibKCHwI5s5p31TIJ4mgKIDyclhLiWd94pmHYCWkNi2bIhxIAq0
 ehw2rxybGen26hEOWszl2wLf+wM+YwNvPVWSpuwbZVF40W5mVLgohJq2yWjKB/lBWgzb+oPh0D9
 nF60wfNJ0E0Dsh3aVw/Y1EPOJUnJfKTE9mBCrc5TqaaznpxfrDdn3bC+V/jnuhkLhlGxyUOivTp
 g==
X-Received: by 2002:a05:6512:63ca:b0:5a8:8891:d7e2 with SMTP id
 2adb3069b0e04-5a88891d802mr1144127e87.14.1778081005119; 
 Wed, 06 May 2026 08:23:25 -0700 (PDT)
Received: from [192.168.2.20] (109-252-156-195.dynamic.spd-mgts.ru.
 [109.252.156.195]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a882e3589dsm1465348e87.30.2026.05.06.08.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 08:23:24 -0700 (PDT)
Message-ID: <d856c0aa-a21e-41c7-b57e-0252f1fbf8f0@gmail.com>
Date: Wed, 6 May 2026 18:23:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/bridge: tc358768: Support non-continuous clock
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <20260311-tc358768-v2-0-e75a99131bd5@ideasonboard.com>
 <20260311-tc358768-v2-4-e75a99131bd5@ideasonboard.com>
From: Dmitry Osipenko <digetx@gmail.com>
Content-Language: en-US
In-Reply-To: <20260311-tc358768-v2-4-e75a99131bd5@ideasonboard.com>
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

11.03.2026 10:48, Tomi Valkeinen пишет:
> The driver prints a warning if MIPI_DSI_CLOCK_NON_CONTINUOUS is set, and
> falls back to continuous clock mode. This was added in commit
> fbc5a90e82c1 ("drm/bridge: tc358768: Disable non-continuous clock mode").
> 
> However, there have been multiple changes to the driver since then, and
> at least in my setup, non-continuous clock mode works: I can see an
> image on the panel, and I can see the clock lanes being non-continuous
> with an oscilloscope.
> 
> So, let's enable MIPI_DSI_CLOCK_NON_CONTINUOUS support.
> 
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: João Paulo Gonçalves <joao.goncalves@toradex.com> # Toradex Verdin AM62
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 755ed6483b2e..a276fbc75dde 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -722,7 +722,6 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  {
>  	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
>  	struct mipi_dsi_device *dsi_dev = priv->output.dev;
> -	unsigned long mode_flags = dsi_dev->mode_flags;
>  	u32 val, mask, val2, lptxcnt, hact, data_type;
>  	s32 raw_val;
>  	struct drm_crtc_state *crtc_state;
> @@ -744,11 +743,6 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  	u32 dsi_vsdly;
>  	const u32 internal_dly = 40;
>  
> -	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
> -		dev_warn_once(dev, "Non-continuous mode unimplemented, falling back to continuous\n");
> -		mode_flags &= ~MIPI_DSI_CLOCK_NON_CONTINUOUS;
> -	}
> -
>  	tc358768_hw_enable(priv);
>  
>  	ret = tc358768_sw_reset(priv);
> @@ -1032,7 +1026,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  	tc358768_write(priv, TC358768_HSTXVREGEN, val);
>  
>  	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
> -		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
> +		       (dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
>  
>  	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>  	val = tc358768_ps_to_ns((lptxcnt + 1) * hsbyteclk_ps * 4);
> @@ -1099,7 +1093,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  
>  	val |= TC358768_DSI_CONTROL_TXMD;
>  
> -	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
> +	if (!(dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
>  		val |= TC358768_DSI_CONTROL_HSCKMD;
>  
>  	if (dsi_dev->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
> 

Acked-by: Dmitry Osipenko <digetx@gmail.com>
