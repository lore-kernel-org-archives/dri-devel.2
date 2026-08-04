Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEADC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D1210EBBE;
	Tue,  4 Aug 2026 20:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="N+nlgbZV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF2D10EBBE
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875761;
 bh=biQaoLSddBbDchmIwrhUIoOHw5mxDbpE5X+xUrX4uRE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N+nlgbZV1f0E/yMNo3n/TB5YqxbJkQHHLlMf1VBTOeWX93KsJvrtdCaIuR5DhfPFB
 /CoJ+MP06mSHoFRbncoC+CpbToo2XlIjq6IriBFW4p/zFGlzIlBxSq1vSTbErakwYM
 Klm90ExCRh+LlI6vnWTN8CYm+p8h+EFa/J7ZHEgHagvoUM0JPfC0HJTAW76PMeQLjH
 uuMsNMDGHjveKc8r4yklOtwuxCkOVkYj1TJKJ/ip7zMZFvXBlBl1g1YIakA/qrXkbM
 /1sQTWcpHmH0LIdDL/oclhjCSJXgnSQ0773qJhif4I4uKcYQm3WV/EnVo79khbJVWC
 j3np02UkK8Q7g==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1016017E0235;
 Tue, 04 Aug 2026 22:35:56 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] drm/vkms: add support to non-uniform LUT for internal
 color curves
Date: Tue,  4 Aug 2026 17:33:48 -0300
Message-ID: <20260804203351.148521-9-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This extends VKMS internal LUT implementation, allowing it to represent
non-uniform LUTs.

Such LUTs have the X axis. LUTs that come from userspace (gamma LUT) are
always uniform, so they don't have a X axis.

Note: vkms_color_srgb_inv_srgb() error tolerance reduced from 1/255 to
119/65535 ~= 0.46/255. Before this patch, the test compared the results
after quantizing them to 8-bit precision, while the updated test
compares directly in 16-bit. The LUT precision does not change with this
patch.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c | 20 +----
 drivers/gpu/drm/vkms/vkms_composer.c         | 85 ++++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h              |  9 +++
 drivers/gpu/drm/vkms/vkms_luts.c             | 57 +++++++++++--
 4 files changed, 139 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index bb9d84377b97..571b1b579310 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
@@ -98,19 +98,6 @@ static void vkms_color_test_get_uniform_lut_index(struct kunit *test)
 		lut_index = get_uniform_lut_index(&test_linear_lut, test_linear_array[i].red);
 		KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(lut_index), i);
 	}
-
-	KUNIT_EXPECT_EQ(test, drm_fixp2int(get_uniform_lut_index(&srgb_eotf, 0x0)), 0x0);
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0x0)), 0x0);
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0x101)), 0x1);
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0x202)), 0x2);
-
-	KUNIT_EXPECT_EQ(test, drm_fixp2int(get_uniform_lut_index(&srgb_inv_eotf, 0x0)), 0x0);
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_inv_eotf, 0x0)), 0x0);
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_inv_eotf, 0x101)), 0x1);
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_inv_eotf, 0x202)), 0x2);
-
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0xfefe)), 0xfe);
-	KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(get_uniform_lut_index(&srgb_eotf, 0xffff)), 0xff);
 }
 
 static void vkms_color_test_lerp(struct kunit *test)
