Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652E606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1JNxkhi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F54110ECEB;
	Mon, 23 Nov 2026 11:11:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF5510ECDE;
 Mon, 23 Nov 2026 11:10:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE46062071;
 Mon, 23 Nov 2026 11:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1A91F000D1;
 Mon, 23 Nov 2026 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795432254;
 bh=Dx4n0KAgYe8Y36/1DYhpscCd9Dcoql+SgHkZsNOxwNQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y1JNxkhinpQyceLptOmc9/uj7rBHwRwkf3s4erfiIwdxRi0uRbBXhaMfEpWW4QfXZ
 9tHzIgBNDXSMqxIEiTvwwDiu91h+VaAUEklRKSyCzGvMtSde/mXMmbrizzFDrVKUPG
 IL0AfxPmrwMU7cQmoyhQiepbsrwk3V3qTRc/RYVz3xrUioc56NoKBSkM5xz1brPGZh
 t9BmnmgpxY9Va2hjXNkgKOMXgWL4gE1t8GMTPZp0YUYrRQcm55GsebMBsQdeqqUoDh
 sF6Y/LB9mmpIpQYqWWRJLgt63ruLc6i4weg0s3cd0EflTEHygXOKOIELd6BZy9HU+2
 xjsUnRp+tQA/Q==
Message-ID: <sashiko-outbox-229101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amd/amdgpu: Add 5K Support for iMac20,1 and
 iMac20,2
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?=
 <amd-gfx@lists.freedesktop.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261123102740.1389-1-atharvatiwarilinuxdev@gmail.com>
References: <20261123102740.1389-1-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 11:10:53 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/amdgpu: registering DM before SMU in
  amdgpu_discovery_set_ip_blocks()
- [Medium] drm/amd/display: dm_encoder_helper_atomic_check() forces
  RMX_FULL scaling
- [Medium] drm/amd/display: companion pipe left blanked in
  dce110_apply_ctx_to_hw()
- [Low] drm/amd/display: undocumented iMacPro1,1 DMI quirk in
  dmi_quirk_table
- [Low] drm/amd/display: NULL dm->adev dereference in
  retrieve_dmi_info() KUnit tests
- [Low] drm/amd/display: direct edid_blob_ptr use and redundant alloc in
  get_modes()
- [Low] drm/amd/display: redundant DPCD write in
  amdgpu_dm_commit_streams()
--

commit f1d3c9c046bd569268b41732fc66898568a48d2e
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2

This commit adds 5K tiled display support for Apple iMac 5K systems by
programming the Apple-specific DPCD 0x4F1 tile-mode register, synchronizing
the dual-link pipes, and initializing the display IP block ahead of the SMU
on iMac20,1 and iMac20,2.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 164e85b66e2d4..479c71ec32109 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
[ ... ]
> @@ -3677,15 +3704,25 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
>  		}
>  	}
> =20
> +	/* TODO: We should enable 5K in EFI and remove this quirk */
> +	imac5k =3D amdgpu_discovery_is_imac5k(adev);
> +	if (unlikely(imac5k)) {
> +		r =3D amdgpu_discovery_set_display_ip_blocks(adev);
> +		if (r)
> +			return r;
> +	}
> +
>  	if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {
>  		r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
>  		if (r)
>  			return r;
>  	}
> =20
> -	r =3D amdgpu_discovery_set_display_ip_blocks(adev);
> -	if (r)
> -		return r;
> +	if (likely(!imac5k)) {
> +		r =3D amdgpu_discovery_set_display_ip_blocks(adev);
> +		if (r)
> +			return r;
> +	}

[Severity: High]
Does registering dm_ip_block ahead of smu_v11_0_ip_block break DCN2.0 SMU
initialization and teardown ordering?

During amdgpu_device_ip_hw_init_phase2(), dm_hw_init() -> amdgpu_dm_init()
-> dc_create() -> dcn20_resource_construct() now runs before smu_hw_init()
sets adev->pm.dpm_enabled =3D true.  In that state, smu_get_uclk_dpm_states=
(),
smu_get_max_sustainable_clocks_by_dc(), and
smu_set_watermarks_for_clock_ranges() all reject DC's calls with
-EOPNOTSUPP:

drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:smu_set_watermarks_for_clock_rang=
es() {
	...
	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
		return -EOPNOTSUPP;
	...
}

