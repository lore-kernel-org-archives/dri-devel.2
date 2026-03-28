Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B0510F3DEE
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 18:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF65910E532;
	Sat, 28 Mar 2026 18:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hO8sc9TD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4ED310E532
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fS/cnf2/xwnh/Z3sFD8l5kyfJNNt5x60ewZgTXeTKLY=; b=hO8sc9TDpS369IGffvx8Futnzr
 2avMJ3p2rh+atxluo0Z5fqtILn//Q+Ft4G9iEXGbOEabH15NoFum6Yx78Y7QfF2HduiS/aTDW230V
 0jzP4wXARkXfsbaFW4WR/sG0kKc66jaI2BzY3dnFpkqnmo6bQ36fX2hip1l4awytgYGmA7buszkgO
 XBr39rKsKyIysvgJ50xMU2Keo5QWWwqvE/KLgvhHbd4g736EcszL6go4Hs2U/BtyLedoV6AH8kY68
 ENd3s4eSru1DCMtVfZ64Z+0Ctn2di0ZK3ZwfoCVzeErS4Q+eJ1s642rVwZ2FcO/e8j+LL/r4t10wT
 aDjYq+tQ==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w6Yme-007f3o-0U; Sat, 28 Mar 2026 19:53:20 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 28 Mar 2026 15:52:49 -0300
Subject: [PATCH v8 3/3] drm/v3d: Introduce Runtime Power Management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260328-v3d-power-management-v8-3-94336830df5f@igalia.com>
References: <20260328-v3d-power-management-v8-0-94336830df5f@igalia.com>
In-Reply-To: <20260328-v3d-power-management-v8-0-94336830df5f@igalia.com>
To: Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15199; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Wsmhfb5+8aF0Iq+BbAeHuAGdhgrPsq+bSyLOvx+l6gc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpyCORwB8qUgRaY/Nu9eiQ4y9xdT+mzOzUvjkxv
 +CWSCqEPQCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacgjkQAKCRA/8w6Kdoj6
 qg6LCACWCQDr0wMSSPcXuRYS9QNIgBJw6WEayava9fBXpOhVvSx9OdS6DMvRpqXnvhNCZqHir+v
 yvIhVOVy+mmEYYp8vVv8I0IzSFF51ZHXs9KW7PgKZJKGgqjBfeS3ABmvRe4wkcls3ycLkKkOB6m
 MDJ1bcrkF2gZuRaB+ZCEOnzc7nlTt5kFfTkCp/NSafDcg+INyizitmpkpR4gCGlGqgKSlgNOCQ8
 gBWzvQIGPcr28GA5kNsqU049STOuZ63X9U3q0dWUABUOmgg+/WVEkYg8yKuYkm8gfwn0Zk9qV1H
 oCGELVkJPWbvyECy9zS5yRQW0XDBXA8UvJAXw7x+FtylbLj0
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

Commit 90a64adb0876 ("drm/v3d: Get rid of pm code") removed the last
bits of power management code that V3D had, which were actually never
hooked. Therefore, currently, the GPU clock is enabled during probe
and only disabled when removing the driver.

Implement proper power management using the kernel's Runtime PM
framework.

Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/Makefile      |  1 +
 drivers/gpu/drm/v3d/v3d_debugfs.c | 23 ++++++++++-
 drivers/gpu/drm/v3d/v3d_drv.c     | 84 +++++++++++++++++----------------------
 drivers/gpu/drm/v3d/v3d_drv.h     | 17 ++++++++
 drivers/gpu/drm/v3d/v3d_mmu.c     | 10 ++++-
 drivers/gpu/drm/v3d/v3d_perfmon.c | 18 +++++++--
 drivers/gpu/drm/v3d/v3d_power.c   | 69 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_submit.c  | 19 +++++++--
 8 files changed, 182 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/v3d/Makefile b/drivers/gpu/drm/v3d/Makefile
index b7d673f1153bef16db3800e50b2bfaf36bf8871b..601b834e377e8342c6668645112347cca4214024 100644
--- a/drivers/gpu/drm/v3d/Makefile
+++ b/drivers/gpu/drm/v3d/Makefile
@@ -10,6 +10,7 @@ v3d-y := \
 	v3d_irq.o \
 	v3d_mmu.o \
 	v3d_perfmon.o \
