Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E45CC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353E510E6C2;
	Mon, 31 Aug 2026 07:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PWnBHq8Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F4810E6C2;
 Mon, 31 Aug 2026 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788161968; x=1819697968;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=BSX4JPsTUA1rhCA4YtPNJ8wqYMmJwWqrUrTT6yZORII=;
 b=PWnBHq8QZSs+1va32XQy+cezqNB7g+c1DaiMqJTrpS1nG37aKKA1gQZu
 y7D7sttxu5K4xFm77BWIXijVflMH4WlGzKRFThK9wAPiqzW9Kp7iRyTqL
 X/tb+mT1J6syoygefRXBQcG2fAPtkaQZDAX0+Ukq+E8dMcrsVMmOiT0Wt
 1PVzfrmNYL8mZBahIOcOIVGchCEADBQtAWSNJdPLRRT1Agx4y9iDd9inL
 17RphW7Jaar9PNoGsIBjxgo7Nd6hBwr9e8CXgoyyJ/0NPDpF1ipxF1016
 p0uursDUeyP+1GcJLf3izGNjQ8uoAga5M6+F8lwRMyJioUIBIlXzdPcOo w==;
X-CSE-ConnectionGUID: GDzVLGrsRCyKHwIys32nzw==
X-CSE-MsgGUID: R96DXOtlQrSukfL5cSXZlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="114098586"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="114098586"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 00:39:09 -0700
X-CSE-ConnectionGUID: jC1wsiNNSiGuHFJsHoTFqw==
X-CSE-MsgGUID: zcC8wP6zRN6l3LDIsV0h4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="306966919"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 00:39:07 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Eduardo Diaz <iamedu@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Eduardo
 Diaz <iamedu@gmail.com>
Subject: Re: [PATCH] drm/i915/cdclk: Don't trust boot readout for per-pipe
 cdclk/voltage tracking
In-Reply-To: <20260830161703.11570-1-iamedu@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260830161703.11570-1-iamedu@gmail.com>
Date: Mon, 31 Aug 2026 10:39:03 +0300
Message-ID: <c2603413d2af50854a620c5966149495b36dc851@intel.com>
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

