Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C68C79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1C710EA05;
	Tue,  8 Sep 2026 04:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SY93NckR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C6F10E9F1;
 Tue,  8 Sep 2026 04:54:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDDF1439EF;
 Tue,  8 Sep 2026 04:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4491F00A3A;
 Tue,  8 Sep 2026 04:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843263;
 bh=qUhEYulvPQUHTo9RKiqAEKWwTZq/0mZB5095bksuuK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SY93NckRLDSm83NaRT4d4lyC20eqTBNbDViFN+vtrzkF3WVHQ/nrJvhKLH4U0Xii2
 CPvUVf0zoFtHo7dxGDIfE+UGh79omHr3hmqpB9AX6wKt9pPV2K6H1t6tCKPTHkk4Km
 bG0Qjg80VAbcaOXk8tyibu/7T23E18AACyLmO6ZQIOrDP/Jxnntc6x+AEBbd9uUGyn
 zrlTBbHHJe+pJGogouT+Xf977HXvOlHMG7SNCqwy1skGv5TrBM9dbNBFZMo1o0CY1a
 NzzHnfnJG7J6q1X5RhrrLHrsHD+1eIuzzuRpX/JY9dag6aNIiUYx1URKqv2fd9GtNj
 iQ+eX7v3zC2QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/14] drm/amd/display: Update KUnit backlight tests
 for luminance property and fixtures
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-11-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:54:23 +0000
Message-Id: <20260908045423.7B4491F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Mock connectors bypass standard DRM initialization, leading to mis=
sing cleanup and leaving dangling pointers on the global `drm_backlight_lis=
t`.
- [Medium] Double initialization of `mode_config` via `drmm_mode_config_ini=
t()` overwrites lists, leaks DRM standard properties, and double-registers =
cleanup actions.
--

commit a56dca4aad815c6c0a1a6a861da4fc03fba94e83
Author: Mario Limonciello (AMD) <superm1@kernel.org>

    drm/amd/display: Update KUnit backlight tests for luminance property an=
d fixtures

    Initialize backlight connector state and display manager dc_lock in
    KUnit connector and adev allocators, and update property count
    expectations in tests to account for the newly attached LUMINANCE prope=
rty.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backli=
ght_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c
> index e03173d4e5bd8..c5f65e9a90ca8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> @@ -52,6 +52,7 @@ static void setup_test_connector(struct kunit *test,
>  	fixture->aconnector->dc_link =3D fixture->link;
>  	fixture->aconnector->base.dev =3D &fixture->adev->ddev;
>  	fixture->link->connector_signal =3D signal;
> +	drm_backlight_connector_init(&fixture->aconnector->base);
>  }

[Severity: High]
Does this bypass standard DRM initialization? By manually initializing the
backlight fields here (and in dm_kunit_alloc_connector()) without registeri=
ng
a standard DRM lifecycle cleanup action, the mock connector avoids
drm_connector_cleanup().=20

When tests like dm_test_register_backlight_device_success() later call
amdgpu_dm_register_backlight_device() and link it into drm_backlight_list, =
does
the lack of cleanup leave a dangling pointer on the global list after the K=
Unit
test finishes and frees the mock connector?

[ ... ]
> @@ -483,12 +484,17 @@ static void dm_test_register_backlight_device_succe=
ss(struct kunit *test)
>  	struct dc_link *link =3D dm_kunit_alloc_link(test);
>  	struct drm_minor *primary;
>  	unsigned int max;
> +	int ret;
> +
> +	ret =3D drmm_mode_config_init(&adev->ddev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Medium]
Is this call to drmm_mode_config_init() redundant and potentially harmful?

The DRM device adev is allocated via dm_kunit_alloc_adev(), which uses
__drm_kunit_helper_alloc_drm_device() with DRIVER_MODESET. This implies
the mode config is already initialized. Calling it again zeroes out lists
like property_list (using INIT_LIST_HEAD) without freeing previously
allocated standard properties, which leads to a memory leak.=20

Furthermore, does it register a duplicate drm_mode_config_init_release acti=
on,
leading to double teardown attempts on the same structures?

A similarly problematic duplicate call also appears to be present in
dm_test_setup_backlight_device_attaches_abm_property().

[ ... ]
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_=
helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_hel=
pers.c
> index aad122c7229f5..ed5045c948fe9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers=
.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers=
.c
[ ... ]
> @@ -172,6 +177,7 @@ struct amdgpu_dm_connector *dm_kunit_alloc_connector(=
struct kunit *test,
>  	if (adev)
>  		aconnector->base.dev =3D &adev->ddev;
>  	aconnector->dc_link =3D link;
> +	drm_backlight_connector_init(&aconnector->base);
> =20
>  	return aconnector;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D10
