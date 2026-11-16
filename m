Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE5606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SpeSUFBw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0AC810ED9C;
	Mon, 16 Nov 2026 09:22:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFFE10E296;
 Mon, 16 Nov 2026 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794820962; x=1826356962;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Y2zldT+YuSEQD9QzOAhBed/JdXYSi8OLsQFal3RWfDo=;
 b=SpeSUFBw90zeiiChxFxuuanpMXURA7yzlj+Rx1ihvvqrBunBOqZszDny
 Pp3cYgGmUngL53lp3rqdyu8PuWJiu4UkvnoPReGRIBb/r8Fnx2VQW3sSY
 w3DtlLrf044fHI/d5r5pEBujj4FeNsq6tCluY1l2pyfaySrFNMcb6sx2O
 +8Y5HXFYzZRwu6M3+S6n2TAr/eSGQNdudqWNUc2NAXf4feh0KvXKTnXHP
 vv6X1+vwG7cvpEXPPNGOwjSP3WC83Orjkz94J3fYRAjZ2OY3/Ydusqo2w
 mDdDfnDVd1KYOmqWRamzlRLD7CUZbIyaHZVAHO3xxcVMuQVGjKyASuP+B w==;
X-CSE-ConnectionGUID: RxDTTptPRxiUbS0OjaWwKQ==
X-CSE-MsgGUID: 9O75o80RT7CkpEbDQLUgMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3442857"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3442857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:22:39 -0800
X-CSE-ConnectionGUID: EQntyqAFTXq7wdrA1wo5ow==
X-CSE-MsgGUID: Snrum0OSRqWvUnjJB+5zPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9640030"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:22:35 -0800
Date: Mon, 16 Nov 2026 11:22:32 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: aot.lerwin@gmail.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/display: Ignore disabled planes in async
 flip checks
Message-ID: <avrLWCctBVWAjOo4@intel.com>
References: <20261115-i915-async-planes-v2-1-c5163dfea5b2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261115-i915-async-planes-v2-1-c5163dfea5b2@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 04:43:35PM +0100, Erwin Springer via B4 Relay wrote:
> From: Erwin Springer <aot.lerwin@gmail.com>
> 
> Atomic async flips may carry properties that don't change, so compositors
> tend to send their whole plane state with every commit. KWin for example
> adds all planes of the pipe, including the ones that are disabled and stay
> disabled (CRTC_ID=0, FB_ID=0).

I have slightly more universal solution to this atomic+async issue.
I just posted it and Cc:d you.

> 
> intel_async_flip_check_uapi() fails the commit as soon as the state
> contains any plane of the pipe that can't do async flips:
> 
>   [drm:intel_atomic_check [i915]] [PLANE:66:plane 2A] async flip not supported
>   [drm:drm_atomic_check_only.cold] atomic driver check for ... failed: -22
> 
> So with such a compositor tearing never works on a pipe with sprite or
> cursor planes, even though only the FB of the primary plane changes. KWin
> silently falls back to vsynced flips, about 60 rejected commits per second.
> 
> A plane without a framebuffer before and after the commit takes no part in
> the flip. Skip it in both async flip checks.
> 
> A plane that is disabled in uapi may still be used by the hardware as the
> Y plane of a planar framebuffer on another plane (planar_linked_plane on
> ICL+). Don't skip such a plane in the uapi check, so the commit is still
> rejected there as before, instead of the linked planes being pulled into
> the state later and tripping the drm_WARN_ON() in
> intel_async_flip_check_hw().
> 
> Tested on Raptor Lake-U (Iris Xe) with the patch applied to the i915 of
> Linux 7.3.4, unmodified KWin 6.8.2 and a fullscreen client that requests
> tearing through wp_tearing_control_v1. Before, none of about 350 frames per
> run was presented without vsync. With the patch 3334 of 3340 frames tear
> and the message above is gone. What is still rejected is the first flip
> after the modifier or format changed, once per run, as intended.
> 
> Signed-off-by: Erwin Springer <aot.lerwin@gmail.com>
> ---
> Changes in v2:
> - Don't skip a disabled plane that is in use as the Y plane of a planar
>   framebuffer, it would trip the drm_WARN_ON() in
>   intel_async_flip_check_hw() (found by the Sashiko review)
>   The device test was done with v1, no planar framebuffer was in use
>   there. v2 is compile-tested (W=1).
> - Link to v1: https://patch.msgid.link/20261115-i915-async-planes-v1-1-d13498d0b6be@gmail.com
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index f4d9148ef..9be7596fa 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -6281,6 +6281,16 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
>  		if (plane->pipe != crtc->pipe)
>  			continue;
>  
> +		/*
> +		 * Userspace may add planes it doesn't change to the commit.
> +		 * A plane that is disabled and stays disabled takes no part
> +		 * in the async flip, unless it is in use as the Y plane of
> +		 * a planar format on another plane.
> +		 */
> +		if (!old_plane_state->uapi.fb && !new_plane_state->uapi.fb &&
> +		    !old_plane_state->planar_linked_plane)
> +			continue;
> +
>  		/*
>  		 * TODO: Async flip is only supported through the page flip IOCTL
>  		 * as of now. So support currently added for primary plane only.
> @@ -6346,6 +6356,10 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
>  		if (plane->pipe != crtc->pipe)
>  			continue;
>  
> +		/* Disabled planes that stay disabled take no part in the flip. */
> +		if (!old_plane_state->hw.fb && !new_plane_state->hw.fb)
> +			continue;
> +
>  		/*
>  		 * Only async flip capable planes should be in the state
>  		 * if we're really about to ask the hardware to perform
> 
> ---
> base-commit: 419bb0e4cadd214a0847010c02ade95e5fc511f7
> change-id: 20261115-i915-async-planes-d532ca94cf3c
> 
> Best regards,
> --  
> Erwin Springer <aot.lerwin@gmail.com>
> 

-- 
Ville Syrjälä
Intel
