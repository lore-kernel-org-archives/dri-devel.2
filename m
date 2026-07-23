Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F54CC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB66410E60D;
	Fri, 24 Jul 2026 00:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YQLbB84g";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7951110E60D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851219; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J7W1jJilnKcEySRYLWzxZ54DUjtRyDCvZfYLuHaGu8BIx9x8EMfIa8+IKefGm2lMHeqPORcjIHV59xdanSDGwWOWDANiNtXmC49YWbJ7Y/1t57YVkf/trShG5iqXkLEISJPGTIm58ZhYG8MGmseph36A5H31qYJ7kEEk/16fE7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851219;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Q7upsY9yMFftCib5x9pBTM8bYUDWeueIF3STXhh17Yk=; 
 b=XiVFYpTfuMbJ5swMa+34AfEkjDm+TC0Mh6nXUXnx4lW2VULXaPdlxtp8NxQtTcldBaxRwzBjAPstX+lE5h8na4xMfhp23TRoNkAtcCYjMEX09Q3uEmxhh0x74tlMsgBezFXcVPKUcdKx/4StKyClzLebsxkAVvldAVipk/jS6Tc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851219; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Q7upsY9yMFftCib5x9pBTM8bYUDWeueIF3STXhh17Yk=;
 b=YQLbB84gxPGXz3hxMMk0AXqe+sXDGMiq1LHey1j+X2ebXeMkeopFLDYfYFUAuV9F
 fgg4Z5nEvu63s6Imub3/GmMV9r43lVjaXu8iZY/GtpjYaKYo78XO2iJ3SV7QnwZIGK3
 CBug+9CX1M0RmrPEDyU6kBp8R3VqDc8kX/rrr4Mg=
Received: by mx.zohomail.com with SMTPS id 1784851217646699.7851036660204;
 Thu, 23 Jul 2026 17:00:17 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:58:58 +0100
Subject: [PATCH v3 05/13] drm/panfrost: Move all device power up and down
 into RPM callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-5-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16882;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=8x2K5W9e7B6Rk+gJLwrnn90cE78maXPX4Ve8vHP4Xko=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqro5py4Pd35HEK/LVk/tk1sZ4IcAW8Uv3Att
 r1LOqxHSDqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 PTAtC/9D+HMDPg0XkAzuwuSc2MbIuxfz5BrATHjeZ3wmVtIWnaqKP2h/YImqy6jLaowomR8kXQy
 FiTm7n0+n+Hn0zl1whTwgnHXhZKCUs/9SYwqs7GfGsb4qRWky+un03nMGBMZE8zeetbX5FgZE1/
 CHfHKa2od1gZZ/G0U6QF5IB5uzF7HdzYRAoiPX+i82jPjqTVBqtGd+GdiU9ulemCuslYo/cu7Jv
 fqc/WQh8N9XLQYDYDkAJLqY6oNf9vVfOeaqDKl4nddzToC/g0ouYGeCHyrfXhYF/2ZheKHfDJ93
 leNXHvpMznbjzEDXZ/y4nhDRMuak1JSPFAo8EpZh2Eg/69wDey43ZqqWz4aRlqkqvrhzZ4DWXZn
 qeftpBGua5FgdjfLdaDm+UPIwogSYji7euAqWDf78+DWrCSIJHH76lX3BxsZCo2Cn9Nl6ODhh9H
 onCq/33TkSsq1+iHa4xOR7ppZbqwhj+chPBV5/F6ffFpg2Jh+HoC/lJjSIYV+Npd7thhU=
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 373 +++++++++++++++++------------
 drivers/gpu/drm/panfrost/panfrost_device.h |   3 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  13 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c    |   7 +-
 4 files changed, 228 insertions(+), 168 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 03905495aee2..d68f1ec82895 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -18,6 +18,11 @@
 #include "panfrost_mmu.h"
 #include "panfrost_perfcnt.h"
 
+static bool panfrost_device_is_initialized(struct panfrost_device *pfdev)
+{
+	return !!pfdev->js;
+}
+
 static int panfrost_reset_init(struct panfrost_device *pfdev)
 {
 	pfdev->rstc = devm_reset_control_array_get_optional_exclusive(pfdev->base.dev);
@@ -34,6 +39,32 @@ static void panfrost_reset_fini(struct panfrost_device *pfdev)
 	reset_control_assert(pfdev->rstc);
 }
 