Because dcn20_resource_construct() only uploads watermarks once at init,
WATERMARKS_EXIST is never set in smu->watermarks_bitmap, leaving DCN
watermark tables unprogrammed at boot and across S3/S4 resume and causing
navi10_display_config_changed() to skip SMU_MSG_NumOfDisplays.  In addition,
amdgpu_device_ip_fini_early() and amdgpu_device_ip_fini() walk
adev->ip_blocks[] in reverse registration order, so smu_hw_fini() and
smu_sw_fini() tear down SMU DPM before dm_hw_fini() shuts down the display
engine.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 284aac4d96bce..8c85878951287 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -4591,6 +4598,27 @@ static void amdgpu_dm_commit_streams(struct drm_at=
omic_commit *state,
>  	dc_exit_ips_for_hw_access(dm->dc);
>  	WARN_ON(!dc_commit_streams(dm->dc, &params));
> =20
> +	if (dm->imac5K_support) {
> +		for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
> +			dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
> +
> +			if (!dm_new_crtc_state->stream)
> +				continue;
> +
> +			if (dm_new_crtc_state->stream->signal !=3D SIGNAL_TYPE_EDP)
> +				continue;
> +
> +			if (new_crtc_state->mode.vdisplay =3D=3D 2880 &&
> +			    new_crtc_state->mode.hdisplay =3D=3D 2560) {
> +				u8 value =3D 1;
> +
> +				core_link_write_dpcd(dm->dc->links[0],
> +						     DP_APPLE_5K_TILE_MODE, &value, 1);
> +				dm->dc->config.imac5K_using_5K =3D true;
> +			} else
> +				dm->dc->config.imac5K_using_5K =3D false;
> +		}
> +	}

[Severity: Low]
Does this write DP_APPLE_5K_TILE_MODE over AUX on every full atomic commit
that includes the eDP CRTC, even when no modeset occurred?

amdgpu_dm_atomic_commit_tail() calls amdgpu_dm_commit_streams() whenever
lock_and_validation_needed is true (such as plane scaling, format, overlay,
or color-management updates), even if dc_commit_streams() returns early
because streams did not change.  Gating this on mode_set_reset_required or
amdgpu_dm_crtc_modeset_required() would avoid redundant AUX writes under
dm->dc_lock.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index c8a1ab8c3b169..e7663adcb501f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -125,6 +125,14 @@ STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(=
struct drm_encoder *encoder,
>  				       drm_mode_vrefresh(adjusted_mode));
>  			dm_new_connector_state->scaling =3D RMX_ASPECT;
>  		}
> +
> +		/* The 5K panel reports no scaling info, scale every non 5K mode to fu=
ll */
> +		if (aconnector->dc_link && aconnector->dc_link->dc->config.imac5K_supp=
ort) {
> +			if (crtc_state->mode.vdisplay !=3D 2880)
> +				dm_new_connector_state->scaling =3D RMX_FULL;
> +			else
> +				dm_new_connector_state->scaling =3D RMX_OFF;
> +		}
>  		return 0;
>  	}

[Severity: Medium]
Why does dm_encoder_helper_atomic_check() unconditionally overwrite
dm_new_connector_state->scaling with RMX_FULL when vdisplay !=3D 2880?

The check right above already defaults non-native eDP modes to RMX_ASPECT
when dm_new_connector_state->scaling =3D=3D RMX_OFF, preserving the aspect =
ratio
as expected when userspace has not requested a scaling mode.  Overwriting
dm_new_connector_state->scaling unconditionally here stretches non-16:9
modes across the panel, ignores any explicit scaling_mode property set by
userspace (such as DRM_MODE_SCALE_ASPECT or DRM_MODE_SCALE_CENTER), and
forces scaling even on the panel's native single-cable 3840x2160 mode.

In addition, persisting RMX_FULL in connector->state causes subsequent
amdgpu_dm_connector_mode_valid() calls to validate the 2560x2880 tile mode
with scaling enabled, where decide_crtc_timing_for_drm_display_mode()
replaces its CRTC timings with the 3840x2160 preferred mode's timings.

