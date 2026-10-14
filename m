Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3445CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3307510E534;
	Wed, 14 Oct 2026 11:19:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990CA10E541;
 Wed, 14 Oct 2026 11:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791976756; x=1823512756;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mILDQ0beEHugYrDGAp7RHecafUChyKoMmsDB5orFUMU=;
 b=JOv21v2NTgWdf1WF/zGHhlmTlevULcR5wEb77SQFe8zbWH+A1VE6OVe5
 9KJxsr83hvqbSjc4OC2NWu2kmi2R9Adi+yQgQbax5JrMYi4U4lFwizfuB
 Zt1JJx138Kx49Lx/VWRt/PJg4SDfBQOxDvdv/MmM5CUB+P771fDyLq+9r
 88NPtSsGBAal5l2MCoXHfu5OtsBK4lyhZdLCMjmg35QWHH+OBnjKUfySn
 2IG/fRHp1Y2aPlP3hvWHHU4CFZGEjLC0R0mbBcj8QGZRyie0hxOBTSp84
 5GeRVt4G0qcAFso9XUMHgSalGx1dULxvvu7JiZm/RsYZww7+wlzO77D2c Q==;
X-CSE-ConnectionGUID: /9/tpmKHSx2shiIbocPToQ==
X-CSE-MsgGUID: QHl05FTORPKJStdRGIGVpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="622477"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="622477"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 04:19:16 -0700
X-CSE-ConnectionGUID: zXUXL0ZSTwu5nDmhUHEoog==
X-CSE-MsgGUID: AfkKKCLKQMqOSDGxji1TyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1372069"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 04:19:11 -0700
Date: Wed, 14 Oct 2026 14:19:09 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: hex@aleph0.ai
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/psr: Send a frame change notification for async
 flips
Message-ID: <as9lLU0VnFW6JLKf@intel.com>
References: <20261013-fix-psr-async-trans-push-v1-1-ee79bf31b66f@aleph0.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013-fix-psr-async-trans-push-v1-1-ee79bf31b66f@aleph0.ai>
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

On Tue, Oct 13, 2026 at 05:16:07PM +0200, Vladyslav Yamkovyi via B4 Relay wrote:
> From: Vladyslav Yamkovyi <hex@aleph0.ai>
> 
> On platforms using TRANS_PUSH for PSR frame-change notifications,
> intel_pipe_update_end() exits early for asynchronous flips, before sending
> the push. The register-based notification is disabled on these platforms,
> and an ORIGIN_FLIP frontbuffer flush does not force PSR to exit.
> 
> This can leave an accepted async flip without a completion event after
> PSR2 enters DEEP_SLEEP. On Panther Lake, scanout freezes and the kernel
> reports "[CRTC:152:pipe A] flip_done timed out". Intel IGT kms_async_flips
> reproduces the failure with the compositor inactive when a 200 ms idle
> interval is inserted before an asynchronous atomic flip.
> 
> Send the PSR frame-change notification after plane programming and before
> releasing the existing PSR lock. Restrict the push to CRTC states that use
> TRANS_PUSH for PSR, leaving other async flips and the synchronous and DSB
> paths unchanged.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9582
> Fixes: 129a4da11707 ("drm/i915/psr: Use TRANS_PUSH to trigger frame change event")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM sparse smatch
> Signed-off-by: Vladyslav Yamkovyi <hex@aleph0.ai>
> ---
> Based on drm-tip (2026-10-13); also applies to v7.3-rc7.
> 
> Runtime-tested on Panther Lake (xe, eDP-1, 2880x1800) with Ubuntu-based
> 7.3.0-rc6 kernels, before and after this fix. IGT kms_async_flips,
> async-flip-with-page-flip-events-tiled-atomic, dynamic subtest
> pipe-A-eDP-1-4-rc-ccs, fails with Flip Timeout before the fix and passes
> afterwards. An LD_PRELOAD interposer inserts one 200 ms idle interval
> before the eighth async atomic commit without changing its request or
> flags. Both runs enter PSR2 Early Transport DEEP_SLEEP with selective
> fetch enabled before that commit.
> 
> Clang 23.1.2, W=1 builds and Sparse/Smatch checks of the CRTC, PSR and VRR
> translation units for i915 and Xe produced no new diagnostics.
> 
> OpenAI Codex (GPT-6-Astra) assisted diagnosis, reproducer and fix
> development, validation and patch preparation, following requests to
> reproduce the freeze independently, trace its driver cause and prepare a
> tested upstream fix. I take direct responsibility for this contribution,
> have carefully reviewed the change and ensured rigorous local testing.
> ---
>  drivers/gpu/drm/i915/display/intel_crtc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
> index 10ed9bdfee76..8ef24cddbaa6 100644
> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
> @@ -736,8 +736,16 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
>  
>  	drm_WARN_ON(display->drm, new_crtc_state->use_dsb);
>  
> -	if (new_crtc_state->do_async_flip)
> +	if (new_crtc_state->do_async_flip) {
> +		/*
> +		 * LNL+ uses TRANS_PUSH for PSR frame-change notifications.
> +		 * Async flips skip the vblank path below, but still need to
> +		 * notify PSR after programming the new surface address.
> +		 */
> +		if (intel_psr_use_trans_push(new_crtc_state))
> +			intel_vrr_send_push(NULL, new_crtc_state);

This will make the behaviour of async flips + VRR inconsistent
between platforms where trans push is used for PSR vs. platforms
where it's not used. We don't want that.

So either we want to start doing trans pushes for all async
flips+VRR cases, or we want to disable the PSR trans push usage
when async flips are happening. The latter would be the safer
option since the mailboxy trans push usage this would cause
hasn't been done before. The vblank evasion code does try to
handle it, but it's not actually tested.

>  		goto out;
> +	}
>  
>  	trace_intel_pipe_update_end(crtc, end_vbl_count, scanline_end);
>  
> 
> ---
> base-commit: eb1bf4700d3b25a1a1e670ef31cc06969fa08019
> change-id: 20261013-fix-psr-async-trans-push-bfa6550270c7
> 

-- 
Ville Syrjälä
Intel
