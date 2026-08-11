Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB1BC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAB610ED97;
	Tue, 11 Aug 2026 21:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="gGdW/PFd";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C7E610E3A0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484567; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K/B+Q9ZJNaJA2q3xAGisiKuG+E/yczC9VJaU6sjSw1AtRrveLIg1XsVUB0tgMntMETQxFBb1Ed5zAkvmDoPtQBskOeUXOWEfrc/muip5fhWDTpMH7PVGVxAMVVumTnCg3ItI1xnGc8xkWlPRDW4nEjMCLwc8brwuvHxgcfl/5Yc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484567;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2O8DNA9VQ31kDWqzdW/bycCh+EkKhsOK7ju/9PYEgCM=; 
 b=DQsreX2sESP9APgBzCs3GjKKAcV4UryJ8d8KQTZbneFrCWLa6g3nlFJbTpqAnFJMDTZZr1QqWthiZARU0EG5nVgf++gsP7E2oGaPH6vCJhfgLu8aeRhnBLWvt6HPVIlBrAvqhhiSAKey4XICa815mXizR+gZJVimuJI7A7B531o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484567; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=2O8DNA9VQ31kDWqzdW/bycCh+EkKhsOK7ju/9PYEgCM=;
 b=gGdW/PFdrVwb5f3uw1B1ir2G/5KpzM0c+W5EEe85K8ZIG9j8p1ieXw0YqX96FALN
 og12GC4f5Ra7CKQdntCo2xALvHC1XPlyqkutyQLF5oTpU4ucHpSr+znLTtIT+AjGxHC
 5YES6fczMu61hue5tRThQaX47MQVwFbyFapXy8kM=
Received: by mx.zohomail.com with SMTPS id 1786484565565358.3485040358163;
 Tue, 11 Aug 2026 14:42:45 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:14 +0100
Subject: [PATCH v5 05/11] drm/panfrost: Move all device power up and down
 into RPM callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-5-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20807;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=gjlUq2K6GpDlK8BXfi9BaYyowTFnJf6CmMMlet9p6VI=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5cz6633CiIzm20dLdZtgpgseJzEwJAARlfSR
 QB8+DS2nZKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PfWEC/957tDSzhgD5jy3ZTyM2fkHUt+R3LmnOwmyWdRYJIyw3Kwsr0v4T46xfWufEqvVqbVPwRx
 IUs5IR/P+GL1e0uhbpssJ+wAVq/AUVejvVRGubOvJ6pJcFE86Sd1mysqiF2PLnYOpe/3Nn+Jhkd
 UxEH5pkCKt5anSe3IOvyEQBUQ7WLEtFiLWcgv+fy4RJJCHa3jpJGLxW+ONoCJG1v0XSdDPYaq9G
 HRh0+Kzq1NKPz/CRPO4Uz+g5fCmXpz9ca5QeV5kz9hRDhYltLfKICTqofbNKzOINZs0O8xGZP0S
 oSFgZUVaYrwp9OX1UIAJdy13at2MXSFm08aV9mXmVmEeGI35diCAk6r/toytx/RO/Sq3FD5a+Hy
 IktM4cDw7ucT7GQ7vwMMcbK94rNk7DsIhXt7Fs9s9DaNicfGbcyKdK461DwcAXa5YnSMfJHItXY
 846SQVSxaY9plt/HESiZ/Kr9qaq6pLoCQiwXdoxcJOEQ8n2AqiKtbLoqVEwHmLLk0MGKI=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

During device probe(), failure to do a PM get() will leave the usage_count
set to 0, which is the value assigned at device creation time. That means
when the autosuspend delay expires, runtime suspend callback won't be
invoked, so the device will remain powered on forever.

On top of that, failure to call PM put() during device unplug means
Panfrost device's PM usage_count increases monotonically for every new
module reload.

The combined outcome of both of the above was that devfreq OPP transition
notifications would be printed all the time, even when no jobs are being
submitted. This quickly fills the kernel ring buffer with junk.

