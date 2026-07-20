Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2020C4452D
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8C610E127;
	Mon, 20 Jul 2026 19:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="FiCbGMQm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W39M6Jay";
	dkim-atps=neutral
X-Greylist: delayed 593 seconds by postgrey-1.36 at gabe;
 Mon, 20 Jul 2026 17:30:50 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F5C10E1FD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 17:30:50 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1784568055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gpk28iHPO7PC05304UxcoPudPVrzlTV8S79O5pVRZfI=;
 b=FiCbGMQms4RcsDVNUsTN51j76nNj8HOPwjC41O5KuWK+oEsHEb4uEvMAWT6AqtIJZg/Z8R
 udp1dikrBomMVcgDOgxVIk3EVgxjNIUWY/dRN6FIN3Vb2iH9KJMrXPmjDOzYe5ouaPfwN0
 FeQ2+V7bs32Sf3YXK9vFUWgZBFODle1UjUDXy839ahPaNxge94c1CCOYPQueaMKDJlGgSb
 v4Zp7Oxva7vQVgYfrNuHrVKyXIKKvJcYXNqSud28EHU6WY8V1IkU5+Zh3TPDLW11Zg2fPl
 EX3QFrIFNLSCDiW8YXhBhSNzX00C4j3MW2dr/v2tl4bdJLuF0mtEOYgEwhinBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1784568055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gpk28iHPO7PC05304UxcoPudPVrzlTV8S79O5pVRZfI=;
 b=W39M6JaymblcVCFinem2pr2nBeAKTlsnQK1sENnAIBsKYRTD/IHR+vXn8GZ3NxS6Ww8V4E
 mV0Q5tEkW+C4M7Cw==
Date: Mon, 20 Jul 2026 19:20:37 +0200
Subject: [PATCH] drm/vc4: hvs/v3d: Fix null dereference in unbind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-rpi-vc4-fix-v1-1-6073a96a5773@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAORYXmoC/yXMQQ5AMBCF4avIrE3SVku4ilhQg7FAWkQivbti+
 b3k/Td4ckwequQGRyd7XpcImSZgp3YZCbmPBiVULgpp0G2Mp9U48IV9mRmZdcJoZSA+Nkdx/mp
 189sf3Ux2fxMQwgMo3gGYbwAAAA==
X-Change-ID: 20260715-rpi-vc4-fix-d93513b05425
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784568054; l=1945;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=rgKMaikcnyYgqwLELlkEBZrPTGaoKIum3hhFD20sO2E=;
 b=wm08g+zCxUBIOnZya9Ew232hQOHQrCbUStR2valI6eUGZrvftuSIKbifX1+ptfWKgRiCT1cmW
 wE9JIb7k1EFAE9IZ7aLCTfL3VAaBoMbfsO6+RhkgrcnqlAiJdn+gyK2
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

The hvs and v3d drivers use dev_get_drvdata(master) in their unbind
functions. Since the vc4-drm gets removed before its dependent drivers
(vc4_hvs/vc4_v3d) the vc4_hvs_unbind/vc4_v3d_unbind functions try to
get drvdata of its master and fails with a null dereference error.

Use the data pointer passed to the unbind functions directly instead of
dev_get_drvdata(master). This avoids using potentially freed memory.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 drivers/gpu/drm/vc4/vc4_v3d.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 184d51ea3fa5..e715147d091c 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -1752,7 +1752,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 static void vc4_hvs_unbind(struct device *dev, struct device *master,
 			   void *data)
 {
-	struct drm_device *drm = dev_get_drvdata(master);
+	struct drm_device *drm = data;
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct vc4_hvs *hvs = vc4->hvs;
 	struct drm_mm_node *node, *next;
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index d31b906cb8e7..f32410420d3e 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -494,7 +494,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 static void vc4_v3d_unbind(struct device *dev, struct device *master,
 			   void *data)
 {
-	struct drm_device *drm = dev_get_drvdata(master);
+	struct drm_device *drm = data;
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 
 	vc4_irq_uninstall(drm);

---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
change-id: 20260715-rpi-vc4-fix-d93513b05425

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

