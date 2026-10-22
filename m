Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735BD606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrjuBK2Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3D91126A2;
	Thu, 22 Oct 2026 14:26:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327CD1126A0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:26:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BA63601F1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB371F000C1;
 Thu, 22 Oct 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792679190;
 bh=NbedwgQ9Y8r2XlmzMuya5d2Ciw3kznJv7fqnDm0CFUk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DrjuBK2YlMuWzm0qrWVlQW+Z5dw7K29lsBE+aQqxSpZOS1YpHdmetXJ7G/TV7xAZb
 vvvQSrDalLIa/6hd+ECoiMSVWadIp2tf7L51rNUMfZJd0OqDbieZnkUXlIQlbnUoPt
 /GfvcOA6YwH+ol1tDjfmP7C2TqZQTD9dfzMn6dbcN5f+U1mcWuoAPG9kOOIcHPcT6r
 /7s2bReM2JlulXB4lEy1/RaJRiX8VsEL1/MYT35KofXhZHr+qBvpQW155+pfS3D9oW
 JfuFER25y++8rYp83O3HE6sugDXftQ4jAeSy44npn9IFm5CjwQM12bOcfpGLqlP59L
 oLFeKpcPFMnMg==
Message-ID: <sashiko-outbox-181632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/15] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-reset-state-flag-v6-11-f36d640b7e76@kernel.org>
References: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
 <20261022-drm-reset-state-flag-v6-11-f36d640b7e76@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 14:26:29 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/atomic: broken lease handling in drm_atomic_commit_fill_with_d=
efaults()
- [Medium] drm/atomic: missing color_mgmt_changed in drm_atomic_commit_fill=
_with_defaults()
--

commit 5d2d0c35315849450f4b89a700b8964027903618
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit introduces drm_atomic_commit_fill_with_defaults() to populate an
atomic commit with freshly created default states for CRTCs, planes,
connectors, and color operations using their atomic_create_state() hooks.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..c3c38695814fc 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1649,6 +1649,148 @@ bool drm_atomic_implements_create_state(struct dr=
m_device *dev)
>  }
>  EXPORT_SYMBOL(drm_atomic_implements_create_state);
> =20
[ ... ]
> +int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
> +					 struct drm_atomic_commit *commit)
> +{
> +	struct drm_device *dev =3D commit->dev;
> +	struct drm_mode_config *config =3D &dev->mode_config;
> +	struct drm_crtc *crtc;
> +	struct drm_plane *plane;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_colorop *colorop;
> +	int ret;
> +
> +	drm_WARN_ON(dev, !commit->acquire_ctx);
> +
> +	/*
> +	 * Private objects are ignored because none have userspace
> +	 * properties we might want to reset. atomic_check
> +	 * implementations will derive or infer their private obj state
> +	 * from the state that will end up being committed anyway.
> +	 */
> +	drm_for_each_colorop(colorop, dev) {
> +		struct drm_colorop_state *colorop_state;
> +
> +		if (!drm_lease_held(file_priv, colorop->plane->base.id))
> +			continue;
> +
> +		ret =3D drm_modeset_lock(&colorop->plane->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		colorop_state =3D drm_atomic_helper_colorop_create_state(colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +
> +		drm_atomic_commit_set_colorop_state(commit, colorop, colorop_state);
> +	}
> +
> +	drm_for_each_plane(plane, dev) {
> +		struct drm_plane_state *plane_state;
> +
> +		if (!drm_lease_held(file_priv, plane->base.id))
> +			continue;
> +
> +		ret =3D drm_modeset_lock(&plane->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +
> +		drm_atomic_commit_set_plane_state(commit, plane, plane_state);
> +	}
> +
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
> +
> +		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
> +	}

[Severity: Medium]
When drm_atomic_commit_fill_with_defaults() replaces the colorop, plane, and
CRTC states with newly created default states, both
crtc_state->color_mgmt_changed and plane_state->color_mgmt_changed are
initialized to false, with crtc_state->{degamma_lut,ctm,gamma_lut} and
plane_state->color_pipeline set to NULL and colorop_state set to defaults.

In drivers/gpu/drm/drm_atomic_uapi.c, drm_atomic_crtc_set_property(),
drm_atomic_plane_set_property(), drm_atomic_set_colorop_for_plane(), and
drm_atomic_colorop_set_property() only set color_mgmt_changed when a proper=
ty
write changes the value already stored in the new state:

drivers/gpu/drm/drm_atomic_uapi.c:drm_atomic_crtc_set_property() {
	...
	ret =3D drm_property_replace_blob_from_id(dev,
				&state->degamma_lut,
				val,
				elem_size * lut_size, -1, elem_size,
				&replaced);
	state->color_mgmt_changed |=3D replaced;
	...
}

drivers/gpu/drm/drm_atomic_uapi.c:drm_atomic_set_colorop_for_plane() {
	...
	/* Color pipeline didn't change */
	if (plane_state->color_pipeline =3D=3D colorop)
		return false;
	...
}

Neither drm_atomic_check_only() nor drm_atomic_helper_check_modeset() and
drm_atomic_helper_check_planes() compares old_state against new_state to set
color_mgmt_changed.

If crtc->state previously had a non-NULL degamma_lut, ctm, or gamma_lut (or
plane->state and colorop->state had an active color pipeline or non-default
colorop settings), and a reset commit either omits those properties to leave
them at defaults or explicitly sets them to 0 / default (which matches the
already-pristine new_state), won't color_mgmt_changed remain false on both
crtc_state and plane_state?

When a reset commit keeps the same mode and routing on an active CRTC so
drm_atomic_crtc_needs_modeset() is false, drivers that gate color updates on
color_mgmt_changed || drm_atomic_crtc_needs_modeset() (such as amdgpu_dm,
i915, msm/dpu1, tidss, and rockchip vop2) will skip reprogramming hardware
LUTs, CTMs, and colorops. In addition, drivers that gate hardware LUT or CTM
updates strictly on crtc_state->color_mgmt_changed (such as
mtk_crtc_atomic_flush(), vc4_hvs_atomic_flush(), omap_crtc_atomic_flush(),
malidp_atomic_commit_update_gamma(), malidp_atomic_commit_update_coloradj(),
d71_improc_update(), and armada_drm_crtc_atomic_begin()) will skip resetting
hardware color management even across a full modeset.

Should drm_atomic_commit_fill_with_defaults() compare the pristine states
against crtc->state, plane->state, and colorop->state and set
color_mgmt_changed accordingly?

> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *connector_state;
> +
> +		if (!drm_lease_held(file_priv, connector->base.id))
> +			continue;
> +
> +		ret =3D drm_modeset_lock(&config->connection_mutex, commit->acquire_ct=
x);
> +		if (ret) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return ret;
> +		}
> +
> +		/*
> +		 * drm_atomic_implements_create_state() already checked
> +		 * this, but connectors can be hotplugged between that
> +		 * lockless check and the iteration here.
> +		 */
> +		if (!connector->funcs->atomic_create_state) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		connector_state =3D connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(connector_state)) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			ret =3D PTR_ERR(connector_state);
> +			return ret;
> +		}
> +
> +		ret =3D drm_atomic_commit_set_connector_state(commit, connector, conne=
ctor_state);
> +		if (ret) {
> +			connector->funcs->atomic_destroy_state(connector, connector_state);
> +			drm_connector_list_iter_end(&conn_iter);
> +			return ret;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);