Even direr than that was the fact MMU interrupts are only enabled when
the device is reset, so after device probe() the very first job targeting
the tiler heap BO would always time out, because the driver's PM runtime
resume callback would not be invoked.

Fix all that by moving all GPU enabling and disabling into RPM resume and
suspend callbacks, and making sure we resume the device right before
touching any HW registers. This is done in imitation of the Panthor model.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 389 ++++++++++++++++-------------
 drivers/gpu/drm/panfrost/panfrost_device.h |   8 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  11 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c    |   9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |   1 -
 drivers/gpu/drm/panfrost/panfrost_job.c    |   7 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c    |   9 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.h    |   1 -
 8 files changed, 236 insertions(+), 199 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 74992deb0b3a..52f4b8c6a05f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -26,11 +26,46 @@ static int panfrost_reset_init(struct panfrost_device *pfdev)
 		return PTR_ERR(pfdev->rstc);
 	}
 
-	return reset_control_deassert(pfdev->rstc);
+	return 0;
 }
 
-static void panfrost_reset_fini(struct panfrost_device *pfdev)
+static int panfrost_clk_enable_deassert_reset(struct panfrost_device *pfdev)
 {
+	int err;
+
+	err = reset_control_deassert(pfdev->rstc);
+	if (err)
+		return err;
+
+	err = clk_enable(pfdev->clock);
+	if (err)
+		goto assert_reset;
+
+	err = clk_enable(pfdev->bus_clock);
+	if (err)
+		goto disable_clock;
+
+	err = clk_enable(pfdev->bus_ace_clock);
+	if (err)
+		goto disable_bus_clock;
+
+	return 0;
+
+disable_bus_clock:
+	clk_disable(pfdev->bus_clock);
+disable_clock:
+	clk_disable(pfdev->clock);
+assert_reset:
+	reset_control_assert(pfdev->rstc);
+
+	return err;
+}
+
+static void panfrost_clk_disable_assert_reset(struct panfrost_device *pfdev)
+{
+	clk_disable(pfdev->bus_ace_clock);
+	clk_disable(pfdev->bus_clock);
+	clk_disable(pfdev->clock);
 	reset_control_assert(pfdev->rstc);
 }
 
@@ -48,7 +83,7 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 	rate = clk_get_rate(pfdev->clock);
 	dev_info(pfdev->base.dev, "clock rate = %lu\n", rate);
 
-	err = clk_prepare_enable(pfdev->clock);
+	err = clk_prepare(pfdev->clock);
 	if (err)
 		return err;
 
@@ -57,44 +92,55 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 		dev_err(pfdev->base.dev, "get bus_clock failed %ld\n",
 			PTR_ERR(pfdev->bus_clock));
 		err = PTR_ERR(pfdev->bus_clock);
-		goto disable_clock;
+		goto unprepare_clock;
 	}
 
 	if (pfdev->bus_clock) {
 		rate = clk_get_rate(pfdev->bus_clock);
 		dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate);
 
-		err = clk_prepare_enable(pfdev->bus_clock);
+		err = clk_prepare(pfdev->bus_clock);
 		if (err)
-			goto disable_clock;
+			goto unprepare_clock;
 	}
 
 	pfdev->bus_ace_clock = devm_clk_get_optional(pfdev->base.dev, "bus_ace");
 	if (IS_ERR(pfdev->bus_ace_clock)) {
 		err = PTR_ERR(pfdev->bus_ace_clock);
 		dev_err(pfdev->base.dev, "get bus_ace_clock failed %d\n", err);
-		goto disable_bus_clock;
+		goto unprepare_bus_clock;
 	}
 
-	err = clk_prepare_enable(pfdev->bus_ace_clock);
+	err = clk_prepare(pfdev->bus_ace_clock);
 	if (err)
