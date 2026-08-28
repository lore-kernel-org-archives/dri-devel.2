Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE0C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A1710F45D;
	Fri, 28 Aug 2026 20:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ce3tDsWI";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA31610F45D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950678; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D8RT7HaXTRFm10eAscpBuju3uOFgjCdXlSTyyzJ2/QgLE4HNeQZiKyID+pkxNWp+SFeB0GdzilAXvM1Xsq0AxqzGde1WTmG3U8PSDM5rqmZhGDIaXtxZyAxi3Uv0402AXzzWUvI3lHJaBtxUUib9blP5c9Gvlw37bdrV1+L/2p0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950678;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=od5OUbKvCXLtDxsFzjvdgUt0gGN3KLsNBfMV+vWPEHA=; 
 b=bxrk+GQL2hs3u6bSwDr4WrMkTLW5yJF1vuH+Avv8a8Cd2EIvaQ6FyTJQ+OqRhQiZRMiWYmdpi4YG/MDKsDp4/kajcGsh2pD2+d7W7cgyowJOtHEBWOkATuXjQDrSu9HOiEaNvkwOP9nGz23dKOQGAP/YaoiCWMBV6Gzl1UiYPMM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950678; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=od5OUbKvCXLtDxsFzjvdgUt0gGN3KLsNBfMV+vWPEHA=;
 b=Ce3tDsWINsZHnhnz2ffPoDij1D/IpphqMuuXOyh8nWcVyBnjIdudKKkTzeyLQlW0
 +rfi+Hy2WMbhGeLZbyJguDyvId7fOXr9ShakJvhI9gFgirlat8Nqa/a3rXuE4TOq6G0
 EhIAZjk/KVZ2FpEFmXQF7T3/x16NTTbEHaWF6pBE=
Received: by mx.zohomail.com with SMTPS id 1787950676241973.8812197132261;
 Fri, 28 Aug 2026 13:57:56 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:46 +0100
Subject: [PATCH v7 06/17] drm/panfrost: Consolidate device clock management
 and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-6-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7529;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=lDX7Gq+nDDqxqZlHoKMag4LTg/zlnGY3wVJubgu254I=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYtK0KIsxurcSdMR2AwMtjFyGwNIlBDr7h5Q
 BlOWJwqpnOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LQAKCRAOJn5M7lND
 Pc3KC/0TZ9tBXAE1hBd3XHdYAjAYKP6LIlXKn9BMMmCtQK4801HKJIRR7sA5ouQqINTghRCoNp0
 QdUdh99JwKv4+dVJDmFGp0+w/U/ATtwzn7NtNzOqRg9sDMpanWFJelb7SS3A8Rs19+K2aaKH45I
 PsyIzYur1LXCS5iGvuPacu7tvocx5yyAldayl2gKZyk03Zel8tRchSv/rTTNqvbdbvawE+rxXJD
 LRViCml296szz/G1Qcy21OGOz9cthhjSs9YkdcQSRCfCsfFt4WdPgVu1a0gY8ANNQdXfdhiZt7z
 EHCKYBgP2BjBMSwULgesDFPA0wCadjPyjO9zKrNn126jMU0XV5PtIojm7cX9qId3jBF0SSJ6N1P
 Ic7ZmSNxJAzhn9jtxmmT2kMm8qH32YHEnZPlQ+PRzqElfqB9MQGgicRRwr97LoHNNbS/tsNcvTh
 6PpAR9Jy5uM7qN+eCrbqqK2WVoEdcD81vmZWvjGOH+DfSMUykMzUSzJNpLCooUf8ndxxg=
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
repetition. Also, as part of the same function, handle reset control
(de)assertions, since that was already the case in the PM runtime
functions.

Also do clk (un)prepares and dis/enables at the same time, since the
clk_prepare_* family of functions can simply increase the refcnt of
an already prepared clock.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 123 +++++++++++++----------------
 1 file changed, 53 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index a9d9669912e0..9549ddb7854a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -27,18 +27,53 @@ static int panfrost_reset_init(struct panfrost_device *pfdev)
 		return PTR_ERR(pfdev->rstc);
 	}
 
-	return reset_control_deassert(pfdev->rstc);
+	return 0;
+}
+
+static int panfrost_clk_enable_deassert_reset(struct panfrost_device *pfdev)
+{
+	int err;
+
+	err = reset_control_deassert(pfdev->rstc);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(pfdev->clock);
+	if (err)
+		goto assert_reset;
+
+	err = clk_prepare_enable(pfdev->bus_clock);
+	if (err)
+		goto disable_clock;
+
+	err = clk_prepare_enable(pfdev->bus_ace_clock);
+	if (err)
+		goto disable_bus_clock;
+
+	return 0;
+
+disable_bus_clock:
+	clk_disable_unprepare(pfdev->bus_clock);
+disable_clock:
+	clk_disable_unprepare(pfdev->clock);
+assert_reset:
+	reset_control_assert(pfdev->rstc);
+
+	return err;
 }
 
