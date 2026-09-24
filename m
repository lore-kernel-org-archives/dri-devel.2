Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CABC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C8D10F700;
	Thu, 24 Sep 2026 18:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="dO1zpDpX";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C7B10F6EB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790273413; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ja/o3FaSGgYmj5WY+R689otiilfYb8SmzWsACos8Qk67ZmsPiECR93++v1VAYxQ3nyGD7ds2rdnFMK1kW3hfDJe8QOxYafZV9Yl+2fw/UQw7dhqHfe3i7s5B3Bd/Xdv6k1uklUyypoxqR1Y0KldpsfxH8mWsRknD/5XUiodztbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790273413;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qcM3/nFqy/NUZZdZNA3Y+KqKX0ifYF1aFycWvpQlz7o=; 
 b=DvPt03MbTgyLKzIY8p2y2FhvwomRPaoYo5ied7a5c4QOV3iFgeUGgyVmurxVlew2KIYtdMj/J/tKZL5sgIOm9gYXONUyXgMt2c49aakM3geyRKdVt2cUJy1lroAJLaAgmsyABRo1Omq9hTKnIhjxOtvCTyAuttFeVLvQJmQA6eA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790273413; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=qcM3/nFqy/NUZZdZNA3Y+KqKX0ifYF1aFycWvpQlz7o=;
 b=dO1zpDpXqNIH/hQEH25vz5LPH5wE17aITcIcrCR2EVl/nHqUoyZEOs+KEhcWOFU1
 2DvsDAzY2N3dMgRAGA8h+lTW1jeFoO6u+abTbZ2pZQomL6bwxxNB69H3XF3K8RJtMq2
 RaQ3P6wFPy0eRy8/bTmj8eNcbuRZQa26DGtskHL8=
Received: by smtp.zohomail.com with SMTPS id 1790273412417157.94252670530898; 
 Thu, 24 Sep 2026 11:10:12 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 24 Sep 2026 19:09:23 +0100
Subject: [PATCH v10 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-claude-fixes-v10-6-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
In-Reply-To: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=9YjbT6utFzW22vI9oiisbYmsMjIEN+KJP+dzW+mgYcA=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtWdY74H/LPvM7LMvuoOAV7I+ZaAP0G+8mMDQe
 uSPHLaBRt6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarVnWAAKCRAOJn5M7lND
 PbGOC/0YFYFUp9g/KN2UaYR0Fmblft0iUxxM398IwzwpV3R70qkRBuhFBPQ0mGkK5LpNKpRHi6e
 LXsgR04RPLHnwcUiOrm/ydrcZRw2GwFHtzhdXx7zGLKQKXdzlpW/CkPVwYskZQgous2p4aS5Eqy
 PdrMYWvIVrbjnIijHc00AqDJT9TDybtkJrnzz2t6Ks7aCJTx8NP6r9YngxK1HrBVYA+2Jjp7Don
 dBIWB6Yu/+eVL8frCrmP7LV1Hnu1kbh1mDrmoPZ5xFRpKlR5U/KVycWG/ydUOekFsezs2NQtfA1
 D+4qVffD14UTZhSDDyNfIxveJvapwDdjx2xffrZg4tBSS7OBdpNGdm78Ep0wl0jE0wJi9yqgH77
 w31jJf6MFWY1emE5gBklRtM4kiHTfa3PkRdgo1yjcoR1ajMWpwO/pPeuLawheiMjfVvNyVO6GRH
 5ub9ggt79/lhtnN/i96zthKTlx5b2grUuZHwGIT1ptrJxSKY6OeobNwAEO2xTLaHK+ADM=
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
 drivers/gpu/drm/panfrost/panfrost_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 55fc22e8d4d4..02ddd391231c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -852,8 +852,13 @@ static int panfrost_probe(struct platform_device *pdev)
 		goto err_out0;
 	}
 
+	/* The reason we must manually set the PM status and usage counter is
+	 * we have just powered the device up but did not go through the PM
+	 * runtime resume callback, so we need to update these ourselves.
+	 */
 	pm_runtime_set_active(pfdev->base.dev);
 	pm_runtime_mark_last_busy(pfdev->base.dev);
+	pm_runtime_get_noresume(pfdev->base.dev);
 	pm_runtime_enable(pfdev->base.dev);
 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
 	pm_runtime_use_autosuspend(pfdev->base.dev);
@@ -866,13 +871,16 @@ static int panfrost_probe(struct platform_device *pdev)
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
@@ -884,9 +892,11 @@ static void panfrost_remove(struct platform_device *pdev)
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