-		goto disable_bus_clock;
+		goto unprepare_bus_clock;
+
+	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT))) {
+		err = panfrost_clk_enable_deassert_reset(pfdev);
+		if (err)
+			goto unprepare_bus_ace_clock;
+	}
 
 	return 0;
 
-disable_bus_clock:
-	clk_disable_unprepare(pfdev->bus_clock);
-disable_clock:
-	clk_disable_unprepare(pfdev->clock);
+unprepare_bus_ace_clock:
+	clk_unprepare(pfdev->bus_ace_clock);
+unprepare_bus_clock:
+	clk_unprepare(pfdev->bus_clock);
+unprepare_clock:
+	clk_unprepare(pfdev->clock);
 
 	return err;
 }
 
 static void panfrost_clk_fini(struct panfrost_device *pfdev)
 {
-	clk_disable_unprepare(pfdev->bus_ace_clock);
-	clk_disable_unprepare(pfdev->bus_clock);
-	clk_disable_unprepare(pfdev->clock);
+	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT)))
+		panfrost_clk_disable_assert_reset(pfdev);
+
+	clk_unprepare(pfdev->bus_ace_clock);
+	clk_unprepare(pfdev->bus_clock);
+	clk_unprepare(pfdev->clock);
 }
 
 static int panfrost_regulator_init(struct panfrost_device *pfdev)
@@ -212,6 +258,127 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
 	return err;
 }
 
+static int panfrost_device_runtime_resume(struct device *dev)
+{
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+	int ret;
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
+		ret = panfrost_clk_enable_deassert_reset(pfdev);
+		if (ret)
+			return ret;
+	}
+
+	panfrost_devfreq_resume(pfdev);
+
+	if (panfrost_device_started(pfdev))
+		panfrost_device_reset(pfdev, true);
+
+	return 0;
+}
+
+static int panfrost_device_runtime_suspend(struct device *dev)
+{
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+
+	if (panfrost_device_started(pfdev) &&
+	    !panfrost_jm_is_idle(pfdev))
+		return -EBUSY;
+
+	panfrost_jm_suspend_irq(pfdev);
+	panfrost_mmu_suspend_irq(pfdev);
+	panfrost_gpu_suspend_irq(pfdev);
+	panfrost_gpu_power_off(pfdev);
+	panfrost_devfreq_suspend(pfdev);
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
+		panfrost_clk_disable_assert_reset(pfdev);
+
+	return 0;
+}
+
+static int panfrost_device_resume(struct device *dev)
+{
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+	int ret;
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
+		unsigned long freq = pfdev->pfdevfreq.fast_rate;
+		struct dev_pm_opp *opp;
+
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+		dev_pm_opp_set_opp(dev, opp);
+		dev_pm_opp_put(opp);
+	}
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
+		ret = clk_enable(pfdev->clock);
+		if (ret)
+			goto err_clk;
+
+		if (pfdev->bus_clock) {
+			ret = clk_enable(pfdev->bus_clock);
+			if (ret)
+				goto err_bus_clk;
+		}
+	}
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		goto err_resume;
+
+	return 0;
+
+err_resume:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
+		clk_disable(pfdev->bus_clock);
+err_bus_clk:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
+		clk_disable(pfdev->clock);
+err_clk:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
+		dev_pm_opp_set_opp(dev, NULL);
+	return ret;
+}
+
+static int panfrost_device_suspend(struct device *dev)
+{
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
+		if (pfdev->bus_clock)
+			clk_disable(pfdev->bus_clock);
+
+		clk_disable(pfdev->clock);
+	}
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
+		dev_pm_opp_set_opp(dev, NULL);
+
+	return 0;
+}
+
+EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
+	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
+};
+
+void panfrost_try_suspend_device(struct panfrost_device *pfdev)
+{
+	pm_runtime_put_sync_suspend(pfdev->base.dev);
+
+	/* If PM is disabled, we need to call the suspend handler manually. */
+	if (!IS_ENABLED(CONFIG_PM))
+		panfrost_device_runtime_suspend(pfdev->base.dev);
+}
+
 int panfrost_device_init(struct panfrost_device *pfdev)
 {
 	int err;
@@ -242,7 +409,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	err = panfrost_clk_init(pfdev);
 	if (err) {
 		dev_err(pfdev->base.dev, "clk init failed %d\n", err);
-		goto out_reset;
+		goto out_pm_domain;
 	}
 
 	err = panfrost_devfreq_init(pfdev);
@@ -265,60 +432,70 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto out_regulator;
 	}
 
