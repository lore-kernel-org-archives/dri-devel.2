Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE037CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B2110E399;
	Tue, 19 May 2026 09:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X6Hi3zFe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C3010E399
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779183723; x=1810719723;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Hhfs4nT6HC6MjT0jJEYdGh2bUJavvEbTjP0QQhz4c6M=;
 b=X6Hi3zFeU/Am/NWwqBcc+w2F8Ir2BcZCBf2trSeMxXq0bMMnLKML5MHr
 7rWOSLQVKvNvXulsEHAjxR+jk9rorVEy6BPOeTmscn1aLSCJ0S1bxY/av
 xMXftqXLxzEIaEg3ovKE31JfF6JrnchtyfioB7gept5a+5UduDSOIo/jb
 wWkxsydbcXwCfecNY8scDeykLchf3bSy5/pHwIv0XI9pP3m3N4AFGMF6R
 6B8msPdIR98Gmyvoqie/hX8ATH5hbJ3BuvzeW4XHOK5IKNvRZ7rPILiZ4
 IJ10DvRkx8HjvJmbFKZlkx8Dq1avxYBurfi/29CeM99ntti2B+TigCIRU w==;
X-CSE-ConnectionGUID: qE+jVuVcTpyU7uJc8KzVag==
X-CSE-MsgGUID: IHMh0GCZTTenS0tQv3qo8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80107818"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80107818"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 02:42:03 -0700
X-CSE-ConnectionGUID: E06rSB3EQfKvvVdX2MGUQA==
X-CSE-MsgGUID: 6zvRwQlASeG1cDcXcrC1Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="233340391"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.218])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 02:41:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Icenowy
 Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
In-Reply-To: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
Date: Tue, 19 May 2026 12:41:56 +0300
Message-ID: <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 19 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> Currently the implementaion of drm_client_modeset_wait_for_vblank()
> assumes drm_vblank_get() will fail when the CRTC isn't active. However
> it seems that this is not true, and running fbcon on a device with the
> first CRTC inactive will lead to kernel warning in some cases (which
> could be reproduced with the loongson driver).
>
> Change the implementation to add a check for the active state (atomic) /
> enabled state (non-atomic) before calling drm_vblank_get(). As the
> assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
> error status of drm_vblank_get() can now be exported too.
>
> Cc: stable@vger.kernel.org
> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index bb49b8361271a..1b03bf351256e 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>  {
>  	struct drm_device *dev = client->dev;
>  	struct drm_crtc *crtc;
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * Rate-limit update frequency to vblank. If there's a DRM master
> @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>  	 * Only wait for a vblank event if the CRTC is enabled, otherwise
>  	 * just don't do anything, not even report an error.
>  	 */

I'll dodge the question whether the change below is right or not, but
for sure the comment above needs to be amended to match the change.

(Please wait for other review comments before sending another version
with the comment changed.)

BR,
Jani.

> +	if (drm_drv_uses_atomic_modeset(dev)) {
> +		if (!crtc->state || !crtc->state->active)
> +			goto out;
> +	} else {
> +		if (!crtc->enabled)
> +			goto out;
> +	}
> +
>  	ret = drm_crtc_vblank_get(crtc);
>  	if (!ret) {
>  		drm_crtc_wait_one_vblank(crtc);
>  		drm_crtc_vblank_put(crtc);
>  	}
>  
> +out:
>  	drm_master_internal_release(dev);
>  
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);

-- 
Jani Nikula, Intel
