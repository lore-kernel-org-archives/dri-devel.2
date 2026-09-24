Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD53C98315
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7043B10F38C;
	Thu, 24 Sep 2026 08:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QzoMScpp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E1210F385;
 Thu, 24 Sep 2026 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790237038; x=1821773038;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ht4eIQbtIrPtGKeyLtuaX/EoLNGaj6v/Hn1biY+6DB0=;
 b=QzoMScpp625bux7oQbb4/St3GkT+zkvdCFBqeGwKk1BiQJNykSH+ZXUz
 yJGtsdG0MUBZiXLaCVhVpvqijfZUxXGPKwQcilj6IQE+wtwBUn3cYfkEC
 NT0td0GlsA8fmkon7sHALZz9vlKsLzCGbPJwaj8tpuf3tYtkVnCJIHPXZ
 0X45HyTJhHEmngpmdkxUibODgTHveRcP79SFKVk6HxvQ5PNPOmWxshveW
 zSuTfCEzqJ7A2IFXzDmeUlckQ9oXoOxcqdtz4uGejCRjMByuuSPRAczha
 mM6y7M1CL9XvpY2jcAXQLnCHnqKJRNqZX1jWNJy74c55s8tjQb2jM8Qcm Q==;
X-CSE-ConnectionGUID: wmWXM0swSo+D1Cw9LSxwww==
X-CSE-MsgGUID: C7Tf5cMJQie4I7YvpWKxmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89956414"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="89956414"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 01:03:58 -0700
X-CSE-ConnectionGUID: uN8caXrkT2ax+wqk3bH4CA==
X-CSE-MsgGUID: EADGVSp8SfmZzftbjOvZBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273541203"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.130])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 01:03:55 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Conor Svensson <conor10@gmail.com>, intel-gfx@lists.freedesktop.org
Cc: Conor Svensson <conor10@gmail.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/i915/dp: Ignore inconsistent TMDS limits on an
 Anker DP branch
In-Reply-To: <20260923221018.42133-1-conor10@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260923221018.42133-1-conor10@gmail.com>
Date: Thu, 24 Sep 2026 11:03:51 +0300
Message-ID: <5893371ab206c97d5d2f1d72eb149d5ace4250e2@intel.com>
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

On Wed, 23 Sep 2026, Conor Svensson <conor10@gmail.com> wrote:
> Reconnecting an Anker 565 A8388 USB-C hub with a DisplayPort monitor
> attached can leave the branch reporting a DVI downstream descriptor
> with 25-165 MHz TMDS limits. On a ThinkPad L14 Gen 4 Intel with a Dell
> S3422DWG, this removes the native 3440x1440 mode from the connector's
> mode list even though the EDID still contains it. An explicit native
> modeline works with the same hardware state.
>
> Ignore the derived TMDS limits only for the captured branch identity,
> firmware and downstream descriptor when EDID 1.4 identifies a digital
> DisplayPort input. Retain the raw descriptor and other mode checks.
> Do not restrict the match to a particular monitor or laptop model.
>
> With otherwise matching upstream Linux 7.2.5 control/patched builds,
> the control loses native modes after USB-C reconnect, while the patched
> kernel selects 3440x1440 at 59.973 Hz automatically. Repeated reconnects,
> both USB-C ports, suspend/resume, undocking while asleep and docked boot
> pass. HDMI also works and does not activate the workaround. Periodic
> picture cycling observed on the control stops with the patch.
>
> The branch identity is not proven unique to this retail adapter. This
> is an experimental workaround for review, not an explanation of why the
> branch reports inconsistent capabilities. Other adapters and monitors
> have not been tested.
>
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180
> Assisted-by: LLM
> Signed-off-by: Conor Svensson <conor10@gmail.com>
> ---
> RFC: is this best handled as a branch quirk here, or in the common DP
> helpers? The captured identity and descriptor match is deliberately narrow;
> there is no monitor/laptop model restriction. The informational log marker
> is retained to show exactly when this experimental workaround executes.
> The commit introducing the underlying problem has not been identified, so
> there is no speculative Fixes tag.
>
> Hardware A/B testing used upstream Linux 7.2.5 with otherwise identical
> configurations. This RFC applies the same 48 added lines to drm-tip at the
> base commit below. This drm-tip revision has not been boot-tested. The affected intel_dp.o
> compiles successfully here with no compiler warnings; strict checkpatch
> passes (human sign-off pending), and 426 predicate boundary cases pass
> with ASan/UBSan. These predicate tests are not DRM integration tests.
>
> Results: three USB-C reconnects, alternate USB-C port, docked s2idle
> resume plus reconnect, undock while asleep/wake/reconnect, and docked
> DisplayPort reboot all passed. HDMI also passed without activating the
> workaround. The control lost native modes and showed periodic picture
> cycling; that cycling stopped on the patched kernel. No custom modeline
> was used in either test kernel. Other hardware and higher refresh rates
> remain untested.
>
> AI assistance: Codex (GPT-6) helped investigate the reported hotplug
> failure, wrote the match/limit-clearing change, prepared the predicate
> tests, collected diagnostics and drafted this message. The human reporter
> performed the physical reconnect, suspend and reboot tests and confirmed
> the visible results. The assistance arose from an extended troubleshooting
> session, rather than a single code-generation prompt.
>
> Evidence and detailed test results:
> https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180#note_3677750
>
> This is my first kernel patch submission. I'd appreciate feedback on
> whether this belongs here or in the common DP helpers, and whether the
> matching criteria are appropriate.

