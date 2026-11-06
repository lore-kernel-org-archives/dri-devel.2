Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4E606A332
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=MkVMmTud
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24AB112FE7;
	Fri,  6 Nov 2026 20:19:01 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA18C10E460
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793996333;
 bh=oVMhuu8wDkT2uP6ojAQG+iyNORDuyd/6LXMBzjrRfkw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MkVMmTudlrqrbU+scnh6JsYnw+BcZDpL/spRYZeSi7jDIed2X96SnGc0Tspv7Xt8J
 ICQcnrDsJ99aHhKmUMSkyhZmO9dfgZp0qa3dfe0jhXih3u8bVUVo9l+GluJUdw94Q8
 KCymqFgELpHyqXxTgKaZPhxlsJGQifvk4efv4EFwVWzfS3xz+gu8Fe0xDQQXEF/kxC
 x6NblO0Hi3tJ43X7Qx9R+Sb21y+IHPt2Gbn/nueR0dY7cJRwn0NyFGb+/V/ueoNyHX
 +oy7dsWLQmt5NH59KoizBOc0rm6/MnglzoXFnMmCH+G1Xp0lzC8Sd7VE4SRb1e0y4n
 hA1VzB+rfPYSg==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0633717E092C;
 Fri, 06 Nov 2026 21:18:48 +0100 (CET)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] drm/vkms: allow color curve LUTs to have different
 sizes
Date: Fri,  6 Nov 2026 17:18:04 -0300
Message-ID: <20261106201813.129911-4-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Instead of keeping a hardcoded size that all LUTs representing color
curves must use, use ARRAY_SIZE() instead.

Besides making the code clearer, this allows us to create optimal LUTs
for each color curve, and each of them can naturally have a different
size. In the next commits we introduce these optimal LUTs.

Reviewed-by: Robert Mader <robert.mader@collabora.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
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
2.56.0

