Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92C606A333
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hs9UsmK0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837D710ECE2;
	Mon, 16 Nov 2026 08:58:48 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AF810E05E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 20:13:58 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-491846221ffso2013383f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794687236; x=1795292036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XM7BpeTGYOLjRkRQmnd19ZT1duE93Nk/WZMbz2kREV0=;
 b=Hs9UsmK0gnegQ903EHffctohs088dM6pIT8yww3YoZhYo7zHhHizicv3M/rlQHN42I
 OC4yQXGNIoxSR7XAHY1ZvPmJFIMcumDiXZyUpLtZbluuUVB3EAprC7yc1fkqK+ZvbC1o
 VQrOpx7mlLLjKwl/eXgVBKVrPK+vj04ogpfHLYhSneMhGAm58ViE4VQyCuW0ZuMWv8F3
 h2/fjc27gz06b6dqpiB0RrJCka3+NQdWXbKNdHBBJpQLxN48SP7jswiF9CHxAcqwdfFa
 G6Pii4KH5Pp2wdN0l0Z8PmmZMORUxiKeCDFW4BhXleLfSC4V3nYaf9HatHK20jb8rUzw
 +d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794687236; x=1795292036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XM7BpeTGYOLjRkRQmnd19ZT1duE93Nk/WZMbz2kREV0=;
 b=23oXJ+m242vJya9dUn8G+1b7yKft3Nk5aedJDqyQe514PG+80uydjCoednPHp0D7r6
 kD1KndmFP7/KMusbPrktljFs+Q0dI8+EUXP9fy8zanZrOesjs11AwgJHXsplDdO2Svw9
 GFjZv2dlFaWh4FE28MR5wqotanvJ2D+U1wknqiISXvd4tuoheCZKa8kQVEYCJ3tk0AUN
 aRk0fSZ+Eml1vD60YMvKgVihmwkA6dRctjFCn3gigrM5DEZyMA2VbPVFjcZcVt+YbdyL
 Tl/8XrlJEaiB2LFaaeRuN/mk9W2cfw0ejOiInbbYEZ+Jaabc91CpZnGa86ss3vbd4hQU
 TWlw==
X-Forwarded-Encrypted: i=1;
 AL+hErF/2RYQb701gpsHdn9jkyeZOmoyfD96FCRKezbQJirNCFhreZLtLvPIkm2FAnHaj/w9maiOJdOHwzw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/dfoeBxVKGfUHk1DiOHBCyXnW/Og3TX1grqZJNJSWHlTyXZRB1
 B5wNHEbD/YQSTjxKenOvrznBH+T1Vf9/2lT2AMOk8HgXGYU4OQ85Pdus
X-Gm-Gg: AYBFou3XDbMQ6oRmuRqK3ZkOpuV+HHpgpl3OZJo+ymRiKHbRNpM1IKJ5r36HvK7F7HW
 QwSlfMSQYsp6qWH6WdAAJNFGr0KxmenIo28Fk4OVfUCKOX2U5UHY4FYzPT1AhdLk9fTB1sVyI+h
 Rctn9UguoEcX7apvBwV4jBHhZWPv9VqpeGT/cyb4IDDuw8u2m3NtoOQq8PL3FuNpIdqL+gVyavR
 I/MBqC1krQJR6U4wNnrDv+wcsKfTVsoV3gfPy7d6MF2KHZXbKzhaut7eU7LdB1HXZZUOgZyA3wy
 N+izvv+5MFsnTu/9yPk+QwozupcmRvTyb/xk3OfTQZjCX40Uxk5i2QSCidBlutAM/UAvfjDeCGH
 bfuwAAMGfT2YvhjHqbyEpU8MlBRPMS/1P+aivJvbJagX6iD1ZeVab6Zevg/YEinPmBQExz0L7mr
 PJ2U4obFr66hsjN8nE/n+wl3q9j8Zf6esDizmzX4EzQdKYuNZXtaty8k78sviQMBYQ6/kJs0/2c
 p6rGEhMbreEQFw9MM0MiCMLUWYuxz/zuHE+1KKpv+Fw0aEBtcfc7IBdhXMLahYWN/Q9SmBRM0M+
 rLdQeCd9ATW9qm03aOHIcX1AfDCI5tAvWCB1LEgIMFJPxF4bRL+D
X-Received: by 2002:adf:e009:0:10b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-49c70de3892mr9802380f8f.10.1794687236291; 
 Sat, 14 Nov 2026 12:13:56 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe373casm12121473f8f.30.2026.11.14.12.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 12:13:55 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v3] drm/fbdev-dma: Copy the shadow buffer on unblank
