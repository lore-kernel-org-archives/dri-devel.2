Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF9CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6DA10F609;
	Fri, 22 May 2026 13:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V+mIRUnp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470D210F5B5
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779455602; x=1810991602;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=XGUCGxnEA4kj79DA+8/vsKuNs1lZvHw/84Eetaa9NPI=;
 b=V+mIRUnpybLtlGJxygHL9Qr+akTH0NWnS3LLyFb0bX1qVMPEGBuJxQRd
 RbzazAIQnuEnqh0lQvBzAKOhLCNGMGPTfRdDN0qE6+MuCNdJVNSF1kuNI
 0Y+RhQWae9Iohf5rC7sLa7czlAU7rrA5kZo9LTYyn6/wFyzeSutLLNEjM
 37Qe4eXAEN68ONyzrvLUM2nGMxUbXDlUPNGxnGLhpYQJfAZaE7Hl7Zilu
 7xsGc8/xLXyecXW5AxE2+SUm0IpJ00nP32ZShNVAUE64aG0Enlt+kNpxR
 8jH8RvQjcXxx4FJ7cKo1uZv4L1QO35XmHP04awEVyYvFAfRK2i+rj9ifh Q==;
X-CSE-ConnectionGUID: Hpixch3kTv2wEcLpwBSzmw==
X-CSE-MsgGUID: Rxb1+RvjS72w0Dj2mYc2mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80353686"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80353686"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 06:13:21 -0700
X-CSE-ConnectionGUID: HFH30V+WS5O0kcta+kn0sw==
X-CSE-MsgGUID: FB9kCSnSRSmU+NtgPu13lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="236689704"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
 by fmviesa010-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 06:13:18 -0700
Date: Fri, 22 May 2026 16:13:15 +0300
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
Message-ID: <ahBWayIcQUHuAt4i@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
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

On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
> > Currently the implementaion of drm_client_modeset_wait_for_vblank()
> > assumes drm_vblank_get() will fail when the CRTC isn't active. However
> > it seems that this is not true, and running fbcon on a device with the
> > first CRTC inactive will lead to kernel warning in some cases (which
> > could be reproduced with the loongson driver).
> >
> > Change the implementation to add a check for the active state (atomic) /
> > enabled state (non-atomic) before calling drm_vblank_get(). As the
> > assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
> > error status of drm_vblank_get() can now be exported too.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> >   drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> > index bb49b8361271a..1b03bf351256e 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >   {
> >   	struct drm_device *dev = client->dev;
> >   	struct drm_crtc *crtc;
> > -	int ret;
> > +	int ret = 0;
> >   
> >   	/*
> >   	 * Rate-limit update frequency to vblank. If there's a DRM master
> > @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >   	 * Only wait for a vblank event if the CRTC is enabled, otherwise
> >   	 * just don't do anything, not even report an error.
> >   	 */
> > +	if (drm_drv_uses_atomic_modeset(dev)) {
> > +		if (!crtc->state || !crtc->state->active)
> > +			goto out;
> > +	} else {
> > +		if (!crtc->enabled)
> > +			goto out;
> > +	}
> > +
> 
> This part is good.

Locking is missing.

> 
> >   	ret = drm_crtc_vblank_get(crtc);
> >   	if (!ret) {
> >   		drm_crtc_wait_one_vblank(crtc);
> >   		drm_crtc_vblank_put(crtc);
> >   	}
> >   
> > +out:
> >   	drm_master_internal_release(dev);
> >   
> > -	return 0;
> > +	return ret;
> 
> But this isn't. There can be CRTCs without any vblank at all. We still 
> want to fail silently for them. So we still have to return 0 here.
> 
> Having set this, fixing this helper is only partially what you want. 
> Since your device has vblanking, the emulation should check on the 
> correct CRTC. IOW you need to pass the right CRTC index at
> 
> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L237
> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L920
> 
> I'm not quite sure how to support this. The CRTC is under 
> fb_helper->client.modesets.crtc. You'd have to figure out which is the 
> relevant one and use that. But that's also not so great, as fbdev ioctls 
> only support CRTC 0. Doing internal re-mappings only complicates matters.
> 
> But why does your HW use CRTC 1 in the first place.

Could be eg. the enabled outputs can't be driven with CRTC 0.

I guess what you want to do is pick the first crtc from modesets[]
which is enabled. Or perhaps even "pick the Nth enabled crtc from
modesets[] based on the ioctl argument".

-- 
Ville Syrjälä
Intel