Thanks for the patch. Please let's first root cause the issue (on the
gitlab issue) before jumping into quirking specific devices.

Regardless, a few comments below.

>
> Thanks,
> Conor
>
>  drivers/gpu/drm/i915/display/intel_dp.c | 48 +++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index ffddf4b33..6d6767ca7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -6153,6 +6153,39 @@ intel_dp_get_edid(struct intel_dp *intel_dp)
>  	return drm_edid_read_ddc(&connector->base, &intel_dp->aux.ddc);
>  }
>  
> +static bool
> +intel_dp_has_anker_tmds_mismatch(struct intel_dp *intel_dp,
> +				 const struct drm_edid *drm_edid)
> +{
> +	static const struct drm_dp_dpcd_ident branch = {
> +		.oui = { 0x90, 0xcc, 0x24 },
> +		.device_id = { 'S', 'Y', 'N', 'A', 'b', 0x10 },
> +		.hw_rev = 0x10,
> +		.sw_major_rev = 0x06,
> +		.sw_minor_rev = 0x05,
> +	};
> +	static const u8 downstream_ports[] = {
> +		0x0a, 0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	};

intel_dp->downstream_ports is read from DPCD address 0x80, and it
dynamically reflects the downstream port information, i.e. what's
currently connected to the branch device. Having a fixed comparison like
this will only work for a specific type of downstream device connected
to a specific downstream port.

> +	const struct edid *edid = drm_edid_raw(drm_edid);

No new drm_edid_raw() calls are to be added.

> +
> +	if (intel_dp_is_edp(intel_dp) || intel_dp->is_mst ||
> +	    !drm_dp_is_branch(intel_dp->dpcd) || !edid)
> +		return false;
> +
> +	/* HDMI and DVI inputs must retain their downstream limits. */
> +	if (edid->version != 1 || edid->revision < 4 ||
> +	    !(edid->input & DRM_EDID_INPUT_DIGITAL) ||
> +	    (edid->input & DRM_EDID_DIGITAL_TYPE_MASK) != DRM_EDID_DIGITAL_TYPE_DP)
> +		return false;
> +
> +	return !memcmp(&intel_dp->desc.ident, &branch, sizeof(branch)) &&
> +		!memcmp(intel_dp->downstream_ports, downstream_ports,
> +			sizeof(downstream_ports)) &&
> +		intel_dp->dfp.min_tmds_clock == 25000 &&
> +		intel_dp->dfp.max_tmds_clock == 165000;
> +}

We have intel_quirks.c with various structured mechanisms for
identifying quirks. If we end up needing a quirk for this, the existing
mechanisms need to be used instead of adding a bunch of code inline like
this.

Again, please let's first root cause and debug the issue instead of
trying to fix the patch.

BR,
Jani.


> +
>  static void
>  intel_dp_update_dfp(struct intel_dp *intel_dp,
>  		    const struct drm_edid *drm_edid)
> @@ -6181,6 +6214,21 @@ intel_dp_update_dfp(struct intel_dp *intel_dp,
>  		drm_dp_get_pcon_max_frl_bw(intel_dp->dpcd,
>  					   intel_dp->downstream_ports);
>  
> +	/*
> +	 * Experimental workaround for the branch observed in an Anker A8388.
> +	 * USB-C hotplug can expose a DVI descriptor for the DP output. The
> +	 * monitor's native timing works when requested explicitly, despite
> +	 * the reported 165 MHz limit. Keep the captured identity and failure
> +	 * signature checks narrow until the underlying cause is understood.
> +	 */
> +	if (intel_dp_has_anker_tmds_mismatch(intel_dp, drm_edid)) {
> +		intel_dp->dfp.min_tmds_clock = 0;
> +		intel_dp->dfp.max_tmds_clock = 0;
> +		drm_info(display->drm,
> +			 "[CONNECTOR:%d:%s] experimental Anker DP TMDS limit workaround\n",
> +			 connector->base.base.id, connector->base.name);
> +	}
> +
>  	drm_dbg_kms(display->drm,
>  		    "[CONNECTOR:%d:%s] DFP max bpc %d, max dotclock %d, TMDS clock %d-%d, PCON Max FRL BW %dGbps\n",
>  		    connector->base.base.id, connector->base.name,
>
> base-commit: 703cd271db3a35088460ab3fec0a96bd48e7fe04

-- 
Jani Nikula, Intel
