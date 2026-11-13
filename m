Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8ED606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+9irfcc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094C810F01B;
	Sat, 14 Nov 2026 16:25:01 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361421124FB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:07:14 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1148534f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794568032; x=1795172832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfZv2Mhpvx4fsCO+edwWL5VaXm+dQyuGhCIxgRMvJOc=;
 b=G+9irfccj804IK8mNF0ih9Zp9ZSzZirzy7ECYAz0//CT+TNijjqHoKqeQWeSxQGpB5
 yX1PWFRyv6dxN+dhEl8z9c17sXfGvQFYMrv1tYVmg6mNU0X/IxrhydArwLfECIVDRF3T
 PLKjspOOh2uwWGGZqe+qxBw/BNDdXsMGVSC6B4ccmI+SaugaYZ3KRd5e1vZbaHb7BEVa
 CJw/0r56NNC6ujtY1qtozo4yG3RNoyubIKOiTdbyM0BmRivgreX9Dysgibo6Cn2gZDRo
 4uqCZMwlorxz666urFPRNLwIf9zF5RBLzQG+34Iug4zPYC3TB32qyQtPZOp4mRNq+s1M
 4HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794568032; x=1795172832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfZv2Mhpvx4fsCO+edwWL5VaXm+dQyuGhCIxgRMvJOc=;
 b=BJjwH/deLnBJp1P5xLHaKA9cuBDnfxbCx+pz5ndp92GhRnyy5l0MIed0SXz+RA3brn
 0X5uunJAidu4GXV76BmR6FxL/SqybzGPV6EICe+GJJJr7rhbzfaBhsGpCh+Z8vMVaKKI
 LkT3GdWkUF1abwIRhADerfd11CMapNIPh8S3ItmIdUSMmU0peW5QSEq1VM6Ggj5mk110
 diB5wpa//Z1gC98tnSgzYiIhurzoeZ+WT48N39zqaxfbpXQ7an+VwxYa4Ub48SDh9yDd
 UavZ6a7DqD2/d86u8puyd0CtlXV+XByrk3Cj7VaihLtpaKUvHV9ZrqFlSp3NKM2JOcnt
 AqXg==
X-Forwarded-Encrypted: i=1;
 AL+hErGPTkUjacPVCwIIidSHUscvpGfZhCpgQkbw04cV+sMO9tuLBs/yheFBo7Hxb1Uh5oc5qnPGW+E50KI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8N3YQQDDn61E475J+Brm/RrUtjEYKYotO9J+GQyj0AHz6Lf6hD
 SRJspV/C/tGdKqvOZlfdtuSGboNss33Ds5pj3Glhq26n1pLQC7/0A0SG
X-Gm-Gg: AYBFou1TNzPptqcKL1eqk7xxlNGNb4z5R2sBGDMp3AQmeRWsdwFWN/57JArZmZYzDs1
 WB79KxgsJydzzj8YqftFnSiTKcP20UshZSSEiNPB84yAStgREtcCtI1KPgHU4dbOWYAHJIn6e+L
 Z34Dq2bwMrdm8uaQEzQ78/zlvlWoLwlT4M8Reh+Hm1sxFMGJ1NAuOmncbI2Z8TVtdt0FXcQmD7Y
 qLcEOh5sBd/Q0K02iDIm5/EHOkBebJHZa1LrNpCfIs72Agr6bzxL2DHZH1zgKtOP+Huwc3oX3rZ
 UoocK/sGmG0CNCNnqgVkkTu19BpctNwXt9JTLwa/Y/7I+SFMQvpieIHB76Kvmm4zdO6f+tEgrzA
 QdShfMK+xPK2Ee+OyxlsFcQ4HUCADyQhJY96RbZqn58+yT2t+Ml4348TKKSacpoCBDPy7WFjZmw
 A7n90h9akczWoJtOgGp7rnGmuHWvxIpDSR7XfV/0Rxxz6pKBZ2Cqgv8hbKzC2PecY0+rkilyMdU
 p9ceeyxK/lKRPsWczXMx94NDwANXLOZdKVb1D+qR7DjY+XDnykTTsAMMr+4aNonNzAowyU2rxHa
 N8VH3Ko0zh0Za8YPBmSkpZ45vMbgkVhmshfIrDUyJL5DRZbctgfXXvPIdMPr6m2PEcW+epRxwA=
 =
X-Received: by 2002:adf:e00e:0:20b0:490:1881:80ec with SMTP id
 ffacd0b85a97d-49c710c24f8mr3546674f8f.36.1794568032302; 
 Fri, 13 Nov 2026 03:07:12 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f5972a7sm4388458f8f.21.2026.11.13.03.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 03:07:11 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v2] drm/fbdev-dma: Copy the shadow buffer on unblank
Date: Fri, 13 Nov 2026 12:07:08 +0100
Message-ID: <20261113110708.927665-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
References: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
Changes v1 -> v2:
  - Do not flush the damage before unblanking: nothing can reach a
    display that is off. Instead, in fbdev-dma, copy the whole shadow
    buffer into the framebuffer memory on unblank, which needs no
    display [Thomas Zimmermann]
  - The fbdev helpers are unchanged, so the title changed too; v1 was
    "drm/fb-helper: flush damage before unblanking"

 drivers/gpu/drm/drm_fbdev_dma.c | 44 ++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 452f84400350..cc8813538bd9 100644
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
@@ -196,6 +187,41 @@ static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
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
+	 */
+	if (blank == FB_BLANK_UNBLANK)
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

