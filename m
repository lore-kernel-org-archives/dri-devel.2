Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D4FC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFC910E30B;
	Mon, 21 Sep 2026 07:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Adqbcp6u";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3B310E698
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:18 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39e03468a5fso1675765a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857318; x=1790462118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OAx1sjiLudq3qKBE3WqnByzTHiBW3JvS52Z/aTNAKlU=;
 b=Adqbcp6u/xl1fPR9QL21NUBTncllCh14gReDu0AXs6VjB+Z3PLrDuyKfgwC2aEO/5d
 H3HX4+AuQsSG9qvuyDeLkKN8NOR3nOYmN/Ydyx92OQSxzxVHDzz58X34GXA493GczOlx
 A4YuGOXqxZ4rQIv5jxe0GHm2T/HutoVINvUSYhMOSWys+mtdj8oJ1zjG0zGMfzPnXF8O
 mVcipkT78YkH4RIXl/UzrP3CID6FobVZuzdO75dMOnnC/SMj3FeikFTt3JTY8pwqkTvl
 NDExG8wn8RfxQBSQLdT4Mn9XQK/0LaYuszQY8jUMYaf2/cMF3gOW2rIExf57HIC3La5C
 lFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857318; x=1790462118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OAx1sjiLudq3qKBE3WqnByzTHiBW3JvS52Z/aTNAKlU=;
 b=qGCvyvzrWpWGWXR8HAInYvANjGeg3LuzQYiezeFZLeYNMyilquB23cMKiaDhEI8V9R
 06OnpYtbSIzS1Yn46P0wrUZdK4RlBTgV5OFTvrE04P6QKs5znkHTE1o5PvHfhJT5LPHU
 hrzDW+2xluJ0/YpKVGbXCP8joDTV6nN5Ts2IWomNzNo6MPqRPm5oiq0aLIxSkd0eYiut
 17bpeVbbMB1BLFyevhXjFSxGgozJ1PTqvLme06WF8PccUsIuzBXxH6W76RpNPrwoTg0v
 D/0xhwePivrKXy3OjLMc4d7pv8B3RDgOl551mgXXalNuljx7o+Zl8NbD8vRjXvWmdm20
 CpEw==
X-Gm-Message-State: AFuF++lXWqZeXAMoLMmQBaAwmwTn9ouU4F5bwATCuyjhxqCzTx+HRchf
 KFLuYeIsTvnIWhDt+tEavsfs3LUznNW8Bygn+yPdkRC9ibMo+3v18ln7AycdzuXk
X-Gm-Gg: AYBFou1Ik9yUl/p6JlOWL1wQflWlU2uUXaZ+XlcxciyU3gHXvkAw3kvB9w6x7Zykw5X
 mJ8i5bN8NxM34pUJwAefB9AJbiztK+H1JmnYrV5o656LWYRKYAe40u22SaI9StFnQP7QuqttFHY
 un3JJfbv99eQt/OwQTjIf/o0OFTh87KMS2cStUcv07sG8S59g2XtsrRWsTb2clw7ymkUK6kDMqa
 8N5D/awmhExIWuRG9khUIh6lFCMyX8Vdt53a+c+Vo7L+sKtFltYQenpaxWyFSCww3A/zYEOycgU
 xdMUFEX9XDErA/8C/IU4yXmx1vPxh8gaE1kIXBKbLhGFO7R6//wrd6KAxB/oZPWmiJL7tcp5lku
 sywxeflEW3wDOdUgqbAjAEXNdF9X5kx2G7MnCWvOXTAZsVW7MbI62I8tLzq42X76UYV7/4h2DOx
 q+iC0c8RVelWbf4yI0KWtGzdoVzWNc4CTyTYB4pd2eD0bUUlXNeBM/BPTJxB3j0WRye2Z2/Rdoh
 5MMI5fgSrR+x9UYigXIPuBlLay6eBR2vwRQMphiFs5LmRl4G2+sKgtrHBjSWR80reHvE5zJI4ts
 93h2Z58QhdPtwlq2PjRN
X-Received: by 2002:a17:90b:2d47:b0:39d:f4fd:8075 with SMTP id
 98e67ed59e1d1-39e54c9c7b7mr11455984a91.19.1789857318170; 
 Sat, 19 Sep 2026 15:35:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c4bc0d2sm6194773a91.12.2026.09.19.15.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: javierm@redhat.com, tzimmermann@suse.de, simona@ffwll.ch,
 airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: ssd130x, st7586,
 sysfb: fix damage clip and buffer allocation bounds
Date: Sat, 19 Sep 2026 22:35:17 +0000
Message-ID: <20260919223517.3890003-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Validate damage rectangle coordinates and buffer sizes in
drivers/gpu/drm/solomon/ssd130x.c, drivers/gpu/drm/sitronix/st7586.c,
and drivers/gpu/drm/sysfb/drm_sysfb_modeset.c.

Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index 28b2245f6b79..ef69f1eb8ead 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -380,7 +380,7 @@ static int st7586_probe(struct spi_device *spi)
 	dbi = &dbidev->dbi;
 	drm = &dbidev->drm;
 
-	bufsize = (st7586_mode.vdisplay + 2) / 3 * st7586_mode.hdisplay;
+	bufsize = (st7586_mode.hdisplay + 2) / 3 * st7586_mode.vdisplay;
 
 	dbi->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(dbi->reset))
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0b0fc6fe3df2..bae080b12e7e 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -802,7 +802,7 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 		/* Process pair of pixels and combine them into a single byte */
 		for (j = 0; j < width; j += segment_width) {
 			u8 n1 = buf[i * width + j];
-			u8 n2 = buf[i * width + j + 1];
+			u8 n2 = (j + 1 < width) ? buf[i * width + j + 1] : 0;
 
 			data_array[array_idx++] = (n2 & 0xf0) | (n1 >> 4);
 		}
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index d2de29caf89e..2909cb7581d0 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -376,17 +376,21 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
 	struct iosys_map dst = sysfb->fb_addr;
-	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
 	unsigned int dst_pitch = sysfb->fb_pitch;
 	const struct drm_format_info *dst_format = sysfb->fb_format;
-	struct drm_rect dst_clip;
+	struct drm_rect dst_clip, fb_rect;
 	unsigned long lines, linepixels, i;
 	int idx;
 
-	drm_rect_init(&dst_clip,
-		      plane_state->src_x >> 16, plane_state->src_y >> 16,
-		      plane_state->src_w >> 16, plane_state->src_h >> 16);
+	if (!old_plane_state || !old_plane_state->visible)
+		return;
+
+	dst_clip = old_plane_state->dst;
+	drm_rect_init(&fb_rect, 0, 0, sysfb->fb_mode.hdisplay, sysfb->fb_mode.vdisplay);
+	if (!drm_rect_intersect(&dst_clip, &fb_rect))
+		return;
 
 	lines = drm_rect_height(&dst_clip);
 	linepixels = drm_rect_width(&dst_clip);
