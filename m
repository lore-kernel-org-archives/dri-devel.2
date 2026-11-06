Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB72606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5DJ9+fD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D77E112E4C;
	Fri,  6 Nov 2026 15:38:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CEE112E4C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:38:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 639CD60232
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027FD1F0089F;
 Fri,  6 Nov 2026 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793979486;
 bh=9JxDRoGxPNIUmLuttQ0dhHVvLbET5LglZ8ysQknQtss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l5DJ9+fDFtxnWgzAbzdR7czzcI6gs/u80gA/rk6YCCNTKsxnCT+Q+kji0x9TFrWdt
 ZiiFCe/9Wc33IKLibbfQ9kFsv1OjITJovgpBBvkh8pGpAki88TsXvtBsBntUTXhAzj
 IBXMsiFB0nBfVKpIV3f+wVxv7Ct9n/hQ523dyQdsJng0j6It+K5GalouIgIbP7jA0w
 BAflRJ/DTEMjR97JSGmU5fD74VwYLkPIWHMSkMfsTC17AZi6P0+EGy6paG5EfYkwrQ
 NZZiL1W0CnYTncF9bZcXrsAOBgIa+k8bPljGyrhHwCGMSYMwLH2RoJS13cTDW896Fr
 gwpANI+iGb7IQ==
Message-ID: <sashiko-outbox-201708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] drm/atomic: Allow filling a commit with pristine
 object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-reset-state-flag-v8-4-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
 <20261106-drm-reset-state-flag-v8-4-50fd046b705f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:38:05 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/atomic: inconsistent cross-lease state in
  drm_atomic_commit_fill_with_defaults()
- [High] drm/atomic: missing driver-private active state in
  drm_atomic_commit_fill_with_defaults()
--

