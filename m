Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F4EC561E6
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2202610EBB9;
	Tue,  4 Aug 2026 20:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="evDr8psI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475ED10EBB6
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875746;
 bh=3068mTz+Dubvz+kl6oalAWQDx74LwvLKt6x82+8ngYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=evDr8psI7sWUHIZmFFcnnApp3F9eOiZ4tcHfUBkMG3T+vMHtzpwzm35cQe2pDiQLI
 yTFnvVjzUcpe7JeQvkEGLs3bxqtFm/nZJxfpmUGqdEoo+Zdse6OpLG+wvOUHbdbtBC
 wLpEYDzT/bSge5xSmhaEH8cOAtOk8p9g1cTC7mxQHe6ZHOfJP2B/6J7+48Zy0k81un
 W9vI/jU7x/o5cCXVWzlxQhBnsWdq/Eu9oyLXBW5YMmn/FS4x3ZcxcvqiEfR2ZGSPHb
 v/VrcNlyLJ2hyp1Rm4DxZbD49FB+CTWirvMh5vBmaD1e5B58CJRRQLGzYZA+launvC
 D7yeFhNsBW8lQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6672317E0235;
 Tue, 04 Aug 2026 22:35:41 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] drm/vkms: improve the way in which we access LUT member
Date: Tue,  4 Aug 2026 17:33:45 -0300
Message-ID: <20260804203351.148521-6-leandro.ribeiro@collabora.com>
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

apply_lut_to_channel_value() indexes a struct drm_color_lut array, and
then cast to (__u16 *) and index with the channel (r -> index 0, g ->
index 1, b -> index 2). This is a bit fragile and prone to issues.

Instead, add a more robust helper lut_channel_value() such that, given a
struct drm_color_lut and a color channel, it retrives the value.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 30 ++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085ad0..bd539ee4c5be 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -75,6 +75,24 @@ VISIBLE_IF_KUNIT u16 lerp_u16(u16 a, u16 b, s64 t)
 }
 EXPORT_SYMBOL_IF_KUNIT(lerp_u16);
 
+static inline u16 lut_channel_value(const struct drm_color_lut *lut,
+				    enum lut_channel channel)
+{
+	switch (channel) {
+	case LUT_RED:
+		return lut->red;
+	case LUT_BLUE:
+		return lut->blue;
+	case LUT_GREEN:
+		return lut->green;
+	case LUT_RESERVED:
+		DRM_DEBUG_DRIVER("LUT_RESERVED channel should not be accessed");
+		return 0;
+	}
+	DRM_DEBUG_DRIVER("unknown LUT channel");
+	return 0;
+}
+
 VISIBLE_IF_KUNIT s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value)
 {
 	s64 color_channel_fp = drm_int2fixp(channel_value);
@@ -86,8 +104,8 @@ EXPORT_SYMBOL_IF_KUNIT(get_lut_index);
 VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 channel_value,
 						enum lut_channel channel)
 {
+	const struct drm_color_lut *lut_y_floor, *lut_y_ceil;
 	s64 lut_index = get_lut_index(lut, channel_value);
-	u16 *floor_lut_value, *ceil_lut_value;
 	u16 floor_channel_value, ceil_channel_value;
 
 	/*
@@ -96,15 +114,15 @@ VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut
 	 */
 	static_assert(sizeof(struct drm_color_lut) == sizeof(__u16) * 4);
 
-	floor_lut_value = (__u16 *)&lut->base[drm_fixp2int(lut_index)];
+	lut_y_floor = &lut->base[drm_fixp2int(lut_index)];
 	if (drm_fixp2int(lut_index) == (lut->lut_length - 1))
 		/* We're at the end of the LUT array, use same value for ceil and floor */
-		ceil_lut_value = floor_lut_value;
+		lut_y_ceil = lut_y_floor;
 	else
-		ceil_lut_value = (__u16 *)&lut->base[drm_fixp2int_ceil(lut_index)];
+		lut_y_ceil = &lut->base[drm_fixp2int_ceil(lut_index)];
 
-	floor_channel_value = floor_lut_value[channel];
-	ceil_channel_value = ceil_lut_value[channel];
+	floor_channel_value = lut_channel_value(lut_y_floor, channel);
+	ceil_channel_value = lut_channel_value(lut_y_ceil, channel);
 
 	return lerp_u16(floor_channel_value, ceil_channel_value,
 			lut_index & DRM_FIXED_DECIMAL_MASK);
-- 
2.55.0

