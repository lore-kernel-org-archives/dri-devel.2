Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB57AC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364C910F5F7;
	Fri, 14 Aug 2026 14:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xyYRK6Qi";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A183410F5F7
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:06:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7512B1A163B;
 Fri, 14 Aug 2026 14:06:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 49B056046D;
 Fri, 14 Aug 2026 14:06:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 76FBB11C4EDA5; 
 Fri, 14 Aug 2026 16:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716404; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dQ3Jok/l1psHBc/8VDJALjoxzjXNRM6OdPzV1zrK2Ng=;
 b=xyYRK6QiO38EkCyy8JQwUGEgtDnLWNwg4FpCQExNQaO5Mi6w7DfacuGrx/R9fcpGLMYOya
 58PfhTtMRyvb9S90l3eAYBLKRCU+iE06lbGkkcqlH8KoMYwlCdRr28LvsFxsGzmbhPmZto
 d372N3AhyCRwPRd5PahRW3tRQsDDZRKL58HdV0kCECgdKCO8A6okaFHbUQS/hzUU3oQ6rR
 IKyTd6yELspJbXWZm86r7HI5D15+O2g7vwngpT71wYcWrMVYCKjr06GQuJWEqLiWaFaJgs
 Dt5/60zfRMH8wuUc2wy8B15a5VLdeOFDIjjuM9ISxidLI1ygYXQA118IaUUn8g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:52 +0200
Subject: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into the
 drm module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-4-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Work is in progress to make every drm_panel automatically create a
panel_bridge [0][1].

This requires the panel code to call the drm_panel_bridge APIs. However
this would create a circular dependency loop on modular builds:

__devm_drm_panel_alloc() [drm]
   -> drm_panel_bridge_add() [drm_kms_helper]
      -> drm_bridge.c APIs [drm]

Moving just the panel_brige.o file from [drm_kms_helper] to [drm] does not
work because the panel bridge code uses the drm_atomic_helper and
drm_probe_helper which add further dependencies on symbols in the
[drm_kms_helper] module.

So take a simple approach, and move the entire drm_kms_helper into the
[drm] module.

Link: https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfhakya3ydwmd63pl26@5jwxaidpikjw/ [0]
Link: https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9d6f2c9c3058@bootlin.com/ [1]
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

*Note* This is just a quick implementation to open a discussion while
having a working implementation. If the approach is approved there will be
more details to polish.
---
 drivers/gpu/drm/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..945d4f117c3f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -139,7 +139,7 @@ obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
 # Modesetting helpers
 #
 
-drm_kms_helper-y := \
+drm-$(CONFIG_DRM_KMS_HELPER) := \
 	drm_atomic_helper.o \
 	drm_atomic_state_helper.o \
 	drm_bridge_helper.o \
@@ -156,9 +156,8 @@ drm_kms_helper-y := \
 	drm_self_refresh_helper.o \
 	drm_simple_kms_helper.o \
 	drm_vblank_helper.o
-drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
-drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
-obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
+drm-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
+drm-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
 
 #
 # Drivers and the rest

-- 
2.55.0