On Sun, 30 Aug 2026, Eduardo Diaz <iamedu@gmail.com> wrote:
> On Panther Lake (xe3lpd) laptops, cold boot reliably corrupts the
> internal eDP panel: pipe A gets a "Selective fetch area calculation
> failed in pipe A" warning immediately followed by a CPU pipe A FIFO
> underrun, and the panel stays corrupted for the rest of the session.
> A subsequent suspend/resume cycle (or any other full re-modeset)
> "fixes" it, which pointed at cdclk/voltage-level tracking rather than
> a genuine hardware race.
>
> intel_modeset_readout_hw_state() runs once at driver probe (and again
> on resume) to figure out what firmware/GOP left the display in. For
> each already-active pipe it calls intel_cdclk_update_hw_state(),
> which seeds cdclk_state->min_cdclk[]/min_voltage_level[] directly
> from the freshly read-out crtc_state. That treats "firmware left this
> pipe active with mode X" as proof that this driver's own cdclk,
> voltage-level and DBUF setup for mode X is already established in
> hardware. It isn't -- only firmware's own, entirely separate code
> path has ever touched those registers.
>
> The OS driver's first real modeset for an inherited pipe typically
> targets the same native panel mode, so the freshly computed
> crtc_state->min_cdclk/min_voltage_level trivially match this
> readout-seeded baseline. intel_cdclk_update_crtc_min_cdclk() and
> intel_cdclk_update_crtc_min_voltage_level() then conclude nothing
> changed and skip the recalculation, on the one commit where it
> actually matters: taking a pipe from firmware ownership to being
> correctly configured by this driver.
>
> Fix this in two parts:
>
>  - Invalidate the per-pipe min_cdclk[]/min_voltage_level[] tracking
>    right after boot-time readout, so the first real atomic commit is
>    guaranteed to see a difference.
>
>  - Stop early-returning in intel_cdclk_update_crtc_min_cdclk() and
>    intel_cdclk_update_crtc_min_voltage_level() based on the crtc_state
>    comparison alone. That comparison is unreliable for exactly the
>    same reason (it's derived from the same readout), and skips the
>    real, tracked-state check below it.
>
> Bisected on real hardware (Lenovo Yoga 9i 14IPH11, Panther Lake) down
> to a narrow window between v6.19.10 (clean on every cold boot) and
> v7.1.10 (broken on every cold boot); confirmed via live kernel
> tracing that the skip path fires unconditionally on this platform
> from the very first post-boot atomic commit onward. This fix
> eliminates the FIFO underrun across many consecutive cold boots on
> the same hardware, with no regression observed across suspend/resume.

Do you have a regressing commit? Nearly 600 commits were merged to i915
display alone between 6.19 and 7.1 so it's not really a narrow window.

Have you filed a bug as described at [1]? With debugs, logs, and
everything.

Have you tried with 1786d2688781 ("drm/i915/cdclk: Avoid spurious cdclk
sanitization on PTL+")?


BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


> The investigation and this fix were developed with the assistance of
> Claude (Anthropic), driven and verified end to end on the affected
> hardware by the Signed-off-by below.
>
> Signed-off-by: Eduardo Diaz <iamedu@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_cdclk.c    | 45 ++++++++++++++-----
>  drivers/gpu/drm/i915/display/intel_cdclk.h    |  1 +
>  .../drm/i915/display/intel_modeset_setup.c    |  1 +
>  3 files changed, 36 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
> index a53d887271..209a2373d1 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> @@ -2981,11 +2981,14 @@ static int intel_cdclk_update_crtc_min_cdclk(struct intel_atomic_state *state,
>  	bool allow_cdclk_decrease = intel_any_crtc_needs_modeset(state);
>  	int ret;
>  
> -	if (new_min_cdclk == old_min_cdclk)
> -		return 0;
> -
> -	if (!allow_cdclk_decrease && new_min_cdclk < old_min_cdclk)
> -		return 0;
> +	/*
> +	 * old_min_cdclk comes from the previous crtc_state, which after
> +	 * boot-time readout reflects whatever firmware/GOP left running,
> +	 * not what this driver has programmed. For an inherited pipe it
> +	 * equals new_min_cdclk by construction (same mode, same formula),
> +	 * so an early return here would skip the recalculation that
> +	 * matters. Always continue on to the cdclk_state check below.
> +	 */
>  
>  	cdclk_state = intel_atomic_get_cdclk_state(state);
>  	if (IS_ERR(cdclk_state))
> @@ -3026,12 +3029,10 @@ static int intel_cdclk_update_crtc_min_voltage_level(struct intel_atomic_state *
>  	bool allow_voltage_level_decrease = intel_any_crtc_needs_modeset(state);
>  	int ret;
>  
> -	if (new_min_voltage_level == old_min_voltage_level)
> -		return 0;
> -
> -	if (!allow_voltage_level_decrease &&
> -	    new_min_voltage_level < old_min_voltage_level)
> -		return 0;
> +	/*
> +	 * old_min_voltage_level is unreliable for the same reason; see
> +	 * intel_cdclk_update_crtc_min_cdclk().
> +	 */
>  
>  	cdclk_state = intel_atomic_get_cdclk_state(state);
>  	if (IS_ERR(cdclk_state))
> @@ -3705,6 +3706,28 @@ void intel_cdclk_update_hw_state(struct intel_display *display)
>  	cdclk_state->dbuf_bw_min_cdclk = intel_dbuf_bw_min_cdclk(display, dbuf_bw_state);
>  }
>  
> +/*
> + * intel_cdclk_update_hw_state() seeds min_cdclk[]/min_voltage_level[]
> + * from readout's crtc_state, i.e. from whatever firmware/GOP left
> + * running, not from anything this driver has programmed. A pipe's
> + * first real modeset usually targets the same native mode, so the
> + * freshly computed value matches this seeded baseline and
> + * intel_cdclk_update_crtc_min_cdclk()/_min_voltage_level() conclude
> + * nothing changed, skipping the recalculation that matters. Call
> + * this after readout so the first real commit sees a difference.
> + */
> +void intel_cdclk_invalidate_min_tracking(struct intel_display *display)
> +{
> +	struct intel_cdclk_state *cdclk_state =
> +		to_intel_cdclk_state(display->cdclk.obj.state);
> +	enum pipe pipe;
> +
> +	for_each_pipe(display, pipe) {
> +		cdclk_state->min_cdclk[pipe] = 0;
> +		cdclk_state->min_voltage_level[pipe] = 0;
> +	}
> +}
> +
>  void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc)
>  {
>  	struct intel_display *display = to_intel_display(crtc);
> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.h b/drivers/gpu/drm/i915/display/intel_cdclk.h
> index a60cbf745e..1517d3605a 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.h
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.h
> @@ -46,6 +46,7 @@ int intel_cdclk_state_set_joined_mbus(struct intel_atomic_state *state, bool joi
>  struct intel_cdclk_state *
>  intel_atomic_get_cdclk_state(struct intel_atomic_state *state);
>  void intel_cdclk_update_hw_state(struct intel_display *display);
> +void intel_cdclk_invalidate_min_tracking(struct intel_display *display);
>  void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc);
>  int intel_cdclk_update_dbuf_bw_min_cdclk(struct intel_atomic_state *state,
>  					 int old_min_cdclk, int new_min_cdclk,
> diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> index 6aed881737..c7be6e63e7 100644
> --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> @@ -880,6 +880,7 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
>  	intel_bw_update_hw_state(display);
>  	intel_dbuf_bw_update_hw_state(display);
>  	intel_cdclk_update_hw_state(display);
> +	intel_cdclk_invalidate_min_tracking(display);
>  
>  	intel_pmdemand_init_pmdemand_params(display, pmdemand_state);
>  }

-- 
Jani Nikula, Intel
