Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56347606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+CW8md1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53CB112029;
	Thu, 29 Oct 2026 08:03:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0378510E0E7
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:02:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B32C643B97
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7944E1F01828;
 Thu, 29 Oct 2026 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260946;
 bh=1zLrculFnAqOhAhJid8B+gx4HmStbujp5/3ZlhKBvqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D+CW8md1hBttNCQHq/qNKpSyM5WxqtuAwWgv2eY7qy1Tqw0Hmlia/MEIrmVSCa39C
 26qhIxk6l1tiQwjPOSSFHsg+vit8jsegBgjpdjW3W2hnQOCcJ7lLU7YyUNsuCBu7lq
 cBbDHjiP+sQ7EYXtbi+9BCNfNPQ4BpnGOkm578a5HIXX7tBGAQr9PSspmu1GrwYzvE
 uN+Mpw5BI1M3TfpaiaptiGK0zu6g05ovqvKJdyK2UQWn0W4blYywwXj1tjAkkMLfQt
 LqIQRZoHqXZyCYuHwm2/qowF/Ze4HxinD/H7Yh+FAudm90/aeznLtpBqYtHjb00dfj
 lbPs5QbJyhb2w==
Message-ID: <sashiko-outbox-188935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/34] drm/atomic_sro: Provide helpers to implement
 hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-17-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-17-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:02:26 +0000
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
- [Medium] drm/atomic_sro: unexported drm_atomic_helper_colorop_create_stat=
e() call
- [Medium] drm/atomic_sro: missing EXPORT_SYMBOL() on per-object readout he=
lpers
- [Medium] drm/atomic_sro: colorop state leak in drm_atomic_helper_sro_read=
out_state()
- [Medium] drm/atomic_sro: missing fallback state when object readout hook =
is absent
- [Medium] drm/atomic_sro: bridge readout WARN_ON() on partial commit conne=
ctor state
--

commit dadf54d14092f977607e2034fd03f065196831b7
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Provide helpers to implement hardware state readout

This commit introduces helper functions in drm_kms_helper to iterate over K=
MS
objects, allocate pristine states, and invoke their hardware state readout
callbacks, along with top-level helpers to build and install the initial
readout state.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/=
gpu/drm/drm_atomic_state_readout_helper.c
> new file mode 100644
> index 0000000000000..a0b0337df2a00
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
> @@ -0,0 +1,681 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_state_readout.h>
> +#include <drm/drm_atomic_state_readout_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_colorop.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_print.h>
> +
> +#include <linux/gfp.h>
> +#include <linux/sched/mm.h>
> +
> +static int
> +drm_atomic_helper_sro_readout_plane_state(struct drm_device *dev,
> +					  struct drm_atomic_sro_state *state,
> +					  struct drm_plane *plane)
> +{
> +	const struct drm_plane_funcs *plane_funcs =3D plane->funcs;
> +	struct drm_plane_state *plane_state;
> +	int ret;
> +
> +	if (!plane_funcs->atomic_sro_readout_state) {
> +		drm_warn(dev, "No plane readout implementation.");
> +		return 0;
> +	}

[Severity: Medium]
When atomic_readout is set to DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
drm_atomic_sro_device_can_readout() allows readout to proceed even if some
objects do not implement atomic_sro_readout_state.

If drm_atomic_helper_sro_readout_plane_state() (and the corresponding CRTC,
connector, bridge, and private object helpers below) returns 0 here without
allocating a default state via atomic_create_state() and storing it in stat=
e,
drm_atomic_helper_sro_readout_state() will succeed and cause
drm_mode_config_create_initial_state() to skip drm_mode_config_create_state=
():

drivers/gpu/drm/drm_mode_config.c:drm_mode_config_create_initial_state() {
	if (dev->mode_config.funcs->atomic_sro_readout_state) {
		ret =3D dev->mode_config.funcs->atomic_sro_readout_state(dev);
		if (!ret)
			goto out;
	}

	ret =3D drm_mode_config_create_state(dev);
}

Won't that leave any object lacking atomic_sro_readout_state with a NULL
state pointer after initialization (and also trigger WARN_ON(!conn_state) in
find_connector_state_for_encoder() during bridge readout if a connector was
skipped)?

> +
> +	drm_dbg_kms(dev, "Initializing Plane %s state.\n", plane->name);
> +
> +	plane_state =3D plane_funcs->atomic_create_state(plane);
> +	if (drm_WARN_ON(dev, IS_ERR(plane_state)))
> +		return PTR_ERR(plane_state);
> +
> +	ret =3D plane_funcs->atomic_sro_readout_state(plane, state,
> +						    plane_state);
> +	if (drm_WARN_ON(dev, ret)) {
> +		plane_funcs->atomic_destroy_state(plane, plane_state);
> +		return ret;
> +	}
> +
> +	drm_atomic_sro_set_plane_state(state, plane, plane_state);
> +
> +	return 0;
> +}

[ ... ]

