Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874B60A3816
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbSuE9Wu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D52112680;
	Thu, 22 Oct 2026 14:09:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B55112680
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:09:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2401F60DD1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10901F000C3;
 Thu, 22 Oct 2026 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792678175;
 bh=bCnQ9GYFP7cPMrPqju59m3aAdpCrIFP9Y6PQTgo0DlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XbSuE9WuwS8TbqAQMQZfviHVgdqwQ8KF2qd1v9ckVjF2TXpOZcU6cXaE0/n1twz7+
 xilMTwKCalD+GU7fWdEYkW9MFJzaby42W0Urq+kTnumYg8wF9DW3zfwW3Gk6i8MBb7
 2onsmb0n5FK06gqRz63iw8JxFQLpoK+63c47A9oXAz8EcdGqGt2rmzDgK/tqFFc3he
 EO+EdndZXlcvufsRAeYBoAROmik9iiQ15fVU1IWMLr5Tn5PfsCPz1Ct6pwavt6yk5j
 sZBKHWdJJdk5Blrlpy2/74b/puD3TNMlEueOKBexVTbrP9qVvecFH1+yiBlwYqqu10
 m9iyfFlSPCVmA==
Message-ID: <sashiko-outbox-181610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/15] drm/vkms: Add driver-specific plane property
 for testing
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-reset-state-flag-v6-15-f36d640b7e76@kernel.org>
References: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
 <20261022-drm-reset-state-flag-v6-15-f36d640b7e76@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 14:09:35 +0000
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
- [High] drm/vkms: NULL dereference in vkms_plane_create_state() if propert=
y alloc fails
- [Medium] drm/vkms: missing connector atomic_create_state breaks DRM_MODE_=
ATOMIC_RESET
--

commit f0d606e22df5b4b30135537f8737279247724656
Author: Maxime Ripard <mripard@kernel.org>

drm/vkms: Add driver-specific plane property for testing

This commit adds a driver-specific "vkms-test-do-not-use-in-prod" range
property to vkms planes so userspace tests can verify that
DRM_MODE_ATOMIC_RESET resets plane state properties to their default values.

> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index fd3d34dcf0fe5..0ebc131c2788f 100644
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

[Severity: High]
Can this trigger a NULL pointer dereference in
drm_object_property_get_default_value() if drm_property_create_range()
fails in vkms_plane_init()?

In drivers/gpu/drm/vkms/vkms_plane.c, vkms_plane_init() treats a
drm_property_create_range() failure as non-fatal and leaves
plane->vkms_test_do_not_use_property as NULL:

	plane->vkms_test_do_not_use_property =3D
		drm_property_create_range(dev, 0,
					  "vkms-test-do-not-use-in-prod",
					  0, U32_MAX);
	if (plane->vkms_test_do_not_use_property)
		drm_object_attach_property(&plane->base.base,
					   plane->vkms_test_do_not_use_property,
					   0);

When vkms_plane_create_state() is subsequently called during device
initialization via vkms_output_init() -> drm_mode_config_reset() (or
during a DRM_MODE_ATOMIC_RESET commit via
drm_atomic_commit_fill_with_defaults()), it unconditionally passes
vkms_plane->vkms_test_do_not_use_property to
drm_object_property_get_default_value().

However, in drivers/gpu/drm/drm_mode_object.c,
drm_object_property_get_default_value() immediately dereferences
property->dev without checking whether property is NULL:

int drm_object_property_get_default_value(struct drm_mode_object *obj,
					  struct drm_property *property,
					  uint64_t *val)
{
	WARN_ON(!drm_drv_uses_atomic_modeset(property->dev));

	return __drm_object_property_get_prop_value(obj, property, val);
}

Should vkms_plane_create_state() check that
vkms_plane->vkms_test_do_not_use_property is non-NULL before calling
drm_object_property_get_default_value(), or should vkms_plane_init()
fail when drm_property_create_range() returns NULL?

[ ... ]

> @@ -283,6 +331,15 @@ struct vkms_plane *vkms_plane_init(struct vkms_devic=
e *vkmsdev,
>  					  DRM_COLOR_YCBCR_BT601,
>  					  DRM_COLOR_YCBCR_FULL_RANGE);
> =20
> +	plane->vkms_test_do_not_use_property =3D
> +		drm_property_create_range(dev, 0,
> +					  "vkms-test-do-not-use-in-prod",
> +					  0, U32_MAX);
> +	if (plane->vkms_test_do_not_use_property)
> +		drm_object_attach_property(&plane->base.base,
> +					   plane->vkms_test_do_not_use_property,
> +					   0);

[Severity: Medium]
Will userspace be able to use DRM_MODE_ATOMIC_RESET to test resetting
this property on vkms while vkms connectors do not implement
atomic_create_state?

When userspace queries DRM_CAP_ATOMIC_RESET in drm_getcap() or submits
an atomic commit with DRM_MODE_ATOMIC_RESET in drm_mode_atomic_ioctl(),
drm_atomic_implements_create_state() and
drm_atomic_commit_fill_with_defaults() in drivers/gpu/drm/drm_atomic.c
require every connector on the device to provide an atomic_create_state
callback:

	drm_connector_list_iter_begin(dev, &conn_iter);
	drm_for_each_connector_iter(connector, &conn_iter) {
		if (!connector->funcs->atomic_create_state) {
			drm_connector_list_iter_end(&conn_iter);
			return false;
		}
	}
	drm_connector_list_iter_end(&conn_iter);

However, vkms_connector_funcs in drivers/gpu/drm/vkms/vkms_connector.c
and vkms_wb_connector_funcs in drivers/gpu/drm/vkms/vkms_writeback.c
still define .reset =3D drm_atomic_helper_connector_reset without setting
.atomic_create_state:

static const struct drm_connector_funcs vkms_connector_funcs =3D {
	.detect =3D vkms_connector_detect,
	.fill_modes =3D drm_helper_probe_single_connector_modes,
	.reset =3D drm_atomic_helper_connector_reset,
	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,
	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
};

Because every valid vkms device registers at least one connector,
drm_atomic_implements_create_state() always returns false on vkms, so
DRM_CAP_ATOMIC_RESET reports 0 and DRM_MODE_ATOMIC_RESET commits fail
with -EOPNOTSUPP before vkms_plane_create_state() can be reached.

Do vkms_connector_funcs and vkms_wb_connector_funcs also need to use
.atomic_create_state =3D drm_atomic_helper_connector_create_state so that
DRM_MODE_ATOMIC_RESET is supported on vkms?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-reset-=
state-flag-v6-0-f36d640b7e76@kernel.org?part=3D15