+	v3d_power.o \
 	v3d_trace_points.o \
 	v3d_sched.o \
 	v3d_sysfs.o \
diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 89f24eec62a74ec49b28f0b22dbf626ba7a35206..634cc796ba2324dc497694c070f2cfffcc4424c9 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -97,7 +97,11 @@ static int v3d_v3d_debugfs_regs(struct seq_file *m, void *unused)
 	struct drm_debugfs_entry *entry = m->private;
 	struct drm_device *dev = entry->dev;
 	struct v3d_dev *v3d = to_v3d_dev(dev);
-	int i, core;
+	int i, core, ret;
+
+	ret = v3d_pm_runtime_get(v3d);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(v3d_hub_reg_defs); i++) {
 		const struct v3d_reg_def *def = &v3d_hub_reg_defs[i];
@@ -139,6 +143,8 @@ static int v3d_v3d_debugfs_regs(struct seq_file *m, void *unused)
 		}
 	}
 
+	v3d_pm_runtime_put(v3d);
+
 	return 0;
 }
 
@@ -148,7 +154,11 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, void *unused)
 	struct drm_device *dev = entry->dev;
 	struct v3d_dev *v3d = to_v3d_dev(dev);
 	u32 ident0, ident1, ident2, ident3, cores;
-	int core;
+	int core, ret;
+
+	ret = v3d_pm_runtime_get(v3d);
+	if (ret)
+		return ret;
 
 	ident0 = V3D_READ(V3D_HUB_IDENT0);
 	ident1 = V3D_READ(V3D_HUB_IDENT1);
@@ -207,6 +217,8 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, void *unused)
 		}
 	}
 
+	v3d_pm_runtime_put(v3d);
+
 	return 0;
 }
 
@@ -234,6 +246,11 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	uint32_t cycles;
 	int core = 0;
 	int measure_ms = 1000;
+	int ret;
+
+	ret = v3d_pm_runtime_get(v3d);
+	if (ret)
+		return ret;
 
 	if (v3d->ver >= V3D_GEN_41) {
 		int cycle_count_reg = V3D_PCTR_CYCLE_COUNT(v3d->ver);
@@ -253,6 +270,8 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	msleep(measure_ms);
 	cycles = V3D_CORE_READ(core, V3D_PCTR_0_PCTR0);
 
+	v3d_pm_runtime_put(v3d);
+
 	seq_printf(m, "cycles: %d (%d.%d Mhz)\n",
 		   cycles,
 		   cycles / (measure_ms * 1000),
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index e57b36f4d81a59d15a223afdc4078ae6456de9a9..fc81dd1247e33e15cd838cf11ae46d79aaf03976 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -59,6 +59,7 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 		[DRM_V3D_PARAM_V3D_CORE0_IDENT1] = V3D_CTL_IDENT1,
 		[DRM_V3D_PARAM_V3D_CORE0_IDENT2] = V3D_CTL_IDENT2,
 	};
+	int ret;
 
 	if (args->pad != 0)
 		return -EINVAL;
@@ -75,12 +76,19 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 		if (args->value != 0)
 			return -EINVAL;
 
+		ret = v3d_pm_runtime_get(v3d);
+		if (ret)
+			return ret;
+
 		if (args->param >= DRM_V3D_PARAM_V3D_CORE0_IDENT0 &&
 		    args->param <= DRM_V3D_PARAM_V3D_CORE0_IDENT2) {
 			args->value = V3D_CORE_READ(0, offset);
 		} else {
 			args->value = V3D_READ(offset);
 		}
+
+		v3d_pm_runtime_put(v3d);
+
 		return 0;
 	}
 
@@ -290,36 +298,6 @@ static const struct of_device_id v3d_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, v3d_of_match);
 
