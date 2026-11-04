Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BA6071A38
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4kxiS3I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7E110E8E6;
	Wed,  4 Nov 2026 20:18:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3901110E8E6
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:18:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04D60408BE;
 Wed,  4 Nov 2026 20:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2011F000C1;
 Wed,  4 Nov 2026 20:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793823502;
 bh=VSOsOdM0yXOFkIYDkR57Jkc3QaVuPh5arUEDsSJkt1U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m4kxiS3ItuR7WdpGqwblU4klSYdh14VyvnHPc0sks0/o++wbJGoCBDlyRr5zCFAMW
 gZDyaDUT9/8Uc8lAPc1sGnNv0rps9rGj/MHWHmjra7E8vCltGrGUSeFGzevmdpzyOV
 85kpvWCkCKh86JWMKZkWOjqrWkiBzhDhZhObIRhA3lizQ5V3IoN/J2vKRnzvyjYmVJ
 72urmw6tKfpKdrQM1lOy8ZmJ0ta3da7gzUs7PVkVQrOKfyjZHQX54SbYyWDOR0t2y0
 H+lhvKdn1tnJuXgYgbmkbtPSp9yXs4/oJJ8N9Kt89Wy75EtWHzKcyg07gdcjVK8UEW
 H1RUKyTUH5vsg==
Message-ID: <sashiko-outbox-197999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104193649.8158-1-atharvatiwarilinuxdev@gmail.com>
References: <20261104193649.8158-1-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:18:22 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/amdgpu: registering DM before SMU in amdgpu_discovery_set_ip_b=
locks()
- [Medium] drm/amd/display: dm_encoder_helper_atomic_check() forces RMX_FUL=
L scaling
- [Medium] drm/amd/display: max_requested_bpc still set to 16 when skipping=
 max_bpc prop
- [Medium] drm/amd/display: resource_are_streams_timing_synchronizable() sk=
ips timing check
- [Medium] drm/amd/display: unchecked DP_LANE0_1_STATUS value in dp_transit=
ion_to_video_idle()
- [Medium] drm/amd/display: unscoped imac5K_support quirk breaks external G=
PUs on iMac20,1/2
- [Medium] drm/amd/display: unchecked DP_LANE0_1_STATUS value in dp_transit=
ion_to_video_idle()
--

commit 6453a4798539c35712ed27f125a2228a469fabe9
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2

This commit adds 5K display and resolution switching support for Apple
iMac20,1 and iMac20,2 systems via DMI quirks and dual-link eDP/DP handling
in amdgpu_dm and DC.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 890792a94e09f..fc107e4fab4fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
[ ... ]
> @@ -4026,15 +4043,24 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
>  		}
>  	}
> =20
> +	/* TODO: We should enable 5K in EFI and remove this quirk */
> +	if (unlikely(dmi_check_system(imac5k_table))) {
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
> +	if (likely(!dmi_check_system(imac5k_table))) {
> +		r =3D amdgpu_discovery_set_display_ip_blocks(adev);
> +		if (r)
> +			return r;
> +	}

[Severity: High]
Does registering the display IP block before the SMU IP block in
amdgpu_discovery_set_ip_blocks() break DC/SMU initialization and teardown
ordering?

During amdgpu_device_ip_init() -> amdgpu_device_ip_hw_init_phase2(), IP
blocks are initialized in forward registration order, so dm_hw_init() ->
amdgpu_dm_init() -> dc_create() -> dcn20_resource_construct() runs before
smu_hw_init():

drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:smu_hw_init() {
	...
	ret =3D smu_init_max_sustainable_clocks(smu);
	if (ret) {
		dev_err(adev->dev, "Failed to init max sustainable clocks!\n");
		return ret;
	}

	adev->pm.dpm_enabled =3D true;
	...
}

Because smu_hw_init() has not run yet when dcn20_resource_construct() and
init_soc_bounding_box() execute, adev->pm.dpm_enabled is still false. As a
result, smu_get_uclk_dpm_states(), smu_get_max_sustainable_clocks_by_dc(),
and smu_set_watermarks_for_clock_ranges() all check
(!smu->pm_enabled || !smu->adev->pm.dpm_enabled) and return -EOPNOTSUPP.
This skips dcn20_update_bounding_box() and dcn20_cap_soc_clocks(), leaves
the DCN watermark table unprogrammed in the SMU, fails clock requests
during dc_hardware_init(), and then resets the active display count to 0
when smu_hw_init() -> smu_smc_hw_setup() -> smu_init_display_count(smu, 0)
runs afterwards.

In addition, amdgpu_device_ip_fini_early() tears down IP blocks in reverse
registration order, so smu_hw_fini() will disable SMU DPM before
dm_hw_fini() shuts down the display hardware.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..d18c7828a2855 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -123,6 +123,13 @@ STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(=
struct drm_encoder *encoder,
>  				       drm_mode_vrefresh(adjusted_mode));
>  			dm_new_connector_state->scaling =3D RMX_ASPECT;
>  		}
> +
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
Should dm_encoder_helper_atomic_check() avoid forcing RMX_FULL when
crtc_state->mode.vdisplay !=3D 2880?

Unconditionally setting dm_new_connector_state->scaling to RMX_FULL
stretches non-16:9 modes across the screen instead of keeping the aspect
ratio with RMX_ASPECT, overwrites any explicit scaling_mode property
requested by userspace (such as RMX_ASPECT or RMX_CENTER), and forces
scaling even when crtc_state->mode is the panel's single-cable native
3840x2160 mode (where drm_crtc_helper_mode_valid_fixed() returns MODE_OK).

[ ... ]

