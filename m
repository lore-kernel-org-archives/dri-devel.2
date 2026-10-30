Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GNfVTdg9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175CB1126CB;
	Fri, 30 Oct 2026 09:37:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493F11126C8;
 Fri, 30 Oct 2026 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353032; x=1824889032;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=M0gjpgQ7DfAt9+x9TjiGjfUPwKgR0H11MEhsD4OYLog=;
 b=GNfVTdg9lk3xqsXyJQBGx38laUPhJ3IzWq+4wcZyqICqYH4yPz9sO52/
 Oo3XtiVZR73W6lFXSFRlc2Zi1zuKhyh8YGvVfPwgH2XxUPZxr7mf98UXn
 ZLwP4VFU0nHhCvKM3Zbl+pwLt2qfOqYu3t5oWVOr+hxRk+WctP9mhGANB
 vbTV5eUVNqYp2zgWqZxLu14JEUVJA/PtbBD6imNkX8BPvGetpjw1GR+7p
 ZMVJqgWnXzTqamo4OlkcYhTWdqG+bKfjrOCOYjCQ5driOEqIRpoFa9/DP
 aVnCMvtVpcPNq0M4CLZwml0ckDNcrBo/4HV072pi43GZ3YS7gpLwCgV42 A==;
X-CSE-ConnectionGUID: gyZSoBVySoGf1dXBSxW4Cg==
X-CSE-MsgGUID: 1DMu5mfuSWKbdnYQY+7q+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2137498"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2137498"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:37:11 -0700
X-CSE-ConnectionGUID: caHEzjaiQGmk8cjV3USHxA==
X-CSE-MsgGUID: DbIZ2r2ZT1qd7L0lyLLw6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5415071"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:37:07 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Theo Andersen Carton <andersen.theo@gmail.com>, rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 airlied@gmail.com, simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Theo Andersen Carton
 <andersen.theo@gmail.com>
Subject: Re: [PATCH v3] drm/i915/ddi: add DDI A force 4 lanes quirk for
 Apple MacBookPro11,5
In-Reply-To: <20260917185235.23792-1-andersen.theo@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260917185235.23792-1-andersen.theo@gmail.com>
Date: Fri, 30 Oct 2026 11:37:05 +0200
Message-ID: <d34dd7cca55a21f7d62c9eff872dcf5c3e9f2297@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 17 Sep 2026, Theo Andersen Carton <andersen.theo@gmail.com> wrote:
> On dual-GPU Retina MacBooks the internal panel is muxed to the discrete
> GPU at boot, so Apple's firmware never lights up eDP on the Intel side.
> As a result it never sets DDI_A_4_LANES, and intel_ddi_max_lanes() reads
> back a source maximum of two lanes for port A.
>
> intel_dp_max_common_lane_count() then takes min3(source_max = 2,
> sink_max = 4, ...) = 2, giving 2 x 2.7 Gbps x 8/10 = 4.32 Gbps of link
> bandwidth. The panel's native 2880x1800@60 8bpc mode needs 8.1 Gbps, so
> every mode is rejected with MODE_CLOCK_HIGH and the connector comes up
> with no usable modes at all -- the panel stays dark whenever i915 is
> made to drive it, which looks like a hardware limitation but is not.
>
> The lanes are physically there. Reading the panel's DPCD from the AMD
> side, where amdgpu drives it correctly, reports MAX_LANE_COUNT = 0x84,
> i.e. 4 lanes, and amdgpu's own link_settings shows it running the panel
> at 4 lanes / HBR. macOS likewise drives this panel from the iGPU at its
> native resolution, so all four lanes are routed through the gmux to
> DDI A. Only the register bit is unset.
>
> intel_ddi_a_force_4_lanes() already exists for exactly this situation --
> its neighbouring comment notes that "Some BIOS might fail to set this
> bit on port A if eDP wasn't lit up at boot" -- but it only covers
> Broxton and Geminilake. Extend it with a DMI quirk so affected Macs get
> the correct lane count too.
>
> The DMI match is deliberately narrow. Other dual-GPU models in the same
> family are very likely affected identically, but they are untested, so
> widen the match only as reports come in.
>
> Tested on a MacBookPro11,5 (Haswell Crystal Well, Iris Pro 5200 +
> Radeon R9 M370X): with the quirk, DDI A comes up as 4 lanes, link
> training passes at link rate 270000 / lane count 4, and i915 drives the
> internal panel at its native 2880x1800.
>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17087
> Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>

