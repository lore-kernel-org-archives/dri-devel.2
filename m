Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF8CC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863FA10E2FF;
	Tue, 21 Jul 2026 22:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="JcWjyMTq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ebiC3dJ";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA1010E241
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:38:35 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1784648313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qr0yzIrf3ANiObvCzKGQ0FrOzPoo5WBOtSa9iiW6L2c=;
 b=JcWjyMTqJl2LU2MceAk83qGUEYBMzQAdfKzqDEInDgu8NUK37fPkzZWmZHAf9d7zdBKuvI
 Yj5rehgeUjIfqoQw1xLJJWiIuYhRdX4F++1s6reShPvrrjny2hrtWkXqX715hT/F8Ler43
 8SfbDNnCMnDfWnWm86eXSfbbz5M6tlplQCrU9XMhOHMFusu+UPXk7jCUGV4r3/C1NfsrIo
 IWpm6ga+G6kqVGtf0LMImH9CMEcC8DBLuxWkUjmvgwKLw1SfUskEEIm/FKllZxEJ9wVhP1
 e/se4HNh3psGihesAM9AVCFGfOF/SXWQNFAPBTQjiv7O5Us09j7axLaCDornUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1784648313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qr0yzIrf3ANiObvCzKGQ0FrOzPoo5WBOtSa9iiW6L2c=;
 b=/ebiC3dJq1eQxGTOdQXF/8jKcpNZ31jHzqZS+KuA/yeaiE33JyZOfpU2NzHNFDoK+g5gMl
 TT1wZLVWnTuxlzAg==
Date: Tue, 21 Jul 2026 17:38:19 +0200
Subject: [PATCH v2] drm/vc4: hvs/v3d: Fix null dereference in unbind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-rpi-vc4-fix-v2-1-b813dcd01dc7@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGqSX2oC/1WNyw6CMBBFf4XM2jF9UAiu/A/DgscoY0whbWkwh
 H+3oBuX5+bec1fw5Jg8XLIVHEX2PNoE6pRBNzT2Qch9YlBCFaKUBt3EGLsc77xgX2kjdStMrgy
 kxeQoxYftVn/Zz+2TurAr9sbAPozufdxFufd+ZiX+zFGixBTrpioaU5b6+mI7BzdaXs49Qb1t2
 wdvNVfyvAAAAA==
X-Change-ID: 20260715-rpi-vc4-fix-d93513b05425
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Douglas Anderson <dianders@chromium.org>, 
 Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784648313; l=2215;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=gT0B/UqWA+MfWagMrYsjYSZgllA5pSGacte4E7za4cU=;
 b=x1oGNt3ancCKQbthbfgNDd12zjrlgcc2w0dm8L1rJ7GcGJpFJDQgBt4fWZeL3f0TeGyzlw4JF
 dw2Xeio/yJECVNVXi0eez2pR/2tC7C0z5jrDzDVkciJfUgJdtwWJaYd
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

Fixes: d3f5168a0810 ("drm/vc4: Bind and initialize the V3D engine.")
Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
Changes in v2:
- Add Fixes tags
- Link to v1: https://patch.msgid.link/20260720-rpi-vc4-fix-v1-1-6073a96a5773@linutronix.de
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

