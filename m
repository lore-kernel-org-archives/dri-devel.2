Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DBDC79FAF
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0881410EDBC;
	Tue,  8 Sep 2026 22:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QcIgNaHn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3F710EDA0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:04:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C58D943E5E;
 Tue,  8 Sep 2026 22:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7142F1F00A3D;
 Tue,  8 Sep 2026 22:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905095;
 bh=qwUK2PGPRP9N49QDc9653gAgUPcVpEE3+mhOYY7c0D4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QcIgNaHnvXKOcubmt/xp5UWcjJDPUO0ISoikgJFGKAmrV4uQS0Y4fM6WlljzC0NaB
 ls1zUlsZ4FmxDA94LbK0I+iwMckHWpPKXa2m3Jdm/KhR3t/EyFQCHSrKaGdPXem8Fu
 Uzv/8nW10Bmq0WTwZmYIUbm/OJhO07FbiNaJBPPyK3A3b4FOg3BWGIuHK0RUyWlKX2
 n2Et8WmKsiBN0zMcewDD3on1T1H75orxWg4W21/jYV7vYPnkbAhK6cqlAhnvn6/npA
 /ZUVt9dEGGdOZb2P2TkpkW+BEJGRm9SzDVU4XNmqpCvAbvnM7MX34p5mkYX0O4KUhf
 HJLC2UptOXqbQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:40 -0500
Subject: [PATCH v3 03/22] accel: ethosu: Fix probe error cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-3-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
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
v2:
 - Adjust for previous patch reworking runtime-PM suspend
---
 drivers/accel/ethosu/ethosu_drv.c | 13 ++++++++++++-
 drivers/accel/ethosu/ethosu_job.c |  6 +-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 1f6fb5d18cf2..2c8d735767b2 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -375,9 +375,20 @@ static int ethosu_probe(struct platform_device *pdev)
 
 	ret = ethosu_init(ethosudev);
 	if (ret)
-		return ret;
+		goto err_job_fini;
 
 	ret = drm_dev_register(&ethosudev->base, 0);
+	if (ret)
+		goto err_sram_free;
+
+	return 0;
+
+err_sram_free:
+	if (ethosudev->sram)
+		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
+			      ethosudev->npu_info.sram_size);
+err_job_fini:
+	ethosu_job_fini(ethosudev);
 	return ret;
 }
 
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 8dce74db0cb4..ec65305e0cd7 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -355,14 +355,10 @@ int ethosu_job_init(struct ethosu_device *edev)
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

