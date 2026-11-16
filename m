Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41594608F8A7
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ePIy2jzg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD1610EF6C;
	Mon, 16 Nov 2026 11:10:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FB910EF6B;
 Mon, 16 Nov 2026 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794827449; x=1826363449;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=oetKBKq3OHnLCF9dOGr4kSyIr2/4Zp2CMeqquq113yk=;
 b=ePIy2jzgpRgxu7eiTwNjM7qhcDT8h/rOhza3HTJ9LLw4+ZCaOIrYHPPM
 LD8HAh8iaKTcfoX/ejHoxK6Ywr86sTkMlgotkiRh+3KO5NEJflCPXNRwO
 s4G+Y6Hoeye2aSwhdcRQi/LqdcWqTW+0RJYb6K7tpV75m4ha49U6ulHtL
 Tc/6wjzUUZg9m5lq7gmk54JXJ1p+hwoOGBmDNm5EiHsQKMcJD+Y6HqHCV
 u/5/Q6Ut/N6a2cF9aSlqg9jqFTAtl+Sb9OrbdfirpqFk7jcWdLeVOIWpD
 o9HObVg6u4gzPbpGfXNtCXcuII8sfaOQYbNKLt2568K7GPSYN7bIoGNjb A==;
X-CSE-ConnectionGUID: +GjLf6jtShyMmId41vNahQ==
X-CSE-MsgGUID: MixJVXj3R1SNObBbH6sJDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3413206"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3413206"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:10:49 -0800
X-CSE-ConnectionGUID: 7N4I0Ue5QxyRTe3+T7uCYQ==
X-CSE-MsgGUID: 9ZAM7YV5TBivpWwcKlrOmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9710302"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:10:46 -0800
Date: Mon, 16 Nov 2026 13:10:40 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 10/12] drm/i915: Complete no-op "async flips" by hand
Message-ID: <avrksFHUYSQTfE95@intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
 <20261116091130.13950-11-ville.syrjala@linux.intel.com>
 <sashiko-outbox-216616@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-216616@kernel.org>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 09:28:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] drm/i915: unreachable noop check in
>   intel_crtc_complete_noop_async_flip()
> - [Medium] drm/i915: intel_crtc_complete_noop_async_flip() checks
>   cleared uapi.event
> --
> 
> commit 828bac38a449130d5473b2a45f7f646152241cec
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> drm/i915: Complete no-op "async flips" by hand
> 
> This commit adds helpers to manually send the vblank event for atomic
> async flip commits when no planes are updated.
> 
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index f79caeb5a82ec..dd12929284bb8 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -1190,6 +1190,42 @@ static void intel_crtc_disable_flip_done(struct intel_atomic_state *state,
> >  	}
> >  }
> >  
> > +static void intel_crtc_complete_noop_async_flip(struct intel_crtc_state *crtc_state)
> > +{
> > +	struct intel_display *display = to_intel_display(crtc_state);
> > +	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
> > +
> > +	if (!crtc_state->do_async_flip)
> > +		return;
> > +
> > +	/*
> > +	 * If there are planes actually performing the async flip then
> > +	 * the commit will be completed via the flip done interrupt
> > +	 * handler. For a fully no-op "async flip" the commit must
> > +	 * be completed by hand as no interrupt will be raised.
> > +	 */
> > +	if (crtc_state->update_planes)
> > +		return;
> 
> [Severity: Medium]
> Can crtc_state->do_async_flip ever be true when crtc_state->update_planes
> is zero?
> 
> intel_crtc_duplicate_state() initializes both fields to zero/false, and the
> only place that sets new_crtc_state->do_async_flip = true is
> intel_plane_atomic_check_with_state() -> intel_plane_atomic_calc_changes()
> for a visible plane, after intel_plane_atomic_check_with_state() has
> already set BIT(plane->id) in new_crtc_state->update_planes:
> 
> drivers/gpu/drm/i915/display/intel_plane.c:intel_plane_atomic_check_with_state() {
> 	...
> 	if (new_plane_state->uapi.visible || old_plane_state->uapi.visible)
> 		new_crtc_state->update_planes |= BIT(plane->id);
> 	...
> 	return intel_plane_atomic_calc_changes(old_crtc_state, new_crtc_state,
> 					       old_plane_state, new_plane_state);
> }
> 
> When no visible planes are in the atomic state, crtc_state->do_async_flip
> remains false (unlike crtc_state->uapi.async_flip), so this function always
> returns early on the first check and never completes a no-op async flip.
> 
> > +
> > +	if (crtc_state->uapi.event) {
> > +		spin_lock_irq(&display->drm->event_lock);
> > +		drm_crtc_send_vblank_event(&crtc->base,
> > +					   crtc_state->uapi.event);
> > +		spin_unlock_irq(&display->drm->event_lock);
> > +
> > +		crtc_state->uapi.event = NULL;
> > +	}
> > +}
> 
> [Severity: Medium]
> Will crtc_state->uapi.event always be NULL by the time
> intel_crtc_complete_noop_async_flip() runs?
> 
> In intel_atomic_commit_tail(), commit_modeset_enables() runs before
> intel_atomic_complete_noop_async_flips().  When new_crtc_state->do_async_flip
> is true, intel_update_crtc() -> intel_pipe_update_start() calls
> intel_crtc_prepare_vblank_event(new_crtc_state, &crtc->flip_done_event),
> which moves new_crtc_state->uapi.event into crtc->flip_done_event and sets
> new_crtc_state->uapi.event = NULL.  With update_planes == 0, no flip-done
> interrupt will fire to consume crtc->flip_done_event, leaving the event
> unsent and causing drm_atomic_helper_wait_for_flip_done() to time out.

Ack. Need to deal with that and not prepare the flip done
event without a plane to send it.

-- 
Ville Syrjälä
Intel
