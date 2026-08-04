Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD342C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CAA10EBBA;
	Tue,  4 Aug 2026 20:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Bfn7vR4X";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44DE10EBBA
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875751;
 bh=rWZoNhz5BMbvrNfZAYlYjXVDVQ2Bbe1v+CkwZzedEG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bfn7vR4XHCG17fhPosNbrVkHAl1Zck+ZFSHjrgHfx9J2ezz1/nZffQdRsjp6EB0zk
 E/pF/xhKLyZgGxxchp6XFm03qJlSJlegDa0wVIAhUkJ+K54KlvaJdybkCg0+hhDdCU
 jm24U/qtbALd6Hku1VnPlVMveDS5PfnzNFN9mAndHdU8qWjCTrzl3f7SrgoLJzeIwB
 qApBXCplBDuoYN7PWjgDANwAumbsKUVQLX6whYa3pk5oT3Hdf0a6mje6JMV7GxURtP
 cIt/6cJSJ+KhOtOfHr9gcrLWd7CAFGMWcPQKwG3VJWsw+5+TMDnv5UJ9/DiONWBxZ6
 slWCXAAvaI7DQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B0C1317E0243;
 Tue, 04 Aug 2026 22:35:46 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] drm/vkms: rename struct vkms_color_lut::base to y
Date: Tue,  4 Aug 2026 17:33:46 -0300
Message-ID: <20260804203351.148521-7-leandro.ribeiro@collabora.com>
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

No behavior change. In the following commits we'll add x, so y better
matches that.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/tests/vkms_color_test.c |  2 +-
 drivers/gpu/drm/vkms/vkms_composer.c         | 10 +++++-----
 drivers/gpu/drm/vkms/vkms_drv.h              |  2 +-
 drivers/gpu/drm/vkms/vkms_luts.c             |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
index 28614edb8eb1..cfcd7e8e7640 100644
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
index bd539ee4c5be..a022554e4b1a 100644
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
@@ -641,7 +641,7 @@ void vkms_composer_worker(struct work_struct *work)
 		s64 max_lut_index_fp;
 		s64 u16_max_fp = drm_int2fixp(0xffff);
 
-		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
+		crtc_state->gamma_lut.y = (struct drm_color_lut *)crtc->state->gamma_lut->data;
 		crtc_state->gamma_lut.lut_length =
 			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
 		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
@@ -649,7 +649,7 @@ void vkms_composer_worker(struct work_struct *work)
 									       u16_max_fp);
 
 	} else {
-		crtc_state->gamma_lut.base = NULL;
+		crtc_state->gamma_lut.y = NULL;
 	}
 
 	spin_unlock_irq(&out->composer_lock);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 1975843abe92..55a3ea184e44 100644
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
2.55.0

