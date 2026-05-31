Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE43DCD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D51112B7D;
	Sun, 31 May 2026 13:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IX+hF9zm";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE3210E0E0
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 07:36:39 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8424b6792efso5250b3a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780212999; x=1780817799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKPe1TO+FoogghrC8LGLLeXq7GSJc49agxpkGaHZqpM=;
 b=IX+hF9zmvwucsZBuFlv79X5SFoHxZM5DfSPIFjbXcO432JumUmaxkNH7AIt4ZzNv+3
 DBXYuAfuIpzSezkIjdBRz9/85aPUWgBFzzmyWaJ6JoGGWufhfS5X3k9eRgJIZFncOyY5
 hEXtg1tBl+cWImbCpgCW996q5LSfgegrXkAQWszeoh3aga362gef6ylHM9zHLuXIxrw4
 AlBPt9qRYRm+xikB1sO92Kzb2liJnVpXq8ehD6OEoU0RNp18VcRtIwmmRUccL7He8v66
 5zg4XKDJD2tFFVIleac9fsj5plkPa/p6rYmCPtTL3ff4RWLY162oG4mMwSLPi5Ez14OE
 i3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780212999; x=1780817799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKPe1TO+FoogghrC8LGLLeXq7GSJc49agxpkGaHZqpM=;
 b=MKJRyuEvt2/xpSepPtBf0tIu0ViyoN+6cbxz+M4FuJuXIc1p2yKH6dttzXbWV4h56f
 8/PxZkpcOQWvmwmY+1x2WRZFxrO/fDxCZi1AFnqxK6U9gAi/rA1f1X4FW0UeYn450PzM
 baHNS7Yi+DzBiFZRRE3REI/6uRpE6eAZDjt+wmyj0fbYCQvt3EKdSIpn+jez8koRj9MM
 dfT6jcngeAKkB4egXdZAHIENnfWeAwYZqDkrFtnsA8Od8bma70EkaaTlhBUFvFC/1OQ2
 gUGZe65TeCsLe9ORsttEOJuY1pkdFvOixpvuSEQTclvhoRoKN+QqTAh6ve3STytOG767
 SIYA==
X-Gm-Message-State: AOJu0YzmatT/gcNTIt84JBzPQPfJJd95qBpdukwSx0vfV2xpH7rsJASj
 5c6LjdiKPZPX2RWehyMmKkoQOn6RTynwzp/Q/rS7Qmj97GrQMaZXmZZNqIV08X5/
X-Gm-Gg: Acq92OEQ3ZcC1N8gc5b7/RngvI9kL2NWVk4JtAj7Zd0m9FHfEWojTwcdIjXNqjSo3jT
 owDvrhq8j9Zr2aNM7L2jNQBJyyvSqs8SDeksLPxfMEhY8HPS1TIXY1QefLZcngvivmUA51GcSHA
 TuF8zELo581+g+P0+fSMkVYNpiPzTJA+dF+4TmxMsYQeVxqzg9gKr73wq9lvGkyoNdey6JBTmvS
 Nw4Cxu7G8pPQWOLGXoKHZKzC2jOdnXHeMy1+uW0QrEo6IlJNmM16qOqut0SRhgwkxTqCiTZAGqd
 sY5lN3M45GAJg6jq9WZOb4nh6ZTCKugD4MYHz5ynnuKgHrizywvniP1a1j/ey+sDQ8pTTek2K1m
 M9160vIuZY5yNai1T+W1SclHqd3uNmnCh/qWYrLFdeiDPHCtTvycL8L04rP7EKePDGxBMfg6Uvm
 vOb5EL7JVwlu9witu2flj6iwyjPDTtplHuwwWgU/zfeQ==
X-Received: by 2002:a05:6a00:1a05:b0:842:3373:f662 with SMTP id
 d2e1a72fcca58-8423374104dmr2845469b3a.11.1780212998783; 
 Sun, 31 May 2026 00:36:38 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 00:36:38 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, stefan@agner.ch, alison.wang@nxp.com,
 jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 1/6] drm/fsl-dcu: Open-code drm_simple_encoder_init()
Date: Sun, 31 May 2026 13:05:27 +0530
Message-Id: <20260531073532.8609-2-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260531073532.8609-1-namanarora029@gmail.com>
References: <20260531073532.8609-1-namanarora029@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

The helper drm_simple_encoder_init() is a thin wrapper around
drm_encoder_init() with a simple destroy-only encoder funcs struct.
Remove the dependency on drm_simple_kms_helper by open-coding the
encoder initialization directly in the driver.

Signed-off-by: Naman Arora <namanarora029@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 84eff7519..a16c6013e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -14,11 +14,14 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "fsl_dcu_drm_drv.h"
 #include "fsl_tcon.h"
 
+static const struct drm_encoder_funcs fsl_dcu_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 			       struct drm_crtc *crtc)
 {
@@ -31,8 +34,9 @@ int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 	if (fsl_dev->tcon)
 		fsl_tcon_bypass_enable(fsl_dev->tcon);
 
-	ret = drm_simple_encoder_init(fsl_dev->drm, encoder,
-				      DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(fsl_dev->drm, encoder,
+			       &fsl_dcu_drm_encoder_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