-	err = panfrost_gpu_init(pfdev);
+	err = devm_pm_runtime_enable(pfdev->base.dev);
 	if (err)
 		goto out_regulator;
 
-	err = panfrost_mmu_init(pfdev);
+	err = pm_runtime_resume_and_get(pfdev->base.dev);
 	if (err)
-		goto out_gpu;
+		goto out_regulator;
 
-	err = panfrost_jm_init(pfdev);
+	/* If PM is disabled, we need to call panfrost_device_runtime_resume() manually. */
+	if (!IS_ENABLED(CONFIG_PM)) {
+		err = panfrost_device_runtime_resume(pfdev->base.dev);
+		if (err)
+			goto out_regulator;
+	}
+
+	err = panfrost_gpu_init(pfdev);
 	if (err)
-		goto out_mmu;
+		goto out_rpm_put;
+
+	err = panfrost_mmu_init(pfdev);
+	if (err)
+		goto out_rpm_put;
 
 	err = panfrost_perfcnt_init(pfdev);
 	if (err)
-		goto out_job;
+		goto out_rpm_put;
 
 	err = panfrost_gem_init(pfdev);
 	if (err)
 		goto out_perfcnt;
 
+	err = panfrost_jm_init(pfdev);
+	if (err)
+		goto out_gem;
+
 	return 0;
 
+out_gem:
+	panfrost_gem_fini(pfdev);
 out_perfcnt:
 	panfrost_perfcnt_fini(pfdev);
-out_job:
-	panfrost_jm_fini(pfdev);
-out_mmu:
-	panfrost_mmu_fini(pfdev);
-out_gpu:
-	panfrost_gpu_fini(pfdev);
+out_rpm_put:
+	panfrost_try_suspend_device(pfdev);
 out_regulator:
 	panfrost_regulator_fini(pfdev);
 out_devfreq:
 	panfrost_devfreq_fini(pfdev);
 out_clk:
 	panfrost_clk_fini(pfdev);
-out_reset:
-	panfrost_reset_fini(pfdev);
 out_pm_domain:
 	panfrost_pm_domain_fini(pfdev);
 	return err;
 }
 
-void panfrost_device_fini(struct panfrost_device *pfdev)
+void
+panfrost_device_fini(struct panfrost_device *pfdev)
 {
+	panfrost_jm_fini(pfdev);
 	panfrost_gem_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
-	panfrost_jm_fini(pfdev);
-	panfrost_mmu_fini(pfdev);
-	panfrost_gpu_fini(pfdev);
-	panfrost_devfreq_fini(pfdev);
+	panfrost_try_suspend_device(pfdev);
 	panfrost_regulator_fini(pfdev);
+	panfrost_devfreq_fini(pfdev);
 	panfrost_clk_fini(pfdev);
-	panfrost_reset_fini(pfdev);
 	panfrost_pm_domain_fini(pfdev);
 }
 
@@ -425,147 +602,9 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	panfrost_gpu_soft_reset(pfdev);
-
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
-
 	panfrost_jm_reset_interrupts(pfdev);
 	if (enable_job_int)
 		panfrost_jm_enable_interrupts(pfdev);
 }
