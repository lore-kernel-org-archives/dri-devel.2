Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EBFCA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C9E10F816;
	Wed,  7 Oct 2026 23:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="KJhSVxSE";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743C910E70B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791416610; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mEjR8dK4F4+5JbnGG6ad22nkbgkVl5MK8985v/pUqxiBd/EXrj24pOYt6RmMMi9p8h2f7QDo02vQ4c9VT+DsEzLRjCILq8wTJnZpBbT0gHkf30ke6qnXXeUye9Fec3sSmW6yhBGsamZcwFAZWOFb+PXiBh8wuPbyolNji+jGwB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791416610;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QwzKVU/azOK7Khc/4f6XJGagG+rrE1JO8HQImvgABaU=; 
 b=jdDMSrZjzGbVh3HJFLBjRs+lOeexDgDcjvog3r2z7aOPtqqf2iBcrh3KQMlXpqhM3rxBjI/y7Wxl9iwwYPdozezzbR0NULpbpF7ilqIMZxEl8xHf/6LTPIAqm4Pw9/J3PdD0LjFW6oZwp/NNCH8vn3sx6u5uqC/QSiyoxDvLJBY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791416610; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=QwzKVU/azOK7Khc/4f6XJGagG+rrE1JO8HQImvgABaU=;
 b=KJhSVxSEE8LK7LxyqFsotkOGw2Dk4VbMO6bhGaT1qZSLB7Ypb1rUMi/Wzd6ObRfY
 Dk8qTLf6cFlzUS8KuiHfNvpfFZ9z21VeH84GIyuc5vr3ZbeMuf6bCbSJVX3YsLCazY1
 3D6BNoWjwGhsDGVkJXqN2U9LOu99jaxAapLSlFXU=
Received: by smtp.zohomail.com with SMTPS id 1791416608993738.2474814799322;
 Wed, 7 Oct 2026 16:43:28 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 08 Oct 2026 00:42:48 +0100
Subject: [PATCH v13 05/15] drm/panfrost: Consolidate device clock
 management and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-claude-fixes-v13-5-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
In-Reply-To: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6919;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=jTSGHhfFQYoYvoFO4YQT6+qPSe03rOqW+dZUAXgC0jc=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxtj7K8oBH/3hv8c0dFFcLahWnfTP1aDG7h1m0
 gQpC3OMZwKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasbY+wAKCRAOJn5M7lND
 PTgyC/47MVNbkiKchSc5KQ2/IXDGGUMpPZsgb3JHOENYOhMLhwRt5Nq7hJeoo44dv0Gevd5W49+
 E6/mYv65gvob8Sw3Gtb8AVigCBfau+eZTh8Hz14SYKgEj231zW7EE9Z9Z9xd+I24ir0RZypnVm9
 iWqKqcW508O4URNckwPaxbYuyndNt5BiiXzQVI+IviMHLO9go4UskcO3yQP8hHguFyQqW0Uxavo
 yrG5iJuuq7CqVSo0IJUao2C3B22nmSaKJJRpApD+nCeUieZurwKHrhgoiGbZe8X5sF18yBr10Cf
 FEiEHwMZ8sb5WXxvG/fYT//W7JH1ZA6q77+PM4nE3xSl9B83RgoAa2OyMrgVhQEs6WMVn0fQ2wP
 OOJjHvZG2QjIDwsqlKOLqK1yDLCHCJEU2OT+iKELfmet17rAl+72leluqw2kb+8yUCHgCkYfq6H
 0LQzQ8IC2b9CISehOi/jowYyMH4UDrFZx6wNKcDmrCGsgDy+xO9RXv37iM9xlf6EQPvcI=
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

Gather all clock enables and disables into a single function to avoid
repetitions between driver init/fini and device resume/suspend, since
these clocks are always handled in bulk.

Also do clk (un)prepares and dis/enables at the same time, since the
clk_prepare_* family of functions can simply increase the refcnt of
an already prepared clock.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 124 ++++++++++++++++-------------
 1 file changed, 69 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index b3a53504bd01..50f4713bfcfd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -34,10 +34,46 @@ static void panfrost_reset_fini(struct panfrost_device *pfdev)
 	reset_control_assert(pfdev->rstc);
 }
 
