Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F9CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CD510F3FB;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d6E6rRrl";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5CC10E8DA
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:38:54 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-37df72c9984so2690961a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783337934; x=1783942734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPiB1VecAR3TN1u8hRdYEbrIAIhOnDTmSxtVCqyGQ3Y=;
 b=d6E6rRrlhLMbGAWVS5fyh5Iaz38KF8UwNnuK5AAL3OnrsKSlfeYs41ssx2mBNeQ5Zg
 OX0ev4Eqk81jkoQ49HiK1SLXqo8ycBSVyWWQwDEWbyL81hpyre4UEzKW+J6qQWdx29r3
 xSfHnLpPB2TnCRu9+GUZZ75g0tHAi/xhecb3K4ry+GagpPZXSGxQvODr0qcJC9vaURV0
 47p2B4DVS1P4MrMfvooa+U7CtHAsydEJnaMJdS6x0m3CZTT0dlnxT6yXJHzTy38JIK2q
 39ZAV7u59A46T08Uth5wObhjZ80MRjnNepLIpaJZ3ew09cn2CghPCmuRutqk5I3ZYFwG
 jH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783337934; x=1783942734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XPiB1VecAR3TN1u8hRdYEbrIAIhOnDTmSxtVCqyGQ3Y=;
 b=Fue/YgFXj9E86YU8v0qbwujXGPnnpqoFUEE0hHiuuY157dmYVnR+a/wSm8gz5QtYNz
 AxvwnWg3GWc+vJOi+O8s3fRsN54J+5Wz+koJSjCEhqnnjbFhHHUYwq5LqdiOvLtzw7IV
 GdbRKTgi3BybKCFSHU3oedzA2VAnDcZxmzbu9/mpQL6BA/VFGl7XJbcJe4b68aoLwrNZ
 mo8pIT+ndYm9Uc40z8zqeSnglefaaunhK4aJd4o1DqpwMHZlbOgGNPR8tVCETJxEkp5R
 PJjx6DrLOWYaU4O1lr/eccVly1r53TkmPfPs9KrDMdmZLE8jFncsn0YPdwtNf6mIF5Pi
 8lxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RokaaY8xWZQda/zBtv3mqJFj7ILM+DZPNr6hBWBwMuEpY0jcwsPLgbr8H6KcsP/8FGHApJALd2GEvc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysAabfMLlDRLU1T1bTMQRuF/iOJlVp8sOCtqZ4o9SyEQfhO/Oa
 gVM6pUY4/WE0vAfbNSV6cNsn2eS0TZHDaOEz+ILUYGOzl5Xtc7tTRAGt
X-Gm-Gg: AfdE7cm4gi/f/1Mn+DTrOapK6dSBy80yUlCrSs8u0R0sS+vV6LWULtPnFHkBz0kX8TQ
 FIEFqqvMfYvuKQO1MELvZuiDNValC09EkmPClMJfZpPqr6Q4dEZfTRCclSVWRffaPwm6xPc/veq
 1e8O4Pou5YGRqH2T8rLUQjRJU4LNkWW0D6QJtSObVbFKY05ddnj+/GMthkIOFs/oEhNS2/8j824
 uyeolZuIQ4DFLnvkC9MnjQc/tzBUitOYwckwCqNd6r9IwPdapCaeCJLwbTOzhcXYryKA67+VGgK
 os4eg6ObAHDy+Ksblp/FkCiLA80hThp4T0c5SKhLWhUfm703B0vc7bqnb3FMbPTdlQT5d7p+cZ3
 rxRmjjjLEg2n1Xk71Dyaw+PNgqq9rxDSO3O2iNLoDKTMMvVZ+IZMBiu89bKPblCXKbbaO6XHzYU
 KQmalAqAzVP/Nznv4XiG2zX7+QQbrSp2RvCB/fj+UHqyNTKUGOVWCbZQuc7Jpy8sSjL77BWdtag
 fnwzMqdqUcL7lPauVs=
X-Received: by 2002:a17:90b:51:b0:37f:9cdf:f0ab with SMTP id
 98e67ed59e1d1-3829f9debb6mr8700704a91.26.1783337933770; 
 Mon, 06 Jul 2026 04:38:53 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31151fff32fsm18581752eec.21.2026.07.06.04.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 04:38:53 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: leoreis.costa@gmail.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org,
 francesco@dolcini.it, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 leonardo.costa@toradex.com, linux-kernel@vger.kernel.org,
 luca.ceresoli@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 simona@ffwll.ch, stable@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
 tzimmermann@suse.de
Subject: Re: [PATCH] drm/bridge: tc358768: Enforce input bus flags via
 atomic_check
Date: Mon,  6 Jul 2026 08:38:36 -0300
Message-ID: <20260706113838.1586775-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706105840.1582166-1-leoreis.costa@gmail.com>
References: <20260706105840.1582166-1-leoreis.costa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

Hello,

> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> Implement the atomic_check hook, replacing the mutually exclusive
> mode_fixup, and set the bridge state input bus flags to the ones
> required by the tc358768. The sync polarity defaulting previously done
> in mode_fixup is carried over into atomic_check unchanged.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 0d85120fcc7a3..0516a331e71ba 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -1262,10 +1262,13 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>  	return input_fmts;
>  }
>  
> -static bool tc358768_mode_fixup(struct drm_bridge *bridge,
> -				const struct drm_display_mode *mode,
> -				struct drm_display_mode *adjusted_mode)
> +static int tc358768_bridge_atomic_check(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state)
>  {
> +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> +
>  	/* Default to positive sync */
>  
>  	if (!(adjusted_mode->flags &
> @@ -1276,13 +1279,15 @@ static bool tc358768_mode_fixup(struct drm_bridge *bridge,
>  	      (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
>  		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
>  
> -	return true;
> +	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
> +
> +	return 0;
>  }
>  
>  static const struct drm_bridge_funcs tc358768_bridge_funcs = {
>  	.attach = tc358768_bridge_attach,
>  	.mode_valid = tc358768_bridge_mode_valid,
> -	.mode_fixup = tc358768_mode_fixup,
> +	.atomic_check = tc358768_bridge_atomic_check,
>  	.atomic_pre_enable = tc358768_bridge_atomic_pre_enable,
>  	.atomic_enable = tc358768_bridge_atomic_enable,
>  	.atomic_disable = tc358768_bridge_atomic_disable,

Please ignore this, as it was not meant to be sent in reply to the thread
above. That was an accident.
