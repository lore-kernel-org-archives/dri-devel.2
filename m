Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95A606A547
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oe2W5AiQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F2410E1D6;
	Fri, 13 Nov 2026 22:39:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D9B10E1A8;
 Fri, 13 Nov 2026 22:39:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62BA643A07;
 Fri, 13 Nov 2026 22:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3BF1F000C4;
 Fri, 13 Nov 2026 22:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794609554;
 bh=lhY3yz84xGj4uDyx4pxMVOKEBSWy+rqjEMw2fBYWe0s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oe2W5AiQp7zC+FORpj7qdJ/n9roDEV8g7XOVDByKndJkieJAbYP+TTnSV8Xmukqjn
 HXpjUOBnhUn1menK5icyxJ8N2DoUjIbZ5bbc0zL5n1kGbeyotIDO0leU7AsqBc0udt
 MzW1HyQl7pIpLg+fRnF4mm/Zc/X9b6jOAZXvSyaOHLTAUctfXaFPUVW+QbgJl+Hbed
 uSGcw6fRBA/5//nu78mm2LWBtfLiCI8bGFb6H6xUepr3qiOhYushFKcNqGVBGCaFvx
 mAxSDkN6a2jNmeI4wkbJVvRKSvDd/MGWeJSIAP9P1Jpsf5p6dfdp8l6Rq7UuyGM+zu
 9XjffI0FxiGug==
Message-ID: <sashiko-outbox-213829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add 5K Support for iMac20,1 and
 iMac20,2
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?=
 <amd-gfx@lists.freedesktop.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261113214721.9382-1-atharvatiwarilinuxdev@gmail.com>
References: <20261113214721.9382-1-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:39:13 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/amdgpu: registering DM before SMU in
  amdgpu_discovery_set_ip_blocks()
- [Medium] drm/amd/display: dm_encoder_helper_atomic_check() forces
  RMX_FULL scaling
- [Medium] drm/amd/display: amdgpu_dm_connector_init_helper() overwrites
  max_bpc to 16
- [Medium] drm/amd/display: resource_are_streams_timing_synchronizable()
  skips timing check
- [Medium] drm/amd/display: companion pipe left blanked in
  dce110_apply_ctx_to_hw()
- [Low] drm/amd/display: undocumented iMacPro1,1 DMI quirk in
  dmi_quirk_table
--

commit 5d88d8dc2e29344b180b127f814886e8656f600c
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2

This commit adds 5K tiled display support for Apple iMac20,1, iMac20,2, and
iMacPro1,1 by configuring DPCD register 0x4F1, synchronizing the two tile
streams, and registering the display IP block before the SMU IP block on
iMac20,1 and iMac20,2.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 22cec7ac57fde..25068c3565827 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
[ ... ]
> @@ -4062,15 +4089,25 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
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
Does registering dm_ip_block before smu_v11_0_ip_block break DC-SMU
initialization and teardown ordering on iMac20,1 and iMac20,2?

amdgpu_device_ip_hw_init_phase2() initializes IP blocks in registration
order, so dm_hw_init() -> amdgpu_dm_init() -> dc_create() ->
dcn20_resource_construct() now runs before smu_hw_init() sets
adev->pm.dpm_enabled =3D true.  While dpm_enabled is false,
init_soc_bounding_box() fails to query UCLK DPM states and maximum
sustainable clocks (-EOPNOTSUPP), and set_wm_ranges()
(smu_set_watermarks_for_clock_ranges()) returns -EOPNOTSUPP without
calling navi10_set_watermarks_table().  Because WATERMARKS_EXIST is never
set in smu->watermarks_bitmap, DCN watermark tables are never uploaded at
boot or on resume, and navi10_display_config_changed() never sends
SMU_MSG_NumOfDisplays to the SMU.

In addition, amdgpu_device_ip_fini_early() and amdgpu_device_ip_fini()
walk adev->ip_blocks[] in reverse order, so smu_hw_fini() and
smu_sw_fini() disable DPM before dm_hw_fini() shuts down display hardware.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..c52cd5002a790 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -123,6 +123,14 @@ STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(=
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
Does forcing dm_new_connector_state->scaling to RMX_FULL for every mode
with vdisplay !=3D 2880 override user-requested scaling modes and corrupt
subsequent mode validation?

The check just above already defaults non-native eDP modes to RMX_ASPECT
when dm_new_connector_state->scaling =3D=3D RMX_OFF, in line with the DRM
policy of preserving aspect ratio unless userspace asks for RMX_FULL.
Overwriting dm_new_connector_state->scaling with RMX_FULL ignores explicit
scaling_mode settings from userspace and forces scaling even on the
panel's single-cable native 3840x2160 mode.

Once RMX_FULL is committed into connector->state, later calls to
amdgpu_dm_connector_mode_valid() pass connector->state to
create_stream_for_sink(), which sees dm_state->scaling !=3D RMX_OFF and
replaces the 2560x2880 tile mode's CRTC timings with the 3840x2160
preferred mode's timings in decide_crtc_timing_for_drm_display_mode().

[ ... ]

> @@ -3312,7 +3330,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_=
display_manager *dm,
>  				adev->mode_info.underscan_vborder_property,
>  				0);
> =20
> -	if (!aconnector->mst_root)
> +	/* Both 5K panel tiles must run at the same bpc, so userspace cannot se=
t it */
> +	if (!aconnector->mst_root && !(dm->imac5K_support && link_index <=3D 1))
>  		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
> =20
>  	aconnector->base.state->max_bpc =3D 16;