-static int panfrost_clk_init(struct panfrost_device *pfdev)
+static int panfrost_clks_enable(struct panfrost_device *pfdev, bool on_resume)
 {
 	int err;
+
+	err = clk_prepare_enable(pfdev->clock);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(pfdev->bus_clock);
+	if (err)
+		goto disable_clock;
+
+	if (on_resume) {
+		err = clk_prepare_enable(pfdev->bus_ace_clock);
+		if (err)
+			goto disable_bus_clock;
+	}
+
+	return 0;
+
+disable_bus_clock:
+	clk_disable_unprepare(pfdev->bus_clock);
+disable_clock:
+	clk_disable_unprepare(pfdev->clock);
+
+	return err;
+}
+
+static void panfrost_clks_disable(struct panfrost_device *pfdev, bool on_suspend)
+{
+	if (on_suspend)
+		clk_disable_unprepare(pfdev->bus_ace_clock);
+	clk_disable_unprepare(pfdev->bus_clock);
+	clk_disable_unprepare(pfdev->clock);
+}
+
+static int panfrost_clk_init(struct panfrost_device *pfdev)
+{
 	unsigned long rate;
+	int err;
 
 	pfdev->clock = devm_clk_get(pfdev->base.dev, NULL);
 	if (IS_ERR(pfdev->clock)) {
@@ -48,53 +84,59 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 	rate = clk_get_rate(pfdev->clock);
 	dev_info(pfdev->base.dev, "clock rate = %lu\n", rate);
 
-	err = clk_prepare_enable(pfdev->clock);
+	err = clk_prepare(pfdev->clock);
 	if (err)
 		return err;
 
 	pfdev->bus_clock = devm_clk_get_optional(pfdev->base.dev, "bus");
 	if (IS_ERR(pfdev->bus_clock)) {
-		dev_err(pfdev->base.dev, "get bus_clock failed %ld\n",
-			PTR_ERR(pfdev->bus_clock));
 		err = PTR_ERR(pfdev->bus_clock);
-		goto disable_clock;
+		dev_err(pfdev->base.dev, "get bus_clock failed %d\n", err);
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
+	if (err)
+		goto unprepare_bus_clock;
+
+	err = panfrost_clks_enable(pfdev, true);
 	if (err)
-		goto disable_bus_clock;
+		goto unprepare_bus_ace_clock;
 
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
+	panfrost_clks_disable(pfdev, true);
+	clk_unprepare(pfdev->bus_ace_clock);
+	clk_unprepare(pfdev->bus_clock);
+	clk_unprepare(pfdev->clock);
 }
 
 static int panfrost_regulator_init(struct panfrost_device *pfdev)
@@ -436,34 +478,17 @@ static int panfrost_device_runtime_resume(struct device *dev)
 		if (ret)
 			return ret;
 
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
+		ret = panfrost_clks_enable(pfdev, true);
+		if (ret) {
+			reset_control_assert(pfdev->rstc);
+			return ret;
+		}
 	}
 
 	panfrost_device_reset(pfdev, true);
 	panfrost_devfreq_resume(pfdev);
 
 	return 0;
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
 }
 
 static int panfrost_device_runtime_suspend(struct device *dev)
@@ -480,9 +505,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 	panfrost_gpu_power_off(pfdev);
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
-		clk_disable(pfdev->bus_ace_clock);
-		clk_disable(pfdev->bus_clock);
-		clk_disable(pfdev->clock);
+		panfrost_clks_disable(pfdev, true);
 		reset_control_assert(pfdev->rstc);
 	}
 
@@ -506,13 +529,9 @@ static int panfrost_device_resume(struct device *dev)
 	}
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		ret = clk_enable(pfdev->clock);
+		ret = panfrost_clks_enable(pfdev, false);
 		if (ret)
 			goto err_clk;
-
-		ret = clk_enable(pfdev->bus_clock);
-		if (ret)
-			goto err_bus_clk;
 	}
 
 	ret = pm_runtime_force_resume(dev);
@@ -523,10 +542,7 @@ static int panfrost_device_resume(struct device *dev)
 
 err_resume:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->bus_clock);
-err_bus_clk:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->clock);
+		panfrost_clks_disable(pfdev, false);
 err_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
 		dev_pm_opp_set_opp(dev, NULL);
@@ -542,10 +558,8 @@ static int panfrost_device_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		clk_disable(pfdev->bus_clock);
-		clk_disable(pfdev->clock);
-	}
+	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
+		panfrost_clks_disable(pfdev, false);
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
 		dev_pm_opp_set_opp(dev, NULL);

-- 
2.55.0

