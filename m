Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79357F46C69
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 17:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8AA10E28B;
	Mon,  6 Apr 2026 17:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q56vpvh7";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA5810E269
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 15:37:43 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-386b553c70eso33676661fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775489861; x=1776094661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=OT0m2cjrqDSfo99BQTDsCGng9x/9w2Ex3suv7RFRwgk=;
 b=Q56vpvh7Pzgb16/GuJZ9Rlfd4Oo1KDKLPPFQ9ACFyuJDCyMH48QgmjsoI6+CGTA4Y7
 PHV8LmwLuzpBSHJk2LmNQpdT0YCvx/xwSE8ooDO1V7ioJCtCcdKsIKhuXKx1lUPJG7nA
 QT1fWrJ3k5GWM6/sDmEriKIJ8GbdArQqYOk/wyrAUbNDHiOtwJKRL8p/z5Hmyrpee1RR
 UsiYWqxBjcki9W0NqRWBOOrOc3IMEihnd90wzUA5p175zQdoZXBSRftLiq3HCEGH2zUj
 G+VX7Fyu16aZPr+tj1OUdrGRDM6wHGQLoQ/PkwdWJjmfMRyfs7SZvNltBRJQPY0AIGgQ
 qS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775489861; x=1776094661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OT0m2cjrqDSfo99BQTDsCGng9x/9w2Ex3suv7RFRwgk=;
 b=SWQTZC9Od2/Te70J/JAUkcTnqD/08CP88cePtzk1MDLzA9gxV9Sz/b2/GjsgXdLDTC
 ZIrvTNkghxzrxt1kgEZzLiEFv+ubpIDDxlrLepTklXaYkPGLhqbSR/UZbBDaFhdT4l14
 yMN5G4DUnq57WmIAYbVPLFKOjQ/XuJ+0GStIJKcjn5eI9p4AjxFmqa9A9Y81bb+mGFa6
 5CQzDIqzjojtvLJLHmmuCrh114GIx5GmRvGf0dopjb6jSjMdWFdBmLQTJRP/H5AHOkY9
 wfrMzXJXsIcFFZjg4F8L0OOm8/LqkpwCA99BNQMdicrA7T2PFPyYfyHm69/Yz7/HNnfJ
 poww==
X-Gm-Message-State: AOJu0YzW71g+s4uYH3QAATJSOFmEs/L5BbKPttgcvukbcYztpH5bp3JE
 HZnBSykmrFPV6oKyUUwKy96Ugs53VUo6qJqPm8DUTwXmHCGs4OchAQ6y
X-Gm-Gg: AeBDietWah06pWzrGTgdac1B5qzXym5TDzk2s4HMhMJ1JJ7eJLiY9cQ3Ua4/mwLNQgP
 nKPWVwWiBxLWNJ8xAFRnj6QIyM6Pr2TIVlOqpcN4WTgFupB5nVg1VMbxHGpypE/a1wpEOMN/Xe6
 EnTg8tLMtlOWnFibRAbaEnlKI5FzytJ/nRvbM8Ct4umG2yaNL6G3twauY3Z8InILWmIAnJ+J9eb
 HuTe+1qfZEQXx/2Ng9eCgNCo8rZOvPykyikL/RwuaNS9EhemOoRzbTHo4f3U71jqyuRu0Fi18Sp
 AqF1XlgoBi3Giq7e0eRddYJvSGziLdgFHDqTuwvY7ZVIGsrbJW1WczQpCeZiZHcejOSxNAl3x4K
 rtMPLFXjkY+joZfGYk+vq8iPYST788t50H6bSB78M8Tw3g6sg4cczWgnXXgHmdWkV1s0nan0cwn
 /rZHqUI7nr4ydGXD5v9Uvp1+oz/6CUttviJX9XamwEXOL0IYlaLBKD
X-Received: by 2002:a2e:bd81:0:b0:38a:5102:9190 with SMTP id
 38308e7fff4ca-38d91d72c8emr37975631fa.28.1775489861128; 
 Mon, 06 Apr 2026 08:37:41 -0700 (PDT)
