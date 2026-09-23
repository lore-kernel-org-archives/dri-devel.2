Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C594C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3B410F091;
	Wed, 23 Sep 2026 14:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VWbRHlMA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B61A10E0E9;
 Wed, 23 Sep 2026 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790172693; x=1821708693;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5grS7nCtM9KyKhO/kor9IGznsy+6PeSOl65OjspMIPc=;
 b=VWbRHlMAY3OwRALXg+DwnyPZuldlylYPAtcrBW3GIlRs2pzOfet4F5eb
 muKyrC1+zjwSup05CeopnsFLBMsq8fd3ECbPJBUxpfhoenv62a/TGbya3
 RerSS7aD+8F2Mn39PsamokClrGqOsU5Zr91kMqDp0pNhVtq6Q8yDSh/v6
 NMgSLEL6O7KT+ZWHpoH+1242Qa2qbVg8j982fDg2LNDDNPXKrE+zAABhl
 evx85ofat0VEkNq3vkl7+qXWXrzT4Bnlzh6l8SYHpIJb/YKeT6vX34D56
 tmxgKm0lNWOjybaMy+b7xSBlKKq9dRaULh6mpgc4l9yBjk8dPYC4Up54T g==;
X-CSE-ConnectionGUID: xXfciBBERhaR8fNsg6yQgg==
X-CSE-MsgGUID: C2AKtPmrTW2EyXR4amUDrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108369886"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="108369886"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:11:33 -0700
X-CSE-ConnectionGUID: H5sZFnXuRymtbmitfpBpvQ==
X-CSE-MsgGUID: scvGZqAgTu+v2c2qD3qSjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="278356180"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.46])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:11:30 -0700
Date: Wed, 23 Sep 2026 17:11:27 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: George Karagounis <taterraster@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 George Karagounis <mail@taterr.org>
Subject: Re: [PATCH] drm/i915/display: Split i845 and i9xx cursor updates
 into arm/noarm
Message-ID: <arPeD2dcyUIEGGn3@intel.com>
References: <20260919173914.111150-1-mail@taterr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260919173914.111150-1-mail@taterr.org>
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

On Sat, Sep 19, 2026 at 08:39:14PM +0300, George Karagounis wrote:
> There was a problem with the i845 and i9xx cursor update functions
> they handled both position updates and control/base/size updates in
> a single armed sequence. This prevented the cursor position from
> being updated asynchronously, which can make the cursor feel laggy

The noarm vs. arm split has nothing to do with that. What it does is
(slightly) reduce the amount of work we have to do inside the vblank
evasion critical section. And in order to do the split one has to
evaluate each an every register to confirm whether they are self
arming or not.

And as for the cursor we can't really do that because of the mailbox
updates being performed from the legacy cursor path. That is, when
performing mailbox updates the non-arming registers must also be
updated during the vblank evasion critical section or else they might
disarm the arming that was done by a previous update in the same frame.
The full legacy cursor fastpath would actually work fine there because
it does both the noarm+arm inside the critical section, but the
non-fastpath route for legacy_cursor_update==true does not so it
would need additional changes.