@@ -136,13 +123,14 @@ static void vkms_color_test_linear(struct kunit *test)
 static void vkms_color_srgb_inv_srgb(struct kunit *test)
 {
 	u16 srgb, final;
+	u16 tolerance = 119;
 
 	for (int i = 0; i < srgb_eotf.lut_length; i++) {
-		srgb = apply_lut_to_channel_value(&srgb_eotf, i * 0x101, LUT_RED);
+		srgb = apply_lut_to_channel_value(&srgb_eotf, srgb_eotf.x[i], LUT_RED);
 		final = apply_lut_to_channel_value(&srgb_inv_eotf, srgb, LUT_RED);
 
-		KUNIT_EXPECT_GE(test, final / 0x101, i - 1);
-		KUNIT_EXPECT_LE(test, final / 0x101, i + 1);
+		KUNIT_EXPECT_GE(test, final, (int)srgb_eotf.x[i] - tolerance);
+		KUNIT_EXPECT_LE(test, final, (int)srgb_eotf.x[i] + tolerance);
 	}
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 1a5e899e5b4a..4ae1ffd31406 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -93,27 +93,81 @@ static inline u16 lut_channel_value(const struct drm_color_lut *lut,
 	return 0;
 }
 
+static u16 apply_non_uniform_lut(const struct vkms_color_lut *lut,
+				 u16 channel_value,
+				 enum lut_channel channel)
+{
+	const struct drm_color_lut *lut_y_lo, *lut_y_hi;
+	u16 y_lo, y_hi;
+	u16 x_lo, x_hi;
+	unsigned int lo, hi, mid;
+	s64 t;
+
+	/*
+	 * Handle values out of LUT domain.
+	 */
+	if (channel_value <= lut->x[0])
+		return lut_channel_value(&lut->y[0], channel);
+	if (channel_value >= lut->x[lut->lut_length - 1])
+		return lut_channel_value(&lut->y[lut->lut_length - 1], channel);
+
+	/*
+	 * Binary search to find the largest index lo such that
+	 * x[lo] <= channel_value.
+	 */
+	lo = 0;
+	hi = lut->lut_length - 1;
+	while (lo < hi) {
+		mid = lo + (hi - lo + 1) / 2;
+		if (lut->x[mid] <= channel_value)
+			lo = mid;
+		else
+			hi = mid - 1;
+	}
+	lut_y_lo = &lut->y[lo];
+
+	/*
+	 * As x[0] < channel_value < x[lut_length - 1] and
+	 * x[lo] <= channel_value, lo + 1 is a valid index.
+	 */
+	lut_y_hi = &lut->y[lo + 1];
+
+	x_lo = lut->x[lo];
+	x_hi = lut->x[lo + 1];
+	y_lo = lut_channel_value(lut_y_lo, channel);
+	y_hi = lut_channel_value(lut_y_hi, channel);
+
+	/* Avoid division by zero when two consecutive x values are equal. */
+	if (x_hi == x_lo)
+		return y_lo;
+
+	t = drm_fixp_div(drm_int2fixp(channel_value - x_lo),
+			 drm_int2fixp(x_hi - x_lo));
+
+	return lerp_u16(y_lo, y_hi, t);
+}
+
 VISIBLE_IF_KUNIT s64 get_uniform_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
 {
 	s64 color_channel_fp = drm_int2fixp(channel_value);
 
+	if (lut->x) {
+		DRM_DEBUG_DRIVER("Non-uniform LUT should not use get_uniform_lut_index()");
+		return 0;
+	}
+
 	return drm_fixp_mul(color_channel_fp, lut->channel_value2index_ratio);
 }
 EXPORT_SYMBOL_IF_KUNIT(get_uniform_lut_index);
 
-VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 channel_value,
-						enum lut_channel channel)
+static u16 apply_uniform_lut(const struct vkms_color_lut *lut,
+			     u16 channel_value,
+			     enum lut_channel channel)
 {
 	const struct drm_color_lut *lut_y_floor, *lut_y_ceil;
 	s64 lut_index = get_uniform_lut_index(lut, channel_value);
 	u16 floor_channel_value, ceil_channel_value;
 
-	/*
-	 * This checks if `struct drm_color_lut` has any gap added by the compiler
-	 * between the struct fields.
-	 */
-	static_assert(sizeof(struct drm_color_lut) == sizeof(__u16) * 4);
-
 	lut_y_floor = &lut->y[drm_fixp2int(lut_index)];
 	if (drm_fixp2int(lut_index) == (lut->lut_length - 1))
 		/* We're at the end of the LUT array, use same value for ceil and floor */
@@ -127,6 +181,21 @@ VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut
 	return lerp_u16(floor_channel_value, ceil_channel_value,
 			lut_index & DRM_FIXED_DECIMAL_MASK);
 }