commit b5521ba27187cadf5fe15d5963f98a6825dc5a6a
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit adds drm_atomic_commit_fill_with_defaults() to populate an
atomic commit with pristine object states created via atomic_create_state()
for CRTCs, planes, connectors, and colorops held by a DRM lease.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..8bda2871f394b 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1649,6 +1649,361 @@ bool drm_atomic_implements_create_state(struct dr=
m_device *dev)
[ ... ]
> +static int drm_atomic_commit_fill_connector_with_defaults(struct drm_fil=
e *file_priv,
> +							  struct drm_atomic_commit *commit,
> +							  struct drm_connector *connector)
> +{
> +	struct drm_connector_state *connector_state;
> +	struct drm_crtc_state *crtc_state;
> +	int ret;
> +
> +	if (drm_lease_held(file_priv, connector->base.id)) {
[ ... ]
> +		if (!connector->state->crtc)
> +			return 0;
> +
> +		/*
> +		 * Make sure the CRTC the connector is currently bound to
> +		 * is part of the commit. The atomic helpers need that
> +		 * state: set_best_encoder() clears the encoder mask of
> +		 * that CRTC when the connector gets detached from it.
> +		 */
> +		crtc_state =3D drm_atomic_get_crtc_state(commit,
> +						       connector->state->crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
> +
> +		/*
> +		 * The pristine state unbinds the connector from that
> +		 * CRTC, so drop it from the connector mask like
> +		 * drm_atomic_set_crtc_for_connector() would.
> +		 */
> +		crtc_state->connector_mask &=3D ~drm_connector_mask(connector);
> +	} else {
> +		/*
> +		 * The connector isn't part of the lease so it keeps its
> +		 * current state. If it is bound to a leased CRTC though,
> +		 * that CRTC is being reset under it and comes with an
> +		 * empty connector mask, so
> +		 * drm_atomic_add_affected_connectors() won't find the
> +		 * connector during the check. Pull it in here so that its
> +		 * routing and encoder are properly handled.
> +		 *
> +		 * The leased CRTCs are all part of the commit by now. An
> +		 * unleased one might not be yet, but it keeps its
> +		 * connector mask, so the helpers will pull the connector
> +		 * in on their own if that CRTC ends up being changed.
> +		 */
> +		if (!connector->state->crtc)
> +			return 0;
> +
> +		if (!drm_atomic_get_new_crtc_state(commit,
> +						   connector->state->crtc))
> +			return 0;
> +
> +		connector_state =3D drm_atomic_get_connector_state(commit,
> +								 connector);
> +		if (IS_ERR(connector_state))
> +			return PTR_ERR(connector_state);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Can cross-lease routing between leased and unleased objects leave
crtc_state->connector_mask, crtc_state->plane_mask, and crtc_state->enable
out of sync with the connector and plane states?

When an unleased connector is currently bound to a leased CRTC, the leased
CRTC gets a pristine state with enable =3D false and connector_mask =3D 0,
while the else branch here duplicates connector->state and leaves
connector_state->crtc pointing to that CRTC and best_encoder set.
update_connector_routing() only detaches a connector when
new_connector_state->crtc is cleared, so the unleased connector stays
attached to the reset CRTC with connector_mask =3D 0, causing
drm_atomic_helper_check_modeset() to validate or commit a zeroed mode on a
disabled CRTC or fail conflicting-encoder checks.

Conversely, when a leased connector is detached from an unleased CRTC in
the if branch and was its last connector, clearing connector_mask leaves
crtc_state->enable set to true with connector_mask =3D 0, which
drm_atomic_helper_check_modeset() rejects because enable !=3D has_connectors
(unlike handle_conflicting_encoders(), which clears the mode and sets
active =3D false when connector_mask reaches 0).

Similarly, in drm_atomic_commit_fill_with_defaults(), the plane loop skips
unleased planes even when plane->state->crtc points to a leased CRTC being
reset.  When drm_atomic_add_affected_planes() later pulls that plane in
with its duplicated active state, drm_atomic_helper_check_plane_state()
rejects the commit because an enabled plane remains attached to a disabled
CRTC, or leaves new_crtc_state->plane_mask missing the plane if the CRTC is
re-enabled.

[ ... ]

> +int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
> +					 struct drm_atomic_commit *commit)
> +{
[ ... ]
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_crtc_state *crtc_state;
> +
> +		if (!drm_lease_held(file_priv, crtc->base.id))
> +			continue;
> +
> +		ret =3D drm_modeset_lock(&crtc->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		crtc_state =3D crtc->funcs->atomic_create_state(crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
[ ... ]
> +		drm_mode_copy(&crtc_state->adjusted_mode,
> +			      &crtc->state->adjusted_mode);
> +
> +		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
> +	}
> +
> +	drm_for_each_plane(plane, dev) {
> +		struct drm_plane_state *plane_state;
> +
> +		if (!drm_lease_held(file_priv, plane->base.id))
> +			continue;
[ ... ]
> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);

[Severity: High]
Does building new states with atomic_create_state() while carrying over
best_encoder and adjusted_mode discard driver-private state and reference
counts that drivers expect to be preserved from old_state?

Drivers that implement atomic_create_state() initialize driver-subclassed
fields to an unallocated/disabled baseline there, and rely on
atomic_duplicate_state() to copy active hardware assignments and retain
references while the object is currently enabled.  Because
drm_atomic_commit_fill_connector_with_defaults() and
drm_atomic_commit_fill_with_defaults() also preserve best_encoder and
adjusted_mode to avoid a modeset when userspace re-applies the active
configuration, atomic_check sees old_crtc_state->enable =3D=3D
new_crtc_state->enable and drm_atomic_crtc_needs_modeset() =3D=3D false on a
freshly created driver state:

- In vc4, vc4_crtc_create_state() sets assigned_channel to
  VC4_HVS_CHANNEL_DISABLED (-1U).  When the CRTC stays enabled,
  vc4_pv_muxing_atomic_check() skips channel assignment and
  vc4_core_clock_atomic_check() indexes hvs_new_state->fifo_state[channel]
  with -1U, writing out of bounds.

- In amdgpu_dm, amdgpu_dm_crtc_create_state() and
  amdgpu_dm_plane_drm_plane_create_state() leave dm_new_crtc_state->stream
  and dm_new_plane_state->dc_state NULL instead of retaining the references
  from old_state.  If the CRTC stays enabled without a modeset,
  dm_update_crtc_state() hits a bug check on dm_new_crtc_state->stream =3D=
=3D
  NULL; if the reset disables an active CRTC or plane,
  dm_update_crtc_state() and dm_update_plane_state() release
  dm_old_crtc_state->stream and dm_old_plane_state->dc_state expecting an
  extra reference from duplicate_state(), causing a double release and
  use-after-free when old_state is destroyed.

- In msm/dpu1, dpu_crtc_create_state() zeroes num_mixers, and
  dpu_crtc_atomic_check() skips dpu_crtc_assign_resources() when
  !mode_changed && !connectors_changed && !color_mgmt_changed, leaving the
  enabled CRTC with no hardware mixers assigned.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-reset-=
state-flag-v8-0-50fd046b705f@kernel.org?part=3D4