> 
> To fix this i split the updates into two phases
> 1. noarm Calculates and writes the CURPOS register immediately.
> 2. arm Calculates and writes CURCNTR, CURBASE, and CURSIZE to
>    latch the control and memory updates at vblank
> 
> Also handled a hardware quirk on i9xx platforms where CURPOS requires
> a CURBASE write to arm the update. The arm phase now writes CURBASE
> even if only the position changed
> 
> This resolves two inline TODOs and improves cursor responsiveness
> 
> Signed-off-by: George Karagounis <mail@taterr.org>
> ---
>  drivers/gpu/drm/i915/display/intel_cursor.c | 44 +++++++++++++++------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
> index 0673f16f6fd0..c12a7222f2f6 100644
> --- a/drivers/gpu/drm/i915/display/intel_cursor.c
> +++ b/drivers/gpu/drm/i915/display/intel_cursor.c
> @@ -270,14 +270,27 @@ static int i845_check_cursor(struct intel_crtc_state *crtc_state,
>  	return 0;
>  }
>  
> -/* TODO: split into noarm+arm pair */
> +static void i845_cursor_update_noarm(struct intel_dsb *dsb,
> +				     struct intel_plane *plane,
> +				     const struct intel_crtc_state *crtc_state,
> +				     const struct intel_plane_state *plane_state)
> +{
> +	struct intel_display *display = to_intel_display(plane);
> +	u32 pos = 0;
> +
> +	if (plane_state && plane_state->uapi.visible)
> +		pos = intel_cursor_position(crtc_state, plane_state, false);
> +
> +	intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
> +}
> +
>  static void i845_cursor_update_arm(struct intel_dsb *dsb,
>  				   struct intel_plane *plane,
>  				   const struct intel_crtc_state *crtc_state,
>  				   const struct intel_plane_state *plane_state)
>  {
>  	struct intel_display *display = to_intel_display(plane);
> -	u32 cntl = 0, base = 0, pos = 0, size = 0;
> +	u32 cntl = 0, base = 0, size = 0;
>  
>  	if (plane_state && plane_state->uapi.visible) {
>  		unsigned int width = drm_rect_width(&plane_state->uapi.dst);
> @@ -289,7 +302,6 @@ static void i845_cursor_update_arm(struct intel_dsb *dsb,
>  		size = CURSOR_HEIGHT(height) | CURSOR_WIDTH(width);
>  
>  		base = plane_state->surf;
> -		pos = intel_cursor_position(crtc_state, plane_state, false);
>  	}
>  
>  	/* On these chipsets we can only modify the base/size/stride
> @@ -301,14 +313,11 @@ static void i845_cursor_update_arm(struct intel_dsb *dsb,
>  		intel_de_write_fw(display, CURCNTR(display, PIPE_A), 0);
>  		intel_de_write_fw(display, CURBASE(display, PIPE_A), base);
>  		intel_de_write_fw(display, CURSIZE(display, PIPE_A), size);
> -		intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
>  		intel_de_write_fw(display, CURCNTR(display, PIPE_A), cntl);
>  
>  		plane->cursor.base = base;
>  		plane->cursor.size = size;
>  		plane->cursor.cntl = cntl;
> -	} else {
> -		intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
>  	}
>  }
>  
> @@ -645,7 +654,21 @@ static void skl_write_cursor_wm(struct intel_dsb *dsb,
>  			   skl_cursor_ddb_reg_val(ddb));
>  }
>  
> -/* TODO: split into noarm+arm pair */
> +static void i9xx_cursor_update_noarm(struct intel_dsb *dsb,
> +				     struct intel_plane *plane,
> +				     const struct intel_crtc_state *crtc_state,
> +				     const struct intel_plane_state *plane_state)
> +{
> +	struct intel_display *display = to_intel_display(plane);
> +	enum pipe pipe = plane->pipe;
> +	u32 pos = 0;
> +
> +	if (plane_state && plane_state->uapi.visible)
> +		pos = intel_cursor_position(crtc_state, plane_state, false);
> +
> +	intel_de_write_dsb(display, dsb, CURPOS(display, pipe), pos);
> +}
> +
>  static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
>  				   struct intel_plane *plane,
>  				   const struct intel_crtc_state *crtc_state,
> @@ -653,7 +676,7 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
>  {
>  	struct intel_display *display = to_intel_display(plane);
>  	enum pipe pipe = plane->pipe;
> -	u32 cntl = 0, base = 0, pos = 0, fbc_ctl = 0;
> +	u32 cntl = 0, base = 0, fbc_ctl = 0;
>  
>  	if (plane_state && plane_state->uapi.visible) {
>  		int width = drm_rect_width(&plane_state->uapi.dst);
> @@ -666,7 +689,6 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
>  			fbc_ctl = CUR_FBC_EN | CUR_FBC_HEIGHT(height - 1);
>  
>  		base = plane_state->surf;
> -		pos = intel_cursor_position(crtc_state, plane_state, false);
>  	}
>  
>  	/*
> @@ -703,14 +725,12 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
>  		if (HAS_CUR_FBC(display))
>  			intel_de_write_dsb(display, dsb, CUR_FBC_CTL(display, pipe), fbc_ctl);
>  		intel_de_write_dsb(display, dsb, CURCNTR(display, pipe), cntl);
> -		intel_de_write_dsb(display, dsb, CURPOS(display, pipe), pos);
>  		intel_de_write_dsb(display, dsb, CURBASE(display, pipe), base);
>  
>  		plane->cursor.base = base;
>  		plane->cursor.size = fbc_ctl;
>  		plane->cursor.cntl = cntl;
>  	} else {
> -		intel_de_write_dsb(display, dsb, CURPOS(display, pipe), pos);
>  		intel_de_write_dsb(display, dsb, CURBASE(display, pipe), base);
>  	}
>  }
> @@ -1019,6 +1039,7 @@ intel_cursor_plane_create(struct intel_display *display,
>  	if (display->platform.i845g || display->platform.i865g) {
>  		cursor->max_stride = i845_cursor_max_stride;
>  		cursor->min_alignment = i845_cursor_min_alignment;
> +		cursor->update_noarm = i845_cursor_update_noarm;
>  		cursor->update_arm = i845_cursor_update_arm;
>  		cursor->disable_arm = i845_cursor_disable_arm;
>  		cursor->get_hw_state = i845_cursor_get_hw_state;
> @@ -1036,6 +1057,7 @@ intel_cursor_plane_create(struct intel_display *display,
>  		if (intel_scanout_needs_vtd_wa(display))
>  			cursor->vtd_guard = 2;
>  
> +		cursor->update_noarm = i9xx_cursor_update_noarm;
>  		cursor->update_arm = i9xx_cursor_update_arm;
>  		cursor->disable_arm = i9xx_cursor_disable_arm;
>  		cursor->get_hw_state = i9xx_cursor_get_hw_state;
> -- 
> 2.55.0

-- 
Ville Syrjälä
Intel
