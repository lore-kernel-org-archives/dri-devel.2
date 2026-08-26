Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16664C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A27610EF65;
	Thu, 27 Aug 2026 09:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="op7pjiAJ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D51E10E895
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
 Content-Type; bh=l2nRAWEMUyhJ+guypkbcFyofsh5sge6XMoQMazS206s=;
 b=op7pjiAJPZ6JS5fHvwSRxByUsar1PULHoHaNydZ2jXAopa8VrAAx8/UFRepnPB
 5sZ07mEL1rAZJU94kbHHnW2k+vFEXBpnBumqpymcMf4dikKOzT/L4lJ+8MU3Qznh
 5pxJnLn25jLbG6ohH11jndDnPbbxjIoWR4p2DHP8l2Swc=
Received: from [IPv6:::1] (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDX3hRlxI5qJbTjPg--.825S2;
 Wed, 26 Aug 2026 18:48:07 +0800 (CST)
Date: Wed, 26 Aug 2026 18:48:03 +0800
From: MYYDAQ <xmmntnbklsa917813@163.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
CC: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tests: document what each drm_format test verifies
User-Agent: K-9 Mail for Android
Message-ID: <DE9CE460-C1A7-4E7E-85BE-AD75EB0D3C23@163.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: _____wDX3hRlxI5qJbTjPg--.825S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3CFyrJrW5CrWfJr4DCr18Grg_yoWDWw13pa
 y2yF98KFs8ta1Fga4UJayDZFW3Kws5Ka4jqry7J3sxtrn8K34IvF4DGF1ayrnxWFyrWwn0
 y3WYkFyDJ3ZFkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrcTPUUUUU=
X-Originating-IP: [2408:8421:ad00:8127:f234:df0b:d07f:46ad]
X-CM-SenderInfo: h0pp03xqenz2jdzrlmirt6il2tof0z/xtbC7QeIEGqOxGeKOwAA3E
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

The drm_format test suite was converted from the former selftests and,
like the other converted suites, its test cases lack any documentation,
making it hard to tell what each test is supposed to verify and whether
it still makes sense as a unit test=2E

Add a comment to every test case explaining what is being tested and
which edge cases are covered, as a first step towards the "Clean up and
document former selftests suites" item in Documentation/gpu/todo=2Erst=2E

No functional changes=2E

Signed-off-by: MYYDAQ <xmmntnbklsa917813@163=2Ecom>
---
 drivers/gpu/drm/tests/drm_format_test=2Ec | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_format_test=2Ec b/drivers/gpu/drm/t=
ests/drm_format_test=2Ec
index 22e2371fd=2E=2E6dcd69890 100644
--- a/drivers/gpu/drm/tests/drm_format_test=2Ec
+++ b/drivers/gpu/drm/tests/drm_format_test=2Ec
@@ -9,6 +9,12 @@
=20
 #include <drm/drm_fourcc=2Eh>
=20
+/*
+ * drm_format_info_block_width() must return 0 for invalid arguments:
+ * a NULL format info, a negative plane index, or a plane index
+ * beyond the number of planes, instead of crashing or returning
+ * garbage=2E
+ */
 static void drm_test_format_block_width_invalid(struct kunit *test)
 {
 	const struct drm_format_info *info =3D NULL;
@@ -18,6 +24,11 @@ static void drm_test_format_block_width_invalid(struct =
kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 1), 0);
 }
=20
+/*
+ * Check the block width of each plane of a single-plane, non-tiled
+ * format (XRGB4444): plane 0 is made of 1x1 blocks, and plane indexes
+ * beyond the number of planes report a width of 0=2E
+ */
 static void drm_test_format_block_width_one_plane(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_XRGB44=
44);
@@ -29,6 +40,11 @@ static void drm_test_format_block_width_one_plane(struc=
t kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
 }
=20
+/*
+ * Check the block width of each plane of a two-plane, non-tiled
+ * format (NV12): both planes are made of 1x1 blocks, and plane
+ * indexes beyond the number of planes report a width of 0=2E
+ */
 static void drm_test_format_block_width_two_plane(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_NV12);
@@ -41,6 +57,11 @@ static void drm_test_format_block_width_two_plane(struc=
t kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
 }
=20
+/*
+ * Check the block width of each plane of a three-plane, non-tiled
+ * format (YUV422): all three planes are made of 1x1 blocks, and plane
+ * indexes beyond the number of planes report a width of 0=2E
+ */
 static void drm_test_format_block_width_three_plane(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_YUV422=
);
@@ -54,6 +75,11 @@ static void drm_test_format_block_width_three_plane(str=
uct kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
 }
=20
+/*
+ * Check the block width of a tiled format (X0L0), whose pixels are
+ * stored in 2x2 blocks: plane 0 reports a width of 2, and plane
+ * indexes beyond the number of planes report a width of 0=2E
+ */
 static void drm_test_format_block_width_tiled(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_X0L0);
@@ -65,6 +91,12 @@ static void drm_test_format_block_width_tiled(struct ku=
nit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, -1), 0);
 }
=20
+/*
+ * drm_format_info_block_height() must return 0 for invalid arguments:
+ * a NULL format info, a negative plane index, or a plane index
+ * beyond the number of planes, instead of crashing or returning
+ * garbage=2E
+ */
 static void drm_test_format_block_height_invalid(struct kunit *test)
 {
 	const struct drm_format_info *info =3D NULL;
@@ -74,6 +106,11 @@ static void drm_test_format_block_height_invalid(struc=
t kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 1), 0);
 }
