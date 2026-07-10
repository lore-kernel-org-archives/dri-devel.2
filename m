Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1DDC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60E010E1F0;
	Fri, 10 Jul 2026 14:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IDeGdwQ5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA5310E1D2;
 Fri, 10 Jul 2026 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783694088; x=1815230088;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=E7J0hoP9iJxRrQY4SyLZ8zK3A2OaNM48pK6QHWpkycI=;
 b=IDeGdwQ5Fp59hempy75PNoiSYejpyYTY0ZtAhWnt19P8ZbLDAKSD3qbK
 bDBaZk3Jdg9avdNNQbOHJupM8p6BYc1Yj7gbRqkqUxYW0mIgrm1yNQ/Px
 nwIdWI0cj55nf9I5a+KjkiwlGC8NMu/WVuAGjhmhB+8KQRYBDUZn6t0co
 PFqH8o+ehhGFWm+2KC9lpkN++UKyD6gtEMGf4h2TQBJo+rMtk/EiT9i+H
 YkG2WkduUiKmyVnWXn3ozC8aFrk+WYK++Ye4z/C187508B4McZh92WOSv
 cADGg5rTbj7e1uEhl/stBjxof9+ZK9oc+GiUOXBvKZdmJvrdq34MqLUWC g==;
X-CSE-ConnectionGUID: DkrZv3LfQqeTKNcjz5Y7Mg==
X-CSE-MsgGUID: l0Ob3VkwQbSXjl+K5WRDvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84585632"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84585632"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:34:48 -0700
X-CSE-ConnectionGUID: lMLBgbmlTs+TOY1M3WxcBg==
X-CSE-MsgGUID: 1xGnrZq/QkCKhJqdN1lOjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254996841"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.208])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:34:46 -0700
Date: Fri, 10 Jul 2026 17:34:43 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 09/10] drm/i915/display: Make get_vblank_counter use
 intel_de_read_fw()
Message-ID: <alEDA5pNM4e7gse8@intel.com>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-10-dev@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702072154.171324-10-dev@lankhorst.se>
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

On Thu, Jul 02, 2026 at 09:21:52AM +0200, Maarten Lankhorst wrote:
> Fixes the following lockdep splat on PREEMPT_RT:
> <3> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> <3> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1373, name: xe_module_load
> <3> preempt_count: 1, expected: 0
> <3> RCU nest depth: 0, expected: 0
> <4> 11 locks held by xe_module_load/1373:
> <4>  #0: ffff888107b691a0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x104/0x220
> <4>  #1: ffff88813cd30280 (&dev->clientlist_mutex){+.+.}-{3:3}, at: drm_client_register+0x32/0xe0
> <4>  #2: ffffffff837f88f8 (registration_lock){+.+.}-{3:3}, at: register_framebuffer+0x1b/0x50
> <4>  #3: ffffffff835985e0 (console_lock){+.+.}-{0:0}, at: fbcon_fb_registered+0x6f/0x90
> <4>  #4: ffff88812589e6a0 (&helper->lock){+.+.}-{3:3}, at: __drm_fb_helper_restore_fbdev_mode_unlocked+0x7b/0x110
> <4>  #5: ffff88813cd30158 (&dev->master_mutex){+.+.}-{3:3}, at: drm_master_internal_acquire+0x20/0x50
> <4>  #6: ffff88812589e488 (&client->modeset_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_locked+0x2a/0x1b0
> <4>  #7: ffffc9000031eef0 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_client_modeset_commit_atomic+0x4c/0x2b0
> <4>  #8: ffffc9000031ef18 (crtc_ww_class_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_atomic+0x4c/0x2b0
> <4>  #9: ffff888114f7b8b8 (&intel_dp->psr.lock){+.+.}-{3:3}, at: intel_psr_lock+0xc5/0xf0 [xe]
> <4>  #10: ffff88812a0cbbc0 (&wl->lock){+.+.}-{2:2}, at: intel_dmc_wl_get+0x3c/0x140 [xe]
> 
> This splat will happen otherwise on all tracepoints too, for similar reasons.
> 
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>  drivers/gpu/drm/i915/display/intel_vblank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
> index 07dca05332e5b..c0cc0a4c25dbe 100644
> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
> @@ -132,7 +132,7 @@ u32 g4x_get_vblank_counter(struct drm_crtc *crtc)
>  	if (!vblank->max_vblank_count)
>  		return 0;
>  
> -	return intel_de_read(display, PIPE_FRMCOUNT_G4X(display, pipe));
> +	return intel_de_read_fw(display, PIPE_FRMCOUNT_G4X(display, pipe));

Sashiko didn't complain about potential ivb/hsw same-cacheline issues
here, so I'll point it out. There isn't too much on that cacheline
though so perhaps not a huge issue (assuming the issue is real in the
first place, which I'm not 100% convinced about). But I'm still thinking
that I'll just try to convert the lock into a raw spinlock while moving
all the mmio stuff directly into intel_de.[ch]. That would avoid part
of the problem at least.

The dmc wakelock stuff I'm not sure we should even worry about here.
If the pipe isn't active we shouldn't really end up calling this anyway,
except maybe if we race with the DMC. Although we don't have register
accessors that skip the DMC stuff while still taking the uncore lock.
I'm not super keen on adding yet another register accessor variant
either, so not sure how to deal with this sort of stuff in the end...

>  }
>  
>  static u32 intel_crtc_scanlines_since_frame_timestamp(struct intel_crtc *crtc)
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