-static void panfrost_reset_fini(struct panfrost_device *pfdev)
+static void panfrost_clk_disable_assert_reset(struct panfrost_device *pfdev)
 {
+	clk_disable_unprepare(pfdev->bus_ace_clock);
+	clk_disable_unprepare(pfdev->bus_clock);
+	clk_disable_unprepare(pfdev->clock);
 	reset_control_assert(pfdev->rstc);
 }
 
 static int panfrost_clk_init(struct panfrost_device *pfdev)
 {
-	int err;
 	unsigned long rate;
+	int err = 0;
 
 	pfdev->clock = devm_clk_get(pfdev->base.dev, NULL);
 	if (IS_ERR(pfdev->clock)) {
@@ -49,53 +84,31 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
 	rate = clk_get_rate(pfdev->clock);
 	dev_info(pfdev->base.dev, "clock rate = %lu\n", rate);
 
-	err = clk_prepare_enable(pfdev->clock);
-	if (err)
-		return err;
-
 	pfdev->bus_clock = devm_clk_get_optional(pfdev->base.dev, "bus");
 	if (IS_ERR(pfdev->bus_clock)) {
-		dev_err(pfdev->base.dev, "get bus_clock failed %ld\n",
-			PTR_ERR(pfdev->bus_clock));
 		err = PTR_ERR(pfdev->bus_clock);
-		goto disable_clock;
+		dev_err(pfdev->base.dev, "get bus_clock failed %d\n", err);
+		return err;
 	}
 
 	if (pfdev->bus_clock) {
 		rate = clk_get_rate(pfdev->bus_clock);
 		dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate);
-
-		err = clk_prepare_enable(pfdev->bus_clock);
-		if (err)
-			goto disable_clock;
 	}
 
 	pfdev->bus_ace_clock = devm_clk_get_optional(pfdev->base.dev, "bus_ace");
 	if (IS_ERR(pfdev->bus_ace_clock)) {
 		err = PTR_ERR(pfdev->bus_ace_clock);
 		dev_err(pfdev->base.dev, "get bus_ace_clock failed %d\n", err);
-		goto disable_bus_clock;
+		return err;
 	}
 
-	err = clk_prepare_enable(pfdev->bus_ace_clock);
-	if (err)
-		goto disable_bus_clock;
-
-	return 0;
-
-disable_bus_clock:
-	clk_disable_unprepare(pfdev->bus_clock);
-disable_clock:
-	clk_disable_unprepare(pfdev->clock);
-
-	return err;
+	return panfrost_clk_enable_deassert_reset(pfdev);
 }
 
 static void panfrost_clk_fini(struct panfrost_device *pfdev)
 {
-	clk_disable_unprepare(pfdev->bus_ace_clock);
-	clk_disable_unprepare(pfdev->bus_clock);
-	clk_disable_unprepare(pfdev->clock);
+	panfrost_clk_disable_assert_reset(pfdev);
 }
 
 static int panfrost_regulator_init(struct panfrost_device *pfdev)
@@ -241,7 +254,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	err = panfrost_clk_init(pfdev);
 	if (err) {
 		dev_err(pfdev->base.dev, "clk init failed %d\n", err);
-		goto out_reset;
+		goto out_pm_domain;
 	}
 
 	err = panfrost_devfreq_init(pfdev);
@@ -317,8 +330,6 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	panfrost_devfreq_fini(pfdev);
 out_clk:
 	panfrost_clk_fini(pfdev);
-out_reset:
-	panfrost_reset_fini(pfdev);
 out_pm_domain:
 	panfrost_pm_domain_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
@@ -338,7 +349,6 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	panfrost_devfreq_fini(pfdev);
 	panfrost_regulator_fini(pfdev);
 	panfrost_clk_fini(pfdev);
-	panfrost_reset_fini(pfdev);
 	panfrost_pm_domain_fini(pfdev);
 
 	pm_runtime_set_suspended(pfdev->base.dev);
@@ -462,38 +472,15 @@ static int panfrost_device_runtime_resume(struct device *dev)
 	int ret;
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
-		ret = reset_control_deassert(pfdev->rstc);
+		ret = panfrost_clk_enable_deassert_reset(pfdev);
 		if (ret)
 			return ret;
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
@@ -509,12 +496,8 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 	panfrost_gpu_suspend_irq(pfdev);
 	panfrost_gpu_power_off(pfdev);
 
-	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
-		clk_disable(pfdev->bus_ace_clock);
-		clk_disable(pfdev->bus_clock);
-		clk_disable(pfdev->clock);
-		reset_control_assert(pfdev->rstc);
-	}
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
+		panfrost_clk_disable_assert_reset(pfdev);
 
 	return 0;
 }
@@ -536,11 +519,11 @@ static int panfrost_device_resume(struct device *dev)
 	}
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		ret = clk_enable(pfdev->clock);
+		ret = clk_prepare_enable(pfdev->clock);
 		if (ret)
 			goto err_clk;
 
-		ret = clk_enable(pfdev->bus_clock);
+		ret = clk_prepare_enable(pfdev->bus_clock);
 		if (ret)
 			goto err_bus_clk;
 	}
@@ -553,10 +536,10 @@ static int panfrost_device_resume(struct device *dev)
 
 err_resume:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->bus_clock);
+		clk_disable_unprepare(pfdev->bus_clock);
 err_bus_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->clock);
+		clk_disable_unprepare(pfdev->clock);
 err_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
 		dev_pm_opp_set_opp(dev, NULL);
@@ -573,8 +556,8 @@ static int panfrost_device_suspend(struct device *dev)
 		return ret;
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		clk_disable(pfdev->bus_clock);
-		clk_disable(pfdev->clock);
+		clk_disable_unprepare(pfdev->bus_clock);
+		clk_disable_unprepare(pfdev->clock);
 	}
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))

-- 
2.55.0