+
+VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 channel_value,
+						enum lut_channel channel)
+{
+	/*
+	 * This checks if `struct drm_color_lut` has any gap added by the compiler
+	 * between the struct fields.
+	 */
+	static_assert(sizeof(struct drm_color_lut) == sizeof(__u16) * 4);
+
+	if (lut->x)
+		return apply_non_uniform_lut(lut, channel_value, channel);
+
+	return apply_uniform_lut(lut, channel_value, channel);
+}
 EXPORT_SYMBOL_IF_KUNIT(apply_lut_to_channel_value);
 
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 55a3ea184e44..be81844dfd22 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -158,7 +158,16 @@ struct vkms_plane {
 	struct drm_plane base;
 };
 
+/**
+ * struct vkms_color_lut - Driver specific color LUT representation
+ * @x: LUT x-values, must be non-decreasing and may be non-uniformly spaced.
+ *     Only required for non-uniform LUTs.
+ * @y: LUT y-values.
+ * @lut_length: The LUT length.
+ * @channel_value2index_ratio: helper for uniform LUTs (no x-values).
+ */
 struct vkms_color_lut {
+	u16 *x;
 	struct drm_color_lut *y;
 	size_t lut_length;
 	s64 channel_value2index_ratio;
diff --git a/drivers/gpu/drm/vkms/vkms_luts.c b/drivers/gpu/drm/vkms/vkms_luts.c
index 7b0c8eaf83b8..c2d5f9e502ae 100644
--- a/drivers/gpu/drm/vkms/vkms_luts.c
+++ b/drivers/gpu/drm/vkms/vkms_luts.c
@@ -12,7 +12,42 @@
  * https://gitlab.freedesktop.org/hwentland/lutgen
  */
 
-static struct drm_color_lut srgb_array[] = {
+static u16 linear_x[] = {
+	0x0000, 0x0101, 0x0202, 0x0303, 0x0404, 0x0505, 0x0606, 0x0707,
+	0x0808, 0x0909, 0x0a0a, 0x0b0b, 0x0c0c, 0x0d0d, 0x0e0e, 0x0f0f,
+	0x1010, 0x1111, 0x1212, 0x1313, 0x1414, 0x1515, 0x1616, 0x1717,
+	0x1818, 0x1919, 0x1a1a, 0x1b1b, 0x1c1c, 0x1d1d, 0x1e1e, 0x1f1f,
+	0x2020, 0x2121, 0x2222, 0x2323, 0x2424, 0x2525, 0x2626, 0x2727,
+	0x2828, 0x2929, 0x2a2a, 0x2b2b, 0x2c2c, 0x2d2d, 0x2e2e, 0x2f2f,
+	0x3030, 0x3131, 0x3232, 0x3333, 0x3434, 0x3535, 0x3636, 0x3737,
+	0x3838, 0x3939, 0x3a3a, 0x3b3b, 0x3c3c, 0x3d3d, 0x3e3e, 0x3f3f,
+	0x4040, 0x4141, 0x4242, 0x4343, 0x4444, 0x4545, 0x4646, 0x4747,
+	0x4848, 0x4949, 0x4a4a, 0x4b4b, 0x4c4c, 0x4d4d, 0x4e4e, 0x4f4f,
+	0x5050, 0x5151, 0x5252, 0x5353, 0x5454, 0x5555, 0x5656, 0x5757,
+	0x5858, 0x5959, 0x5a5a, 0x5b5b, 0x5c5c, 0x5d5d, 0x5e5e, 0x5f5f,
+	0x6060, 0x6161, 0x6262, 0x6363, 0x6464, 0x6565, 0x6666, 0x6767,
+	0x6868, 0x6969, 0x6a6a, 0x6b6b, 0x6c6c, 0x6d6d, 0x6e6e, 0x6f6f,
+	0x7070, 0x7171, 0x7272, 0x7373, 0x7474, 0x7575, 0x7676, 0x7777,
+	0x7878, 0x7979, 0x7a7a, 0x7b7b, 0x7c7c, 0x7d7d, 0x7e7e, 0x7f7f,
+	0x8080, 0x8181, 0x8282, 0x8383, 0x8484, 0x8585, 0x8686, 0x8787,
+	0x8888, 0x8989, 0x8a8a, 0x8b8b, 0x8c8c, 0x8d8d, 0x8e8e, 0x8f8f,
+	0x9090, 0x9191, 0x9292, 0x9393, 0x9494, 0x9595, 0x9696, 0x9797,
+	0x9898, 0x9999, 0x9a9a, 0x9b9b, 0x9c9c, 0x9d9d, 0x9e9e, 0x9f9f,
+	0xa0a0, 0xa1a1, 0xa2a2, 0xa3a3, 0xa4a4, 0xa5a5, 0xa6a6, 0xa7a7,
+	0xa8a8, 0xa9a9, 0xaaaa, 0xabab, 0xacac, 0xadad, 0xaeae, 0xafaf,
+	0xb0b0, 0xb1b1, 0xb2b2, 0xb3b3, 0xb4b4, 0xb5b5, 0xb6b6, 0xb7b7,
+	0xb8b8, 0xb9b9, 0xbaba, 0xbbbb, 0xbcbc, 0xbdbd, 0xbebe, 0xbfbf,
+	0xc0c0, 0xc1c1, 0xc2c2, 0xc3c3, 0xc4c4, 0xc5c5, 0xc6c6, 0xc7c7,
+	0xc8c8, 0xc9c9, 0xcaca, 0xcbcb, 0xcccc, 0xcdcd, 0xcece, 0xcfcf,
+	0xd0d0, 0xd1d1, 0xd2d2, 0xd3d3, 0xd4d4, 0xd5d5, 0xd6d6, 0xd7d7,
+	0xd8d8, 0xd9d9, 0xdada, 0xdbdb, 0xdcdc, 0xdddd, 0xdede, 0xdfdf,
+	0xe0e0, 0xe1e1, 0xe2e2, 0xe3e3, 0xe4e4, 0xe5e5, 0xe6e6, 0xe7e7,
+	0xe8e8, 0xe9e9, 0xeaea, 0xebeb, 0xecec, 0xeded, 0xeeee, 0xefef,
+	0xf0f0, 0xf1f1, 0xf2f2, 0xf3f3, 0xf4f4, 0xf5f5, 0xf6f6, 0xf7f7,
+	0xf8f8, 0xf9f9, 0xfafa, 0xfbfb, 0xfcfc, 0xfdfd, 0xfefe, 0xffff
+};
+
+static struct drm_color_lut srgb_y[] = {
 	{ 0x0, 0x0, 0x0, 0 },
 	{ 0x13, 0x13, 0x13, 0 },
 	{ 0x27, 0x27, 0x27, 0 },
@@ -271,14 +306,17 @@ static struct drm_color_lut srgb_array[] = {
 	{ 0xffff, 0xffff, 0xffff, 0 },
 };
 
+static_assert(ARRAY_SIZE(linear_x) == ARRAY_SIZE(srgb_y),
+	      "srgb x and y must have the same number of entries");
+
 const struct vkms_color_lut srgb_eotf = {
-	.y = srgb_array,
-	.lut_length = ARRAY_SIZE(srgb_array),
-	.channel_value2index_ratio = 0xff00ffll
+	.x = linear_x,
+	.y = srgb_y,
+	.lut_length = ARRAY_SIZE(srgb_y)
 };
 EXPORT_SYMBOL(srgb_eotf);
 
-static struct drm_color_lut srgb_inv_array[] = {
+static struct drm_color_lut srgb_inv_y[] = {
 	{ 0x0, 0x0, 0x0, 0 },
 	{ 0xcc2, 0xcc2, 0xcc2, 0 },
 	{ 0x15be, 0x15be, 0x15be, 0 },
@@ -537,9 +575,12 @@ static struct drm_color_lut srgb_inv_array[] = {
 	{ 0xffff, 0xffff, 0xffff, 0 },
 };
 
+static_assert(ARRAY_SIZE(linear_x) == ARRAY_SIZE(srgb_inv_y),
+	      "srgb_inv x and y must have the same number of entries");
+
 const struct vkms_color_lut srgb_inv_eotf = {
-	.y = srgb_inv_array,
-	.lut_length = ARRAY_SIZE(srgb_inv_array),
-	.channel_value2index_ratio = 0xff00ffll
+	.x = linear_x,
+	.y = srgb_inv_y,
+	.lut_length = ARRAY_SIZE(srgb_inv_y)
 };
 EXPORT_SYMBOL(srgb_inv_eotf);
-- 
2.55.0

