Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90983F53D72
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C4510E279;
	Mon, 16 Mar 2026 16:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PGlJKIfF";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE2710E281
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 16:40:49 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 248F9BD2;
 Mon, 16 Mar 2026 17:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773679177;
 bh=Kzr1m6Va29xtUkkFLvG6x5CgshfUIGpowXhuuaDrOns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PGlJKIfFimg6caDoKZiMxZeVUwOfDr8bkablGpGZTBFxu8LHj84LwjmVjIJj3U+WR
 pQfgEqeWPWRjYCsyTaUzol6hkVeQqvUQW63OTNarHkMp6QVN29wgU3btF6hCmtOmmy
 IJrTppq+SpRvkhBGG2qL5IQ2x8kXRlAJBlajBRCA=
Date: Mon, 16 Mar 2026 18:40:47 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] drm/tidss: Convert to atomic_create_state
Message-ID: <20260316164047.GP31604@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-13-de7397c8e1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-drm-mode-config-init-v1-13-de7397c8e1cf@kernel.org>
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

On Tue, Mar 10, 2026 at 05:07:05PM +0100, Maxime Ripard wrote:
> Our driver uses reset to create the various object states, but only
> calls the helper that allocate a new state. They are thus strictly
> equivalent to the new atomic_create_state helpers, so let's switch to
> these.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/tidss/tidss_crtc.c  | 17 +++++++----------
>  drivers/gpu/drm/tidss/tidss_plane.c |  2 +-
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index a31c21c5f855ac8a94089dd3908e2510193b7d67..66e3d161c60bc14b2982cff4cdd43030d4086798 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -355,24 +355,21 @@ static void tidss_crtc_destroy_state(struct drm_crtc *crtc,
>  
>  	__drm_atomic_helper_crtc_destroy_state(&tstate->base);
>  	kfree(tstate);
>  }
>  
> -static void tidss_crtc_reset(struct drm_crtc *crtc)
> +static struct drm_crtc_state *tidss_crtc_create_state(struct drm_crtc *crtc)
>  {
>  	struct tidss_crtc_state *tstate;
>  
> -	if (crtc->state)
> -		tidss_crtc_destroy_state(crtc, crtc->state);
> -
>  	tstate = kzalloc_obj(*tstate);
> -	if (!tstate) {
> -		crtc->state = NULL;
> -		return;
> -	}
> +	if (!tstate)
> +		return ERR_PTR(-ENOMEM);
>  
> -	__drm_atomic_helper_crtc_reset(crtc, &tstate->base);
> +	__drm_atomic_helper_crtc_create_state(crtc, &tstate->base);
> +
> +	return &tstate->base;
>  }
>  
>  static struct drm_crtc_state *tidss_crtc_duplicate_state(struct drm_crtc *crtc)
>  {
>  	struct tidss_crtc_state *state, *current_state;
> @@ -403,14 +400,14 @@ static void tidss_crtc_destroy(struct drm_crtc *crtc)
>  	drm_crtc_cleanup(crtc);
>  	kfree(tcrtc);
>  }
>  
>  static const struct drm_crtc_funcs tidss_crtc_funcs = {
> -	.reset = tidss_crtc_reset,
>  	.destroy = tidss_crtc_destroy,
>  	.set_config = drm_atomic_helper_set_config,
>  	.page_flip = drm_atomic_helper_page_flip,
> +	.atomic_create_state = tidss_crtc_create_state,
>  	.atomic_duplicate_state = tidss_crtc_duplicate_state,
>  	.atomic_destroy_state = tidss_crtc_destroy_state,
>  	.enable_vblank = tidss_crtc_enable_vblank,
>  	.disable_vblank = tidss_crtc_disable_vblank,
>  };
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
> index aaa02c851c595aa3781ec2e6741af1999092aa40..518498d4576528a0ec59fd03cf27a87b1b3f1e6e 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -176,12 +176,12 @@ static const struct drm_plane_helper_funcs tidss_primary_plane_helper_funcs = {
>  };
>  
>  static const struct drm_plane_funcs tidss_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.reset = drm_atomic_helper_plane_reset,
>  	.destroy = drm_plane_destroy,
> +	.atomic_create_state = drm_atomic_helper_plane_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
>  };
>  
>  struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
> 

-- 
Regards,

Laurent Pinchart