-static void
-v3d_idle_sms(struct v3d_dev *v3d)
-{
-	if (v3d->ver < V3D_GEN_71)
-		return;
-
-	V3D_SMS_WRITE(V3D_SMS_TEE_CS, V3D_SMS_CLEAR_POWER_OFF);
-
-	if (wait_for((V3D_GET_FIELD(V3D_SMS_READ(V3D_SMS_TEE_CS),
-				    V3D_SMS_STATE) == V3D_SMS_IDLE), 100)) {
-		drm_err(&v3d->drm, "Failed to power up SMS\n");
-	}
-
-	v3d_reset_sms(v3d);
-}
-
-static void
-v3d_power_off_sms(struct v3d_dev *v3d)
-{
-	if (v3d->ver < V3D_GEN_71)
-		return;
-
-	V3D_SMS_WRITE(V3D_SMS_TEE_CS, V3D_SMS_POWER_OFF);
-
-	if (wait_for((V3D_GET_FIELD(V3D_SMS_READ(V3D_SMS_TEE_CS),
-				    V3D_SMS_STATE) == V3D_SMS_POWER_OFF_STATE), 100)) {
-		drm_err(&v3d->drm, "Failed to power off SMS\n");
-	}
-}
-
 static int
 map_regs(struct v3d_dev *v3d, void __iomem **regs, const char *name)
 {
@@ -403,19 +381,26 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	if (ret)
 		goto dma_free;
 
-	ret = clk_prepare_enable(v3d->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't enable the V3D clock\n");
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
 		goto gem_destroy;
-	}
 
-	v3d_idle_sms(v3d);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto gem_destroy;
+
+	/* If PM is disabled, we need to call v3d_power_resume() manually. */
+	if (!IS_ENABLED(CONFIG_PM)) {
+		ret = v3d_power_resume(dev);
+		if (ret)
+			goto gem_destroy;
+	}
 
 	mmu_debug = V3D_READ(V3D_MMU_DEBUG_INFO);
 	mask = DMA_BIT_MASK(30 + V3D_GET_FIELD(mmu_debug, V3D_MMU_PA_WIDTH));
 	ret = dma_set_mask_and_coherent(dev, mask);
 	if (ret)
-		goto clk_disable;
+		goto runtime_pm_put;
 
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 
@@ -435,27 +420,26 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	ident3 = V3D_READ(V3D_HUB_IDENT3);
 	v3d->rev = V3D_GET_FIELD(ident3, V3D_HUB_IDENT3_IPREV);
 
-	v3d_init_hw_state(v3d);
-	v3d_mmu_set_page_table(v3d);
-	v3d_irq_enable(v3d);
+	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		goto irq_disable;
+		goto runtime_pm_put;
 
 	ret = v3d_sysfs_init(dev);
 	if (ret)
 		goto drm_unregister;
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 drm_unregister:
 	drm_dev_unregister(drm);
-irq_disable:
-	v3d_irq_disable(v3d);
-clk_disable:
-	v3d_power_off_sms(v3d);
-	clk_disable_unprepare(v3d->clk);
+runtime_pm_put:
+	pm_runtime_put_sync_suspend(dev);
 gem_destroy:
 	v3d_gem_destroy(drm);
 dma_free:
@@ -473,21 +457,27 @@ static void v3d_platform_drm_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(drm);
 
-	v3d_power_off_sms(v3d);
+	pm_runtime_suspend(dev);
 
-	clk_disable_unprepare(v3d->clk);
+	/* If PM is disabled, we need to call v3d_power_suspend() manually. */
+	if (!IS_ENABLED(CONFIG_PM))
+		v3d_power_suspend(dev);
 
 	v3d_gem_destroy(drm);
 
 	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
 }
 
+static DEFINE_RUNTIME_DEV_PM_OPS(v3d_pm_ops, v3d_power_suspend,
+				 v3d_power_resume, NULL);
+
 static struct platform_driver v3d_platform_driver = {
 	.probe		= v3d_platform_drm_probe,
 	.remove		= v3d_platform_drm_remove,
 	.driver		= {
 		.name	= "v3d",
 		.of_match_table = v3d_of_match,
+		.pm = pm_ptr(&v3d_pm_ops),
 	},
 };
 
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index ebf406b615bb52de9cb98ea8efe941a5787fb4bd..4ebe175a8c6b0016d087388ce02cd35a8ae65a13 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -3,6 +3,7 @@
 
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock_types.h>
 #include <linux/workqueue.h>
 
