Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1E5CA5FAE
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB0710EC81;
	Tue, 29 Sep 2026 03:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="idV9ml+O";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541BF10EC6E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790653526; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mPbQwCHVbEHX1venRYVJju3RLHI15qgBgV6jMGYerwfW8zeRkOqSIo3jM9eLGD3i4cECtRjaM+woEb0xXwQW5Wc5uLkVqL/VqVpakQcNwStM3Ni05qX5s1TMKf9xrixoGRgicdxa/+xdK/5xfHLVeNQuVo2LZ0pKysF8KsYwBFw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790653526;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1l5Ny1atPb8EZLxEhWkpMhPhmjy5rNhNeS6uEnxIXJI=; 
 b=HZFTQHL8r25F4WPsiOzfCpgM1mR9qcwBNVrDL31L1Bs479CTmXUntSix0tZNHllUdep9xOATTNba+CsVWLuskZnJTR6bF0FdQDqiAsAD/NMpgaZ0fZwv+c/L3vlF3WfWvX4A7WFnC1hv4Ch9W9Y4gBhCw5SKlChwxU3rbDrQIdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790653526; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1l5Ny1atPb8EZLxEhWkpMhPhmjy5rNhNeS6uEnxIXJI=;
 b=idV9ml+Ow4iTQ/RIbTbHd5NSClUvBwespulChMEiwMQOwXNfu6lpCKMRL85fBfOV
 7rrksmp6lNnYNCJ+0cS7peTUcufvExIBLtwh5zvZF9uPia/c2hVZCIp42RdbOikjHAH
 yKrxtf0s/8pUTxAimCBgpbDWHsR31WM6IqPoi7XU=
Received: by smtp.zohomail.com with SMTPS id 1790653525951216.049987039185;
 Mon, 28 Sep 2026 20:45:25 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 29 Sep 2026 04:44:40 +0100
Subject: [PATCH v12 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-claude-fixes-v12-6-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
In-Reply-To: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3047;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=MchsDCU1R51oMCc3VpT10eY0LmlWG70F5tjOLRNzjms=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBquzQu6Yi1tb+FSu5BMygV/TaNGVFJsjC+v6Yi9
 mV6obkUFVmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCars0LgAKCRAOJn5M7lND
 PSGKC/9iyFUUnLp7Sk+Uyoy8MtY19hHaDEqgsJF88vYjbt6lgs1yYCJ299PcxMT5zFdQhR0fTwV
 7LhXyY/Z6X3QPp+iV5Jhg4sauBGHg/OCKT7QXShgrgYuBRmpvcGcV6+SYMVUXfgYm3wN0KDHWbc
 91NUcwDfbpjLVpJXYWshctqh6sv47Ikjq5m+Jpq39dTSpY0jdCqCHow7MKAD7p7Yn+WAyOz0+1o
 24bTDR/f2JdN55QjNLuVBF+8DAh1CuDJyXZ+OJRAnVcXQjBN+lk5GMtmw7fDcy6Y6/bL+2vkVgw
 CPgAoHuRHiSsLep7iHuWWdVTbZzhsUIk33ccTuQrxcPiWkkW51rfWnOF7T2QifORYE+Xfsa6857
 t9NnEskUvZC6Tu08MTX5bcJx/x1TbhVHcmDkcw38PZXpz6Oqcbqs4Oo5Tiqs4Ahn6Qs7vqujyXB
 lqplMFg4kJx6iVKqsY5njuafwuzAgrN7oSzpsuu9leISAeju/e/Rq4exySWU/LNXurH1A=
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

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 55fc22e8d4d4..907d4a14a0b5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -852,6 +852,11 @@ static int panfrost_probe(struct platform_device *pdev)
 		goto err_out0;
 	}
 
+	/* The reason we must manually set the PM status and usage counter is
+	 * we have just powered the device up but did not go through the PM
+	 * runtime resume callback, so we need to update these ourselves.
+	 */
+	pm_runtime_get_noresume(pfdev->base.dev);
 	pm_runtime_set_active(pfdev->base.dev);
 	pm_runtime_mark_last_busy(pfdev->base.dev);
 	pm_runtime_enable(pfdev->base.dev);
@@ -866,13 +871,16 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_out1;
 
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 
 	return 0;
 
 err_out1:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 err_out0:
 	return err;
 }
@@ -884,9 +892,12 @@ static void panfrost_remove(struct platform_device *pdev)
 	drm_dev_unregister(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
+
 }
 
 static ssize_t profiling_show(struct device *dev,

-- 
2.55.0

