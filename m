Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CD5CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9941128F2;
	Thu,  4 Jun 2026 17:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="S/E3VCQK";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0AA1128F2
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594586; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KLmuyC371ERDtC8Wczkr/p5t89MrfMvUfQr0qaR+GYQ4QOCzz4Jc7imft6ZxXjfBDzUBmFhLBdmnsTBATL7zGxVakx7cSHFOasatXJl+KtEY1U0mJ0c9S1OY3yCvLkomUfL3xIRYH36yIO/eFR2bgP0xx8hlLeg07+5l8ZKqWWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594586;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iwZcKiyxHwEmbdNy4kCaFfHeOAIucyXq5lbxbdoFBOg=; 
 b=ZtuWXDRJYUKERBaYndjU+UvF14LZKNWRjE3LA2S11eDgv8Av/Jjphvy+LA/miEd/KTa4UVP+hz8zfo+GqtrK9CN6QxkrqAafF1fAfRKeEU+nAB945nAl2DxO4X8vL5L4hKCWYkSTClix0E8ARkPSHMWRjT7BMNYwTDdN2zrZyxE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594586; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=iwZcKiyxHwEmbdNy4kCaFfHeOAIucyXq5lbxbdoFBOg=;
 b=S/E3VCQKUjJSuxI9QwC4LuAqU1C0c9XX3nNF5zV2mRU+mo2bPBdyf5YyQUpIDg0S
 +texT6biJKepcc7Z+BuBiaD80vwLgQ1Z2R3ZkNttEHf935w8kpPQ6r3ddtpkCS9jH+r
 hN3DYXqAp2Xbwfd9aVQpMHJXJbbFL4s2RbZSvsyU=
Received: by mx.zohomail.com with SMTPS id 1780594585579182.13885950655424;
 Thu, 4 Jun 2026 10:36:25 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 04 Jun 2026 18:35:25 +0100
Subject: [PATCH v2 6/7] drm/panfrost: Fix PM usage_count mishandling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
In-Reply-To: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=XOZYON/h0gjpbCjgbdZ8W9Cc/v4a7uUTt41Tls3kh5U=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8EvcGstm3zaGTXqIh8Jb+vnVGxatCt+Mq4
 tA89sCD2KmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PQURDACnZfXGjdInK3srJRcJTKM5gqH01EKmi2FQKG9sVa/d5YAOSSBQZmxOLuaDkxsFEcysvL9
 SX8U58TDl1naXXH6LofqcaZNX0OoX7I5zPxy7kn72lybXI87qq5AUTkVz6WsMpByX0Bps3p0XA3
 v/r4UopvvbSZLHvoyG02GPhkxFqJ/4EOLwo2p8SwL3F4OxadS1cN4Y0xrLHx/BvYfsMBhYEoJNi
 h2j5Sq08DJN79AXSuz1dG3xFoWS2Vr4BJ70Ru96asiDhMLuWqFs4h1nQZkv+dkT9xTjKe7HVjx6
 isRu0kxbYR4Pg3eZZzQt1Pl9tbQH/2NiQY39dEv5PneBOg+jcKAyJrFUE6vxof63i3kE/QWTGho
 vZUswWz48LuIM5v3sZ6cCKBSMi4QlUqQwFlUAw74gUnYtvyDm/FkkW/mFws6QRiv1T2M/4ghE+1
 TbRC3bqdM+0LjpR7wCkE+aogkYLqzEJ7AkBlgk44aGf0T8JvGcnPHAMpoKJMbtC7JfGBc=
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

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 2d4b6aa95c66..545fbf2c8d0c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -989,6 +989,7 @@ static int panfrost_probe(struct platform_device *pdev)
 	pm_runtime_set_active(pfdev->base.dev);
 	pm_runtime_mark_last_busy(pfdev->base.dev);
 	pm_runtime_enable(pfdev->base.dev);
+	pm_runtime_get_noresume(pfdev->base.dev);
 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
 	pm_runtime_use_autosuspend(pfdev->base.dev);
 
@@ -1000,10 +1001,12 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_out1;
 
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 
 	return 0;
 
 err_out1:
+	pm_runtime_put_noidle(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
@@ -1018,8 +1021,9 @@ static void panfrost_remove(struct platform_device *pdev)
 	drm_dev_unregister(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
+	pm_runtime_put_noidle(pfdev->base.dev);
+	pm_runtime_disable(pfdev->base.dev);
 	pm_runtime_set_suspended(pfdev->base.dev);
 }
 

-- 
2.53.0

