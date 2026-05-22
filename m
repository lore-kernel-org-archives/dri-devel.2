Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A310CCD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7EE310F5ED;
	Fri, 22 May 2026 13:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Jp5MlugV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A9E10F5ED
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779456506; x=1810992506;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=vMCnx8a+02wpW1v2x3Gaju1pVGV683eSmQkhfp/4j3U=;
 b=Jp5MlugV/BBp62w6fFZ7ISWyUR2bJZqFZWZ2m6M3QjCXU7ovamz5M6iW
 PWdr7uskW0YtrjPUJaP7/s7W6LtWforpw/nY2ThyeVuLuMrGFoSZmk/9e
 2uRkQ9zamuNI+fN9avVwEWiL+6TEBdPqwlJBtmFK/tGV7ydU98h7EnDxp
 X5ROz6ZwnWYN3Zbzo1lgAy4MH1aE6fWwBdMezZnU4nKc7lpmWt+c3hC+5
 UNkgkHRDIFnUIZSzPuaP5mCZUTlI1lkF/Jh5DEq6q8TTuGkcL6Pj8JTnc
 zvws7v0gkgY1oDuBMft+d5c85fLCyA7hCasmpmfs6hWXzLydc7m3z0DUc Q==;
X-CSE-ConnectionGUID: hWP+H0p3QMSrtP2tcQ/N5A==
X-CSE-MsgGUID: mwXuJQYJRaKpqFZ3mrBisA==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80236690"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80236690"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 06:28:25 -0700
X-CSE-ConnectionGUID: q+1wd2RyQXCYQ84bgdaVhA==
X-CSE-MsgGUID: LG5P5DgUT5uXTJP5dpOaXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="241143308"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
 by orviesa007-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 06:28:22 -0700
Date: Fri, 22 May 2026 16:28:18 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
Message-ID: <ahBZ8nIqR4qESLZg@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
 <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Fri, May 22, 2026 at 03:24:05PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 22.05.26 um 15:13 schrieb Ville Syrjälä:
> > On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
> >>> Currently the implementaion of drm_client_modeset_wait_for_vblank()
> >>> assumes drm_vblank_get() will fail when the CRTC isn't active. However
> >>> it seems that this is not true, and running fbcon on a device with the
> >>> first CRTC inactive will lead to kernel warning in some cases (which
> >>> could be reproduced with the loongson driver).
> >>>
> >>> Change the implementation to add a check for the active state (atomic) /
> >>> enabled state (non-atomic) before calling drm_vblank_get(). As the
> >>> assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
> >>> error status of drm_vblank_get() can now be exported too.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
> >>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> >>> ---
> >>>    drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
> >>>    1 file changed, 11 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> >>> index bb49b8361271a..1b03bf351256e 100644
> >>> --- a/drivers/gpu/drm/drm_client_modeset.c
> >>> +++ b/drivers/gpu/drm/drm_client_modeset.c
> >>> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >>>    {
> >>>    	struct drm_device *dev = client->dev;
> >>>    	struct drm_crtc *crtc;
> >>> -	int ret;
> >>> +	int ret = 0;
> >>>    
> >>>    	/*
> >>>    	 * Rate-limit update frequency to vblank. If there's a DRM master
> >>> @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >>>    	 * Only wait for a vblank event if the CRTC is enabled, otherwise
> >>>    	 * just don't do anything, not even report an error.
> >>>    	 */
> >>> +	if (drm_drv_uses_atomic_modeset(dev)) {
> >>> +		if (!crtc->state || !crtc->state->active)
> >>> +			goto out;
> >>> +	} else {
> >>> +		if (!crtc->enabled)
> >>> +			goto out;
> >>> +	}
> >>> +
> >> This part is good.
> > Locking is missing.
> 
> Ok
> 
> >
> >>>    	ret = drm_crtc_vblank_get(crtc);
> >>>    	if (!ret) {
> >>>    		drm_crtc_wait_one_vblank(crtc);
> >>>    		drm_crtc_vblank_put(crtc);
> >>>    	}
> >>>    
> >>> +out:
> >>>    	drm_master_internal_release(dev);
> >>>    
> >>> -	return 0;
> >>> +	return ret;
> >> But this isn't. There can be CRTCs without any vblank at all. We still
> >> want to fail silently for them. So we still have to return 0 here.
> >>
> >> Having set this, fixing this helper is only partially what you want.
> >> Since your device has vblanking, the emulation should check on the
> >> correct CRTC. IOW you need to pass the right CRTC index at
> >>
> >> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L237
> >> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L920
> >>
> >> I'm not quite sure how to support this. The CRTC is under
> >> fb_helper->client.modesets.crtc. You'd have to figure out which is the
> >> relevant one and use that. But that's also not so great, as fbdev ioctls
> >> only support CRTC 0. Doing internal re-mappings only complicates matters.
> >>
> >> But why does your HW use CRTC 1 in the first place.
> > Could be eg. the enabled outputs can't be driven with CRTC 0.
> >
> > I guess what you want to do is pick the first crtc from modesets[]
> > which is enabled. Or perhaps even "pick the Nth enabled crtc from
> > modesets[] based on the ioctl argument".
> 
> The enable-status of each CRTC could change later on, which might lead 
> to problems.

Sound like a locking issue if someone is changing the configuration
at the same time we're trying to do the vblank wait here.

> Picking the one CRTC/output with the lowest spec and 
> mirroring it to the others might work. This CRTC would then be the one 
> to wait for.
> 
> Best regards
> Thomas
> 
> >
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 

-- 
Ville Syrjälä
Intel