Received: from nano.alefors.se (83-233-6-82.cust.bredband2.com. [83.233.6.82])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd2108a4fsm30781991fa.23.2026.04.06.08.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:37:40 -0700 (PDT)
From: =?UTF-8?q?Magnus=20H=C3=B6rlin?= <magnus@alefors.se>
To: p.zabel@pengutronix.de
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 =?UTF-8?q?Magnus=20H=C3=B6rlin?= <magnus@alefors.se>
Subject: [PATCH] drm/imx/ipuv3: do not adjust hactive for non-8-pixel-aligned
 modes
Date: Mon,  6 Apr 2026 17:36:54 +0200
Message-Id: <20260406153654.2094908-1-magnus@alefors.se>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 17:44:33 +0000
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

The IPUv3 display driver rounds up hactive to 8-pixel alignment in
mode_set_nofb(), stealing pixels from the front porch.
ipu_src_rect_width() applies the same rounding to the IDMAC read
width. While this keeps the DC and IDMAC in sync, it causes the
display to receive more active pixels than the mode specifies.

On fixed-pixel displays whose native width is not 8-pixel aligned
(e.g. 854x480), the extra pixels cause visible skewing: each
scanline is offset, making vertical lines lean.

Remove both alignment overrides. The IDMAC and DC now use the exact
mode width. The DMA burst size is already adapted to arbitrary
widths by ipu_calculate_bursts(), so no alignment is required at
the pixel level.

Demote the DC warning about non-8-aligned hactive to dev_dbg, since
it is informational rather than indicative of a problem.

Signed-off-by: Magnus Hörlin <magnus@alefors.se>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c  | 9 ---------
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 9 ++++++++-
 drivers/gpu/ipu-v3/ipu-dc.c             | 5 +++--
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
index a18b9d1a6..47b88f29a 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
@@ -304,15 +304,6 @@ static void ipu_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	sig_cfg.vsync_pin = imx_crtc_state->di_vsync_pin;
 
 	drm_display_mode_to_videomode(mode, &sig_cfg.mode);
-	if (!IS_ALIGNED(sig_cfg.mode.hactive, 8)) {
-		unsigned int new_hactive = ALIGN(sig_cfg.mode.hactive, 8);
-
-		dev_warn(ipu_crtc->dev, "8-pixel align hactive %d -> %d\n",
-			 sig_cfg.mode.hactive, new_hactive);
-
-		sig_cfg.mode.hfront_porch -= new_hactive - sig_cfg.mode.hactive;
-		sig_cfg.mode.hactive = new_hactive;
-	}
 
 	ipu_dc_init_sync(ipu_crtc->dc, ipu_crtc->di,
 			 mode->flags & DRM_MODE_FLAG_INTERLACE,
diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index c1c7be4e2..58e7853e6 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -34,7 +34,14 @@ to_ipu_plane_state(struct drm_plane_state *p)
 
 static unsigned int ipu_src_rect_width(const struct drm_plane_state *state)
 {
-	return ALIGN(drm_rect_width(&state->src) >> 16, 8);
+	/*
+	 * Do not align width to 8 pixels here. The IDMAC read width
+	 * must match the DC/DI hactive exactly, otherwise the DMFC
+	 * FIFO overflows or underflows causing IDMAC timeouts or
+	 * display corruption. The DMA burst size is adapted to the
+	 * actual width by ipu_calculate_bursts().
+	 */
+	return drm_rect_width(&state->src) >> 16;
 }
 
 static inline struct ipu_plane *to_ipu_plane(struct drm_plane *p)
diff --git a/drivers/gpu/ipu-v3/ipu-dc.c b/drivers/gpu/ipu-v3/ipu-dc.c
index b038a6d73..f5990e3dc 100644
--- a/drivers/gpu/ipu-v3/ipu-dc.c
+++ b/drivers/gpu/ipu-v3/ipu-dc.c
@@ -168,8 +168,9 @@ int ipu_dc_init_sync(struct ipu_dc *dc, struct ipu_di *di, bool interlaced,
 	dc->di = ipu_di_get_num(di);
 
 	if (!IS_ALIGNED(width, 8)) {
-		dev_warn(priv->dev,
-			 "%s: hactive does not align to 8 byte\n", __func__);
+		dev_dbg(priv->dev,
+			"%s: hactive %u is not 8-pixel aligned\n",
+			__func__, width);
 	}
 
 	map = ipu_bus_format_to_map(bus_format);
-- 
2.39.5

