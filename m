Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E224C5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7F310E2EF;
	Sun, 16 Aug 2026 14:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LNREf+sn";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193BE89226
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=vl/eDLXvzwRHbnKEGcO7uWX8r+r4t1HiABnu3Z6RFNA=; b=LNREf+sn6v9HJ8PVwYGe1xOBTR
 KjN3zGTImGetPKkPyCcQ+JaACz3vonblf/UCWxzoZKJF/iFaxYBXZhwlghQYe9VSl9D01L95YHRNR
 G0DUz74ZCw+CZN6EZ7n3VhAQrUsoGG9aX9wSbv2aP5OtW13ozP0C2iw9lbbUz8LfnoXI65CHV4Fho
 XdcnDu85rJfKtwPWCjU6rv1NOrGrrMsIe2xXSKwcnIXLTiaYbV+7VCT/c5n9GLukI5ayVvSatwvxA
 EzUndBKZ16z+QAHAM+rxwtVWGngbZKGFAJ8kAMTu+31VhEl+2XJWa212lvn0LV3GealfLh8/4UGYz
 OTalORWQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvbUz-002tuI-QU; Sun, 16 Aug 2026 16:06:06 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 16 Aug 2026 11:05:42 -0300
Subject: [PATCH 3/4] drm/vc4: Use the reset controller to recover from a
 GPU hang
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-vc4-reset-control-v1-3-896444373716@igalia.com>
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
In-Reply-To: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7853; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=au0YWz6wNN99SqBlBHzsa22hd3tU+455N4Wq793mUOY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgcO4MvBHXOE3Ws7FH74gkOr1lpSRaHJN5UlhT
 1YL7sl3zs2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoHDuAAKCRA/8w6Kdoj6
 qi0PB/9a0zqYoESx/yUNwYcdybIYC4i0StuLmUAOWz3i+2SMYENN0lPitrK0CmbUJBlopX7bOrL
 4rgzs1dw39lASYEbfEtIDz7izztZPAd50/9Do/Nr0CtO+gawUqDhr8MmuW2ndiWTj7uJGgibJ+W
 qqZwp0tZBXI/z7CMyi9Mh5JYWWkiwy/p76wqaevNdeo76520MRJRZ76RJR3AstuUPWcjCP3eEi5
 qGa7NvwfYxYPP0KxFd1JUrTOlIMJjGnE0d67ZgRgt0wemDAGS76HsWSMOXmyAnV98V7j04YMTgY
 kdkko87OC7l1/W+VVI1lnUwjTbu7GJ4aP7Su0/0yt4Q2A7/3
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

vc4_reset() recovers a hung GPU by dropping the runtime PM usage count to
zero so that the power domain goes down, and then taking it again. Such an
unconventional approach only works if the driver knows exactly how many
references it holds, which is why vc4 wrapped every pm_runtime_get_sync()
call in a private refcount and mutex.

Commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains
under a new binding.") exposed a V3D reset line for exactly this reason,
so that the block can be reset without power-cycling its domain, but the
vc4 driver never picked it up. Use it now, which removes the need for the
private refcount and leaves vc4_v3d_pm_get/put() as plain runtime PM
wrappers.