=20
+/*
+ * Check the block height of each plane of a single-plane, non-tiled
+ * format (XRGB4444): plane 0 is made of 1x1 blocks, and plane indexes
+ * beyond the number of planes report a height of 0=2E
+ */
 static void drm_test_format_block_height_one_plane(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_XRGB44=
44);
@@ -85,6 +122,11 @@ static void drm_test_format_block_height_one_plane(str=
uct kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 1), 0);
 }
=20
+/*
+ * Check the block height of each plane of a two-plane, non-tiled
+ * format (NV12): both planes are made of 1x1 blocks, and plane
+ * indexes beyond the number of planes report a height of 0=2E
+ */
 static void drm_test_format_block_height_two_plane(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_NV12);
@@ -97,6 +139,11 @@ static void drm_test_format_block_height_two_plane(str=
uct kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
 }
=20
+/*
+ * Check the block height of each plane of a three-plane, non-tiled
+ * format (YUV422): all three planes are made of 1x1 blocks, and plane
+ * indexes beyond the number of planes report a height of 0=2E
+ */
 static void drm_test_format_block_height_three_plane(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_YUV422=
);
@@ -110,6 +157,11 @@ static void drm_test_format_block_height_three_plane(=
struct kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
 }
=20
+/*
+ * Check the block height of a tiled format (X0L0), whose pixels are
+ * stored in 2x2 blocks: plane 0 reports a height of 2, and plane
+ * indexes beyond the number of planes report a height of 0=2E
+ */
 static void drm_test_format_block_height_tiled(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_X0L0);
@@ -121,6 +173,12 @@ static void drm_test_format_block_height_tiled(struct=
 kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, -1), 0);
 }
=20
+/*
+ * drm_format_info_min_pitch() must return 0 for invalid arguments:
+ * a NULL format info, a negative plane index, or a plane index
+ * beyond the number of planes, instead of crashing or returning
+ * garbage=2E
+ */
 static void drm_test_format_min_pitch_invalid(struct kunit *test)
 {
 	const struct drm_format_info *info =3D NULL;
@@ -130,6 +188,11 @@ static void drm_test_format_min_pitch_invalid(struct =
kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 0), 0);
 }
=20
+/*
+ * Check the minimum pitch of the single 8-bits-per-pixel plane of
+ * RGB332: one byte per pixel for any width, including odd widths
+ * which must not be rounded, up to the UINT_MAX boundary=2E
+ */
 static void drm_test_format_min_pitch_one_plane_8bpp(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_RGB332=
);
@@ -153,6 +216,11 @@ static void drm_test_format_min_pitch_one_plane_8bpp(=
struct kunit *test)
 			(uint64_t)(UINT_MAX - 1));
 }
=20
+/*
+ * Check the minimum pitch of the single 16-bits-per-pixel plane of
+ * XRGB4444: two bytes per pixel for any width, including odd widths
+ * which must not be rounded, up to the UINT_MAX boundary=2E
+ */
 static void drm_test_format_min_pitch_one_plane_16bpp(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_XRGB44=
44);
@@ -176,6 +244,11 @@ static void drm_test_format_min_pitch_one_plane_16bpp=
(struct kunit *test)
 			(uint64_t)(UINT_MAX - 1) * 2);
 }
=20
+/*
+ * Check the minimum pitch of the single 24-bits-per-pixel plane of
+ * RGB888: three bytes per pixel for any width, including odd widths
+ * which must not be rounded, up to the UINT_MAX boundary=2E
+ */
 static void drm_test_format_min_pitch_one_plane_24bpp(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_RGB888=
);
@@ -199,6 +272,11 @@ static void drm_test_format_min_pitch_one_plane_24bpp=
(struct kunit *test)
 			(uint64_t)(UINT_MAX - 1) * 3);
 }
=20
+/*
+ * Check the minimum pitch of the single 32-bits-per-pixel plane of
+ * ABGR8888: four bytes per pixel for any width, including odd widths
+ * which must not be rounded, up to the UINT_MAX boundary=2E
+ */
 static void drm_test_format_min_pitch_one_plane_32bpp(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_ABGR88=
88);
@@ -222,6 +300,12 @@ static void drm_test_format_min_pitch_one_plane_32bpp=
(struct kunit *test)
 			(uint64_t)(UINT_MAX - 1) * 4);
 }
=20
+/*
+ * Check the minimum pitch of both planes of NV12: the first plane
+ * stores one byte per pixel, the second stores two bytes per pixel,
+ * odd widths must not be rounded, and chroma subsampling is not
+ * taken into account=2E
+ */
 static void drm_test_format_min_pitch_two_plane(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_NV12);
@@ -257,6 +341,11 @@ static void drm_test_format_min_pitch_two_plane(struc=
t kunit *test)
 			(uint64_t)(UINT_MAX - 1));
 }
=20
+/*
+ * Check the minimum pitch of all three planes of YUV422, where each
+ * plane stores one byte per pixel: odd widths must not be rounded and
+ * chroma subsampling is not taken into account=2E
+ */
 static void drm_test_format_min_pitch_three_plane_8bpp(struct kunit *test=
)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_YUV422=
);
@@ -304,6 +393,12 @@ static void drm_test_format_min_pitch_three_plane_8bp=
p(struct kunit *test)
 			(uint64_t)(UINT_MAX - 1) / 2);
 }
=20
+/*
+ * Check the minimum pitch of a tiled format (X0L2), which stores
+ * 8 bytes in 2x2 pixel blocks: two bytes per pixel for any width,
+ * including odd widths which must not be rounded, up to the UINT_MAX
+ * boundary=2E
+ */
 static void drm_test_format_min_pitch_tiled(struct kunit *test)
 {
 	const struct drm_format_info *info =3D drm_format_info(DRM_FORMAT_X0L2);