[Severity: High]
Can this per-object lease filtering cause NULL pointer dereferences and bro=
ken
atomic state when a lease is used or revoked?

First, drm_atomic_commit_fill_with_defaults() calls drm_lease_held() in four
separate loops (for colorops, planes, CRTCs, and connectors), taking and
releasing dev->mode_config.idr_mutex on each call. Concurrent lease revocat=
ion
via drm_mode_revoke_lease_ioctl() or drm_lease_revoke() only acquires
dev->mode_config.idr_mutex (without any drm_modeset_lock) and clears
master->leases. If a lease is revoked after the plane loop adds a leased pl=
ane
(with old_plane_state->crtc !=3D NULL and pristine new_plane_state->crtc =
=3D=3D
NULL) but before the CRTC loop checks old_plane_state->crtc, that CRTC is
skipped and never added to the commit. During drm_atomic_commit(),
drm_atomic_helper_plane_changed() hits WARN_ON(!crtc_state),
drm_atomic_plane_check() and drm_atomic_helper_check_plane_state() succeed
because new_plane_state->fb is NULL, and drm_atomic_helper_setup_commit() ->
crtc_or_fake_commit() dereferences a NULL new_crtc_state:

drivers/gpu/drm/drm_atomic_helper.c:crtc_or_fake_commit() {
	if (crtc) {
		struct drm_crtc_state *new_crtc_state;

		new_crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);

		return new_crtc_state->commit;
	}
	...
}

Second, drm_mode_create_lease_ioctl() -> fill_object_idr() -> validate_leas=
e()
does not verify that leased planes or connectors are not currently bound to=
 an
unleased CRTC, nor does drm_lease_held() prevent the lessor (where
master->lessor =3D=3D NULL) from configuring cross-lease routing. Unlike
drm_atomic_get_plane_state() and drm_atomic_get_connector_state(), which pu=
ll
old_state->crtc into the commit via drm_atomic_get_crtc_state(),
drm_atomic_commit_fill_with_defaults() resets leased planes and connectors =
to
crtc =3D NULL while skipping unleased CRTCs. If old_connector_state->crtc i=
s not
in the commit, update_connector_routing() dereferences a NULL crtc_state:

drivers/gpu/drm/drm_atomic_helper.c:update_connector_routing() {
	...
	if (old_connector_state->crtc !=3D new_connector_state->crtc) {
		if (old_connector_state->crtc) {
			crtc_state =3D drm_atomic_get_new_crtc_state(state, old_connector_state-=
>crtc);
			crtc_state->connectors_changed =3D true;
		}
	...
}

Similarly, if old_plane_state->crtc is not in the commit,
crtc_or_fake_commit() dereferences a NULL new_crtc_state.

Third, when universal_planes is enabled, a lease on a CRTC does not have to
include every plane (such as overlay or cursor planes) or cloned connector
currently active on that CRTC. Resetting the leased CRTC to a pristine state
(enable =3D false, plane_mask =3D 0, connector_mask =3D 0) while skipping t=
he
unleased plane or connector causes drm_atomic_helper_check_modeset() ->
drm_atomic_add_affected_planes() to duplicate the unleased plane's active
state (with crtc =3D leased_crtc and fb !=3D NULL). That causes
drm_atomic_helper_check_plane_state() to fail with -EINVAL if the CRTC rema=
ins
disabled, or leaves new_crtc_state->plane_mask missing the unleased plane if
the CRTC is re-enabled in the same commit. Meanwhile,
drm_atomic_add_affected_connectors() inspects new_crtc_state->connector_mask
(which is 0), failing to pull in the unleased connector and leaving
connector->state->crtc and best_encoder dangling on the reset CRTC.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_atomic_commit_fill_with_defaults);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-reset-=
state-flag-v6-0-f36d640b7e76@kernel.org?part=3D11
