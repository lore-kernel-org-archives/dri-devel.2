Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnZUalVh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381F510E4CF;
	Fri, 30 Oct 2026 17:24:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAF710E4CF
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:23:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D216605D0;
 Fri, 30 Oct 2026 17:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17431F00A1B;
 Fri, 30 Oct 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793381036;
 bh=/OBhgDJo/YxDOnnvUsXiuggkit72jCn9CuAtTBfYXKw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LnZUalVhR/sDIodZ2KDScA3+omFMed1GffxGGIvoAkh6J2aK49HyidvGiMm1h7hOV
 ITaf1numX4h7R+Xi2khEGSDqfNzDRNly6w7Pq4F9lkext7E6KknHQqjeYJDXFTPGCg
 ubjnZiX6bpYUWAAsNW2CmTQeCffqW0mxx03wtqjXUKEPuZe5uf7zVxF7pxtaisl+4s
 pU1DGaQ6efPr+beoIj9MFoCioikOMuHeSqXgmLu9/QfQwQFoiKeZOqfcvCOp0sCjh4
 7TbFjO60iUaJdnGgMCfwqTKBkiVs0bVCafsrBFxPxNmja8X03EMXu466btGka4gwDv
 Vdcrwqg2XdLkA==
Message-ID: <sashiko-outbox-191333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] drm/amd/display: drop RGBA8888 from plane format
 lists
To: "MuXian Chen" <a18165943161@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030171816.11610-1-a18165943161@gmail.com>
References: <20261030171816.11610-1-a18165943161@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:23:56 +0000
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
- [Medium] drm/amd/display: broken KUnit test dm_test_get_plane_formats()
--

commit 7e1267e34b886f02722f18cb9144a71e1afc6858
Author: MuXian Chen <a18165943161@gmail.com>

drm/amd/display: drop RGBA8888 from plane format lists

This commit removes DRM_FORMAT_RGBA8888 from rgb_formats[] and
overlay_formats[] because DC has no surface pixel format for RGBA8888 and
fails atomic commits in fill_dc_plane_info_and_addr() when compositors sele=
ct
it.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5339

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 91398230d4083..6d5454fb5e379 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -49,11 +49,13 @@
>   * For future use cases we should either initialize them dynamically bas=
ed on
>   * plane capabilities, or initialize this array to all formats, so inter=
nal drm
>   * check will succeed, and let DC implement proper check
> + *
> + * DC has no surface format for DRM_FORMAT_RGBA8888, so it must not be
> + * advertised here or in overlay_formats.
>   */
>  static const uint32_t rgb_formats[] =3D {
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_RGBA8888,
>  	DRM_FORMAT_XRGB2101010,
>  	DRM_FORMAT_XBGR2101010,
>  	DRM_FORMAT_ARGB2101010,
> @@ -70,7 +72,6 @@ static const uint32_t rgb_formats[] =3D {
>  static const uint32_t overlay_formats[] =3D {
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_RGBA8888,

[Severity: Medium]
Does removing DRM_FORMAT_RGBA8888 from rgb_formats[] and overlay_formats[] =
in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c break the KUnit test
dm_test_get_plane_formats() in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c?

Because amdgpu_dm_plane_get_plane_formats() populates the format list by
iterating over ARRAY_SIZE(rgb_formats) (reduced from 14 to 13) for primary =
and
universal planes and ARRAY_SIZE(overlay_formats) (reduced from 9 to 8) for
overlay planes, running the amdgpu_dm_plane KUnit suite triggers failures in
dm_test_get_plane_formats():

	plane->type =3D DRM_PLANE_TYPE_PRIMARY;
	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, forma=
ts, 32), 14);

	cap->pixel_format_support.nv12 =3D true;
	cap->pixel_format_support.p010 =3D true;
	cap->pixel_format_support.fp16 =3D true;
	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, cap, format=
s, 32), 20);

	plane->type =3D DRM_PLANE_TYPE_OVERLAY;
	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, forma=
ts, 32), 9);

	universal_cap->type =3D DC_PLANE_TYPE_DCN_UNIVERSAL;
	KUNIT_EXPECT_EQ(test,
			amdgpu_dm_plane_get_plane_formats(plane, universal_cap, formats, 32),
			14);

Should these expected counts in dm_test_get_plane_formats() be updated to 1=
3,
19, 8, and 13 to match the new array sizes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171816.1161=
0-1-a18165943161@gmail.com?part=3D1
