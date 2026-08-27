Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04222C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5FF10F195;
	Thu, 27 Aug 2026 20:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jh7hjHX7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F7F10F195
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73AF944004;
 Thu, 27 Aug 2026 20:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FBA1F00AC4;
 Thu, 27 Aug 2026 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862802;
 bh=O3KjHmD0IPMWcLD9Xn+YXTCqHQcBqnsYviRiyVpX+NE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Jh7hjHX7iGtT1ug25dVup8Smp11OoN4Nq5b/Wpp9jIB6B/50iPybYaWXAeAzmX2Zv
 NnJbjzF1TUlwclczDSizbHOSinYOgYijwB9BOHOJ4DblJ08qE6WaTv2SPgpxjhIHj8
 di6HT6vFRrOJUeF1P9lUkhZjaPWvbY/tJGuKUyXhAQ7i9L0PaSe6Vk8DVXdsGnLbzA
 IGxfQD+KFl3RwBrOWSd84HPgBY6iH2nLBnzFdvPZ43fXVASFGkoJkwRZQc180EIlzo
 Y6Ank4A48SPAljZ5fOJgPD4wU6FyvxQz5hHJUlkuIGXfBkTaNgOlIbPdBoNFyjCB/a
 euSpLK/Dg7yrg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 27 Aug 2026 15:33:05 -0500
Subject: [PATCH 06/11] accel: ethosu: Fix probe error cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ethosu-fixes-v1-6-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
In-Reply-To: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

Once the job scheduler has been initialized, failures from ethosu_init()
or drm_dev_register() return from probe without tearing it down. The
registration failure also leaves the SRAM-pool allocation in use, because
the platform remove callback is not called after a failed probe.

Unwind the initialized resources on both paths. Also do not call
drm_sched_fini() after a failed drm_sched_init(): the scheduler initializer
already unwinds its partial setup, while drm_sched_fini() requires a
successfully initialized scheduler.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_drv.c | 14 ++++++++++++--
 drivers/accel/ethosu/ethosu_job.c |  6 +-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index f1af7b3ea038..41ecfc623d42 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -371,13 +371,23 @@ static int ethosu_probe(struct platform_device *pdev)
 
 	ret = ethosu_init(ethosudev);
 	if (ret)
-		return ret;
+		goto err_job_fini;
 
 	ret = drm_dev_register(&ethosudev->base, 0);
 	if (ret)
-		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
+		goto err_pm_runtime;
+
+	pm_runtime_put_autosuspend(ethosudev->base.dev);
+	return 0;
 
+err_pm_runtime:
+	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
 	pm_runtime_put_autosuspend(ethosudev->base.dev);
+	if (ethosudev->sram)
+		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
+			      ethosudev->npu_info.sram_size);
+err_job_fini:
+	ethosu_job_fini(ethosudev);
 	return ret;
 }
 
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 0982722a9195..7cadd75ad0ba 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -349,14 +349,10 @@ int ethosu_job_init(struct ethosu_device *edev)
 	ret = drm_sched_init(&edev->sched, &args);
 	if (ret) {
 		dev_err(dev, "Failed to create scheduler: %d\n", ret);
-		goto err_sched;
+		return ret;
 	}
 
 	return 0;
-
-err_sched:
-	drm_sched_fini(&edev->sched);
-	return ret;
 }
 
 void ethosu_job_fini(struct ethosu_device *dev)

-- 
2.53.0

