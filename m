Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE9FC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB24010F905;
	Fri, 25 Sep 2026 07:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EyMitim5";
	dkim-atps=neutral
Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com
 [74.125.224.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F7810F16C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:07:36 +0000 (UTC)
Received: by mail-yx2-f42.google.com with SMTP id
 956f58d0204a3-672ce86b21aso1580166d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194055; x=1790798855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6m8h8p8x3swINqHznguOqnp4bmSBliy9kDD6omjjK2s=;
 b=EyMitim5/wDijRPEIH0rz3WnaK/03QViGIETm2Lsvao6q1rWxYn9Lb8i0cW/vdZi3X
 cWqJm3Lf+26ZR0zNYQ7d1b/kgO6x9AwLuVFY8lrov3wBRxJrX9AFxQhM3GNntIZ1I95v
 08Nu3/t4PFlhpKPjZNPX4GWzXfaizfP62wksuFNTCLUjy+17VK6TfultUK4zAXoXg/9s
 4wO/T8zfw7ODFqIDSC5sgUkrBGZfSfswnMdLhGaPF5UQ7bfQHRTsFzBMdgN3bv7u06U3
 qioou9BXs6O8fCFS2eOcslgBGZwS5ClO7+fNu6BjnBYrvJwOriU8atK+o/HbUSF/QUe7
 BcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194055; x=1790798855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6m8h8p8x3swINqHznguOqnp4bmSBliy9kDD6omjjK2s=;
 b=O9WdbAW3WkXryyaq1gB3rv4dB9+dj7Y3maqiYlY2tFTW9wAkDeaiTqSazIu1aGyFL0
 lznQUtLvlRiPNwdoPPvgtJIzMMPqV8eYu2tXLWx4D60XHyLN0uWJ/rp/wI5yi+DO0laz
 MmLrKoJsAYRz6y9tCrytG0k9CSXL/SymwVl11T7z7DBJ8YQMZMQwxk2ktEpDeLkIsGq3
 NE4WPNLdxsbDaXOJfJ/vBKLYXuGeGxyJohAcdIHh/AfiuTQ/SMxSQPbQZqBoyiTFk+V0
 fgvOzKUnifI1Iggbh9gYDzBfFXsM1uwShDwI5ikPZM6sDCYgqjSZvTMm8qnNtWRJxMrg
 4R2Q==
X-Gm-Message-State: AFuF++l7/A7rSsP4MMkjCKLGG7FDVdNgpGsoMq4qyTXvM1QUC3SZVSpK
 FJTusFDNgzdpzVsqTmIQ7WqAfBnpgaCu1yIgV5chRFVql2clB5pSvSl2rQMg4Mcy
X-Gm-Gg: AYBFou2v+K/+eBIahPp84aJCDGs6f512aWGusHh8yKEHsjeFpi4iAhyJDEGV5z+865c
 ltMtH9pJnkEjluY55d8xFQgxAPxa3wUMbeBR1hkdwkdvg3MoPK5m1MjS9cMleeusw91/ocPrzLu
 zCNDmZ85yJ9HQWBMUzyTTIWrAShRynVnqn6Nqh9YCLnrEXgGTjL1ukk4Git03w6a9FULJhwKE5i
 7Y6/SHeZYK8kYBuEEb47Ovn1S/uN60CCXh3BxjfmHa8XoDbKkAMMg0UJdvy9WP7f3xuCjPEsI+s
 1fIjHKPuJnH/SrNg50c2rsG+6ju2lD2THz3DHYT6UeHRfw4SmSSh6T+uMvaRaWnNhmnr9y4ji4r
 BM7UBb3y9KZcNO7ZYiEJ66Yw/nTxTBq1N/fD+iAAigZas4pbPAvkv3gRIu06FajisonIx5l/13/
 Umyv7cR+FBgGIgAB/zUs8QFEN/V0bmvUdosUHBFGpq3ZHcVwHJs2h5gTp+Ixzk+qyUzIPIyr2nI
 +tczXDMqMY8L1ucs3T2
X-Received: by 2002:a05:690e:144f:b0:66f:c1bc:408d with SMTP id
 956f58d0204a3-672ed3e7bd8mr217573d50.80.1790194055472; 
 Wed, 23 Sep 2026 13:07:35 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d80bea23sm1221915d50.10.2026.09.23.13.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:07:35 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kamlesh.gurudasani@gmail.com,
 lanzano.alex@gmail.com, phil@raspberrypi.com, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 2/2] drm/tiny: allow a framebuffer larger than the panel on
 MIPI DBI drivers
Date: Wed, 23 Sep 2026 14:57:12 -0500
Message-ID: <20260923195713.88-3-frazinjonathan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923195713.88-1-frazinjonathan@gmail.com>
References: <20260923195713.88-1-frazinjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

Every drm/tiny MIPI DBI driver pins mode_config.max_width/max_height to
the panel size, so KMS rejects any framebuffer that is not exactly
panel-sized:

    ili9341 spi0.0: bad framebuffer width 480, should be >= 240 && <= 240

Raise the maximums to DRM_SHADOW_PLANE_MAX_WIDTH/HEIGHT (which its
kerneldoc recommends for shadow-plane drivers) on the drivers that flush
through the shared drm_mipi_dbi_plane_helper_atomic_update(), so a client
can allocate a larger framebuffer and pick the displayed region through
the plane source rectangle - a crop / pan with no scaling, now that
drm_mipi_dbi honours the source offset (previous patch):

    ili9341, hx8357d, ili9486, mi0283qt, ili9163, panel-mipi-dbi

