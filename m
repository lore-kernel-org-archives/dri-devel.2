Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642B6C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C873010E162;
	Fri, 14 Aug 2026 15:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0xOwrJp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFCC10E162
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:25:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A2ED4326D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5319D1F000E9;
 Fri, 14 Aug 2026 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721113;
 bh=hbE9D5YB/rcYypLT8d0RREVMJJB0zdJRgKJbdmoPf0E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M0xOwrJplnnnnK/DXTDXJylPOk3VCLw77lfK8ZEOrgHPf7zzhjqHjsjSF7iWvG/kL
 2htAl5byqpWhFDh53j5hUeELspHrM7nY4GEhe3fRUgdp0B9MV87YB+DpdX3xR5PgmL
 y2NuGP/mQBwCzKqquxlO/o7xBnZaHRHOxSWCAtI0uc+kEC0sl+lUhQiMmxheCRZc/J
 fmQ2plZcMw/WUSTUe0imFhFosD5znaUXWD9hjOHGF5Rtc9/e4/k3I4IuWyYrDUi/bf
 KEqio6/saAVq0f6yJ8bcHgh/Ub5Dz+exSEKt4YMUAeBbO1/MdvxjVPlHmU4QJuKf6v
 QXK334y5InPLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 40/61] drm/amdgpu_dm: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-40-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-40-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:25:12 +0000
Message-Id: <20260814152513.5319D1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing drm_plane_cleanup() on the error path in amdgpu_dm_plane_i=
nit() causes a Use-After-Free of the plane object when the caller frees the=
 plane.
--

--- Patch [40]: [PATCH v2 40/61] drm/amdgpu_dm: Convert to atomic_create_st=
ate ---
commit 6612d2468dd0e4946eb21b27b9d60498ca111985
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu_dm: Convert to atomic_create_state

This commit converts the plane reset implementation to use the
atomic_create_state hook. A custom state subclass is initialized
without resetting any hardware. The conversion was performed via a
Coccinelle semantic patch.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c

[ ... ]

> @@ -1993,9 +1992,16 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
>  		return res;
>  #endif
> =20
> -	/* Create (reset) the plane state */
> -	if (plane->funcs->reset)
> -		plane->funcs->reset(plane);
> +	/* Create the plane state */
> +	if (plane->funcs->atomic_create_state) {
> +		struct drm_plane_state *plane_state;
> +
> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);

[Severity: High]
This is a pre-existing issue, but I wanted to ask about this error path.
If plane->funcs->atomic_create_state() fails and returns an error pointer,
we return the error directly without calling drm_plane_cleanup().

Since drm_universal_plane_init() was called earlier in this function, the
plane is already linked into the mode_config.plane_list. If we return an
error here, the caller initialize_plane() will free the plane memory:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:initialize_plane() {
    ...
    if (ret) {
        drm_err(adev_to_drm(dm->adev), "KMS: Failed to initialize plane\n");
        kfree(plane);
        return ret;
    }
    ...
}

Does this leave a freed pointer on the plane list that could cause a
use-after-free later during device teardown in drm_mode_config_cleanup()?

While this problem already existed for dm_plane_init_colorops() failures,
it appears this patch might expose it to a new allocation failure path.

> +
> +		plane->state =3D plane_state;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D40
