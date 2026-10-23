Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAD606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O4lmRQ+6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC48B10E608;
	Fri, 23 Oct 2026 12:52:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05C210E3C3;
 Fri, 23 Oct 2026 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792759959; x=1824295959;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=uC/gz90oGzp4OzSVHhRWvZGIsTl5Z0xSeQUEbSuDTCc=;
 b=O4lmRQ+6ws/2AbVG1ijGwU+gh9zR2ReVr1KgXNQBVH0UefFZMu4O2GTg
 4IHatNmsmIAt7GoOTgdP/fQ3KlnSmmmJO/3fi4huJvn1EtQHdHCwuBAj7
 H//q21PTZhC4MeUNoqlzArN/0Q0ri03PRV+T0KVAMs2VA2f7+N1iqxL6c
 DeZ2S7ASfT9rS5kNkiMuMDrHB8Bel3NZcIxOF6CGDXDlJwyWY+pP6vgYV
 OpeJ7MWutEawW4uxWea7jBr7HQH3Ho/Ge2xC2THKyYxZY6AkTY0YpMqo2
 /NV+Sg4X5TpmgSZGRh7q40jUKWHN25sTor3aSTGjeF/INgA2EWbluoJjY w==;
X-CSE-ConnectionGUID: RUigQjzYT/mUcL4VI+GQqQ==
X-CSE-MsgGUID: K7qD3Ct1Qn68gQq33rhxZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1399439"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1399439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 05:52:38 -0700
X-CSE-ConnectionGUID: owh5pRRqQjCgO2MS7Zu/Qw==
X-CSE-MsgGUID: V6smB5F8Q5G4+kD2wYccZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3980812"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.106])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 05:52:37 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kenneth Assogba <kennethassogba@gmail.com>, rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/i915/display: limit power defaults on affected
 Latitude 7490
In-Reply-To: <CANuUoF7c0tNjogjAZVBMd_reP1Z3wGOj3ybT0EB69ecWcNbKjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <CANuUoF7c0tNjogjAZVBMd_reP1Z3wGOj3ybT0EB69ecWcNbKjQ@mail.gmail.com>
Date: Fri, 23 Oct 2026 15:52:34 +0300
Message-ID: <5cd3479e15035e5eb0aa9356f0febf3477c00fd9@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026, Kenneth Assogba <kennethassogba@gmail.com> wrote:
> A Dell Latitude 7490 (BIOS 1.41.0, PCI 8086:5917, subsystem 1028:081c)
> repeatedly froze with its internal display active on Ubuntu
> 7.0.0-38-generic. Logs contain skl_dpll0_update and
> gen9_disable_dc_states warnings. The user reports several freeze-free
> days with PSR/DC disabled, including undocked sessions; swap/zswap
> changes are a confounding factor.
>
> This RFC disables automatic PSR/DC defaults only for the matching
> PCI/DMI identifiers and preserves explicit overrides. Linux 7.3 with
> this change built and booted. Without i915 overrides, global
> parameters stayed -1 and device values became 0; the internal display
> was enabled. Initial checks found no earlier warning names, GPU
> hang/reset or OOM patterns.
>
> Unpatched mainline reproduction, separate PSR/DC tests, bisection and
> power measurements are missing. Power consumption may increase. Is the
> early per-device parameter hook appropriate, and should panel
> identification further narrow the match?

Please prefer filing bugs as described at [1]. The goal is to root cause
issues and make stuff work in a generic fashion, not apply quirks on
individual machines as the first course of action.

Sometimes when we do have to use quirks, we have existing frameworks for
it, and adding stuff inline like this is certainly not acceptable.


BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


