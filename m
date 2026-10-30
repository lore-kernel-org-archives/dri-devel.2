Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952C606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+Peb4HG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70AA112741;
	Fri, 30 Oct 2026 10:40:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1537F11274F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:40:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF5A46025F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F061F00A02;
 Fri, 30 Oct 2026 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356813;
 bh=zoL0kzYJ6/gfZGZRQ4OUAW+wQgL1MujI3THp3ZfA8pA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B+Peb4HGRgDpEVTrulNP3I7t4iI391EJqZU/z5E9DERPmJ5mesEwPh9zlD4wqwbyJ
 tk61EfW8fp3g6iQPg5oJv0Yzgs/IlfLU4fQY0Wj0fTPMyAW3ZLl9ESAYslQHjR8mNA
 QimenZbBSwiknHvqy0M5sdcqy243mTD9Ovq1+04UtgSUytH+R0dLix5e6HUsVOH0V9
 ondfaxcSwvDAUktzUL3Ahy8ox4uCqjBTU7aOTJxSuc7/ioi6tIWj/o67axThk4mPDk
 HTD2yB7ENYcCSs+ZUw0E0n5scGgstqYSM6RwaAXClWNMzH7gUHvQtK2Ex9d9fRHhMc
 tLrGDSoCkN8ig==
Message-ID: <sashiko-outbox-190856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/16] drm/vkms: Add driver-specific plane property
 for testing
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-drm-reset-state-flag-v7-16-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
 <20261030-drm-reset-state-flag-v7-16-4e55eaeae683@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:40:13 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/vkms: missing connector atomic_create_state breaks DRM_MODE_=
ATOMIC_RESET
--

commit dd5905026f6d7cc05c849f79e8c81bca404953ae
Author: Maxime Ripard <mripard@kernel.org>

drm/vkms: Add driver-specific plane property for testing

This commit adds a driver-specific "vkms-test-do-not-use-in-prod" range
property to vkms planes to allow userspace to test DRM_MODE_ATOMIC_RESET
without interfering with standard compositor properties.

> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index fd3d34dcf0fe5..42513cb462ace 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c

[ ... ]

> @@ -85,7 +92,9 @@ static void vkms_plane_destroy_state(struct drm_plane *=
plane,
> =20
>  static struct drm_plane_state *vkms_plane_create_state(struct drm_plane =
*plane)
>  {
> +	struct vkms_plane *vkms_plane =3D to_vkms_plane(plane);
>  	struct vkms_plane_state *vkms_state;
> +	u64 val;
> =20
>  	vkms_state =3D kzalloc_obj(*vkms_state);
>  	if (!vkms_state) {
> @@ -95,14 +104,53 @@ static struct drm_plane_state *vkms_plane_create_sta=
te(struct drm_plane *plane)
> =20
>  	__drm_gem_shadow_plane_state_init(plane, &vkms_state->base);
> =20
> +	if (!drm_object_property_get_default_value(&plane->base,
> +						   vkms_plane->vkms_test_do_not_use_property,
> +						   &val))
> +		vkms_state->vkms_test_do_not_use_value =3D val;

[Severity: Medium]
As reported by Sashiko on v6 [1], can vkms_plane_create_state() actually be
reached via DRM_MODE_ATOMIC_RESET while vkms connectors do not implement
atomic_create_state?

When userspace queries DRM_CAP_ATOMIC_RESET in drm_getcap() or submits an
atomic commit with DRM_MODE_ATOMIC_RESET in drm_mode_atomic_ioctl(),
drm_atomic_implements_create_state() and
drm_atomic_commit_fill_with_defaults() check all connectors on the device:

drivers/gpu/drm/drm_atomic.c:drm_atomic_implements_create_state() {
    ...
	drm_connector_list_iter_begin(dev, &conn_iter);
	drm_for_each_connector_iter(connector, &conn_iter) {
		if (!connector->funcs->atomic_create_state) {
			drm_connector_list_iter_end(&conn_iter);
			return false;
		}
	}
	drm_connector_list_iter_end(&conn_iter);
    ...
}

In vkms, both connector function tables still set .reset instead of
.atomic_create_state:

drivers/gpu/drm/vkms/vkms_connector.c:
static const struct drm_connector_funcs vkms_connector_funcs =3D {
	.detect =3D vkms_connector_detect,
	.fill_modes =3D drm_helper_probe_single_connector_modes,
	.reset =3D drm_atomic_helper_connector_reset,
	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,
	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
};

drivers/gpu/drm/vkms/vkms_writeback.c:
static const struct drm_connector_funcs vkms_wb_connector_funcs =3D {
	.fill_modes =3D drm_helper_probe_single_connector_modes,
	.reset =3D drm_atomic_helper_connector_reset,
	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,
	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
};

Because every valid vkms device requires at least one connector,
drm_atomic_implements_create_state() returns false and DRM_MODE_ATOMIC_RESET
commits fail with -EOPNOTSUPP before vkms_plane_create_state() can be invok=
ed.

Should vkms_connector_funcs and vkms_wb_connector_funcs also be converted to
use .atomic_create_state =3D drm_atomic_helper_connector_create_state so th=
is
property can be used to test DRM_MODE_ATOMIC_RESET?

[1] https://lore.kernel.org/r/20261022-drm-reset-state-flag-v6-15-f36d640b7=
e76@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-drm-reset-=
state-flag-v7-0-4e55eaeae683@kernel.org?part=3D16