> +int
> +drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
> +					   struct drm_atomic_sro_state *state,
> +					   struct drm_atomic_commit *commit)
> +{
> +	struct drm_plane *plane;
> +	int ret;
> +
> +	might_alloc(GFP_KERNEL);
> +
> +	if (commit)
> +		return drm_atomic_helper_sro_readout_commit_planes_state(dev, state, c=
ommit);
> +
> +	drm_for_each_plane(plane, dev) {
> +		ret =3D drm_atomic_helper_sro_readout_plane_state(dev, state, plane);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Should drm_atomic_helper_sro_readout_planes_state() and the other four
per-object helpers (drm_atomic_helper_sro_readout_crtcs_state(),
drm_atomic_helper_sro_readout_connectors_state(),
drm_atomic_helper_sro_readout_bridges_state(), and
drm_atomic_helper_sro_readout_private_objs_state()) have EXPORT_SYMBOL()?

They are declared in include/drm/drm_atomic_state_readout_helper.h and pull=
ed
into Documentation/gpu/drm-kms-helpers.rst via :export:, but without
EXPORT_SYMBOL() modular drivers implementing a custom atomic_sro_build_state
callback will fail to link at modpost.

[ ... ]

> +static int
> +drm_atomic_helper_sro_readout_commit_connectors_state(struct drm_device =
*dev,
> +						      struct drm_atomic_sro_state *state,
> +						      struct drm_atomic_commit *commit)
> +{
> +	struct drm_connector_state *new_connector_state;
> +	struct drm_connector *connector;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!commit)
> +		return -EINVAL;
> +
> +	for_each_new_connector_in_state(commit, connector, new_connector_state,=
 i) {
> +		ret =3D drm_atomic_helper_sro_readout_connector_state(dev, state, conn=
ector);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
When drm_atomic_helper_sro_build_state() is called with a non-NULL commit t=
hat
only includes a subset of the device's connectors,
drm_atomic_helper_sro_readout_commit_connectors_state() only populates
connector states in state for the connectors in that commit.

Later in drm_atomic_helper_sro_build_state(),
drm_atomic_helper_sro_readout_bridges_state() reads out the bridges for the
committed connectors' encoders. For bridges using
drm_bridge_atomic_readout_priv_state(), this calls
find_connector_state_for_encoder() in drivers/gpu/drm/drm_bridge.c:

	drm_for_each_connector_iter(connector, &conn_iter) {
		struct drm_connector_state *conn_state =3D
			drm_atomic_sro_get_connector_state(state, connector);

		if (WARN_ON(!conn_state))
			continue;

Doesn't this trigger WARN_ON(!conn_state) for every connector on the device
that was not part of the commit?

[ ... ]

> +int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
> +{
> +	const struct drm_mode_config_helper_funcs *funcs =3D
> +		dev->mode_config.helper_private;
> +	struct drm_atomic_sro_state *state;
> +	struct drm_colorop *colorop;
> +
> +	if (!drm_atomic_sro_device_can_readout(dev)) {
> +		drm_info(dev, "Device doesn't support hardware state readout.");
> +		return -ENOTSUPP;
> +	}
> +
> +	state =3D funcs->atomic_sro_build_state(dev, NULL);
> +	if (IS_ERR(state))
> +		return PTR_ERR(state);
> +
> +	/* TODO: Add colorop state readout support */
> +	drm_for_each_colorop(colorop, dev) {
> +		struct drm_colorop_state *colorop_state;
> +
> +		colorop_state =3D drm_atomic_helper_colorop_create_state(colorop);

[Severity: Medium]
Does this build when CONFIG_DRM_KMS_HELPER=3Dm?

drm_atomic_state_readout_helper.o is linked into drm_kms_helper.ko in
drivers/gpu/drm/Makefile, while drm_atomic_helper_colorop_create_state() is
defined in drivers/gpu/drm/drm_colorop.c (part of drm.ko) without
EXPORT_SYMBOL(), which causes a modpost undefined symbol error.

> +		if (IS_ERR(colorop_state)) {
> +			drm_atomic_sro_state_free(state);
> +			return PTR_ERR(colorop_state);
> +		}
> +
> +		colorop->state =3D colorop_state;
> +	}

[Severity: Medium]
Can this loop leak colorop->state?

The drm_plane_colorop_*_init() helpers in drivers/gpu/drm/drm_colorop.c call
drm_colorop_reset(), which allocates and populates colorop->state during
initialization. In drivers/gpu/drm/drm_mode_config.c,
drm_mode_config_create_state() skips colorops that already have a state:

	drm_for_each_colorop(colorop, dev) {
		struct drm_colorop_state *colorop_state;

		if (colorop->state)
			continue;

		colorop_state =3D drm_atomic_helper_colorop_create_state(colorop);

Assigning colorop->state unconditionally here without checking or destroying
an existing colorop->state (and without cleaning up earlier iterations if a
later drm_atomic_helper_colorop_create_state() call fails) appears to leak =
the
previously allocated struct drm_colorop_state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D17