@@ -324,6 +325,8 @@ struct v3d_job {
 
 	/* Callback for the freeing of the job on refcount going to 0. */
 	void (*free)(struct kref *ref);
+
+	bool has_pm_ref;
 };
 
 struct v3d_bin_job {
@@ -597,6 +600,20 @@ int v3d_mmu_set_page_table(struct v3d_dev *v3d);
 void v3d_mmu_insert_ptes(struct v3d_bo *bo);
 void v3d_mmu_remove_ptes(struct v3d_bo *bo);
 
+/* v3d_power.c */
+int v3d_power_suspend(struct device *dev);
+int v3d_power_resume(struct device *dev);
+
+static __always_inline int v3d_pm_runtime_get(struct v3d_dev *v3d)
+{
+	return pm_runtime_resume_and_get(v3d->drm.dev);
+}
+
+static __always_inline int v3d_pm_runtime_put(struct v3d_dev *v3d)
+{
+	return pm_runtime_put_autosuspend(v3d->drm.dev);
+}
+
 /* v3d_sched.c */
 void v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
 				   unsigned int count);
diff --git a/drivers/gpu/drm/v3d/v3d_mmu.c b/drivers/gpu/drm/v3d/v3d_mmu.c
index c513a393c0313772650fd6d7236127b2dc4101d9..630c64e51d2f2ad30e59fa2b175487efe0bfba49 100644
--- a/drivers/gpu/drm/v3d/v3d_mmu.c
+++ b/drivers/gpu/drm/v3d/v3d_mmu.c
@@ -39,7 +39,11 @@ static bool v3d_mmu_is_aligned(u32 page, u32 page_address, size_t alignment)
 
 int v3d_mmu_flush_all(struct v3d_dev *v3d)
 {
-	int ret;
+	int ret = 0;
+
+	/* Flush the PTs only if we're already awake */
+	if (!pm_runtime_get_if_active(v3d->drm.dev))
+		return 0;
 
 	V3D_WRITE(V3D_MMUC_CONTROL, V3D_MMUC_CONTROL_FLUSH |
 		  V3D_MMUC_CONTROL_ENABLE);
@@ -48,7 +52,7 @@ int v3d_mmu_flush_all(struct v3d_dev *v3d)
 			 V3D_MMUC_CONTROL_FLUSHING), 100);
 	if (ret) {
 		dev_err(v3d->drm.dev, "MMUC flush wait idle failed\n");
-		return ret;
+		goto pm_put;
 	}
 
 	V3D_WRITE(V3D_MMU_CTL, V3D_READ(V3D_MMU_CTL) |
@@ -59,6 +63,8 @@ int v3d_mmu_flush_all(struct v3d_dev *v3d)
 	if (ret)
 		dev_err(v3d->drm.dev, "MMU TLB clear wait idle failed\n");
 
+pm_put:
+	v3d_pm_runtime_put(v3d);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 8e0249580bbacac507b2d7c0bcac37ef19c1a54e..02451fc09dbbf6d33640000249786e2836732647 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -232,6 +232,9 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 	if (WARN_ON_ONCE(!perfmon || v3d->active_perfmon))
 		return;
 
+	if (!pm_runtime_get_if_active(v3d->drm.dev))
+		return;
+
 	ncounters = perfmon->ncounters;
 	mask = GENMASK(ncounters - 1, 0);
 
@@ -257,6 +260,8 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 	V3D_CORE_WRITE(0, V3D_PCTR_0_OVERFLOW, mask);
 
 	v3d->active_perfmon = perfmon;
+
+	v3d_pm_runtime_put(v3d);
 }
 
 void v3d_perfmon_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
@@ -268,10 +273,11 @@ void v3d_perfmon_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
 		return;
 
 	mutex_lock(&perfmon->lock);
-	if (perfmon != v3d->active_perfmon) {
-		mutex_unlock(&perfmon->lock);
-		return;
-	}
+	if (perfmon != v3d->active_perfmon)
+		goto out;
+
+	if (!pm_runtime_get_if_active(v3d->drm.dev))
+		goto out_clear;
 
 	if (capture)
 		for (i = 0; i < perfmon->ncounters; i++)
@@ -279,7 +285,11 @@ void v3d_perfmon_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
 
 	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, 0);
 
