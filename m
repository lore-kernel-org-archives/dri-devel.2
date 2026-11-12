Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE8606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3Q4fQzM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D7B11222F;
	Thu, 12 Nov 2026 16:55:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E32B11222F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:54:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C42243C32
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157911F000C4;
 Thu, 12 Nov 2026 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794502496;
 bh=qYkVhpkzR3/FmguEY45YONKnO00Xyx8nJsVZplW/4Jw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i3Q4fQzMXMI5n/eCnSon4DJLOb4ZCJ3ghQEFdP/+cnUMEhKzUM8AzDvNDtXZ0bScq
 acGKw0L9vkz12KtuCv9SgLQPV1d4TorRSe8a6y5tvabT03k1mKFwZIHZg+xPE6Zhx3
 UKrlpthL4wfN2FWphQE5sEEjdo4rll9NYa/CQ7WGHlIhfTV5aFH0JHI/8MCKCLCDBD
 4DbprmljEp63IG1J6zbN0eC/BJmyZOx0Q050KUluTrXX66T4g/EyNNuqha6LCs7vR1
 HkK2upyBWlfnI16I2xixVgwvaOiLgCuLoBfXtRjj6hYQRWG1m+4Hgu5kqUVlPbpf0I
 gpua72tF5t0YQ==
Message-ID: <sashiko-outbox-211548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/9] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-drm-reset-state-flag-v10-8-cefaa1ed056d@kernel.org>
References: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
 <20261112-drm-reset-state-flag-v10-8-cefaa1ed056d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:54:55 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/atomic: lease revocation race in
  drm_atomic_commit_fill_with_defaults()
--

commit b8c56650ab4657eb654cfbc63cf4622958dcbfc9
Author: Sebastian Wick <sebastian.wick@redhat.com>

drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

This commit introduces the DRM_MODE_ATOMIC_RESET flag and the
DRM_CAP_ATOMIC_RESET capability to reset all KMS object states to their
defaults before applying the properties supplied in an atomic commit.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1eebcf6f5e05b..fe6d8cc533bc9 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
[ ... ]
> @@ -1688,6 +1715,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
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

[Severity: Medium]
Can concurrent lease revocation during drm_atomic_commit_fill_with_defaults=
()
populate a partial pipeline into state and cause a NULL pointer dereference=
 in
crtc_or_fake_commit()?

Each drm_lease_held() call in drm_atomic_commit_fill_with_defaults() acquir=
es
and drops dev->mode_config.idr_mutex on its own, while _drm_lease_revoke()
empties master->leases under idr_mutex without taking modeset locks.  If a
lessor revokes the lease between the plane loop and the CRTC loop, an active
plane is added to the commit with a reset state (new_plane_state->crtc =3D=
=3D NULL,
old_plane_state->crtc =3D=3D crtc) without adding its CRTC:

CPU0 (lessee)                               CPU1 (lessor)
drm_mode_atomic_ioctl()
  drm_atomic_commit_fill_with_defaults()
    drm_for_each_plane()
      drm_lease_held(..., plane) -> true
      drm_lease_held(..., crtc) -> true
      drm_atomic_commit_set_plane_state()
                                            drm_mode_revoke_lease_ioctl()
                                              _drm_lease_revoke()
                                                idr_destroy(&master->leases)
    drm_for_each_crtc()
      drm_lease_held(..., crtc) -> false
    drm_for_each_connector_iter()
      drm_lease_held(...) -> false
  drm_atomic_commit()
    ...
      drm_atomic_helper_plane_changed()
        crtc_state =3D drm_atomic_get_new_crtc_state(state,
                                                   old_plane_state->crtc)
        WARN_ON(!crtc_state)
      ...
      drm_atomic_helper_setup_commit()
        crtc_or_fake_commit(state, old_plane_state->crtc)
          new_crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc)
          new_crtc_state->commit  <-- NULL pointer dereference

Unlike drm_atomic_get_plane_state(), the plane loop in
drm_atomic_commit_fill_with_defaults() relies on the subsequent CRTC loop to
add old_plane_state->crtc to the commit, and the connector loop's -ENOENT
partial-pipeline guard is also bypassed once drm_lease_held() returns false=
 for
the CRTC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-drm-reset-=
state-flag-v10-0-cefaa1ed056d@kernel.org?part=3D8
