Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AE0C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 03:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211D510F140;
	Fri, 31 Jul 2026 03:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRxCDxKx";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC5910F13D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 03:50:24 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8487088510aso637755b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785469824; x=1786074624; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MPpw50A8aDDXaO5N2qxp/QSPaF2brStqQosmRuHsnMY=;
 b=lRxCDxKxUhnla5IIBVTR+x7ju05QBz27zzEqv1BBvPjN0Rpva2N9pryE4c7TSE42Sn
 r6eH3DL9JZVAVaT1wid/ZDObIlmLCl9QCN08nHws6Q8HVOjdziIqAMu8jvVTJeDT8Q+N
 vyCAo2Nv9g3C2CHjWf0why9Of6Graq/O0SHohTdPBlNL4b+6kLLuH3IehzbehoAOKOxk
 3u4hVfUaX+IQ69HkweBOxE1O+yQHfU7DQijvzagkploT0Rz2JIDtyoaheF+2Fu8f88XE
 nHwp5YbSeXQul+VKBHIv/9XxPwfGmN7zzxCJp7CrrQMFXOGSERLOLkgvFAUKY8uOqgMR
 rIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785469824; x=1786074624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MPpw50A8aDDXaO5N2qxp/QSPaF2brStqQosmRuHsnMY=;
 b=e4kh8SJFQ0YU6s1lK0te7kNh6l2fhQfldyBcQ+0J2OtC9ybCcGCg0rM7iGRtPhFP7a
 i6Vkq/zhhCbx7i6eNL6Nmx1NClM9bzGIEIZbr7WoidNX/5ftVzJrf/V02/JIrsuBkt9w
 iILIaKTaq+xl6JQM9Q5T/eOPuV2S7BWIRDKrBz9aGJdP5TBp7YnNy69BbjID34UNsSpg
 kBJkHKf8q2VF91WLcZPBMqJFvUWV0Vu1wWAMC8kEQWkYJIaB6FL26xANUgGwEhH7wiya
 0sgTvo+GhVySCyw/1NR7pwsLVYsRy2DtOqDmy7z7bwKGPpoL9mo4nPewpiVxaZJtMDhE
 2shQ==
X-Gm-Message-State: AOJu0YxGaRUhLvY9lURNYChGhfFK4BWjGJL7lk4zup9XY5+BhAbC+5BN
 FhQvCOGDEchtFyET6EveIg1dLGgoSjEJ5SoDipirSlOd87jyuuCCk3W7
X-Gm-Gg: AR+sD12Nq4F3TMqFrQ7rxJwK4gAvnrNINOXCArZ78UC8s6/aruz55KNGL8cnW4NmQ4T
 GxYEwAKcpS/mXyv0YOx9mQGqc+2sV+zO6Q1ZyqlX6gz8HZLvq7xHJ2xg1tPk+EU2dinVvwhrjTM
 3ATr5qkhjs95j5DBEnMfTxIfeikraLhOXMXBNNRXxAuAno/lQgJh/MAsO7guWLwFpSJyipRZfmo
 GrHL+PaK49wQOHSXRkrSbPJDHLxnCZSnGW15fx2tjjRvsNPmYr0tE617QLUV4+u1hiQTMz7zEFV
 g88O/BwLx+tHUcRhoBdRCfotAek96Gyuffr+jRkS62Auuwu10x55wqqC34wfms+c6bhwvx3uhpO
 P0JR5UMUXfOF85i+90B68bZN4efvkQeLJQHIuAL9uN5TaXFvO41fUYUSpUPxoP/YofmD92dj4SC
 uH6zfGFA38ptMe7Lnq9EBAeJcgOFg1RC/H+m25VzWXD6SOb5rIXYTP7U14MXktaicDyPKa9T4Wo
 l0wlph+c6OP2SkOQNddLaV1X/c2hBwtRqMTUWNSbl9sBvjC
X-Received: by 2002:a05:6a00:a1d:b0:848:2f73:8ffd with SMTP id
 d2e1a72fcca58-84ed7210be2mr299870b3a.70.1785469823804; 
 Thu, 30 Jul 2026 20:50:23 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ed57cdc73sm175536b3a.17.2026.07.30.20.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 20:50:23 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Fri, 31 Jul 2026 11:50:13 +0800
Subject: [PATCH 2/3] drm/tiny: ssd16xx: support panels whose RAM X order is
 reversed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ssd16xx-pixpaper-rpi5-v1-2-18ffc0dbf59a@gmail.com>
References: <20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com>
In-Reply-To: <20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com>
To: Devarsh Thakkar <devarsht@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Wig Cheng <onlywig@gmail.com>, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785469814; l=4672;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=P8XfbTrAfbdlfN+bN8FRLlokz2szn+P1uihKxnKnl/Q=;
 b=SybVE/0RIpQdUyXa7NlxTtqa5DJXWiD7B2SDtUXcmYrnDe6BHvKL223ZTYTB1XiBW3oFjr2Ec
 7UqqpTMltvUBoc53kqAe6ad6jZegW2pWJYTP9iaMv6tfg0tFB3ysb5O
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

