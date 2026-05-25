Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF2CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 23:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19D010E418;
	Mon, 25 May 2026 23:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="JBoyNN02";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49F410E416
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779750242; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=l5r/MxAlqaQXDOibfw8Zin5iV7fjs+jEKqvE0L8EY2Lwt0S0nvmTmcWrFdl+SoBTHnRfYQXt275wjdS8T5G82CsTocuH8wo4quz1VpGHNXPCH//Z/u9Ijh6Feq4ydiKhx3tsjiXUc88OTOAB6HHufr7GJI9qqTXhPCW9mZpQ9zs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779750242;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3uMmtZrZVnNyNjElE0Imw5xihVKdfytgiAvGx9AV5Z4=; 
 b=TDpoJ51itp5ERAzCkCCRUKD4rka4erAV8Xsr3gqPucF/h2o+qtqbhjKQff950h0n7Q3c+xSlMTuuphYCBJF/OL6/rq8vsLx729hHQOYNjgVwUiA9bV4kRmrsJuQfFFF5afpba/Be0yMs0kWy0m5uBs/gObOnwxQJfJLbGOqlfyg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779750242; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=3uMmtZrZVnNyNjElE0Imw5xihVKdfytgiAvGx9AV5Z4=;
 b=JBoyNN021DJI9jwZ7evGC6UMEdnuM+uNzwXUmWyMDfk8h0q63Mx+sNCVcdnasyLg
 rE9xRiCGSeoU3toGdtooaZt52NRNAe1aPlbkp36679cVMW+UENHTbLHjdAsw6DZHRye
 mqman0gcMbNtbQrfrBxHAxS/e2DwbRqIrY2Xlxhs=
Received: by mx.zohomail.com with SMTPS id 1779750241929857.2187873046425;
 Mon, 25 May 2026 16:04:01 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 26 May 2026 00:03:38 +0100
Subject: [PATCH 4/4] drm/panfrost: Fix RPM so device suspends when no jobs
 are in flight
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260526-claude-fixes-v1-4-16e92eaa4949@collabora.com>
References: <20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com>
In-Reply-To: <20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=izv85PNFMeLtWKhKwSBpU+rJAP155QAMwLKf4ltC0WA=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqFNVUxp2+zhJQjklUg8NhrHgHksT6d4hHxh3W7
 HgdTobBBFGJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCahTVVAAKCRAOJn5M7lND
 PaIyC/41kv+5gXNp3reqJxfvPafthIPiVGzU9WGZZUrALaqw7R7artNkECChnqcBUeFDd51RAM1
 oQ1a6bUycTSBfIWjL4FK5aTPuewtJ/FLmhCtI2SJ+kUUZw5ChVKTHxgP41S/Z6ALC1uYVLmGKOG
 LHUYWbYbYhOTWSZdbA2zIgPeTEZVYg4uBOMcg0yJ1sb2AlysrA7geH1650jj1K+FCZnXbii/4N5
 BbZ42IMKxYoSB2K9wOuFNwr1jyGvsWhKtIiI3xGEJnWugY8i/csuR52udYB3OPH/r2fjOuXBTwJ
 /ELL1N+htnnoGj6xyPg8+jxIqZR9T/4nt9zWXMnGSnXO3QSA0ZmqtCFBoeFZaEG1Keg9LnGSlwo
 mdbjcXFLd7KzK30TnoRETBQ+8tuhGlzxe9POMu2X1bs/tujZ1G87lwQNGug4cyo5+L3DJXvhdNR
 2zIz3dDRULLNY5m9l0hrlNvYOeXVtDbxCZcuRXF0SrFBC2w+Qln1kXTAB2RNmYItxy+KI=
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

Right now, because of an apparent bug in the management of runtime PM,
the device remains powered on at all times. This was causing three
different issues:

- Because MMU interrupts are only enabled when the device resets, the very
first job targeting the tiler heap would always time out, as a device reset
is only performed during a runtime resume operation.
- Devfreq OPP transition notifications would be printed all the time, even
when the device is meant to be idle, which polute the kernel ring buffer.
- PM refcnt would eventually underflow.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index cb8e5015847f..68b831add0bb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -986,9 +986,8 @@ static int panfrost_probe(struct platform_device *pdev)
 		goto err_out0;
 	}
 
-	pm_runtime_set_active(pfdev->base.dev);
-	pm_runtime_mark_last_busy(pfdev->base.dev);
 	pm_runtime_enable(pfdev->base.dev);
+	pm_runtime_resume_and_get(pfdev->base.dev);
 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
 	pm_runtime_use_autosuspend(pfdev->base.dev);
 
@@ -1004,6 +1003,8 @@ static int panfrost_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out2;
 
+	pm_runtime_put_sync_suspend(pfdev->base.dev);
+
 	return 0;
 
 err_out2:
@@ -1024,8 +1025,9 @@ static void panfrost_remove(struct platform_device *pdev)
 	panfrost_gem_shrinker_cleanup(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
-	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
+	pm_runtime_put_sync(pfdev->base.dev);
+	pm_runtime_disable(pfdev->base.dev);
 	pm_runtime_set_suspended(pfdev->base.dev);
 }
 

-- 
2.53.0