-
-static int panfrost_device_runtime_resume(struct device *dev)
-{
-	struct panfrost_device *pfdev = dev_get_drvdata(dev);
-	int ret;
-
-	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
-		ret = reset_control_deassert(pfdev->rstc);
-		if (ret)
-			return ret;
-
-		ret = clk_enable(pfdev->clock);
-		if (ret)
-			goto err_clk;
-
-		ret = clk_enable(pfdev->bus_clock);
-		if (ret)
-			goto err_bus_clk;
-
-		ret = clk_enable(pfdev->bus_ace_clock);
-		if (ret)
-			goto err_bus_ace_clk;
-	}
-
-	panfrost_device_reset(pfdev, true);
-	panfrost_devfreq_resume(pfdev);
-
-	return 0;
-
-err_bus_ace_clk:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
-		clk_disable(pfdev->bus_clock);
-err_bus_clk:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
-		clk_disable(pfdev->clock);
-err_clk:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
-		reset_control_assert(pfdev->rstc);
-	return ret;
-}
-
-static int panfrost_device_runtime_suspend(struct device *dev)
-{
-	struct panfrost_device *pfdev = dev_get_drvdata(dev);
-
-	if (!panfrost_jm_is_idle(pfdev))
-		return -EBUSY;
-
-	panfrost_devfreq_suspend(pfdev);
-	panfrost_jm_suspend_irq(pfdev);
-	panfrost_mmu_suspend_irq(pfdev);
-	panfrost_gpu_suspend_irq(pfdev);
-	panfrost_gpu_power_off(pfdev);
-
-	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
-		clk_disable(pfdev->bus_ace_clock);
-		clk_disable(pfdev->bus_clock);
-		clk_disable(pfdev->clock);
-		reset_control_assert(pfdev->rstc);
-	}
-
-	return 0;
-}
-
-static int panfrost_device_resume(struct device *dev)
-{
-	struct panfrost_device *pfdev = dev_get_drvdata(dev);
-	int ret;
-
-	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
-		unsigned long freq = pfdev->pfdevfreq.fast_rate;
-		struct dev_pm_opp *opp;
-
-		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		if (IS_ERR(opp))
-			return PTR_ERR(opp);
-		dev_pm_opp_set_opp(dev, opp);
-		dev_pm_opp_put(opp);
-	}
-
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		ret = clk_enable(pfdev->clock);
-		if (ret)
-			goto err_clk;
-
-		if (pfdev->bus_clock) {
-			ret = clk_enable(pfdev->bus_clock);
-			if (ret)
-				goto err_bus_clk;
-		}
-	}
-
-	ret = pm_runtime_force_resume(dev);
-	if (ret)
-		goto err_resume;
-
-	return 0;
-
-err_resume:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
-		clk_disable(pfdev->bus_clock);
-err_bus_clk:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->clock);
-err_clk:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
-		dev_pm_opp_set_opp(dev, NULL);
-	return ret;
-}
-
-static int panfrost_device_suspend(struct device *dev)
-{
-	struct panfrost_device *pfdev = dev_get_drvdata(dev);
-	int ret;
-
-	ret = pm_runtime_force_suspend(dev);
-	if (ret)
-		return ret;
-
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		if (pfdev->bus_clock)
-			clk_disable(pfdev->bus_clock);
-
-		clk_disable(pfdev->clock);
-	}
-
-	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
-		dev_pm_opp_set_opp(dev, NULL);
-
-	return 0;
-}
-
-EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
-	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
-};
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index ec55c136b1b6..0fd33bc5b86f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -253,6 +253,8 @@ int panfrost_device_init(struct panfrost_device *pfdev);
 void panfrost_device_fini(struct panfrost_device *pfdev);
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
 
+void panfrost_try_suspend_device(struct panfrost_device *pfdev);
+
 extern const struct dev_pm_ops panfrost_pm_ops;
 
 enum drm_panfrost_exception_type {
@@ -342,4 +344,10 @@ panfrost_device_schedule_reset(struct panfrost_device *pfdev)
 	queue_work(pfdev->reset.wq, &pfdev->reset.work);
 }
 
