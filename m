Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A91C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB07610E67D;
	Thu, 30 Jul 2026 11:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="ciDCy+/a";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDEF10E67D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yj
 EsmvklDG29KLP0XQelUpMV/7ZZ2pHVTFvvqbPPvHg=; b=ciDCy+/aBsJA4Z24zI
 Ukn+zwwo0ZIUJhqZsdpG2Ozsmio3tfsWoPdjS+UxiNeDJnPUdzol+z8p0xTovDK/
 Z0b/L/zSM/QaJgOk2DYxUl05pQfd9Wx8tlMgvRTtjKkBe9aq0nkeaVKfZ47RKkfX
 5yUgRyqJmBrKzLLkowJpxKrho=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDnN+vbLmtqz6GNMw--.5323S2; 
 Thu, 30 Jul 2026 19:00:45 +0800 (CST)
From: oushixiong1025@163.com
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2] drm/log: Batch vmap/vunmap and flush for record drawing
Date: Thu, 30 Jul 2026 18:59:50 +0800
Message-Id: <20260730105950.670892-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnN+vbLmtqz6GNMw--.5323S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1DGr1kJw48AFWDJFy7ZFb_yoWrKF1kpr
 Zayr9akF4UtrWFk34qvrZ5ArnxXa1DW34jgr47CasxGF4DAF9ava45Aa9xAF4UJw1kCrnx
 Xr13KF48Gr1jka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4R04R2prLt3hywAA3b
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

From: Shixiong Ou <oushixiong@kylinos.cn>

drm_log_draw_new_line() calls drm_log_clear_line() and drm_log_draw_line(),
which independently call drm_client_buffer_vmap_local(),
drm_client_buffer_vunmap_local(), and drm_client_buffer_flush(). For each
call to drm_log_draw_new_line(), this results in 2 vmap/vunmap pairs and
2 flush calls, even though vmap_local maps the entire framebuffer
each time.

Refactor drm_log_clear_line() and drm_log_draw_line() to accept a
pre-mapped iosys_map by value, removing the per-line vmap/vunmap/flush
calls. Move the single vmap/vunmap pair and flush up to
drm_log_draw_new_line(), which now maps once before clearing and
drawing, then issues a single flush after unmapping.

Also remove the now-unused drm_rect from both functions.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v1->v2:
   Remove unused drm_rect from drm_log_clear_line() and
   drm_log_draw_line().

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index ac10c978f917..52563e2a1c45 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -94,37 +94,28 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
 	}
 }
 
-static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line)
+static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line,
+			       struct iosys_map map)
 {
 	struct drm_framebuffer *fb = scanout->buffer->fb;
 	unsigned long height = scanout->scaled_font_h;
-	struct iosys_map map;
-	struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, height);
 
-	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
-		return;
-	iosys_map_memset(&map, r.y1 * fb->pitches[0], 0, height * fb->pitches[0]);
-	drm_client_buffer_vunmap_local(scanout->buffer);
-	drm_client_buffer_flush(scanout->buffer, &r);
+	iosys_map_memset(&map, line * height * fb->pitches[0], 0, height * fb->pitches[0]);
 }
 
 static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
-			      unsigned int len, unsigned int prefix_len)
+			      unsigned int len, unsigned int prefix_len,
+			      struct iosys_map map)
 {
 	struct drm_framebuffer *fb = scanout->buffer->fb;
-	struct iosys_map map;
 	const struct font_desc *font = scanout->font;
 	size_t font_pitch = DIV_ROUND_UP(font->width, 8);
 	const u8 *src;
 	u32 px_width = fb->format->cpp[0];
-	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * scanout->scaled_font_h,
-					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
 	u32 i;
 
-	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
-		return;
+	iosys_map_incr(&map, scanout->line * scanout->scaled_font_h * fb->pitches[0]);
 
-	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
 	for (i = 0; i < len && i < scanout->columns; i++) {
 		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
 		src = font_data_glyph_buf(font->data, font->width, font->height,
@@ -139,21 +130,40 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 	scanout->line++;
 	if (scanout->line >= scanout->rows)
 		scanout->line = 0;
-	drm_client_buffer_vunmap_local(scanout->buffer);
-	drm_client_buffer_flush(scanout->buffer, &r);
 }
 
 static void drm_log_draw_new_line(struct drm_log_scanout *scanout,
-				  const char *s, unsigned int len, unsigned int prefix_len)
+				  const char *s, unsigned int len,
+				  unsigned int prefix_len)
 {
+	struct iosys_map map;
+	struct drm_framebuffer *fb = scanout->buffer->fb;
+	u32 height = scanout->scaled_font_h;
+	u32 line = scanout->line;
+	u32 y2;
+	struct drm_rect dirty;
+
+	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
+		return;
+
 	if (scanout->line == 0) {
-		drm_log_clear_line(scanout, 0);
-		drm_log_clear_line(scanout, 1);
-		drm_log_clear_line(scanout, 2);
-	} else if (scanout->line + 2 < scanout->rows)
-		drm_log_clear_line(scanout, scanout->line + 2);
+		drm_log_clear_line(scanout, 0, map);
+		drm_log_clear_line(scanout, 1, map);
+		drm_log_clear_line(scanout, 2, map);
+		y2 = min(3, scanout->rows) * height;
+	} else if (scanout->line + 2 < scanout->rows) {
+		drm_log_clear_line(scanout, scanout->line + 2, map);
+		y2 = (line + 3) * height;
+	} else {
+		y2 = (line + 1) * height;
+	}
+
+	drm_log_draw_line(scanout, s, len, prefix_len, map);
+
+	drm_client_buffer_vunmap_local(scanout->buffer);
 
-	drm_log_draw_line(scanout, s, len, prefix_len);
+	dirty = DRM_RECT_INIT(0, line * height, fb->width, y2 - line * height);
+	drm_client_buffer_flush(scanout->buffer, &dirty);
 }
 
 /*
--
2.25.1

No virus found
		Checked by Hillstone Network AntiVirus