[Severity: Medium]
Does skipping drm_connector_attach_max_bpc_property() actually keep the
two tiles at 8 bpc when the next lines unconditionally set max_bpc and
max_requested_bpc to 16?

amdgpu_dm_connector_funcs_reset() initializes max_requested_bpc to 8, but
amdgpu_dm_connector_init_helper() immediately overwrites both
aconnector->base.state->max_bpc and max_requested_bpc with 16.
amdgpu_dm_create_validate_stream_for_sink() then reads 16 from
max_requested_bpc, leaving the eDP and DP links free to pick mismatched
color depths while hiding the max bpc property from userspace.

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

[Severity: Low]
This isn't a bug, but dmi_quirk_table also enables imac5K_support on
iMacPro1,1, whereas the commit title and message only describe adding
support for iMac20,1 and iMac20,2.  Could the commit message explain that
iMacPro1,1 is also enabled here and why it is not included in
imac5k_table in amdgpu_discovery.c?

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 187486d978da6..e07b3648e090c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -689,6 +689,16 @@ bool resource_are_streams_timing_synchronizable(
>  	struct dc_stream_state *stream1,
>  	struct dc_stream_state *stream2)
>  {
> +
> +	if (stream1->ctx->dc->config.imac5K_support &&
> +		((stream1->signal =3D=3D SIGNAL_TYPE_EDP &&
> +		  stream2->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT &&
> +		stream2->link->link_index =3D=3D 1) ||
> +		(stream2->signal =3D=3D SIGNAL_TYPE_EDP &&
> +		 stream1->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT &&
> +		stream1->link->link_index =3D=3D 1)))
> +		return true;
> +
>  	if (stream1->timing.h_total !=3D stream2->timing.h_total)
>  		return false;

[Severity: Medium]
Does returning true at the top of
resource_are_streams_timing_synchronizable() cause DC to synchronize pipes
with mismatched timings?

Placing this check before the h_total, v_total, h_addressable,
v_addressable, v_front_porch, pix_clk_100hz, and c_depth comparisons means
that if link 0 switches to a non-5K mode such as 3840x2160 while link 1 is
still active at 2560x2880 (for example during per-CRTC legacy modesets),
program_timing_sync() and dcn20_populate_dml_pipes_from_context() will
still group the two pipes as TIMING_SYNCHRONIZABLE and program hardware
OTG synchronization across different resolutions and pixel clocks.  Should
this check only bypass the final ignore_msa_timing_param check after the
timings have been verified to match?

> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 7b3aa02dda63b..aba1dc9b486a8 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
[ ... ]
> @@ -2664,6 +2665,32 @@ enum dc_status dce110_apply_ctx_to_hw(
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
On DCE120 (iMacPro1,1), does clearing right->link_state_valid inside
dce110_apply_ctx_to_hw() leave the companion pipe blanked when the
primary pipe is reprogrammed without a modeset on the companion CRTC?

When right->link_state_valid is set to false, pipe_need_reprogram()
becomes true for the companion pipe even though the companion stream's
mode_changed flag is false.  dce110_reset_hw_ctx_wrap() then blanks the
companion timing generator, disables the CRTC, and calls free_mem_input(),
and dce110_apply_single_controller_ctx_to_hw() re-enables the CRTC in a
blanked state.  Unlike DCN20, where program_front_end_for_ctx() runs for
all pipes after apply_ctx_to_hw(), dc_commit_state_no_check() on DCE skips
dc->hwss.apply_ctx_for_surface() after apply_ctx_to_hw() when
stream->mode_changed is false:

drivers/gpu/drm/amd/display/dc/core/dc.c:dc_commit_state_no_check() {
    ...
	for (i =3D 0; i < context->stream_count; i++) {
		const struct dc_link *link =3D context->streams[i]->link;

		if (!context->streams[i]->mode_changed)
			continue;

		if (dc->hwss.apply_ctx_for_surface) {
			apply_ctx_interdependent_lock(dc, context, context->streams[i], true);
			dc->hwss.apply_ctx_for_surface(
					dc, context->streams[i],
					context->stream_status[i].plane_count,
					context);
    ...
}

As a result, allocate_mem_input(), dce110_program_front_end_for_pipe(),
and program_surface_visibility() are not run to unblank and restore the
companion pipe, leaving the right half of the panel black.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214721.9382=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1
