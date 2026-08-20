Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A277C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4C710F05D;
	Thu, 20 Aug 2026 14:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iwLrL5fZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C227410F05D
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:38:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 911D141431;
 Thu, 20 Aug 2026 14:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613601F000E9;
 Thu, 20 Aug 2026 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787236729;
 bh=OXwwdQDxjbn0oOkoZXEiWu35gCbdHOo6rC8tDyff51g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iwLrL5fZsmVAcSTAIu/W0DXwanQnU2X7GWkEJ+xFOivRwPzGItCGzdHA36IuCbRiE
 W/NjvRGaiLwqlUrRaVp9tFrdsOCRsk6B3uZSs4ImEF1m6niYOj3fb4w7l6cthIHi55
 BbmXQBytg72Cjzye3VLnHF2qL/SR0qX9TiSQD5UbQRRr83yi7o/ZalD8pcHu2KKaPL
 XR5WLgZSqN0rMMarM7m6JEYxuDiWiCdylRvHrmyG2KAJPzS0jUA0iHwuh3w4kkoFvE
 hVVoPhSEo/w8sa3wXGD4F740ghg4zjs1hnO//AUZh/jHr2YpCaS320QKkQV3XmdvFB
 OXAxu/78hN8zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:38:49 +0000
Message-Id: <20260820143849.613601F000E9@smtp.kernel.org>
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
- [Medium] Erroneous deletion of active test coverage and prototype causing=
 a compiler warning. The patch removes the KUnit tests and header declarati=
on for `parse_hdmi_amd_vsdb()` based on the incorrect assumption that the f=
unction was removed by commit `f65198b3d073`. However, `f65198b3d073` is no=
t present in the baseline tree. As a result, `parse_hdmi_amd_vsdb()` remain=
s fully implemented and actively used by `amdgpu_dm_update_freesync_caps()`=
. Applying this patch deletes valid test coverage for an active code path. =
Additionally, because the function uses the `STATIC_IFN_KUNIT` macro (makin=
g it global when KUnit is enabled), removing its prototype from the header =
triggers a `-Wmissing-prototypes` compiler warning.
--

--- Patch [1]: [PATCH] drm/amd/display: Drop KUnit tests for removed parse_=
hdmi_amd_vsdb() ---
commit 9e04fb9539ed0ab6b97c5e730b64224c40a317f4
Author: Rodrigo Vivi <rodrigo.vivi@intel.com>

drm/amd/display: Drop KUnit tests for removed parse_hdmi_amd_vsdb()

This commit removes the declaration and KUnit tests for
parse_hdmi_amd_vsdb(), stating that the function was previously removed.

Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from common =
EDID parser")
Cc: Alex Huang <Alex.Huang2@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Assisted-by: Copilot:Claude-Opus-5
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> index 4e9eb3ff2c904..ce900844602e5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> @@ -153,9 +153,6 @@ void parse_edid_displayid_vrr(struct drm_connector *c=
onnector,
>  			      const struct edid *edid);
>  int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>  		 struct amdgpu_hdmi_vsdb_info *vsdb_info);
> -int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> -			const struct edid *edid,
> -			struct amdgpu_hdmi_vsdb_info *vsdb_info);

[Severity: Medium]
Is this function actually removed in the current tree?

The commit message states parse_hdmi_amd_vsdb() was removed by f65198b3d073,
but it appears that commit is not present in the baseline tree.

Looking at drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c,=20
parse_hdmi_amd_vsdb() is still fully implemented and actively called by=20
amdgpu_dm_update_freesync_caps():

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c:amdgpu_dm_updat=
e_freesync_caps() {
    ...
    i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
    ...
}

Since parse_hdmi_amd_vsdb() is defined using STATIC_IFN_KUNIT (which makes
it a global function when KUnit is enabled), removing its prototype here
triggers a -Wmissing-prototypes compiler warning during KUnit builds.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connec=
tor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connecto=
r_test.c
> index a54fd9529dc9e..83d3be5432028 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_tes=
t.c
> @@ -4874,75 +4874,6 @@ static void dm_test_get_amd_vsdb_supported(struct =
kunit *test)
>  	KUNIT_EXPECT_TRUE(test, vsdb_info.replay_mode);
>  }
> =20
> -/**
> - * dm_test_parse_hdmi_amd_vsdb_null_edid - Test NULL EDID returns -ENODEV
> - * @test: The KUnit test context
> - */
> -static void dm_test_parse_hdmi_amd_vsdb_null_edid(struct kunit *test)

[Severity: Medium]
Because parse_hdmi_amd_vsdb() is still present and used, does removing
these tests prematurely delete valid test coverage for an active code path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820142802.1342=
066-2-rodrigo.vivi@intel.com?part=3D1