The fixed mode, the minimums and the connector are unchanged. The plane
check (drm_mipi_dbi_plane_helper_atomic_check) still forbids scaling and
repositioning, and the transfer buffer is sized from the display mode,
so the flushed rectangle stays bounded by the panel regardless of the
framebuffer dimensions.

ili9225 is left out: it has its own atomic_update / ili9225_fb_dirty()
that addresses the panel from the damage rectangle without the source
offset, so raising its limits would let a mispositioned buffer through.

Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jonathan Frazin <frazinjonathan@gmail.com>
---
 drivers/gpu/drm/tiny/hx8357d.c        | 8 ++++++--
 drivers/gpu/drm/tiny/ili9163.c        | 8 ++++++--
 drivers/gpu/drm/tiny/ili9341.c        | 8 ++++++--
 drivers/gpu/drm/tiny/ili9486.c        | 8 ++++++--
 drivers/gpu/drm/tiny/mi0283qt.c       | 8 ++++++--
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 8 ++++++--
 6 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index f942a8d09..0599b8ccf 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -320,9 +320,13 @@ static int hx8357d_probe(struct spi_device *spi)
 		return ret;
 
 	drm->mode_config.min_width = dbidev->mode.hdisplay;
-	drm->mode_config.max_width = dbidev->mode.hdisplay;
+	/*
+	 * Allow a framebuffer larger than the panel so a sub-region can be
+	 * displayed via the plane source rectangle (crop / pan, no scaling).
+	 */
+	drm->mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
-	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
 	drm->mode_config.funcs = &hx8357d_mode_config_funcs;
 	drm->mode_config.preferred_depth = 16;
 	drm->mode_config.helper_private = &hx8357d_mode_config_helper_funcs;
diff --git a/drivers/gpu/drm/tiny/ili9163.c b/drivers/gpu/drm/tiny/ili9163.c
index 884242450..fe6c13056 100644
--- a/drivers/gpu/drm/tiny/ili9163.c
+++ b/drivers/gpu/drm/tiny/ili9163.c
@@ -251,9 +251,13 @@ static int ili9163_probe(struct spi_device *spi)
 		return ret;
 
 	drm->mode_config.min_width = dbidev->mode.hdisplay;
-	drm->mode_config.max_width = dbidev->mode.hdisplay;
+	/*
+	 * Allow a framebuffer larger than the panel so a sub-region can be
+	 * displayed via the plane source rectangle (crop / pan, no scaling).
+	 */
+	drm->mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
-	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
 	drm->mode_config.funcs = &ili9163_mode_config_funcs;
 	drm->mode_config.preferred_depth = 16;
 	drm->mode_config.helper_private = &ili9163_mode_config_helper_funcs;
diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 003381aa2..1e4bb56e3 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -282,9 +282,13 @@ static int ili9341_probe(struct spi_device *spi)
 		return ret;
 
 	drm->mode_config.min_width = dbidev->mode.hdisplay;
-	drm->mode_config.max_width = dbidev->mode.hdisplay;
+	/*
+	 * Allow a framebuffer larger than the panel so a sub-region can be
+	 * displayed via the plane source rectangle (crop / pan, no scaling).
+	 */
+	drm->mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
-	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
 	drm->mode_config.funcs = &ili9341_mode_config_funcs;
 	drm->mode_config.preferred_depth = 16;
 	drm->mode_config.helper_private = &ili9341_mode_config_helper_funcs;
diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index fab8bd7ce..de33d702a 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -309,9 +309,13 @@ static int ili9486_probe(struct spi_device *spi)
 		return ret;
 
 	drm->mode_config.min_width = dbidev->mode.hdisplay;
-	drm->mode_config.max_width = dbidev->mode.hdisplay;
+	/*
+	 * Allow a framebuffer larger than the panel so a sub-region can be
+	 * displayed via the plane source rectangle (crop / pan, no scaling).
+	 */
+	drm->mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
-	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
 	drm->mode_config.funcs = &ili9486_mode_config_funcs;
 	drm->mode_config.preferred_depth = 16;
 	drm->mode_config.helper_private = &ili9486_mode_config_helper_funcs;
diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index b0121e89e..df3801914 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -290,9 +290,13 @@ static int mi0283qt_probe(struct spi_device *spi)
 		return ret;
 
 	drm->mode_config.min_width = dbidev->mode.hdisplay;
-	drm->mode_config.max_width = dbidev->mode.hdisplay;
+	/*
+	 * Allow a framebuffer larger than the panel so a sub-region can be
+	 * displayed via the plane source rectangle (crop / pan, no scaling).
+	 */
+	drm->mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
-	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
 	drm->mode_config.funcs = &mi0283qt_mode_config_funcs;
 	drm->mode_config.preferred_depth = 16;
 	drm->mode_config.helper_private = &mi0283qt_mode_config_helper_funcs;
diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 60cd65cae..a0a098b0d 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -448,9 +448,13 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 		return ret;
 
 	drm->mode_config.min_width = dbidev->mode.hdisplay;
-	drm->mode_config.max_width = dbidev->mode.hdisplay;
+	/*
+	 * Allow a framebuffer larger than the panel so a sub-region can be
+	 * displayed via the plane source rectangle (crop / pan, no scaling).
+	 */
+	drm->mode_config.max_width = DRM_SHADOW_PLANE_MAX_WIDTH;
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
-	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.max_height = DRM_SHADOW_PLANE_MAX_HEIGHT;
 	drm->mode_config.funcs = &panel_mipi_dbi_mode_config_funcs;
 	drm->mode_config.preferred_depth = bpp;
 	drm->mode_config.helper_private = &panel_mipi_dbi_mode_config_helper_funcs;
-- 
2.53.0