Date: Sat, 14 Nov 2026 21:13:51 +0100
Message-ID: <20261114201351.2788719-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113110708.927665-1-angelo.compagnucci@gmail.com>
References: <20261113110708.927665-1-angelo.compagnucci@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With a shadow buffer, what userspace draws in fbdev reaches the
framebuffer memory only when the damage worker runs. Turning the display
on shows the framebuffer memory as it is. So a program that draws its
first picture and then unblanks, such as a boot splash, shows an older
picture for a moment.

Seen on an ILI9341 panel (tinydrm ili9341): enabling the pipe sends the
whole framebuffer memory to the panel, still black, and the splash only
replaces it once the damage worker runs.

Nothing can be flushed to a display that is off. But the copy from the
shadow buffer into the framebuffer memory does not need the display. On
unblank, copy the whole shadow buffer into the framebuffer memory before
turning the display on. The damage worker still flushes the damage once
the display is on.

The copy takes a mutex. Skip it during an oops, when the console is
unblanked in atomic context: drm_fb_helper_blank() does nothing then.

Fixes: 360399643299 ("drm/fbdev-dma: Add shadow buffering for deferred I/O")
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
Changes v2 -> v3:
  - Skip the copy during an oops: it takes a mutex, and the console is
    then unblanked in atomic context [Sashiko AI review]
  - Add the Fixes tag [Sashiko AI review]

Changes v1 -> v2:
  - Do not flush the damage before unblanking: nothing can reach a
    display that is off. Instead, in fbdev-dma, copy the whole shadow
    buffer into the framebuffer memory on unblank, which needs no
    display [Thomas Zimmermann]
  - The fbdev helpers are unchanged, so the title changed too; v1 was
    "drm/fb-helper: flush damage before unblanking"

 drivers/gpu/drm/drm_fbdev_dma.c | 48 ++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 452f84400350..3effc5c05d9c 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -93,15 +93,6 @@ static void drm_fbdev_dma_shadowed_fb_destroy(struct fb_info *info)
 	drm_client_release(&fb_helper->client);
 }
 
-static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops = {
-	.owner = THIS_MODULE,
-	.fb_open = drm_fbdev_dma_fb_open,
-	.fb_release = drm_fbdev_dma_fb_release,
-	FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
-	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_destroy = drm_fbdev_dma_shadowed_fb_destroy,
-};
-
 /*
  * struct drm_fb_helper
  */
@@ -196,6 +187,45 @@ static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
  * struct drm_fb_helper
  */
 
+static int drm_fbdev_dma_shadowed_fb_blank(int blank, struct fb_info *info)
+{
+	struct drm_fb_helper *fb_helper = info->par;
+	struct drm_clip_rect clip = {
+		.x2 = fb_helper->fb->width,
+		.y2 = fb_helper->fb->height,
+	};
+
+	/*
+	 * Turning the display on shows the framebuffer memory. Copy the
+	 * shadow buffer into it first, so it holds what was drawn. This
+	 * does not need the display; the damage worker still flushes the
+	 * damage once the display is on.
+	 *
+	 * The copy takes a mutex, so skip it during an oops, where the
+	 * console is unblanked in atomic context. drm_fb_helper_blank()
+	 * does nothing then.
+	 */
+	if (blank == FB_BLANK_UNBLANK && !oops_in_progress)
+		drm_fbdev_dma_damage_blit(fb_helper, &clip);
+
+	return drm_fb_helper_blank(blank, info);
+}
+
+static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops = {
+	.owner = THIS_MODULE,
+	.fb_open = drm_fbdev_dma_fb_open,
+	.fb_release = drm_fbdev_dma_fb_release,
+	FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
+	/* DRM_FB_HELPER_DEFAULT_OPS, with a blank that copies the shadow */
+	.fb_check_var = drm_fb_helper_check_var,
+	.fb_set_par = drm_fb_helper_set_par,
+	.fb_setcmap = drm_fb_helper_setcmap,
+	.fb_blank = drm_fbdev_dma_shadowed_fb_blank,
+	.fb_pan_display = drm_fb_helper_pan_display,
+	.fb_ioctl = drm_fb_helper_ioctl,
+	.fb_destroy = drm_fbdev_dma_shadowed_fb_destroy,
+};
+
 static int drm_fbdev_dma_driver_fbdev_probe_tail(struct drm_fb_helper *fb_helper,
 						 struct drm_fb_helper_surface_size *sizes)
 {
-- 
2.53.0