+	v3d_pm_runtime_put(v3d);
+
+out_clear:
 	v3d->active_perfmon = NULL;
+out:
 	mutex_unlock(&perfmon->lock);
 }
 
diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_power.c
new file mode 100644
index 0000000000000000000000000000000000000000..2b7e639d5da30c798ccc12cc1559e005915e2d8d
--- /dev/null
+++ b/drivers/gpu/drm/v3d/v3d_power.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Raspberry Pi */
+
+#include <linux/clk.h>
+
+#include <drm/drm_print.h>
+
+#include "v3d_drv.h"
+#include "v3d_regs.h"
+
+static void
+v3d_resume_sms(struct v3d_dev *v3d)
+{
+	if (v3d->ver < V3D_GEN_71)
+		return;
+
+	V3D_SMS_WRITE(V3D_SMS_TEE_CS, V3D_SMS_CLEAR_POWER_OFF);
+
+	if (wait_for((V3D_GET_FIELD(V3D_SMS_READ(V3D_SMS_TEE_CS),
+				    V3D_SMS_STATE) == V3D_SMS_IDLE), 100)) {
+		drm_err(&v3d->drm, "Failed to power up SMS\n");
+	}
+
+	v3d_reset_sms(v3d);
+}
+
+static void
+v3d_suspend_sms(struct v3d_dev *v3d)
+{
+	if (v3d->ver < V3D_GEN_71)
+		return;
+
+	V3D_SMS_WRITE(V3D_SMS_TEE_CS, V3D_SMS_POWER_OFF);
+
+	if (wait_for((V3D_GET_FIELD(V3D_SMS_READ(V3D_SMS_TEE_CS),
+				    V3D_SMS_STATE) == V3D_SMS_POWER_OFF_STATE), 100)) {
+		drm_err(&v3d->drm, "Failed to power off SMS\n");
+	}
+}
+
+int v3d_power_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct v3d_dev *v3d = to_v3d_dev(drm);
+
+	v3d_irq_disable(v3d);
+	v3d_suspend_sms(v3d);
+	clk_disable_unprepare(v3d->clk);
+
+	return 0;
+}
+
+int v3d_power_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct v3d_dev *v3d = to_v3d_dev(drm);
+	int ret;
+
+	ret = clk_prepare_enable(v3d->clk);
+	if (ret)
+		return ret;
+
+	v3d_resume_sms(v3d);
+	v3d_init_hw_state(v3d);
+	v3d_mmu_set_page_table(v3d);
+	v3d_irq_enable(v3d);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 8f061b6a05c6aa76ea5513407ebf3c0ce80b8256..f75da2e3533e236821818924f91ec602950af85a 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -106,6 +106,9 @@ v3d_job_free(struct kref *ref)
 	v3d_stats_put(job->client_stats);
 	v3d_stats_put(job->global_stats);
 
+	if (job->has_pm_ref)
+		v3d_pm_runtime_put(job->v3d);
+
 	kfree(job);
 }
 
@@ -187,13 +190,13 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 				if (copy_from_user(&in, handle++, sizeof(in))) {
 					ret = -EFAULT;
 					drm_dbg(&v3d->drm, "Failed to copy wait dep handle.\n");
-					goto fail_deps;
+					goto fail_job_init;
 				}
 				ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv, in.handle, 0);
 
 				// TODO: Investigate why this was filtered out for the IOCTL.
 				if (ret && ret != -ENOENT)
-					goto fail_deps;
+					goto fail_job_init;
 			}
 		}
 	} else {
@@ -201,7 +204,15 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 
 		// TODO: Investigate why this was filtered out for the IOCTL.
 		if (ret && ret != -ENOENT)
-			goto fail_deps;
+			goto fail_job_init;
+	}
+
+	/* CPU jobs don't require hardware resources */
+	if (queue != V3D_CPU) {
+		ret = v3d_pm_runtime_get(v3d);
+		if (ret)
+			goto fail_job_init;
+		job->has_pm_ref = true;
 	}
 
 	kref_init(&job->refcount);
@@ -211,7 +222,7 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 
 	return 0;
 
-fail_deps:
+fail_job_init:
 	drm_sched_job_cleanup(&job->base);
 	return ret;
 }

-- 
2.53.0

