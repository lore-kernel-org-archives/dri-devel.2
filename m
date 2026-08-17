Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF777C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474B310E83B;
	Mon, 17 Aug 2026 15:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="h0hlB0Rl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAEE810E83B
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=tGcDLIv1hlmM1u6L2elYNagyWFy5NU+7a81O7slofw8=; b=h0hlB0RlARGz/vh2np4nX6Ufc9
 m+rTB+ezso/V/pDCoMQ3oyQkjbiZp+lEZTI1moPemEp5+3lVWL/9U7exz/wyNmrscq/ICgr/sF/a3
 o4vagOtA99m+l5zRM7PfQrvhrqN9Kwf3N6rkG0EqUB9BBj8yTOG5bzireKohOg7yAc54ZDxrTvat9
 bMprUyTVAs78BTwgRdj7laC+R4XuEmxCAaAA9rfVBOOlFzoImZvHWTj4aWHVjs+AXNC6Q+s/DMbrH
 c7DCswl5e8yh2Pf/j20NfqNIoXAfuL/yYSDLrR1Q0xpKXkf5iBujzhCPhEqYL8ckiA5Wl9nTWuo4w
 ZY0MFT5w==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvz49-004eWD-2D; Mon, 17 Aug 2026 17:15:57 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 12:15:35 -0300
Subject: [PATCH 5/6] drm/vc4: Hold a runtime PM reference in the binner
 overflow work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-vc4-irq-cleanup-v1-5-ee6c592b3836@igalia.com>
References: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
In-Reply-To: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=TZtKcoXuSXgkL7eh0lrDELhoQt4909BkOTACrjm/ds0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgyWdaFftSo86k8zhOt945rTfSLfvRSYZ91uE7
 Y/Ajl60CZyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoMlnQAKCRA/8w6Kdoj6
 qh7eB/9pq60VDmUWAXPPzeSh2x4D+E+sTUee+N0G9m322xGjdhqlJaHSJxz6MRyk0ZBrBAyAObj
 MHzBpdp2G5q26hbLvwmTikDuDJKpF6lSiaUbDEYPjKiFDRIDEqOC0JmMH70gU902iIQ3Xfvay4M
 C+V1dLrp5Y3jApKCeG+p4WxW2FN0ijNh84RJeyV/gtWB9X/A9+PmN7uEVokLmzZrnIOv1R+q7/r
 5VrEP+Jw3t39DIiTAkpPiTXCfbQKquDU7oy/CALvxHD6UgrHliXt1w473u6CLLJfGSHe8S71/ow
 tctfaOfXjxse/7i2mYkDyg3R6I4iosluVleB5pr0RpjkmYuK
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The out-of-memory interrupt only queues vc4_overflow_mem_work(), so the
V3D block can be runtime suspended before the work runs. It then hands the
binner a new overflow slot through V3D_BPOA and V3D_BPOS, registers that
are unreachable once the block is down.

Take a runtime PM reference in the work and give up when the block is no
longer active. Nothing is lost by giving up: the interrupt mask is rebuilt
on resume, and the binner can ask again as soon as it is short of memory.

Fixes: 001bdb55d9eb ("drm/vc4: Enable runtime PM.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 2efed552c08a..999010381da1 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -46,6 +46,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_print.h>
 
@@ -65,6 +66,9 @@ vc4_overflow_mem_work(struct work_struct *work)
 	struct vc4_exec_info *exec;
 	unsigned long irqflags;
 
+	if (pm_runtime_get_if_active(&vc4->v3d->pdev->dev) <= 0)
+		return;
+
 	mutex_lock(&vc4->bin_bo_lock);
 
 	if (!vc4->bin_bo)
@@ -109,6 +113,7 @@ vc4_overflow_mem_work(struct work_struct *work)
 
 complete:
 	mutex_unlock(&vc4->bin_bo_lock);
+	pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
 }
 
 static void

-- 
2.55.0

