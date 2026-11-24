Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vu5unnIr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D1E10F4B5;
	Tue, 24 Nov 2026 11:40:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F7110F4B1;
 Tue, 24 Nov 2026 11:40:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 197CE623CA;
 Tue, 24 Nov 2026 11:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510901F000C4;
 Tue, 24 Nov 2026 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795520446;
 bh=9lgGb0/s8EoA+O+PUJGWiOHE8Vl1saUg0bdCVy/P708=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vu5unnIrWkAFyIQGkMo/vTmYsTOYkLd6a8DzsZbg2jiF5zyju778L0sqJ5ZVYA+Bs
 pTKOHlfZxaWBJVrOIHCHbiG43hD6dz2UUiV9QVThLoMTPSLXyy3Hi0Hjr7lVp1AmG4
 UkhXvvTsBAwChnfmFeycJEogX3xJmQHsG3pxrkaI1aI684BUlXzv+pKxtWEevO2RAL
 rDh63V46TkFw28acGgn6sEPyImtUJOG3gSbOjocm/XgReBGf8vKF/EcpS9oROPIMNe
 mM4mob69y2W9SafjLZ9vVWsM1rrz8enxpXKP0uonmaOJaawcnAc/y9P4hVXn7cLkBB
 U5uST0pyf+v9g==
Message-ID: <sashiko-outbox-231059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] drm/i915: Carry the current state over created states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-6-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
 <20261124-drm-i915-conversion-state-readout-v1-6-b7132f72644d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:40:45 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/i915: intel_atomic_carry_over_state() skips enabled
  DPMS-off CRTCs
- [High] drm/i915: uninitialized max_requested_bpc and scaling_mode on
  created states
- [Medium] drm/i915: missing NV12 link carry-over in
  intel_atomic_carry_over_state()
--

commit 1fe4500ef10219b7da036ae0e043737aa33211ff
Author: Maxime Ripard <mripard@kernel.org>

drm/i915: Carry the current state over created states

This commit adds intel_atomic_carry_over_state() to copy the current CRTC
hardware state and plane scaler assignment into newly created states during
DRM_MODE_ATOMIC_RESET commits.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 1172e48daf235..d645203104a77 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -6519,6 +6519,116 @@ static int intel_atomic_check_config_and_link(str=
uct intel_atomic_state *state)
> =20
>  	return ret;
>  }
[ ... ]
> +static int intel_atomic_carry_over_state(struct intel_atomic_state *stat=
e)
> +{
> +	struct intel_crtc_state *old_crtc_state, *new_crtc_state;
> +	struct intel_plane_state *old_plane_state, *new_plane_state;
> +	struct intel_crtc *crtc;
> +	struct intel_plane *plane;
> +	int i;
> +
> +	for_each_oldnew_intel_crtc_in_state(state, crtc, old_crtc_state,
> +					    new_crtc_state) {
> +		struct intel_crtc_state *carried_state;
> +
> +		if (new_crtc_state->cpu_transcoder !=3D INVALID_TRANSCODER ||
> +		    !old_crtc_state->hw.active)
> +			continue;

[Severity: High]
Does checking !old_crtc_state->hw.active skip CRTCs that are enabled with
DPMS off (old_crtc_state->hw.enable =3D=3D true, hw.active =3D=3D false)?

In i915, pipe configuration, cpu_transcoder, DPLL reservations, DP tunnel
bandwidth, joiner pipes, and plane scalers are all allocated and tracked
whenever crtc_state->hw.enable is true, even while hw.active is false.
When a DRM_MODE_ATOMIC_RESET commit hits an enabled but inactive CRTC,
skipping the carry-over drops intel_dpll and icl_port_dplls without
releasing them (leaking the shared DPLL reservation in
dpll_state->pipe_mask and triggering a WARN in intel_dpll_crtc_get() on
later modesets), loses dp_tunnel_ref and joiner_pipes, and leaves
new_crtc_state->scaler_state empty while the plane loop below still copies
old_plane_state->scaler_id >=3D 0 into new_plane_state->scaler_id, allowing
intel_atomic_setup_scaler() to assign the same hardware scaler ID twice.
On G4X/VLV/CHV, intel_crtc_prepare_cleared_state() also preserves
crtc_state->wm even on disabled CRTCs.

[ ... ]

> +	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
> +					      new_plane_state, i) {
> +		if (new_plane_state->scaler_id < 0 &&
> +		    old_plane_state->scaler_id >=3D 0)
> +			new_plane_state->scaler_id =3D
> +				old_plane_state->scaler_id;
> +	}

[Severity: Medium]
Should this plane loop also carry over old_plane_state->planar_linked_plane
and old_plane_state->is_y_plane?

On DISPLAY_VER >=3D 11, scanning out a planar YUV framebuffer links the
visible UV plane to an internal Y plane whose uapi.crtc is NULL, so the Y
plane is not in crtc->state->plane_mask.  When a DRM_MODE_ATOMIC_RESET
commit does not initially include the internal Y plane (for example, from
a DRM lease covering only the primary/UV plane) or switches the UV plane
to a non-planar format, intel_joiner_affected_planes() and
unlink_nv12_plane() rely on new_plane_state->planar_linked_plane and
is_y_plane to pull in and unlink the Y plane:

drivers/gpu/drm/i915/display/intel_plane.c:unlink_nv12_plane() {
	if (!plane_state->planar_linked_plane)
		return;

	plane_state->planar_linked_plane =3D NULL;

	if (!plane_state->is_y_plane)
		return;
    ...
	crtc_state->enabled_planes &=3D ~BIT(plane->id);
	crtc_state->active_planes &=3D ~BIT(plane->id);
}

Because created plane states have planar_linked_plane =3D=3D NULL and
is_y_plane =3D=3D false, BIT(y_plane->id) remains set in
new_crtc_state->enabled_planes and active_planes, leaving the Y plane
programmed in hardware or causing icl_check_nv12_planes() to run out of
free Y planes and fail with -EINVAL.

> +
> +	return 0;
> +}

[Severity: High]
Does intel_atomic_carry_over_state() also need to restore connector state
defaults such as max_requested_bpc, max_bpc, and scaling_mode on created
connector states?

At init time, drm_connector_attach_max_bpc_property() initializes
state->max_requested_bpc and state->max_bpc to the connector maximum, and
intel_attach_scaling_mode_property() sets state->scaling_mode to
DRM_MODE_SCALE_ASPECT.  During DRM_MODE_ATOMIC_RESET,
intel_digital_connector_create_state() zero-allocates the connector state
and calls __drm_atomic_helper_connector_state_init(), leaving
max_requested_bpc, max_bpc, and scaling_mode at 0 whenever userspace does
not explicitly set those properties in the reset commit.

As a result, drm_atomic_helper_check_modeset() and
intel_digital_connector_atomic_check() see max_requested_bpc and
scaling_mode change from their previous values and force a modeset on
active CRTCs instead of taking the nomodeset path, and the modeset then
hits MISSING_CASE(0) WARNs and returns -EINVAL in
compute_sink_pipe_bpp() -> bpc_to_bpp() and gmch_panel_fitting().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-drm-i915-c=
onversion-state-readout-v1-0-b7132f72644d@kernel.org?part=3D6
