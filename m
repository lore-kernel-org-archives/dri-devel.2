Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067C6C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4691510E678;
	Mon, 31 Aug 2026 07:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="QQeQgUVS";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F9410E0FE
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 03:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=5jyqa2t64jfz7j3mddw2j2si6q.protonmail; t=1788061929; x=1788321129;
 bh=ZalboOQlaRdM07h0DCHOooTZyMCDymSdS7Ibwrc+ZOA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=QQeQgUVSbsRZ/Pr60TiLr0vFvhdHoXGuDMyKAvBEEHlFJ2CGnEt1r5+I0//6PrkuP
 xJFZILNCeTjoiqf0wl4sGr8iFeL0v6Q3mz21wgdQLGUbs6LicYDhUImfg1bnSE+PMg
 8KSzx5Wpb29GADdvpQdlfWvSl/v0ETbYPkb9K433f19pIhF6/AJKuPxhsRruUC3JEh
 IJYMwcXGF+142eFmxwdiPk+g1XmO0kG6qjf/p2PrCx/VK/HUmUozrg9CkynfkUQRnE
 WkGkR8fPS4JB+W5MlbLx1QSalu7JYtHE8CsS+jbJqAbLD1zPRA4cYOtex2jxYsc6oi
 /bk7h1sfbCuqQ==
Date: Sun, 30 Aug 2026 03:52:06 +0000
To: amd-gfx@lists.freedesktop.org
From: Satyajit Roy <edu042sjroy@proton.me>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, jerry.zuo@amd.com, wayne.lin@amd.com, yan.li@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Satyajit Roy <sroy14@alum.utk.edu>
Subject: [PATCH 2/3] drm/amd/display: Honor Broadcast RGB for BT.2020 RGB
 output
Message-ID: <20260830035120.937992-3-edu042sjroy@proton.me>
In-Reply-To: <20260830035120.937992-1-edu042sjroy@proton.me>
References: <20260830035120.937992-1-edu042sjroy@proton.me>
Feedback-ID: 147615787:user:proton
X-Pm-Message-ID: 1a25c08e6bc2c6a214d24d3c36fb934063f828a2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Satyajit Roy <sroy14@alum.utk.edu>

amdgpu_dm_get_output_color_space() applies the Broadcast RGB connector
property to default RGB output, but always selects full-range output for
BT.2020 RGB. Consequently, explicitly selecting Limited has no effect on
the output CSC or AVI InfoFrame when HDR uses BT.2020 RGB.

Select COLOR_SPACE_2020_RGB_LIMITEDRANGE when the output encoding is RGB
and Broadcast RGB is Limited. Keep Automatic and Full at full range, and
leave YCbCr output unchanged.

Add KUnit coverage for limited-range RGB output through both BT.2020
connector colorspace values.

Fixes: 6eb4c13a3845 ("drm/amd/display: Support "Broadcast RGB" drm property=
")
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 10 +++--
 .../tests/amdgpu_dm_connector_test.c          | 37 +++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 8a35e4df13c..f2f6a2a0db9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -758,10 +758,14 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc=
_timing *dc_crtc_timing,
 =09=09break;
 =09case DRM_MODE_COLORIMETRY_BT2020_RGB:
 =09case DRM_MODE_COLORIMETRY_BT2020_YCC:
-=09=09if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB)
-=09=09=09color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
-=09=09else
+=09=09if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB) {
+=09=09=09if (connector_state->hdmi.broadcast_rgb =3D=3D DRM_HDMI_BROADCAST=
_RGB_LIMITED)
+=09=09=09=09color_space =3D COLOR_SPACE_2020_RGB_LIMITEDRANGE;
+=09=09=09else
+=09=09=09=09color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
+=09=09} else {
 =09=09=09color_space =3D COLOR_SPACE_2020_YCBCR_LIMITED;
+=09=09}
 =09=09break;
 =09case DRM_MODE_COLORIMETRY_DEFAULT: /* ITU601 */
 =09default:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connecto=
r_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_=
test.c
index 76334fb840d..29bbe9f7826 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.=
c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.=
c
@@ -570,6 +570,23 @@ static void dm_test_output_color_space_bt2020_rgb(stru=
ct kunit *test)
 =09=09=09(int)COLOR_SPACE_2020_RGB_FULLRANGE);
 }
=20
+/**
+ * dm_test_output_color_space_bt2020_rgb_limited - Test limited BT.2020 RG=
B
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_bt2020_rgb_limited(struct kunit *te=
st)
+{
+=09struct dc_crtc_timing timing =3D {};
+=09struct drm_connector_state state =3D {};
+
+=09timing.pixel_encoding =3D PIXEL_ENCODING_RGB;
+=09state.colorspace =3D DRM_MODE_COLORIMETRY_BT2020_RGB;
+=09state.hdmi.broadcast_rgb =3D DRM_HDMI_BROADCAST_RGB_LIMITED;
+
+=09KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &s=
tate),
+=09=09=09(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
+}
+
 /**
  * dm_test_output_color_space_bt2020_ycc - Test Output color space bt2020 =
ycc
  * @test: The KUnit test context
@@ -641,6 +658,24 @@ static void dm_test_output_color_space_bt2020_ycc_rgb_=
encoding(struct kunit *tes
 =09=09=09(int)COLOR_SPACE_2020_RGB_FULLRANGE);
 }
=20
+/**
+ * dm_test_output_color_space_bt2020_ycc_rgb_encoding_limited - Test limit=
ed
+ * BT.2020 RGB output selected through the BT.2020 YCC connector colorspac=
e
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_bt2020_ycc_rgb_encoding_limited(str=
uct kunit *test)
+{
+=09struct dc_crtc_timing timing =3D {};
+=09struct drm_connector_state state =3D {};
+
+=09timing.pixel_encoding =3D PIXEL_ENCODING_RGB;
+=09state.colorspace =3D DRM_MODE_COLORIMETRY_BT2020_YCC;
+=09state.hdmi.broadcast_rgb =3D DRM_HDMI_BROADCAST_RGB_LIMITED;
+
+=09KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &s=
tate),
+=09=09=09(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
+}
+
 /**
  * dm_test_output_color_space_bt2020_rgb_ycc_encoding - Test Output color =
space
  * bt2020 rgb with non-rgb pixel encoding falls back to limited ycbcr
@@ -8409,10 +8444,12 @@ static struct kunit_case amdgpu_dm_connector_tests[=
] =3D {
 =09KUNIT_CASE(dm_test_output_color_space_bt709_y_only),
 =09KUNIT_CASE(dm_test_output_color_space_oprgb),
 =09KUNIT_CASE(dm_test_output_color_space_bt2020_rgb),
+=09KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_limited),
 =09KUNIT_CASE(dm_test_output_color_space_bt2020_ycc),
 =09KUNIT_CASE(dm_test_output_color_space_default_ycbcr709_y_only),
 =09KUNIT_CASE(dm_test_output_color_space_default_ycbcr601),
 =09KUNIT_CASE(dm_test_output_color_space_bt2020_ycc_rgb_encoding),
+=09KUNIT_CASE(dm_test_output_color_space_bt2020_ycc_rgb_encoding_limited),
 =09KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_ycc_encoding),
 =09/* Tests for amdgpu_dm_convert_dc_color_depth_into_bpc */
 =09KUNIT_CASE(dm_test_convert_color_depth_bpc_mappings),
--=20
2.51.1


