Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23287C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7259B10EBA9;
	Tue,  4 Aug 2026 20:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IuaZzJLL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E86910EBA9
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875730;
 bh=JRlp8cArJAk/fd5nHchn+448FMkhongiykRKKe+H8G4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IuaZzJLLZFIixG3hiRgwcWFQUZfZaTHQDc78Wa8M7uC8A70jSe2ASF2Wow/SP/vIs
 yiHcjL3V7HpR1nwT72x861YD3KAZ9FP9d9viaCkFfjoVjmzjV6KCkdsr+pSCXj4FYf
 2YZKlHNx34wHO8qMe8gV/T1uGhK8NQq8bp/YJjymqTrRx+PQCX9ICTqDpV5gCqgt4N
 Zuo2XeJ+fAtQlRNfsopk+hR3oA7i3FVsH5IIG/P0LS81EszWASCxmvti2Eu/QGpZ2o
 qr1YLArM+pIaqgEEkt5WL2FErZ376fBBvvLx98v4YS9IQIKxsbwIO3y5rXhmuhwfX0
 C8jljNLHw3mnA==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F8F717E107E;
 Tue, 04 Aug 2026 22:35:25 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] drm/vkms: allow color curve LUTs to have different sizes
Date: Tue,  4 Aug 2026 17:33:42 -0300
Message-ID: <20260804203351.148521-3-leandro.ribeiro@collabora.com>
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

Instead of keeping a hardcoded size that all LUTs representing color
curves must use, use ARRAY_SIZE() instead.

Besides making the code clearer, this allows us to create optimal LUTs
for each color curve, and each of them can naturally have a different
size. In the next commits we introduce these optimal LUTs.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c |  4 ++--
 drivers/gpu/drm/vkms/vkms_luts.c             | 12 ++++++------
 drivers/gpu/drm/vkms/vkms_luts.h             |  2 --
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index 1a1c7cac2f15..18e73a8a5c31 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
@@ -128,7 +128,7 @@ static void vkms_color_test_lerp(struct kunit *test)
 
 static void vkms_color_test_linear(struct kunit *test)
 {
-	for (int i = 0; i < LUT_SIZE; i++) {
+	for (int i = 0; i < linear_eotf.lut_length; i++) {
 		int linear = apply_lut_to_channel_value(&linear_eotf, i * 0x101, LUT_RED);
 
 		KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(linear, 0x101), i);
@@ -139,7 +139,7 @@ static void vkms_color_srgb_inv_srgb(struct kunit *test)
 {
 	u16 srgb, final;
 
-	for (int i = 0; i < LUT_SIZE; i++) {
+	for (int i = 0; i < srgb_eotf.lut_length; i++) {
 		srgb = apply_lut_to_channel_value(&srgb_eotf, i * 0x101, LUT_RED);
 		final = apply_lut_to_channel_value(&srgb_inv_eotf, srgb, LUT_RED);
 
diff --git a/drivers/gpu/drm/vkms/vkms_luts.c b/drivers/gpu/drm/vkms/vkms_luts.c
index 82cb792f10d8..6dcdef26bda8 100644
--- a/drivers/gpu/drm/vkms/vkms_luts.c
+++ b/drivers/gpu/drm/vkms/vkms_luts.c
@@ -12,7 +12,7 @@
  * https://gitlab.freedesktop.org/hwentland/lutgen
  */
 
-static struct drm_color_lut linear_array[LUT_SIZE] = {
+static struct drm_color_lut linear_array[] = {
 	{ 0x0, 0x0, 0x0, 0 },
 	{ 0x101, 0x101, 0x101, 0 },
 	{ 0x202, 0x202, 0x202, 0 },
@@ -273,12 +273,12 @@ static struct drm_color_lut linear_array[LUT_SIZE] = {
 
 const struct vkms_color_lut linear_eotf = {
 	.base = linear_array,
-	.lut_length = LUT_SIZE,
+	.lut_length = ARRAY_SIZE(linear_array),
 	.channel_value2index_ratio = 0xff00ffll
 };
 EXPORT_SYMBOL(linear_eotf);
 
-static struct drm_color_lut srgb_array[LUT_SIZE] = {
+static struct drm_color_lut srgb_array[] = {
 	{ 0x0, 0x0, 0x0, 0 },
 	{ 0x13, 0x13, 0x13, 0 },
 	{ 0x27, 0x27, 0x27, 0 },
@@ -539,12 +539,12 @@ static struct drm_color_lut srgb_array[LUT_SIZE] = {
 
 const struct vkms_color_lut srgb_eotf = {
 	.base = srgb_array,
-	.lut_length = LUT_SIZE,
+	.lut_length = ARRAY_SIZE(srgb_array),
 	.channel_value2index_ratio = 0xff00ffll
 };
 EXPORT_SYMBOL(srgb_eotf);
 
-static struct drm_color_lut srgb_inv_array[LUT_SIZE] = {
+static struct drm_color_lut srgb_inv_array[] = {
 	{ 0x0, 0x0, 0x0, 0 },
 	{ 0xcc2, 0xcc2, 0xcc2, 0 },
 	{ 0x15be, 0x15be, 0x15be, 0 },
@@ -805,7 +805,7 @@ static struct drm_color_lut srgb_inv_array[LUT_SIZE] = {
 
 const struct vkms_color_lut srgb_inv_eotf = {
 	.base = srgb_inv_array,
-	.lut_length = LUT_SIZE,
+	.lut_length = ARRAY_SIZE(srgb_inv_array),
 	.channel_value2index_ratio = 0xff00ffll
 };
 EXPORT_SYMBOL(srgb_inv_eotf);
diff --git a/drivers/gpu/drm/vkms/vkms_luts.h b/drivers/gpu/drm/vkms/vkms_luts.h
index 925a4a7b84e2..8078ab33b83e 100644
--- a/drivers/gpu/drm/vkms/vkms_luts.h
+++ b/drivers/gpu/drm/vkms/vkms_luts.h
@@ -3,8 +3,6 @@
 #ifndef _VKMS_LUTS_H_
 #define _VKMS_LUTS_H_
 
-#define LUT_SIZE 256
-
 extern const struct vkms_color_lut linear_eotf;
 extern const struct vkms_color_lut srgb_eotf;
 extern const struct vkms_color_lut srgb_inv_eotf;
-- 
2.55.0

