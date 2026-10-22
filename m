Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D204606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSHv4XV8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E742C112683;
	Thu, 22 Oct 2026 14:18:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1412112683
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:18:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A22A40347
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BEE1F000C1;
 Thu, 22 Oct 2026 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792678681;
 bh=APcYXwFbg9C8NWfPrvgec+9qCIt6bGlKPQ9amNVlc84=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aSHv4XV81o17iMxtm24AzceTos6gZBTfXNrf+Wh64LoehmgAYp2zaL/WV/c1CCoRe
 WcC1dGRwSTm5GYdRMKmdQNBf9CYl9nG/ksOv8xdNlHzaAXNidBN70heLOHSo5+c+xU
 7QuGhE84093Aov1GIexqvpju4Ny5jojOQkawLZEN+9vJt5JLGzm0V9mFvtEc8uUQCS
 X5GyToksdz3gwtouI/4+rI+wEWZkSFSHiY52hqeyE+s9vr25AAnVEYJ07+ji5ptCkX
 aoAKSWSCSWXJhFu9kT7BDWT+9OlKidy4NskBjoLgX5XUX9XP/vndkinluBdBvPDFZ/
 wcudYq+xQHFMQ==
Message-ID: <sashiko-outbox-181627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/15] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-reset-state-flag-v6-13-f36d640b7e76@kernel.org>
References: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
 <20261022-drm-reset-state-flag-v6-13-f36d640b7e76@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 14:18:00 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/atomic: DRM_MODE_ATOMIC_RESET with page-flip event fails on in=
active CRTC
- [High] drm/atomic: NULL crtc_state dereference on DRM_MODE_ATOMIC_RESET i=
n DRM lease
- [Medium] drm/ioctl: drm_getcap() reports DRM_CAP_ATOMIC_RESET on non-atom=
ic drivers
- [Medium] drm/atomic: DRM_MODE_ATOMIC_RESET clears best_encoder and forces=
 full modeset
- [Medium] drm/atomic: DRM_MODE_ATOMIC_RESET fails to set color_mgmt_change=
d on reset
--

commit 421841f24ef240ac1eae965a30846086114bc3d7
Author: Sebastian Wick <sebastian.wick@redhat.com>

drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

This commit introduces the DRM_MODE_ATOMIC_RESET flag for atomic commits and
the DRM_CAP_ATOMIC_RESET capability so userspace can reset all KMS object
states to their defaults before applying the properties in the request.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1eebcf6f5e05b..9ff1ddecb8ede 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c

[ ... ]

> @@ -1688,6 +1695,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	fence_state =3D NULL;
>  	num_fences =3D 0;
> =20
> +	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
> +		if (!drm_atomic_implements_create_state(dev)) {
> +			ret =3D -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		ret =3D drm_atomic_commit_fill_with_defaults(file_priv, state);
> +		if (ret)
> +			goto out;
> +	}

[Severity: High]
What happens when userspace combines DRM_MODE_ATOMIC_RESET with
DRM_MODE_PAGE_FLIP_EVENT on a device where at least one crtc is currently o=
ff
and remains off after the commit?

In drivers/gpu/drm/drm_atomic_uapi.c, drm_mode_atomic_ioctl() calls
drm_atomic_commit_fill_with_defaults(file_priv, state), which populates
state->crtcs with a default drm_crtc_state (where enable and active are
false) for every crtc on the device or lease. Any crtc not explicitly enabl=
ed
by properties in the request remains in state->crtcs with
new_crtc_state->active set to false.

Later in drm_mode_atomic_ioctl(), prepare_signaling() iterates over every
crtc in state and attaches a vblank event whenever DRM_MODE_PAGE_FLIP_EVENT
is set:

drivers/gpu/drm/drm_atomic_uapi.c:prepare_signaling() {
    ...
	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
		s32 __user *fence_ptr;

		fence_ptr =3D get_out_fence_for_crtc(crtc_state->state, crtc);

		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
			struct drm_pending_vblank_event *e;

			e =3D create_vblank_event(crtc, arg->user_data);
			if (!e)
				return -ENOMEM;

			crtc_state->event =3D e;
		}
    ...
}