The reset line is optional, to accommodate older device trees. Device
trees that do not describe one still get the driver-side recovery in
vc4_irq_reset(), but the hardware is left untouched. Two in-tree platforms
use the VC4 V3D block: BCM2835 gains the resets property in the next
commit, and Cygnus is no worse off than it was, as its V3D node has no
power domain and the power-cycle only ever gated its clock.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 13 ++++++++-----
 drivers/gpu/drm/vc4/vc4_gem.c | 40 ++++++++++++++++++++++++----------------
 drivers/gpu/drm/vc4/vc4_irq.c |  7 +++----
 drivers/gpu/drm/vc4/vc4_v3d.c | 36 ++++++++++++------------------------
 4 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 0f5958c1e6b6..86e0e7c12901 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -212,14 +212,9 @@ struct vc4_dev {
 
 	struct work_struct overflow_mem_work;
 
-	int power_refcount;
-
 	/* Set to true when the load tracker is active. */
 	bool load_tracker_enabled;
 
-	/* Mutex controlling the power refcount. */
-	struct mutex power_lock;
-
 	struct {
 		struct timer_list timer;
 		struct work_struct reset_work;
@@ -294,6 +289,13 @@ struct vc4_v3d {
 	struct platform_device *pdev;
 	void __iomem *regs;
 	struct clk *clk;
+
+	/* Reset line for the V3D block, used to recover from a GPU hang.
+	 * NULL if the device tree does not describe one, in which case the
+	 * GPU cannot be reset.
+	 */
+	struct reset_control *reset;
+
 	struct debugfs_regset32 regset;
 };
 
@@ -1056,6 +1058,7 @@ int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used);
 void vc4_v3d_bin_bo_put(struct vc4_dev *vc4);
 int vc4_v3d_pm_get(struct vc4_dev *vc4);
 void vc4_v3d_pm_put(struct vc4_dev *vc4);
+void vc4_v3d_init_hw(struct drm_device *dev);
 int vc4_v3d_debugfs_init(struct drm_minor *minor);
 
 /* vc4_validate.c */
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index e231c906709c..3212b9167620 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -23,7 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/sched/signal.h>
@@ -292,19 +292,22 @@ vc4_save_hang_state(struct drm_device *dev)
 static void
 vc4_reset(struct drm_device *dev)
 {
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_v3d *v3d = to_vc4_dev(dev)->v3d;
+	int ret;
 
-	DRM_INFO("Resetting GPU.\n");
+	vc4_irq_disable(dev);
 
-	mutex_lock(&vc4->power_lock);
-	if (vc4->power_refcount) {
-		/* Power the device off and back on the by dropping the
-		 * reference on runtime PM.
-		 */
-		pm_runtime_put_sync_suspend(&vc4->v3d->pdev->dev);
-		pm_runtime_get_sync(&vc4->v3d->pdev->dev);
+	if (v3d->reset) {
+		drm_info(dev, "Resetting GPU.\n");
+
+		ret = reset_control_reset(v3d->reset);
+		if (ret)
+			drm_err(dev, "Failed to reset the GPU: %d\n", ret);
+
+		vc4_v3d_init_hw(dev);
+	} else {
+		drm_info_once(dev, "No reset line; GPU state is not reset.\n");
 	}
-	mutex_unlock(&vc4->power_lock);
 
 	vc4_irq_reset(dev);
 
@@ -320,10 +323,19 @@ vc4_reset_work(struct work_struct *work)
 {
 	struct vc4_dev *vc4 =
 		container_of(work, struct vc4_dev, hangcheck.reset_work);
+	int ret;
+
+	/* Make sure the device is not suspended during the reset. */
+	ret = vc4_v3d_pm_get(vc4);
+	if (ret) {
+		drm_err(&vc4->base, "Failed to resume V3D for GPU reset: %d\n", ret);
+		return;
+	}
 
 	vc4_save_hang_state(&vc4->base);
-
 	vc4_reset(&vc4->base);
+
+	vc4_v3d_pm_put(vc4);
 }
 
 static void
@@ -1177,10 +1189,6 @@ int vc4_gem_init(struct drm_device *dev)
 
 	INIT_WORK(&vc4->job_done_work, vc4_job_done_work);
 
-	ret = drmm_mutex_init(dev, &vc4->power_lock);
-	if (ret)
-		return ret;
-
 	INIT_LIST_HEAD(&vc4->purgeable.list);
 
 	ret = drmm_mutex_init(dev, &vc4->purgeable.lock);
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 8e5141bb5075..90c5194a1c93 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -336,10 +336,9 @@ void vc4_irq_reset(struct drm_device *dev)
 	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
 
 	/*
-	 * Turn all our interrupts on.  Binner out of memory is the
-	 * only one we expect to trigger at this point, since we've
-	 * just come from poweron and haven't supplied any overflow
-	 * memory yet.
+	 * Turn all our interrupts on. Binner out of memory is the only
+	 * one we expect to trigger at this point, since the reset cleared
+	 * the overflow memory address and none has been supplied yet.
 	 */
 	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
 
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 379ab77243ad..d2da8d2f8eeb 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -9,6 +9,7 @@
 #include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include <drm/drm_print.h>
 
@@ -122,29 +123,13 @@ static int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
 	return 0;
 }
 
-/*
- * Wraps pm_runtime_get_sync() in a refcount, so that we can reliably
- * get the pm_runtime refcount to 0 in vc4_reset().
- */
 int
 vc4_v3d_pm_get(struct vc4_dev *vc4)
 {
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
 
-	mutex_lock(&vc4->power_lock);
-	if (vc4->power_refcount++ == 0) {
-		int ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
-
-		if (ret < 0) {
-			vc4->power_refcount--;
-			mutex_unlock(&vc4->power_lock);
-			return ret;
-		}
-	}
-	mutex_unlock(&vc4->power_lock);
-
-	return 0;
+	return pm_runtime_resume_and_get(&vc4->v3d->pdev->dev);
 }
 
 void
@@ -153,15 +138,10 @@ vc4_v3d_pm_put(struct vc4_dev *vc4)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	mutex_lock(&vc4->power_lock);
-	if (--vc4->power_refcount == 0) {
-		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
-		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
-	}
-	mutex_unlock(&vc4->power_lock);
+	pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
 }
 
-static void vc4_v3d_init_hw(struct drm_device *dev)
+void vc4_v3d_init_hw(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
@@ -447,6 +427,14 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (IS_ERR(v3d->clk))
 		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n");
 
+	v3d->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(v3d->reset))
+		return dev_err_probe(dev, PTR_ERR(v3d->reset),
+				     "Failed to get reset control\n");
+
+	if (!v3d->reset)
+		drm_warn(drm, "No V3D reset line in the device tree");
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		return ret;

-- 
2.55.0

