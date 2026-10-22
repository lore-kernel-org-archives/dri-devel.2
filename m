Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735F606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbXAaCA+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5061710E463;
	Thu, 22 Oct 2026 17:50:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C4E10E463
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 17:50:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9646241AFB;
 Thu, 22 Oct 2026 17:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500B61F01825;
 Thu, 22 Oct 2026 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792691427;
 bh=Zu7LZx21uOCJ6qYx1j9/N7Nq1fnwtWkLqpYvHE2VzeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WbXAaCA+LEA+ho+dNCnjToQRfPdkZFGsVKMdr0o7iEWyBBik8hBkHcZldJqRYHdw0
 EWOAjEPg5vV8DrzNaGMWswT0xzMcAVo1aakkEUY9iJw17LAqkZ4E9lPxJeLURFSKbl
 pNrgaavtpxSor3imells8trsF3NnZLazl2+PmqjMuzuSw8Dz5QCQgec/H37ZVjUOoi
 GmsE9NwVaYRE5CcTi8p4wW36xsP6IZFGaUSuaU/9NIudiKB18GtUhOdmJ7iJz6AmfP
 iTLyY3ercz0f8krGCBMlfKQ0XomVjA4Bq9Vzo8OMuxK/ZppNAwcWxGDOhZ2ssNh6/Z
 lLZazpLK7J9gA==
Message-ID: <sashiko-outbox-181891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amd/display: Update colorop pipeline tests for
 new fixed matrix op
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022173655.2318987-4-John.Harrison@Igalia.com>
References: <20261022173655.2318987-1-John.Harrison@Igalia.com>
 <20261022173655.2318987-4-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:50:26 +0000
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
- [Medium] drm/amd/display: undeclared DRM_COLOROP_FIXED_MATRIX breaks KUni=
t test build
--

commit fa1c05a038fce65c050bce3e6d89515560ce7081
Author: John Harrison <John.Harrison@Igalia.com>

drm/amd/display: Update colorop pipeline tests for new fixed matrix op

This commit updates the expected colorop pipeline arrays in the amdgpu_dm
KUnit tests to begin with DRM_COLOROP_FIXED_MATRIX.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_coloro=
p_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_te=
st.c
> index 90cc5592ef5de..00f1d5b33b1f0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
> @@ -192,6 +192,7 @@ static void dm_expect_colorop_pipeline(struct kunit *=
test, struct drm_device *dr
>  static void dm_test_initialize_default_pipeline(struct kunit *test)
>  {
>  	static const enum drm_colorop_type expected[] =3D {
> +		DRM_COLOROP_FIXED_MATRIX,
>  		DRM_COLOROP_1D_CURVE,	/* degam TF */
>  		DRM_COLOROP_MULTIPLIER,
>  		DRM_COLOROP_CTM_3X4,
> @@ -257,6 +258,7 @@ static void dm_test_initialize_default_pipeline_caps(=
struct kunit *test,
>  static void dm_test_initialize_default_pipeline_dpp_3d_lut(struct kunit =
*test)
>  {
>  	static const enum drm_colorop_type expected[] =3D {
> +		DRM_COLOROP_FIXED_MATRIX,
>  		DRM_COLOROP_1D_CURVE,
>  		DRM_COLOROP_MULTIPLIER,
>  		DRM_COLOROP_CTM_3X4,
> @@ -278,6 +280,7 @@ static void dm_test_initialize_default_pipeline_dpp_3=
d_lut(struct kunit *test)
>  static void dm_test_initialize_default_pipeline_mpc_preblend(struct kuni=
t *test)
>  {
>  	static const enum drm_colorop_type expected[] =3D {
> +		DRM_COLOROP_FIXED_MATRIX,
>  		DRM_COLOROP_1D_CURVE,
>  		DRM_COLOROP_MULTIPLIER,
>  		DRM_COLOROP_CTM_3X4,
> @@ -299,6 +302,7 @@ static void dm_test_initialize_default_pipeline_mpc_p=
reblend(struct kunit *test)
>  static void dm_test_initialize_default_pipeline_no_3d_lut(struct kunit *=
test)
>  {
>  	static const enum drm_colorop_type expected[] =3D {
> +		DRM_COLOROP_FIXED_MATRIX,
>  		DRM_COLOROP_1D_CURVE,
>  		DRM_COLOROP_MULTIPLIER,
>  		DRM_COLOROP_CTM_3X4,

[Severity: Medium]
Does this break the build when CONFIG_DRM_AMD_DC_KUNIT_TEST is enabled?

This patch adds DRM_COLOROP_FIXED_MATRIX to the expected[] arrays in
dm_test_initialize_default_pipeline(),
dm_test_initialize_default_pipeline_dpp_3d_lut(),
dm_test_initialize_default_pipeline_mpc_preblend(), and
dm_test_initialize_default_pipeline_no_3d_lut() in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c.

The commit references Fixes: 6d103ad11583 ("drm/amd/display: Add fixed matr=
ix
colorop to color pipeline"), which in turn depends on f6c58e4ae87c
("drm/colorop: Add DRM_COLOROP_FIXED_MATRIX"), but neither commit is present
in this branch.

In include/uapi/drm/drm_mode.h, enum drm_colorop_type does not define
DRM_COLOROP_FIXED_MATRIX:

    enum drm_colorop_type {
            DRM_COLOROP_1D_CURVE,
            DRM_COLOROP_1D_LUT,
            DRM_COLOROP_CTM_3X4,
            DRM_COLOROP_MULTIPLIER,
            DRM_COLOROP_3D_LUT,
    };

In addition, amdgpu_dm_build_default_pipeline() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c still starts the
default pipeline with DRM_COLOROP_1D_CURVE:

    /* 1D curve - DEGAM TF */
    ops[i] =3D colorop_kzalloc_obj();
    if (!ops[i]) {
            ret =3D -ENOMEM;
            goto cleanup;
    }

    ret =3D colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
                                amdgpu_dm_supported_degam_tfs,
                                DRM_COLOROP_FLAG_ALLOW_BYPASS);

Should this patch only be applied to a branch that already contains commits
f6c58e4ae87c and 6d103ad11583?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022173655.2318=
987-1-John.Harrison@Igalia.com?part=3D3