When drm_atomic_commit() or drm_atomic_nonblocking_commit() subsequently ru=
ns
drm_atomic_check_only() -> drm_atomic_crtc_check() in
drivers/gpu/drm/drm_atomic.c, any crtc that was off and remains off causes =
the
entire commit to fail with -EINVAL:

drivers/gpu/drm/drm_atomic.c:drm_atomic_crtc_check() {
    ...
	if (new_crtc_state->event &&
	    !new_crtc_state->active && !old_crtc_state->active) {
		drm_dbg_atomic(crtc->dev,
			       "[CRTC:%d:%s] requesting event but off\n",
			       crtc->base.id, crtc->name);
		return -EINVAL;
	}
    ...
}

This also means a preceding DRM_MODE_ATOMIC_TEST_ONLY | DRM_MODE_ATOMIC_RES=
ET
commit succeeds while the subsequent commit with DRM_MODE_PAGE_FLIP_EVENT
fails. Should prepare_signaling() avoid attaching vblank events to inactive
crtcs that were only added by drm_atomic_commit_fill_with_defaults()?

[Severity: High]
Can calling drm_atomic_commit_fill_with_defaults() from
drm_mode_atomic_ioctl() trigger a NULL crtc_state dereference in
update_connector_routing() when used by a drm lessee?

In drivers/gpu/drm/drm_atomic.c, drm_atomic_commit_fill_with_defaults()
filters crtcs, planes, and connectors independently via drm_lease_held():

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
	drm_for_each_crtc(crtc, dev) {
		struct drm_crtc_state *crtc_state;

		if (!drm_lease_held(file_priv, crtc->base.id))
			continue;
    ...
	drm_for_each_connector_iter(connector, &conn_iter) {
		struct drm_connector_state *connector_state;

		if (!drm_lease_held(file_priv, connector->base.id))
			continue;
    ...
}

Unlike drm_atomic_get_connector_state(), which pulls the connector's
previously bound crtc into the commit via drm_atomic_get_crtc_state(),
drm_atomic_commit_fill_with_defaults() resets a leased connector to
new_connector_state->crtc =3D NULL while skipping old_connector_state->crtc=
 if
that crtc is not held by the lease.

When drm_atomic_check_only() -> drm_atomic_helper_check_modeset() ->
update_connector_routing() runs in drivers/gpu/drm/drm_atomic_helper.c,
drm_atomic_get_new_crtc_state(state, old_connector_state->crtc) returns NULL
and is immediately dereferenced:

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

Conversely, if a leased crtc currently has an unleased plane or connector
bound to it, resetting the leased crtc zeroes its plane_mask, connector_mas=
k,
and encoder_mask without detaching the unleased object.

[Severity: Medium]
Will resetting connector state via atomic_create_state() in
drm_atomic_commit_fill_with_defaults() force a full modeset even when an
active connector remains bound to the same crtc and mode?

In drivers/gpu/drm/drm_atomic.c, drm_atomic_commit_fill_with_defaults()
creates each connector state via connector->funcs->atomic_create_state(),
which leaves new_connector_state->best_encoder as NULL (whereas
atomic_duplicate_state() preserves old_connector_state->best_encoder):

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
		connector_state =3D connector->funcs->atomic_create_state(connector);
		if (IS_ERR(connector_state)) {
			drm_connector_list_iter_end(&conn_iter);
			ret =3D PTR_ERR(connector_state);
			return ret;
		}
    ...
}

When userspace re-applies the same crtc to the connector in the reset commi=
t,
new_connector_state->best_encoder is still NULL when
drm_atomic_helper_check_modeset() -> update_connector_routing() runs in
drivers/gpu/drm/drm_atomic_helper.c:

drivers/gpu/drm/drm_atomic_helper.c:update_connector_routing() {
    ...
	if (new_encoder =3D=3D new_connector_state->best_encoder) {
		set_best_encoder(state, new_connector_state, new_encoder);
        ...
		return 0;
	}

	steal_encoder(state, new_encoder);

	set_best_encoder(state, new_connector_state, new_encoder);

	crtc_state->connectors_changed =3D true;
    ...
}