Some panels have their first column wired to the controller's last source
output, so the controller scans RAM X in the opposite direction and the
image comes out horizontally mirrored.  SSD1677 offers no source-direction
control that I could find - command 0x01 only affects the gate side - so it
has to be handled while packing the framebuffer.

Add an x_mirror flag to struct ssd16xx_device_config and honour it in both
branches of ssd16xx_convert_fb_to_1bpp(): the scanline order in the
landscape path, and the inner loop in the portrait one, which is what maps
to RAM X there.  The DRM_FORMAT_R1 memcpy fast path cannot mirror while
copying, so it is skipped when the flag is set.  Enable it for the
pixpaper-426m entry.

Tested on a Mayqueen PIXPAPER 4.26m (SSD1677, 800x480): a pattern with
four differently sized corner blocks renders correctly at rotation 0, and
a DT rotation of 90 gives a clean clockwise portrait.  Doing only the
landscape path leaves the portrait output transposed.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/ssd16xx.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ssd16xx.c b/drivers/gpu/drm/tiny/ssd16xx.c
index 02a28c0e07085e35d5210b6e20c214b163ede88f..d311720bbfbe0dd288dbd588be02c79b5eab3eab 100644
--- a/drivers/gpu/drm/tiny/ssd16xx.c
+++ b/drivers/gpu/drm/tiny/ssd16xx.c
@@ -380,6 +380,9 @@ struct ssd16xx_device_config {
 	const u8 *booster_soft_start_data;
 	u8        booster_soft_start_len;
 
+	/* Controller scans this panel's RAM X in the reverse direction. */
+	bool x_mirror;
+
 	/* Panel-specific display mode (resolution and physical dimensions) */
 	const struct drm_display_mode *mode;
 };
@@ -584,6 +587,7 @@ static const struct ssd16xx_device_config ssd16xx_device_configs[] = {
 		.default_refresh_mode_init = SSD16XX_REFRESH_FULL,
 		.red_supported     = false,
 		.default_color_mode = SSD16XX_COLOR_MODE_BW,
+		.x_mirror          = true,
 		.booster_soft_start_data = pixpaper426m_booster_soft_start,
 		.booster_soft_start_len  = ARRAY_SIZE(pixpaper426m_booster_soft_start),
 		.mode = &pixpaper426m_mode,
@@ -1199,10 +1203,11 @@ static void ssd16xx_convert_fb_to_3color(u8 *bw_dst, u8 *red_dst,
 static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 				       struct drm_framebuffer *fb,
 				       struct drm_rect *rect,
-				       unsigned int orientation)
+				       unsigned int orientation,
+				       bool x_mirror)
 {
 	u32 format = fb->format->format;
-	int x, y;
+	int x, y, i;
 	u8 byte = 0;
 	unsigned int bit_pos = 0;
 	unsigned int dst_idx = 0;
@@ -1224,7 +1229,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 	 * if not, the generic pixel-by-pixel loop below handles non-aligned
 	 * rects safely.
 	 */
-	if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0) {
+	if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0 &&
+	    !x_mirror) {
 		unsigned int src_pitch = fb->pitches[0];
 		unsigned int width_bytes = drm_rect_width(rect) / 8;
 
@@ -1246,7 +1252,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 		 * The data entry mode and cursor position control scan direction.
 		 */
 		for (x = rect->x2 - 1; x >= (int)rect->x1; x--) {
-			for (y = rect->y1; y < rect->y2; y++) {
+			for (i = 0; i < drm_rect_height(rect); i++) {
+				y = x_mirror ? rect->y2 - 1 - i : rect->y1 + i;
 				if (ssd16xx_pixel_is_white(src, fb, x, y))
 					byte |= (1 << (7 - bit_pos));
 				if (++bit_pos == 8) {
@@ -1272,7 +1279,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 		 * The data entry mode and cursor position control scan direction.
 		 */
 		for (y = rect->y1; y < rect->y2; y++) {
-			for (x = rect->x1; x < rect->x2; x++) {
+			for (i = 0; i < drm_rect_width(rect); i++) {
+				x = x_mirror ? rect->x2 - 1 - i : rect->x1 + i;
 				if (ssd16xx_pixel_is_white(src, fb, x, y))
 					byte |= (1 << (7 - bit_pos));
 				if (++bit_pos == 8) {
@@ -1345,7 +1353,9 @@ static int ssd16xx_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect,
 	if (red_buffer)
 		ssd16xx_convert_fb_to_3color(mono_buffer, red_buffer, &map, fb, rect);
 	else
-		ssd16xx_convert_fb_to_1bpp(mono_buffer, &map, fb, rect, device->orientation);
+		ssd16xx_convert_fb_to_1bpp(mono_buffer, &map, fb, rect,
+					   device->orientation,
+					   device->device_cfg->x_mirror);
 
 	drm_dbg(&device->drm,
 		"fb_dirty: mono[0..3]=0x%02x 0x%02x 0x%02x 0x%02x (data_size=%u)\n",

-- 
2.34.1