+static inline bool
+panfrost_device_started(struct panfrost_device *pfdev)
+{
+	return pfdev->js;
+}
+
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 331a3bd5b98c..8410de95e364 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -988,9 +988,6 @@ static int panfrost_probe(struct platform_device *pdev)
 		goto err_out0;
 	}
 
-	pm_runtime_set_active(pfdev->base.dev);
-	pm_runtime_mark_last_busy(pfdev->base.dev);
-	pm_runtime_enable(pfdev->base.dev);
 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
 	pm_runtime_use_autosuspend(pfdev->base.dev);
 
@@ -1002,13 +999,12 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_out1;
 
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 
 	return 0;
 
 err_out1:
-	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
 err_out0:
 	return err;
 }
@@ -1019,10 +1015,9 @@ static void panfrost_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&pfdev->base);
 
-	pm_runtime_get_sync(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
+
 	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
 }
 
 static ssize_t profiling_show(struct device *dev,
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 7d555e63e21a..0a3a68b561c9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -509,7 +509,9 @@ void panfrost_gpu_suspend_irq(struct panfrost_device *pfdev)
 	set_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
 
 	gpu_write(pfdev, GPU_INT_MASK, 0);
-	synchronize_irq(pfdev->gpu_irq);
+
+	if (pfdev->gpu_irq > 0)
+		synchronize_irq(pfdev->gpu_irq);
 }
 
 int panfrost_gpu_init(struct panfrost_device *pfdev)
@@ -548,11 +550,6 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 	return 0;
 }
 
-void panfrost_gpu_fini(struct panfrost_device *pfdev)
-{
-	panfrost_gpu_power_off(pfdev);
-}
-
 u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev)
 {
 	u32 flush_id;
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
index b4fef11211d5..3b39eaaa4d8f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
@@ -8,7 +8,6 @@
 struct panfrost_device;
 
 int panfrost_gpu_init(struct panfrost_device *pfdev);
-void panfrost_gpu_fini(struct panfrost_device *pfdev);
 
 u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev);
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 2d12b83e900a..c761379851da 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -446,7 +446,9 @@ void panfrost_jm_suspend_irq(struct panfrost_device *pfdev)
 	set_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
 
 	job_write(pfdev, JOB_INT_MASK, 0);
-	synchronize_irq(pfdev->js->irq);
+
+	if (pfdev->js)
+		synchronize_irq(pfdev->js->irq);
 }
 
 static void panfrost_job_handle_err(struct panfrost_device *pfdev,
@@ -869,7 +871,6 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	js = devm_kzalloc(pfdev->base.dev, sizeof(*js), GFP_KERNEL);
 	if (!js)
 		return -ENOMEM;
-	pfdev->js = js;
 
 	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
 	spin_lock_init(&js->job_lock);
@@ -904,6 +905,8 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 		}
 	}
 
+	pfdev->js = js;
+
 	panfrost_jm_reset_interrupts(pfdev);
 	panfrost_jm_enable_interrupts(pfdev);
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..3fe37dd12360 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -973,15 +973,12 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 	return 0;
 }
 
-void panfrost_mmu_fini(struct panfrost_device *pfdev)
-{
-	mmu_write(pfdev, MMU_INT_MASK, 0);
-}
-
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
 {
 	set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
 
 	mmu_write(pfdev, MMU_INT_MASK, 0);
-	synchronize_irq(pfdev->mmu_irq);
+
+	if (pfdev->mmu_irq > 0)
+		synchronize_irq(pfdev->mmu_irq);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index 27c3c65ed074..f69ac4a880b3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -13,7 +13,6 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping);
 void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping);
 
 int panfrost_mmu_init(struct panfrost_device *pfdev);
-void panfrost_mmu_fini(struct panfrost_device *pfdev);
 void panfrost_mmu_reset(struct panfrost_device *pfdev);
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
 

-- 
2.55.0