> @@ -3312,7 +3329,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_=
display_manager *dm,
>  				adev->mode_info.underscan_vborder_property,
>  				0);
> =20
> -	if (!aconnector->mst_root)
> +	if (!aconnector->mst_root && !(dm->imac5K_support && link_index <=3D 1))
>  		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
> =20
>  	aconnector->base.state->max_bpc =3D 16;

[Severity: Medium]
Does skipping drm_connector_attach_max_bpc_property() in
amdgpu_dm_connector_init_helper() actually cap the bpc on links 0 and 1?

Right after this check, amdgpu_dm_connector_init_helper() still executes:

	aconnector->base.state->max_bpc =3D 16;
	aconnector->base.state->max_requested_bpc =3D aconnector->base.state->max_=
bpc;

Because amdgpu_dm_create_validate_stream_for_sink() reads requested_bpc
from drm_state->max_requested_bpc and drm_atomic_connector_check() only
clamps state->max_bpc when connector->max_bpc_property is attached,
max_requested_bpc remains 16 while userspace loses the max bpc KMS
property on both connectors.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
> index 259966703cef5..8657dd972ee96 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
[ ... ]
> @@ -176,6 +199,10 @@ void retrieve_dmi_info(struct amdgpu_display_manager=
 *dm)
>  		dm->edp0_on_dp1_quirk =3D true;
>  		drm_info(dev, "support_edp0_on_dp1 attached\n");
>  	}
> +	if (quirk_entries.imac5K_support) {
> +		dm->imac5K_support =3D true;
> +		drm_info(dev, "imac5K_support attached\n");
> +	}
>  }

[Severity: Medium]
What happens if an external AMD GPU (eGPU) is connected to an iMac20,1 or
iMac20,2?

In retrieve_dmi_info(), dm->imac5K_support (and consequently
dc->config.imac5K_support) is enabled solely from the host DMI match
without checking whether the GPU actually drives the internal eDP panel.
On an external AMD GPU attached to one of these hosts:

- link_detect() will return false on link_index =3D=3D 1 once link->local_s=
ink
  is populated, preventing subsequent unplug, hotplug, or resume detection
  on that connector.
- amdgpu_dm_connector_init_helper() will omit the max bpc property on
  link_index 0 and 1.
- dce110_apply_ctx_to_hw() and dp_transition_to_video_idle() will treat
  link_index 0 and 1 on the external GPU as the internal primary and
  companion 5K links.

Should imac5K_support be scoped to the internal GPU or verified against
link 0 being an eDP connector?

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 187486d978da6..98f74ffc2c27f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -689,6 +689,14 @@ bool resource_are_streams_timing_synchronizable(
>  	struct dc_stream_state *stream1,
>  	struct dc_stream_state *stream2)
>  {
> +
> +	if (stream1->ctx->dc->config.imac5K_support &&
> +		((stream1->signal =3D=3D SIGNAL_TYPE_EDP && stream2->signal =3D=3D SIG=
NAL_TYPE_DISPLAY_PORT &&
> +		stream2->link->link_index =3D=3D 1) ||
> +		(stream2->signal =3D=3D SIGNAL_TYPE_EDP && stream1->signal =3D=3D SIGN=
AL_TYPE_DISPLAY_PORT &&
> +		stream1->link->link_index =3D=3D 1)))
> +		return true;
> +
>  	if (stream1->timing.h_total !=3D stream2->timing.h_total)
>  		return false;

[Severity: Medium]
In resource_are_streams_timing_synchronizable(), does returning true at the
very beginning of the function bypass the timing equality checks when the
two streams have different timings?

Placing this return before the comparisons of h_total, v_total,
h_addressable, v_addressable, v_front_porch, and pix_clk_100hz means any
active streams on eDP and DP link 1 are reported as timing-synchronizable
even if their timings do not match (for example, during a per-CRTC legacy
modeset where one CRTC switches to a non-5K mode while the second CRTC is
still active at 2560x2880). Callers such as program_timing_sync() will then
attempt to hardware-synchronize OTGs running with incompatible timings.

Should this check be placed after the timing comparisons so that it only
bypasses the clamping.c_depth or ignore_msa_timing_param checks?

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_traini=
ng.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> index 3be36d1063ded..4eca11169f803 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> @@ -1540,8 +1540,15 @@ static enum link_training_result dp_transition_to_=
video_idle(
>  		 */
>  		if (link->connector_signal !=3D SIGNAL_TYPE_EDP && status =3D=3D LINK_=
TRAINING_SUCCESS) {
>  			msleep(5);
> -			if (!link->skip_fallback_on_link_loss)
> +			if (link->dc->config.imac5K_support && link->link_index =3D=3D 1) {
> +				uint8_t lanes;
> +
> +				if (core_link_read_dpcd(link, DP_LANE0_1_STATUS,
> +							&lanes, 1) !=3D DC_OK)
> +					status =3D LINK_TRAINING_LINK_LOSS;
> +			} else if (!link->skip_fallback_on_link_loss) {
>  				status =3D dp_check_link_loss_status(link, lt_settings);
> +			}
>  		}
>  		return status;
>  	}

[Severity: Medium]
In dp_transition_to_video_idle(), DP_LANE0_1_STATUS is read into lanes on
link_index =3D=3D 1, but the value of lanes is never inspected (and
DP_LANE2_3_STATUS is not read).

If the AUX read returns DC_OK while the lane status bits report that clock
recovery, channel equalization, or symbol lock failed, status remains
LINK_TRAINING_SUCCESS. Was lanes meant to be checked for lane status bits,
or is this intentionally only testing whether the AUX transaction succeeds
on the TCON?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104193649.8158=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1
