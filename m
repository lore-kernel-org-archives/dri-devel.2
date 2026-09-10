Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CAEC79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE2F10F536;
	Fri, 11 Sep 2026 07:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aboh/g+Q";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE6410E1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:51:11 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-864cd11a932so4736107b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789066270; x=1789671070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6m8h8p8x3swINqHznguOqnp4bmSBliy9kDD6omjjK2s=;
 b=Aboh/g+Q1I70y5ydBMvU3a4I9kS/5b/E3omSjdrMQrnJdJ4IviH+8pBHWoi4HhrvZB
 JSuwaWPBZQY8swwHTTgLX8q92UNgxtJxE2rSA8qlGS0zBLsxu6830Ruu7h1VGCKs+0f4
 cx1OwbcQdZjE8euvIBP1dlXkYrrItD6f58HuwbKVkFxaUSSPJujzARhM9eB2DJv++tRb
 JARvPfY/BwY/qsmr7GXbq6DPHz/bfhXEd4313oD9w7/rucOgNFew2WEBHbBS7EJ2E+Dy
 b8EcGQ7FfX+hJm4yPJnP7al8X88IIQou9qJv1oG0T3LXFkuO/JM3H/b0KT/D4IgTf0gA
 ehQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789066270; x=1789671070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6m8h8p8x3swINqHznguOqnp4bmSBliy9kDD6omjjK2s=;
 b=R/6PNzLL7nxJxLWoi8eaMZPVJo/IW8YltlD92mCSrody/o0IeTLngQz/iniudNHptT
 k5KFbt2ouK3KZgSnufGGoisFWHHMF63aF1OWEzRkLNiMGs60rixmU1LW+1OwgfeN6tt4
 3esWG5Abf4XnyPDcUXjyeDUIYDf2eEym6VEsLKq9K1hwmhWJaxSte7fzTSLArCvGWeLr
 5ioRD4pJjNGJOY91Myq+V7m0gJzba8FNNwjyEQ/s8nczR+9a8Jf/SH+fH+ymOXa12ejy
 3yFSDQg7xMeQ8rjFXFwczhCrBb5tC3owEwA14YNRzn74Mk3ABMsz3PEJP+K1QIJfOtTE
 0bcw==
X-Gm-Message-State: AFuF++kg3mYLtPcRRte1nrdoa7sjKFpxtUMSTzFM1NUcKXqdpSpnmWcw
 lR3iBJgxfLyd0GoLdlktAqz8a41upTNLAzwWYH3pvStU33I2w1y8GlB32ApUX8N8
X-Gm-Gg: AYBFou21pVFrz0mKaV7KM1Obqf/ZNwFmzxq1ApO1ShqNddWnHSAflHWKBTvn5Z/3Adx
 25gSarUMlFMe4mrw7uXGBhBiqi00XuPfLWf0e68eb5foPy+nVlftaOJPDKg+2kcQxeLbRZuD5nP
 Z0Pp7UlI+hglKC6/WaI8u8E7e25GES6O9t3MoxP++JL3cM/a3IthFoRNRL0FBe5pUGLzl7EZHAi
 tKTfJi4G/wCGeB8cOmyfZ1nOYf+sqp7PerRayt87S4aseTNk2tWmapOSSH/0n9yZ1sd3gpPyHpb
 u1feotHIfh0x8smOR7kGewnRbKoar7yvr65/lot7rceDjndpktcmHeuQFVo3DgmVV5hB82x39Iz
 iycb2zvG3woEWberlcTzpwhXHQrI8iJltDTmFe7rp3D7W2b8IBwY3gHVRAjUgB8l239g2ZcVwc4
 nhf5wQsYfxy6iuAyGH+wJC4J962sfLhGMfyZDhEdTvYAcoY7BcvTdKbWLn10uwCH6ChFIr0dnN2
 hWs4WMZgw==
X-Received: by 2002:a05:690c:9c04:b0:861:7cb6:5790 with SMTP id
 00721157ae682-88200ebff7cmr20543767b3.4.1789066265217; 
 Thu, 10 Sep 2026 11:51:05 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-88486086a50sm3291707b3.17.2026.09.10.11.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:51:04 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v1 2/2] drm/tiny: allow a framebuffer larger than the panel on
 MIPI DBI drivers
Date: Thu, 10 Sep 2026 13:48:57 -0500
Message-ID: <20260910185030.870-3-frazinjonathan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910185030.870-1-frazinjonathan@gmail.com>
References: <20260910185030.870-1-frazinjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