> @@ -3091,9 +3099,19 @@ static int amdgpu_dm_connector_get_modes(struct dr=
m_connector *connector)
>  	const struct drm_edid *drm_edid =3D amdgpu_dm_connector->drm_edid;
>  	struct dc_link_settings *verified_link_cap =3D &dc_link->verified_link_=
cap;
>  	const struct dc *dc =3D dc_link->dc;
> +	struct dc_sink *sink =3D amdgpu_dm_connector->dc_sink;
> =20
>  	encoder =3D amdgpu_dm_connector_to_encoder(connector);
> =20
> +	if (dc->config.imac5K_support && sink &&
> +	    sink->link->link_index =3D=3D 1 && !connector->edid_blob_ptr) {
> +		const struct drm_edid *kept =3D drm_edid_alloc(sink->dc_edid.raw_edid,
> +							     sink->dc_edid.length);
> +
> +		drm_edid_connector_update(connector, kept);
> +		drm_edid_free(kept);
> +	}
> +
>  	if (!drm_edid) {

[Severity: Low]
Can this use amdgpu_dm_connector->drm_edid instead of testing
connector->edid_blob_ptr and allocating a temporary drm_edid?

include/drm/drm_connector.h documents that edid_blob_ptr is internal to DRM
and must not be used by drivers directly.  Also, when drm_edid is NULL here,
freeing kept without storing it in amdgpu_dm_connector->drm_edid (and
updating local drm_edid) causes the !drm_edid branch right below to fall
back to drm_add_modes_noedid(connector, 640, 480) instead of probing modes
from the EDID.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
> index 259966703cef5..a84ff90efb54f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
[ ... ]
> @@ -151,6 +159,27 @@ static const struct dmi_system_id dmi_quirk_table[] =
=3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 465 16 inch G11 Notebook PC"),
>  		},
>  	},
> +	{
> +		.callback =3D imac5K_support_callback,
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,1"),
> +		},
> +	},
> +	{
> +		.callback =3D imac5K_support_callback,
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "iMac20,2"),
> +		},
> +	},
> +	{
> +		.callback =3D imac5K_support_callback,
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "iMacPro1,1"),
> +		},
> +	},
>  	{}

[Severity: Low]
This isn't a bug, but dmi_quirk_table enables imac5K_support on iMacPro1,1
while the commit subject, changelog, and imac5k_table in amdgpu_discovery.c
only describe adding support for iMac20,1 and iMac20,2.  Could the commit
message document that iMacPro1,1 is also enabled here and why it is omitted
from imac5k_table?

> @@ -176,6 +206,12 @@ void retrieve_dmi_info(struct amdgpu_display_manager=
 *dm)
>  		dm->edp0_on_dp1_quirk =3D true;
>  		drm_info(dev, "support_edp0_on_dp1 attached\n");
>  	}
> +	if (quirk_entries.imac5K_support &&
> +	    !pci_is_thunderbolt_attached(dm->adev->pdev) &&
> +	    !dev_is_removable(&dm->adev->pdev->dev)) {
> +		dm->imac5K_support =3D true;
> +		drm_info(dev, "imac5K_support attached\n");
> +	}
>  }

[Severity: Low]
Can dm->adev be NULL when retrieve_dmi_info() is called from the KUnit tests
in drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c?

Those tests pass a zero-allocated struct amdgpu_display_manager where
dm->adev is NULL, so running the KUnit suite on a DMI-matched iMac will hit
a NULL pointer dereference on dm->adev->pdev.

> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 328321961fba2..edffaca05756c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -2657,7 +2657,8 @@ enum dc_status dce110_apply_ctx_to_hw(
[ ... ]
> +	if (primary >=3D 0 && companion >=3D 0) {
> +		struct pipe_ctx *old =3D &dc->current_state->res_ctx.pipe_ctx[primary];
> +		struct dc_link *right =3D context->res_ctx.pipe_ctx[companion].stream-=
>link;
> +
> +		if (!old->stream ||
> +		    pipe_need_reprogram(old, &context->res_ctx.pipe_ctx[primary]))
> +			right->link_state_valid =3D false;
> +	}
> +
>  	/* Reset old context */
>  	/* look up the targets that have been removed since last commit */
>  	hws->funcs.reset_hw_ctx_wrap(dc, context);

[Severity: Medium]
On DCE12 (such as Vega10/Vega12 in iMacPro1,1), does clearing
right->link_state_valid here without marking the companion stream
mode_changed leave the right tile blanked?

When right->link_state_valid is set to false, pipe_need_reprogram() becomes
true for the companion pipe inside dce110_reset_hw_ctx_wrap(), which blanks
its timing generator, frees its memory input, and calls
dc->hwss.disable_plane().  dce110_apply_single_controller_ctx_to_hw() then
re-enables the companion timing generator in a blanked state, and on DCE12
(where program_front_end_for_ctx is NULL and apply_ctx_for_surface is used)
dc_commit_state_no_check() skips apply_ctx_for_surface() after
apply_ctx_to_hw() whenever the companion stream's mode_changed flag is
false:

drivers/gpu/drm/amd/display/dc/core/dc.c:dc_commit_state_no_check() {
	...
	for (i =3D 0; i < context->stream_count; i++) {
		const struct dc_link *link =3D context->streams[i]->link;

		if (!context->streams[i]->mode_changed)
			continue;

		if (dc->hwss.apply_ctx_for_surface) {
	...
}

This leaves the companion tile's front-end plane disabled and its timing
generator blanked whenever the primary pipe is reprogrammed without a mode
change on the companion stream.  Note also that
reset_syncd_pipes_from_disabled_pipes() at the top of
dce110_apply_ctx_to_hw() runs before right->link_state_valid is cleared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123102740.1389=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1
