Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15ADC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6B010E63D;
	Wed, 29 Jul 2026 08:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="IXoIojad";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1E910E63D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ak
 YqOpgV5Vc5b4Rt4S0+ZrqmzSx+XtvE6lK7xlUvBQw=; b=IXoIojadnc7UclYhQc
 jWlgr7ck1A4J5oh0MudZMP84lXor2TTti50hsb5WfRETuw4rA+V62yPJihquxUQ7
 LqOaLbS/6L8cSvtMAex5uX3hHQ7kSk9PZixfxqFHP16TfDHSQdbwZeUNzda96gWQ
 CRySxs4Pn8f52aoevWGS/04H0=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wCHU2RZvmlqpb+LMA--.43134S2; 
 Wed, 29 Jul 2026 16:48:25 +0800 (CST)
From: oushixiong1025@163.com
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 4/4] drm/log: Batch vmap/vunmap and flush for record drawing
Date: Wed, 29 Jul 2026 16:48:23 +0800
Message-Id: <20260729084823.693723-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHU2RZvmlqpb+LMA--.43134S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1DGr1kJw48AFyUKw45Jrb_yoWruFW5pr
 ZayrWSkF4UtFWfC34qvFs3ArnxXa1DW34j9rW7C3sxGF4DAF9ava45Ja9xAF4UJw1kCrnI
 qr9xKF48Gr1jka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8kuxUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4Rm6yWppvlnlSwAA3B
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

drm_log_draw_new_line() calls drm_log_clear_line() and
drm_log_draw_line(), which independently call
drm_client_buffer_vmap_local(), drm_client_buffer_vunmap_local(),
and drm_client_buffer_flush(). For each call to
drm_log_draw_new_line(), this results in 2 vmap/vunmap pairs and
2 flush calls, even though vmap_local maps the entire framebuffer
each time.

Refactor drm_log_clear_line() and drm_log_draw_line() to accept a
pre-mapped iosys_map by value, removing the per-line vmap/vunmap/flush
calls. Move the single vmap/vunmap pair and flush up to
drm_log_draw_new_line(), which now maps once before clearing and
drawing, then issues a single flush after unmapping.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/clients/drm_log.c | 52 ++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 63577aeb705c..4896b3e00710 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -109,25 +109,21 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
 	}
 }
 
-static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line)
+static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line,
+			       struct iosys_map map)
 {
 	struct drm_framebuffer *fb = scanout->buffer->fb;
 	unsigned long height = scanout->scaled_font_h;
-	struct iosys_map map;
 	struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, height);
 
-	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
-		return;
 	iosys_map_memset(&map, r.y1 * fb->pitches[0], 0, height * fb->pitches[0]);
-	drm_client_buffer_vunmap_local(scanout->buffer);
-	drm_client_buffer_flush(scanout->buffer, &r);
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
@@ -136,10 +132,9 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
 	u32 i;
 
-	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
-		return;
 
 	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
+
 	for (i = 0; i < len && i < scanout->columns; i++) {
 		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
 		src = font_data_glyph_buf(font->data, font->width, font->height,
@@ -154,21 +149,40 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
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

