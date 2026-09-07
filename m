Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2C2C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90CE10E649;
	Mon,  7 Sep 2026 20:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="aKUaxKl2";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B7E10E649
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788812217; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WD8ccLcdh8s7Fa6MHqhzpICylP4GYTyORQfj9MOoRcd303iM3ibn6iT2XC+m7+E8iLx2R1CkPJ6O+piS9Dz4YudONK5gvOsRSADJPl2qAKQqlFT7QQQ7kH1ZAwiBf0hfRe6qbifvD6qSA0PUaaVe+SDMJY6NZMIb2CpCgWJVJgI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788812217;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uE6tGIUw4nUFeMlGUIl2Vj3+Z0EEpcFNwJvK87yeLC8=; 
 b=h/h/DsbJ/xbhdmECWnmELI7dauVlrhQtEKnd70qvsS8yvYzlstL+oxvKiz/M52ns7OkTNx4wUwIUQHHxF0Be7JcspPb3/mblhnb7an8cL+/CND4w/hCQVmif0SrN4L7Sfajna7ATHZfQ7VPlQ07RMeAo2HFRAvil0NmViiktdxQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788812216; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=uE6tGIUw4nUFeMlGUIl2Vj3+Z0EEpcFNwJvK87yeLC8=;
 b=aKUaxKl2TLC6TN4jGZkM/FbyEClN6aT0D1om3qM3gOPSLKdSXNLQgvFZ949Oh9kD
 wZszQXnqQ3T8wBt89xFbsNmVj1SC3NHPVjDhgl4OBB9fQJYP3tJ09Q90jfl4+DGLth3
 mnhKsIStpcin0ucVQdFvRSU2NLne7tWDO9hmbIQ8=
Received: by mx.zohomail.com with SMTPS id 1788812216128147.32011858226542;
 Mon, 7 Sep 2026 13:16:56 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 07 Sep 2026 21:16:15 +0100
Subject: [PATCH v8 06/16] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-claude-fixes-v8-6-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
In-Reply-To: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=MXDSZuGOlvNH11js9h2jqHaS2B66edvM5cQo30VukSA=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqnxuLlGOzIgawUwuYpp0nKK5dQPkI8bbCvB+Lh
 9KIWjh3znSJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCap8biwAKCRAOJn5M7lND
 PRqZDACpAFQtVm5Nhz/+t1EZw9uGhQ53sKfdFN0qq5r2BCy8vIeb1MgZJwaBHlkMI502otkcW9l
 2UWxCI4H3CXJdG9k5gEQcPrUDTIGpPp/MVHZPvOvUwdAlZyv8Xl07VEuaNYI2oBZAp3uJckX8w8
 SETgA4DujgTmEGyV9aWufusH5bv5QKtqzyk/fK74tY58zmDWYRj/xJw/WRSKJjHfTJAYUQ+AnNk
 HomidiH/na6IQwIg7p40ha2DxTivAreXIiLlkP40qMWm3Q4rrtY/9/B194IC2dcT0k7O5OMv/1a
 r1yOZxJbj36NBFtUCOK1jWNzKfrXkV6a0VZe2XlGSjxQ/Re3d8wPStnFCmzY9v3X61dy17Y4nH5
 vhJkUc5sHOz/a9hqAZ6hED2HTha8tokx+Z186ty0hageFM0m9AQCGyFRThVr32jXphUY1FtH8G5
 QN1IvZxMGY2zjKYrNK8iXfc4MLObNtzq2i/oCGAL0lr/iTG/0ceoLfUQ39IgFpRoDUED4=
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

The outcome of both of the above meant that:

- Devfreq OPP transition notifications would be printed all the time,
  even when no jobs are being submitted. This quickly fills the kernel
  ring buffer with junk.
- Because MMU interrupts are only enabled when the device is reset,
  the very first job targeting the tiler heap BO after device probe()
  would always time out, since the driver's PM runtime resume callback
  would not be invoked.

To fix the above:
- Manually adjust the PM refcnt at device probe and removal time.
- Ensure pm_runtime_dont_use_autosuspend is called in the wind-down path.
- Call pm_runtime_put_autosuspend() when device is ready to accept jobs
- Move pm_runtime_set_suspended() before panfrost_device_fini() so that
  resource unwinding happens in the opposite order as initialisation.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 55fc22e8d4d4..a3eff77add55 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -854,6 +854,7 @@ static int panfrost_probe(struct platform_device *pdev)
 
 	pm_runtime_set_active(pfdev->base.dev);
 	pm_runtime_mark_last_busy(pfdev->base.dev);
+	pm_runtime_get_noresume(pfdev->base.dev);
 	pm_runtime_enable(pfdev->base.dev);
 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
 	pm_runtime_use_autosuspend(pfdev->base.dev);
@@ -866,13 +867,16 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_out1;
 
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 
 	return 0;
 
 err_out1:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
-	panfrost_device_fini(pfdev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 	pm_runtime_set_suspended(pfdev->base.dev);
+	panfrost_device_fini(pfdev);
 err_out0:
 	return err;
 }
@@ -884,9 +888,11 @@ static void panfrost_remove(struct platform_device *pdev)
 	drm_dev_unregister(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
-	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
+	panfrost_device_fini(pfdev);
 }
 
 static ssize_t profiling_show(struct device *dev,

-- 
2.55.0