Because update_connector_routing() compares new_encoder against
new_connector_state->best_encoder rather than
old_connector_state->best_encoder, the check always fails and sets
crtc_state->connectors_changed =3D true. Does this cause
drm_atomic_crtc_needs_modeset() to return true unconditionally on active
crtcs, rejecting reset commits that omit DRM_MODE_ATOMIC_ALLOW_MODESET with
-EINVAL?

[Severity: Medium]
When DRM_MODE_ATOMIC_RESET clears previously active crtc color management
blobs (degamma_lut, ctm, gamma_lut) or a plane color_pipeline, how does
color_mgmt_changed get set on the new state?

In drivers/gpu/drm/drm_atomic.c, drm_atomic_commit_fill_with_defaults()
allocates fresh plane and crtc states via atomic_create_state(), which
initializes degamma_lut, ctm, gamma_lut, and color_pipeline to NULL and
color_mgmt_changed to false:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
		plane_state =3D plane->funcs->atomic_create_state(plane);
		if (IS_ERR(plane_state))
			return PTR_ERR(plane_state);

		drm_atomic_commit_set_plane_state(commit, plane, plane_state);
    ...
		crtc_state =3D crtc->funcs->atomic_create_state(crtc);
		if (IS_ERR(crtc_state))
			return PTR_ERR(crtc_state);

		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
    ...
}

In drivers/gpu/drm/drm_atomic_uapi.c, drm_atomic_crtc_set_property() and
drm_atomic_plane_set_property() only update color_mgmt_changed when a prope=
rty
change modifies the in-progress state:

drivers/gpu/drm/drm_atomic_uapi.c:drm_atomic_crtc_set_property() {
    ...
		ret =3D drm_property_replace_blob_from_id(dev,
					&state->degamma_lut,
					val,
					elem_size * lut_size, -1, elem_size,
					&replaced);
		state->color_mgmt_changed |=3D replaced;
		return ret;
    ...
}

drivers/gpu/drm/drm_atomic_uapi.c:drm_atomic_plane_set_property() {
    ...
		state->color_mgmt_changed |=3D drm_atomic_set_colorop_for_plane(state, co=
lorop);
    ...
}

If an active crtc or plane had a non-NULL lut, ctm, or color_pipeline in
old_crtc_state or old_plane_state and the reset commit leaves those propert=
ies
at their default NULL values (or explicitly writes 0), color_mgmt_changed
remains false. Won't drivers that gate hardware lut, ctm, or color pipeline
updates on color_mgmt_changed skip reprogramming the hardware and leave sta=
le
color transforms active?

>  	for (i =3D 0; i < arg->count_objs; i++) {
>  		uint32_t obj_id, count_props;
>  		struct drm_mode_object *obj;
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 0dbf04d4aa9e0..e589d93871e27 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -305,6 +305,9 @@ static int drm_getcap(struct drm_device *dev, void *d=
ata, struct drm_file *file_
>  		req->value =3D drm_core_check_feature(dev, DRIVER_ATOMIC) &&
>  			     dev->mode_config.async_page_flip;
>  		break;
> +	case DRM_CAP_ATOMIC_RESET:
> +		req->value =3D drm_atomic_implements_create_state(dev);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

[Severity: Medium]
Should DRM_CAP_ATOMIC_RESET in drm_getcap() also check
drm_core_check_feature(dev, DRIVER_ATOMIC) like DRM_CAP_ATOMIC_ASYNC_PAGE_F=
LIP
does right above it?

In drivers/gpu/drm/drm_ioctl.c, this switch in drm_getcap() only checks
drm_core_check_feature(dev, DRIVER_MODESET), and
drm_atomic_implements_create_state() in drivers/gpu/drm/drm_atomic.c only
checks whether objects in plane_list, crtc_list, and connector_list have
atomic_create_state hooks. On KMS drivers where DRIVER_ATOMIC is not set (f=
or
example, when a driver clears DRIVER_ATOMIC dynamically or when the mode
object lists are empty), drm_getcap() will report DRM_CAP_ATOMIC_RESET =3D 1
even though DRM_IOCTL_MODE_ATOMIC fails with -EOPNOTSUPP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-reset-=
state-flag-v6-0-f36d640b7e76@kernel.org?part=3D13
