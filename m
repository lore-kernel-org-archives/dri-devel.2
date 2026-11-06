Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD303606A337
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YFzK6/zR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C6A10EAA5;
	Fri,  6 Nov 2026 20:19:22 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B197610E460
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793996354;
 bh=wXSeLjxD7mSVR194e/x1gPtgqhDX4PnezaJdA495BGA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YFzK6/zRwe7MJs9BtYlbJ9AXIqKH35UhPHwReTkoGzoXZ7diqyRHy6mG9JQADjipL
 XLn6p1aLKdl7lQROU5AP3IdtDrCc2X1SU5ooXt+10p+FsOV5YDL2bXdB1MNJ+UEL+u
 jQFp7B5w7j2DuePnESp0+qQaU63eyiefJlHfUvCS69QgTncvBM9ZEOXLI8Nb5udwPY
 hCmvvYL2vbvMfsi8cXJmkvtHdwkeCYsw2uXbzSacwT/8mzUwUUWFlWeF3Awa+ueyvX
 3HnqRegiTNGx1E/UHAbpLHpBEJrvLJhkBHRsYeBCgWWLV9CWeTkjONRo8Isccgm0cM
 u6CGx97npn2rg==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D1AB17E066C;
 Fri, 06 Nov 2026 21:19:09 +0100 (CET)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] drm/vkms: rename struct vkms_color_lut::base to y
Date: Fri,  6 Nov 2026 17:18:08 -0300
Message-ID: <20261106201813.129911-8-leandro.ribeiro@collabora.com>
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

No behavior change. In the following commits we'll add x, so y better
matches that.

Reviewed-by: Robert Mader <robert.mader@collabora.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c |  2 +-
 drivers/gpu/drm/vkms/vkms_composer.c         | 10 +++++-----
 drivers/gpu/drm/vkms/vkms_drv.h              |  2 +-
 drivers/gpu/drm/vkms/vkms_luts.c             |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index 83ef2afcc819..c223797a542a 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
@@ -81,7 +81,7 @@ static const struct vkms_color_test_lerp_params color_test_lerp_cases[] = {
 };
 
 static const struct vkms_color_lut test_linear_lut = {
-	.base = test_linear_array,
+	.y = test_linear_array,
 	.lut_length = ARRAY_SIZE(test_linear_array),
 	.channel_value2index_ratio = 0xf000fll
 };
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index b4a433be1b2d..640a1a03f06f 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -114,12 +114,12 @@ VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut
 	 */
 	static_assert(sizeof(struct drm_color_lut) == sizeof(__u16) * 4);
 
-	lut_y_floor = &lut->base[drm_fixp2int(lut_index)];
+	lut_y_floor = &lut->y[drm_fixp2int(lut_index)];
 	if (drm_fixp2int(lut_index) == (lut->lut_length - 1))
 		/* We're at the end of the LUT array, use same value for ceil and floor */
 		lut_y_ceil = lut_y_floor;
 	else
-		lut_y_ceil = &lut->base[drm_fixp2int_ceil(lut_index)];
+		lut_y_ceil = &lut->y[drm_fixp2int_ceil(lut_index)];
 
 	floor_channel_value = lut_channel_value(lut_y_floor, channel);
 	ceil_channel_value = lut_channel_value(lut_y_ceil, channel);
@@ -132,7 +132,7 @@ EXPORT_SYMBOL_IF_KUNIT(apply_lut_to_channel_value);
 
 static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buffer *output_buffer)
 {
-	if (!crtc_state->gamma_lut.base)
+	if (!crtc_state->gamma_lut.y)
 		return;
 
 	if (!crtc_state->gamma_lut.lut_length)
@@ -647,7 +647,7 @@ void vkms_composer_worker(struct work_struct *work)
 		s64 max_lut_index_fp;
 		s64 u16_max_fp = drm_int2fixp(0xffff);
 
-		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
+		crtc_state->gamma_lut.y = (struct drm_color_lut *)crtc->state->gamma_lut->data;
 		crtc_state->gamma_lut.lut_length =
 			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
 		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
@@ -655,7 +655,7 @@ void vkms_composer_worker(struct work_struct *work)
 									       u16_max_fp);
 
 	} else {
-		crtc_state->gamma_lut.base = NULL;
+		crtc_state->gamma_lut.y = NULL;
 	}
 
 	spin_unlock_irq(&out->composer_lock);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 34b855431af3..cdcf7a79697b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -159,7 +159,7 @@ struct vkms_plane {
 };
 
 struct vkms_color_lut {
-	struct drm_color_lut *base;
+	struct drm_color_lut *y;
 	size_t lut_length;
 	s64 channel_value2index_ratio;
 };
diff --git a/drivers/gpu/drm/vkms/vkms_luts.c b/drivers/gpu/drm/vkms/vkms_luts.c
index d0e96df2c120..7b0c8eaf83b8 100644
--- a/drivers/gpu/drm/vkms/vkms_luts.c
+++ b/drivers/gpu/drm/vkms/vkms_luts.c
@@ -272,7 +272,7 @@ static struct drm_color_lut srgb_array[] = {
 };
 
 const struct vkms_color_lut srgb_eotf = {
-	.base = srgb_array,
+	.y = srgb_array,
 	.lut_length = ARRAY_SIZE(srgb_array),
 	.channel_value2index_ratio = 0xff00ffll
 };
@@ -538,7 +538,7 @@ static struct drm_color_lut srgb_inv_array[] = {
 };
 
 const struct vkms_color_lut srgb_inv_eotf = {
-	.base = srgb_inv_array,
+	.y = srgb_inv_array,
 	.lut_length = ARRAY_SIZE(srgb_inv_array),
 	.channel_value2index_ratio = 0xff00ffll
 };
-- 
2.56.0

