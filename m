Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3ABC624C8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC8B10E68C;
	Mon, 31 Aug 2026 07:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="ZKC61E0H";
	dkim-atps=neutral
X-Greylist: delayed 513 seconds by postgrey-1.36 at gabe;
 Sun, 30 Aug 2026 04:00:27 UTC
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE1F10E049;
 Sun, 30 Aug 2026 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1788061924; x=1788321124;
 bh=jnji4+6IgYi4Ks1u6FUqTfrHf09mB52dg2/DurOipCQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZKC61E0HlqSWJ/6DatUJJrWJULEPaw7xB/kSMwT+Bnl01LVekS07P5pXxxH3KJmnA
 TLs5O0qHkF1iYlW3gGXEkveaUF6P2t/o9KLAL9mQ/zuNDw0Hn33bQiRE9URPFLEyss
 40CraMSOPVYFairLWKGdDNCqP19wdalwamb30E5zcjDzGnPhU1t1vtThkOuSpm8C9U
 H1g7VriwxqctPMKF4zaAjFJBiBcROPsl94k3jxLXzYgd2ELp4WO2w2iD2C68EFWbPp
 KIsPa7TIyaQn8PZC/iMhtB4opoZZ6MVaQWfNfwzKcYI36rzwlLbtbsO4yB//EAgyeT
 /FPaW8Fks6jXg==
Date: Sun, 30 Aug 2026 03:51:58 +0000
To: amd-gfx@lists.freedesktop.org
From: Satyajit Roy <edu042sjroy@proton.me>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, jerry.zuo@amd.com, wayne.lin@amd.com, yan.li@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Satyajit Roy <sroy14@alum.utk.edu>
Subject: [PATCH 1/3] drm/amd/display: Propagate HDMI RGB quantization
 selectability
Message-ID: <20260830035120.937992-2-edu042sjroy@proton.me>
In-Reply-To: <20260830035120.937992-1-edu042sjroy@proton.me>
References: <20260830035120.937992-1-edu042sjroy@proton.me>
Feedback-ID: 147615787:user:proton
X-Pm-Message-ID: f4cf8d134f4afb49c85062f7dec4c0287be81f1e
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

DC uses dc_edid_caps.qs_bit when constructing the HDMI AVI InfoFrame
quantization-range field. Although DRM parses the sink capability into
drm_display_info, DM never copies it into the DC EDID capabilities. The
field therefore remains zero and the AVI quantization range stays at its
default value.

Copy rgb_quant_range_selectable for HDMI sinks and extend the existing
EDID-capability KUnit test to cover it.

Fixes: 6eb4c13a3845 ("drm/amd/display: Support "Broadcast RGB" drm property=
")
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c       | 1 +
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ab15ceec4da..e49a8dda512 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -218,6 +218,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 =09edid_caps->edid_hdmi =3D connector->display_info.is_hdmi;
=20
 =09if (edid_caps->edid_hdmi) {
+=09=09edid_caps->qs_bit =3D connector->display_info.rgb_quant_range_select=
able;
 =09=09populate_hdmi_info_from_connector(link->dc->config.enable_frl, &conn=
ector->display_info.hdmi, edid_caps);
 =09=09drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n"=
, __func__, connector->name, edid_caps->max_frl_rate);
 =09=09if (edid_caps->frl_dsc_support)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_=
test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test=
.c
index d4232648d8e..b13f258740c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -412,12 +412,14 @@ static void dm_test_parse_edid_caps_hdmi_frl(struct k=
unit *test)
=20
 =09/* Drive the HDMI/FRL branch */
 =09connector->display_info.is_hdmi =3D true;
+=09connector->display_info.rgb_quant_range_selectable =3D true;
 =09connector->display_info.hdmi.scdc.supported =3D true;
 =09connector->display_info.hdmi.max_lanes =3D 4;
 =09connector->display_info.hdmi.max_frl_rate_per_lane =3D 12;
=20
 =09KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_ca=
ps), EDID_OK);
 =09KUNIT_EXPECT_TRUE(test, edid_caps->edid_hdmi);
+=09KUNIT_EXPECT_EQ(test, edid_caps->qs_bit, 1);
 =09KUNIT_EXPECT_TRUE(test, edid_caps->scdc_present);
 =09/* max_lanes 4 + max_frl_rate_per_lane 12 -> rate index 6 */
 =09KUNIT_EXPECT_EQ(test, edid_caps->max_frl_rate, 6);
--=20
2.51.1