+static int panfrost_clk_enable(struct panfrost_device *pfdev)
+{
+	int err;
+
+	err = clk_enable(pfdev->clock);
+	if (err)
+		return err;
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
+
+	return err;
+}
+
 static int panfrost_clk_init(struct panfrost_device *pfdev)
 {
 	int err;
@@ -48,7 +79,7 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 	rate = clk_get_rate(pfdev->clock);
 	dev_info(pfdev->base.dev, "clock rate = %lu\n", rate);
 
-	err = clk_prepare_enable(pfdev->clock);
+	err = clk_prepare(pfdev->clock);
 	if (err)
 		return err;
 
@@ -57,35 +88,43 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
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
+		err = panfrost_clk_enable(pfdev);
+		if (err)
+			goto unprepare_bus_ace_clock;
+	}
 
 	return 0;
 
-disable_bus_clock:
-	clk_disable_unprepare(pfdev->bus_clock);
-disable_clock:
-	clk_disable_unprepare(pfdev->clock);
+unprepare_bus_ace_clock:
+	clk_unprepare(pfdev->bus_clock);
+unprepare_bus_clock:
+	clk_unprepare(pfdev->bus_clock);
+unprepare_clock:
+	clk_unprepare(pfdev->clock);
 
 	return err;
 }
@@ -212,6 +251,143 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
 	return err;
 }
 
+static int panfrost_device_runtime_resume(struct device *dev)
+{
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+	int ret;
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
+		ret = reset_control_deassert(pfdev->rstc);
+		if (ret)
+			return ret;
+
+		ret = panfrost_clk_enable(pfdev);
+		if (ret)
+			goto err_clk;
+	}
+
+	panfrost_device_reset(pfdev, true);
+	panfrost_devfreq_resume(pfdev);
+
+	return 0;
+
+err_clk:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
+		reset_control_assert(pfdev->rstc);
+	return ret;
+}
+
+static int panfrost_device_runtime_suspend(struct device *dev)
+{
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+
+	if (!panfrost_jm_is_idle(pfdev))
+		return -EBUSY;
+
+	panfrost_devfreq_suspend(pfdev);
+	panfrost_jm_suspend_irq(pfdev);
+	panfrost_mmu_suspend_irq(pfdev);
+	panfrost_gpu_suspend_irq(pfdev);
+	panfrost_gpu_power_off(pfdev);
+
+	if (panfrost_device_is_initialized(pfdev) &&
+	    pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
+		clk_disable(pfdev->bus_ace_clock);
+		clk_disable(pfdev->bus_clock);
+		clk_disable(pfdev->clock);
+		reset_control_assert(pfdev->rstc);
+	}
+
+	if (!panfrost_device_is_initialized(pfdev)) {
+		panfrost_clk_fini(pfdev);
+		reset_control_assert(pfdev->rstc);
+	}
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
@@ -265,10 +441,25 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto out_regulator;
 	}
 
-	err = panfrost_gpu_init(pfdev);
+	err = devm_pm_runtime_enable(pfdev->base.dev);
+	if (err)
+		goto out_regulator;
+
+	err = pm_runtime_resume_and_get(pfdev->base.dev);
 	if (err)
 		goto out_regulator;
 
+	/* If PM is disabled, we need to call panfrost_device_runtime_resume() manually. */
+	if (!IS_ENABLED(CONFIG_PM)) {
+		err = panfrost_device_runtime_resume(pfdev->base.dev);
+		if (err)
+			goto out_regulator;
+	}
+
+	err = panfrost_gpu_init(pfdev);
+	if (err)
+		goto out_rpm_put;
+
 	err = panfrost_mmu_init(pfdev);
 	if (err)
 		goto out_gpu;
@@ -295,6 +486,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	panfrost_mmu_fini(pfdev);
 out_gpu:
 	panfrost_gpu_fini(pfdev);
+out_rpm_put:
+	panfrost_try_suspend_device(pfdev);
 out_regulator:
 	panfrost_regulator_fini(pfdev);
 out_devfreq:
@@ -313,12 +506,8 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_gem_shrinker_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
-	panfrost_mmu_fini(pfdev);
-	panfrost_gpu_fini(pfdev);
-	panfrost_devfreq_fini(pfdev);
 	panfrost_regulator_fini(pfdev);
-	panfrost_clk_fini(pfdev);
-	panfrost_reset_fini(pfdev);
+	panfrost_devfreq_fini(pfdev);
 	panfrost_pm_domain_fini(pfdev);
 }
 
@@ -424,148 +613,20 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
-	panfrost_gpu_soft_reset(pfdev);
-
-	panfrost_gpu_power_on(pfdev);
-	panfrost_mmu_reset(pfdev);
-
-	panfrost_jm_reset_interrupts(pfdev);
-	if (enable_job_int)
-		panfrost_jm_enable_interrupts(pfdev);
-}
-
-static int panfrost_device_runtime_resume(struct device *dev)
-{
-	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	int ret;
 
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
+	/* Do the actual device reset */
+	ret = panfrost_gpu_soft_reset(pfdev);
+	panfrost_gpu_power_on(pfdev);
 
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		if (pfdev->bus_clock)
-			clk_disable(pfdev->bus_clock);
+	if (!panfrost_device_is_initialized(pfdev) && !ret)
+		atomic_set(&pfdev->gpu_powered, 1);
 
-		clk_disable(pfdev->clock);
+	/* Post-reset */
+	if (panfrost_device_is_initialized(pfdev)) {
+		panfrost_mmu_reset(pfdev);
+		panfrost_jm_reset_interrupts(pfdev);
+		if (enable_job_int)
+			panfrost_jm_enable_interrupts(pfdev);
 	}
-
-	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
-		dev_pm_opp_set_opp(dev, NULL);
-
-	return 0;
 }
-
-EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
-	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
-};
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index ec55c136b1b6..6bec8fcb701e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -142,6 +142,7 @@ struct panfrost_device {
 	/* pm_domains for devices with more than one. */
 	struct device *pm_domain_devs[MAX_PM_DOMAINS];
 	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
+	atomic_t gpu_powered;
 	bool coherent;
 
 	struct panfrost_features features;
@@ -253,6 +254,8 @@ int panfrost_device_init(struct panfrost_device *pfdev);
 void panfrost_device_fini(struct panfrost_device *pfdev);
 void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
 
+void panfrost_try_suspend_device(struct panfrost_device *pfdev);
+
 extern const struct dev_pm_ops panfrost_pm_ops;
 
 enum drm_panfrost_exception_type {
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 331a3bd5b98c..5eb4b095b1f8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -988,9 +988,7 @@ static int panfrost_probe(struct platform_device *pdev)
 		goto err_out0;
 	}
 
-	pm_runtime_set_active(pfdev->base.dev);
 	pm_runtime_mark_last_busy(pfdev->base.dev);
-	pm_runtime_enable(pfdev->base.dev);
 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
 	pm_runtime_use_autosuspend(pfdev->base.dev);
 
@@ -1002,13 +1000,13 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_out1;
 
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 
 	return 0;
 
 err_out1:
-	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
+	panfrost_try_suspend_device(pfdev);
 err_out0:
 	return err;
 }
@@ -1019,10 +1017,11 @@ static void panfrost_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&pfdev->base);
 
-	pm_runtime_get_sync(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
+
 	panfrost_device_fini(pfdev);
-	pm_runtime_set_suspended(pfdev->base.dev);
+
+	panfrost_try_suspend_device(pfdev);
 }
 
 static ssize_t profiling_show(struct device *dev,
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 7d555e63e21a..1b22578f71bc 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -516,9 +516,8 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 {
 	int err;
 
-	err = panfrost_gpu_soft_reset(pfdev);
-	if (err)
-		return err;
+	if (!atomic_read(&pfdev->gpu_powered))
+		return -ETIMEDOUT;
 
 	err = panfrost_gpu_init_features(pfdev);
 	if (err)
@@ -543,8 +542,6 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
-	panfrost_gpu_power_on(pfdev);
-
 	return 0;
 }
 

-- 
2.55.0