Sorry, this fell through the cracks. It looks good to me, but I kicked
the CI to run. We don't actually have Macs in CI, but it's more to
ensure we're not regressing anything.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Cc: stable@vger.kernel.org

> ---
> Numbering note: neither earlier posting was labelled, so to match the
> numbering already used on the list this is v3. v1 [1] was pasted into a
> mail client by hand, which hard-wrapped the diff and detabbed it, leaving
> it unapplicable. v2 [2] was the same patch resent with git send-email,
> unlabelled.
>
> v3:
> - No functional change since v2.
> - Commit message: the machine is Haswell (Crystal Well), not Broadwell as
>   v1/v2 claimed. The DMI match was always by model, so no code change.
> - Added Closes: tag for the bug report, which carries the failing-case
>   logs, the VBT dump and the EDID.
>
> [1] https://lore.kernel.org/r/CANFnrspHiK7ii28XPdLkOMyhSZcJ9xz6CT-kNX+oiiF+8N-2Fg@mail.gmail.com
> [2] https://lore.kernel.org/lkml/20260912091805.531666-1-andersen.theo@gmail.com/
>  drivers/gpu/drm/i915/display/intel_ddi.c    |  7 +++++
>  drivers/gpu/drm/i915/display/intel_quirks.c | 34 +++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 02a53c9848e1..f746287830b3 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4976,6 +4976,13 @@ static bool intel_ddi_a_force_4_lanes(struct intel_digital_port *dig_port)
>  	if (display->platform.geminilake || display->platform.broxton)
>  		return true;
>  
> +	/*
> +	 * Machines whose firmware leaves eDP dark on the Intel side never set
> +	 * the bit, so trust the quirk rather than the register.
> +	 */
> +	if (intel_has_quirk(display, QUIRK_DDI_A_FORCE_4_LANES))
> +		return true;
> +
>  	return false;
>  }
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 33245f44c0d5..feb28956a013 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -100,6 +100,20 @@ static void quirk_disable_psr2(struct intel_display *display)
>  	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
>  }
>  
> +/*
> + * Dual-GPU Macs boot with the internal panel muxed to the discrete GPU, so
> + * the firmware never lights up eDP on the Intel side and consequently never
> + * sets DDI_A_4_LANES -- even though all four lanes are wired through the gmux
> + * to DDI A. Without the bit, port A is capped at two lanes, which is not
> + * enough bandwidth for the panel's native mode, leaving the connector with no
> + * usable modes at all.
> + */
> +static void quirk_ddi_a_force_4_lanes(struct intel_display *display)
> +{
> +	intel_set_quirk(display, QUIRK_DDI_A_FORCE_4_LANES);
> +	drm_info(display->drm, "Applying DDI A force 4 lanes quirk\n");
> +}
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -142,6 +156,13 @@ static int intel_dmi_no_pps_backlight(const struct dmi_system_id *id)
>  	return 1;
>  }
>  
> +static int intel_dmi_ddi_a_force_4_lanes(const struct dmi_system_id *id)
> +{
> +	DRM_INFO("DDI A is 4 lanes despite firmware on %s\n", id->ident);
> +
> +	return 1;
> +}
> +
>  static const struct intel_dmi_quirk intel_dmi_quirks[] = {
>  	{
>  		.dmi_id_list = &(const struct dmi_system_id[]) {
> @@ -188,6 +209,19 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
>  		},
>  		.hook = quirk_no_pps_backlight_power_hook,
>  	},
> +	{
> +		.dmi_id_list = &(const struct dmi_system_id[]) {
> +			{
> +				.callback = intel_dmi_ddi_a_force_4_lanes,
> +				.ident = "Apple MacBookPro11,5",
> +				.matches = {DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +					    DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,5"),
> +				},
> +			},
> +			{ }
> +		},
> +		.hook = quirk_ddi_a_force_4_lanes,
> +	},
>  };
>  
>  static struct intel_quirk intel_quirks[] = {
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 970a4fe52faf..d2b8e9183c62 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>  	QUIRK_EDP_LIMIT_RATE_HBR2,
>  	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>  	QUIRK_DISABLE_PSR2,
> +	QUIRK_DDI_A_FORCE_4_LANES,
>  };
>  
>  void intel_init_quirks(struct intel_display *display);
>
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713

-- 
Jani Nikula, Intel