>
> The attached text/plain RFC preserves the patch bytes; Gmail changes
> pasted diffs. It includes my DCO sign-off and Assisted-by: LLM
> attribution.
>
> Report and tests:
> https://gist.github.com/kennethassogba/b8332d07d6e4c508307b625cc8a037b6
>
> Kenneth Assogba
> From a2f6c87b3705283a3e2c66b2b85a04e895488874 Mon Sep 17 00:00:00 2001
> From: Kenneth Assogba <kennethassogba@gmail.com>
> Date: Mon, 19 Oct 2026 22:26:34 +0200
> Subject: [RFC PATCH] drm/i915/display: limit power defaults on affected
>  Latitude 7490
>
> A Latitude 7490 with BIOS 1.41.0 repeatedly froze with its internal
> display active on Ubuntu 7.0.0-38-generic. The retained journal contains
> skl_dpll0_update and gen9_disable_dc_states warnings. The user reports
> several freeze-free days with PSR and display C-states disabled together,
> including undocked sessions. Swap/zswap changes are a confounding factor.
>
> Disable automatic PSR/DC defaults for PCI 8086:5917, subsystem 1028:081c,
> and exact Dell Latitude 7490 / BIOS 1.41.0 DMI matches. Preserve explicit
> parameter values. Apply the defaults after the per-device parameter copy,
> before display power initialization consumes enable_dc.
>
> Linux 7.3 with this change built and booted on the reporting machine.
> Without PSR/DC boot arguments, global values stayed -1 and per-device
> values became 0. The internal display was enabled and the initial log
> check found neither earlier warning name, GPU hang/reset nor OOM patterns.
>
> This RFC proposes a machine-specific workaround. The underlying cause,
> unpatched mainline behavior and the need for both settings remain open.
> Disabling these features may increase power consumption.
>
> Link: https://gist.github.com/kennethassogba/b8332d07d6e4c508307b625cc8a0=
37b6
> Assisted-by: LLM
> Signed-off-by: Kenneth Assogba <kennethassogba@gmail.com>
> ---
>  .../drm/i915/display/intel_display_device.c   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/driver=
s/gpu/drm/i915/display/intel_display_device.c
> index f17fc2c..770f524 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -3,6 +3,7 @@
>   * Copyright =C2=A9 2023 Intel Corporation
>   */
>=20=20
> +#include <linux/dmi.h>
>  #include <linux/pci.h>
>=20=20
>  #include <drm/drm_color_mgmt.h>
> @@ -1690,6 +1691,31 @@ static const char *step_name(const struct intel_di=
splay_runtime_info *runtime)
>  	return strlen(runtime->step_name) ? runtime->step_name : "N/A";
>  }
>=20=20
> +static void intel_display_device_apply_param_quirks(struct intel_display=
 *display,
> +						  const struct pci_dev *pdev)
> +{
> +	struct intel_display_params *params =3D &display->params;
> +
> +	/* Limit the workaround to the hardware and firmware reported affected.=
 */
> +	if (pdev->vendor !=3D PCI_VENDOR_ID_INTEL || pdev->device !=3D 0x5917 ||
> +	    pdev->subsystem_vendor !=3D 0x1028 || pdev->subsystem_device !=3D 0=
x081c ||
> +	    !dmi_match(DMI_SYS_VENDOR, "Dell Inc.") ||
> +	    !dmi_match(DMI_PRODUCT_NAME, "Latitude 7490") ||
> +	    !dmi_match(DMI_BIOS_VERSION, "1.41.0"))
> +		return;
> +
> +	if (params->enable_psr !=3D -1 && params->enable_dc !=3D -1)
> +		return;
> +
> +	/* Preserve explicit module parameter values for further diagnosis. */
> +	if (params->enable_psr =3D=3D -1)
> +		params->enable_psr =3D 0;
> +	if (params->enable_dc =3D=3D -1)
> +		params->enable_dc =3D 0;
> +
> +	drm_info(display->drm, "Applying Latitude 7490 display power defaults\n=
");
> +}
> +
>  struct intel_display *intel_display_device_probe(struct pci_dev *pdev,
>  						 const struct intel_display_parent_interface *parent)
>  {
> @@ -1710,6 +1736,7 @@ struct intel_display *intel_display_device_probe(st=
ruct pci_dev *pdev,
>  	display->parent =3D parent;
>=20=20
>  	intel_display_params_copy(&display->params);
> +	intel_display_device_apply_param_quirks(display, pdev);
>=20=20
>  	if (has_no_display(pdev)) {
>  		drm_dbg_kms(display->drm, "Device doesn't have display\n");

--=20
Jani Nikula, Intel
