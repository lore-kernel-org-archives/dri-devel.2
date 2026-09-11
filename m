Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EDFC88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB8210F70F;
	Fri, 11 Sep 2026 23:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VLKOXLUw";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B06610F70F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169315; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h5GdodCEFYWC5aT5Y/s//I6Q+CHvxAqxaTWneE2iC2vVZRl12xU3dPyr/CLkxHedXIfoIGGdpLHl9k2w6cqmgY5X/2kwepXMNpu400fKuQMJ0O3DriDLEYrDgn3MvVd001kw7kTpvfQM4s/ozr10N3Wf4Py8FN6LlvbZ6q27DN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169315;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mF1RZthkuxBEzV521eRDnzbipr0oJ1kFYAE3ZplKRrI=; 
 b=YnLro6LnZjQIkSdX/VLtn69PK4p7HWAKA0r24RjFTOW0+kJPNfibSVF2L99ICzSR8H/l+98yqLpSdBXn/rK1zZxhvQ7ixZfpNHXnut7Q6uvI8iPhJ7JKxzMRJA/FIkF4c/XEnqX1efdRP8sg710O+cUi0QyAU2sWJZ1tkAv/8Uw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169315; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=mF1RZthkuxBEzV521eRDnzbipr0oJ1kFYAE3ZplKRrI=;
 b=VLKOXLUw7RqplPKwJnSdOtPG40kQL9RcdPXU2x//YsPEKx45uWVRh9LZVCoJ1HL4
 9bafbtktoI45L2M+xbt7SQiechlV6mdRWZ6+5Dk2s/d8Kq3v/QDc4NwythwRT5iw3XA
 BWn17ab4mO0nR5HXAiC3TuWAK7hnWMArDk1T4rl4=
Received: by mx.zohomail.com with SMTPS id 178916931426765.30832356669805;
 Fri, 11 Sep 2026 16:28:34 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 12 Sep 2026 00:28:06 +0100
Subject: [PATCH v9 05/16] drm/panfrost: Consolidate device clock management
 and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260912-claude-fixes-v9-5-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
In-Reply-To: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6296;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=8N9OTvjoinX5/P8Bx031evS2KBpmBBnj/B3cF4lIFps=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqpI6DNigqCJshDoRQPNvcgGhnu2sXDOg3GT1s0
 YkQaqCLPbeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaqSOgwAKCRAOJn5M7lND
 PS7QDACn3Oe8lAXZQy7znZ/c3vG6QzQ/yWJJDJLrgIOCdVaRvpp2S42zk1BX8fZ10j865qNwPhw
 /83YrT08hW3DlEO7CeEXUVSIGPVIwsIWPtKOMNJUBMdXBldSyq6pHD8HSfXDLxWOV2vIyWhsqXV
 tXiTRnRtRNMMdkM7olHXRQQPhpcdEqYy+z0RgsShPKazKZ3CKGEQwuIPCpcCrAjnIw943yEp/Tb
 mLcZ8xcr6Jehgzoe3mgRwDTg0M/uByTsz9il+jTeGthXWR6/GocYbLReI8EZUyv2+1Q7ZGWQAUT
 RhFXQPoLtVEbddnLHVPd8/Kq6M5ukXH2DA/95VYugN5CRKfawtY3jO/ABIa3mvCCKi8mrjFGIeM
 sjWL5BKVNOnwlpYAg7PD0I7ykfUxcblMNpty8lW0UzCaNec/OnczroXM3XyxBoXIYyXzv10y5vp
 m/ARckoiLl9DuNqsDlIg+VJR9oRi02jj44R22JXO1k3TyjmMJmj6B8dfGr15kW1sE07PY=
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

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 118 +++++++++++++----------------
 1 file changed, 52 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index b3a53504bd01..2fcbd223204c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -34,10 +34,46 @@ static void panfrost_reset_fini(struct panfrost_device *pfdev)
 	reset_control_assert(pfdev->rstc);
 }
 
-static int panfrost_clk_init(struct panfrost_device *pfdev)
+static int panfrost_clk_enable(struct panfrost_device *pfdev, bool enable_ace_clock)
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
+	if (enable_ace_clock) {
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
+static void panfrost_clk_disable(struct panfrost_device *pfdev, bool disable_ace_clock)
+{
+	if (disable_ace_clock)
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
@@ -48,53 +84,31 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
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
+	return panfrost_clk_enable(pfdev, true);
 }
 
 static void panfrost_clk_fini(struct panfrost_device *pfdev)
 {
-	clk_disable_unprepare(pfdev->bus_ace_clock);
-	clk_disable_unprepare(pfdev->bus_clock);
-	clk_disable_unprepare(pfdev->clock);
+	panfrost_clk_disable(pfdev, true);
 }
 
 static int panfrost_regulator_init(struct panfrost_device *pfdev)
@@ -436,34 +450,17 @@ static int panfrost_device_runtime_resume(struct device *dev)
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
+		ret = panfrost_clk_enable(pfdev, true);
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
@@ -480,9 +477,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 	panfrost_gpu_power_off(pfdev);
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
-		clk_disable(pfdev->bus_ace_clock);
-		clk_disable(pfdev->bus_clock);
-		clk_disable(pfdev->clock);
+		panfrost_clk_disable(pfdev, true);
 		reset_control_assert(pfdev->rstc);
 	}
 
@@ -506,13 +501,9 @@ static int panfrost_device_resume(struct device *dev)
 	}
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		ret = clk_enable(pfdev->clock);
+		ret = panfrost_clk_enable(pfdev, false);
 		if (ret)
 			goto err_clk;
-
-		ret = clk_enable(pfdev->bus_clock);
-		if (ret)
-			goto err_bus_clk;
 	}
 
 	ret = pm_runtime_force_resume(dev);
@@ -523,10 +514,7 @@ static int panfrost_device_resume(struct device *dev)
 
 err_resume:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->bus_clock);
-err_bus_clk:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->clock);
+		clk_disable_unprepare(pfdev->bus_clock);
 err_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
 		dev_pm_opp_set_opp(dev, NULL);
@@ -542,10 +530,8 @@ static int panfrost_device_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		clk_disable(pfdev->bus_clock);
-		clk_disable(pfdev->clock);
-	}
+	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
+		panfrost_clk_disable(pfdev, false);
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
 		dev_pm_opp_set_opp(dev, NULL);

-- 
2.55.0

