Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0E60A3810
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdhaFQiO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892FF1122B0;
	Thu, 29 Oct 2026 13:36:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543EC1122AA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 316DE4404B;
 Thu, 29 Oct 2026 13:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80DB1F031E1;
 Thu, 29 Oct 2026 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280978;
 bh=GM5VmsZhp0iE6Ir2BLSdxfR1P3M6Uv+8pRs0goYv+WE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DdhaFQiOrQD8Nu90otlounTDm2QHU/6LZmhO+KqFLP1hz5s1BOMN8LnZdOei2g/b3
 q+s8kjfvh/3e7tCunT/P1o5cC4Ffb1y4g3IK2BP8z7easy/Zgq2eccD2q97q6LNhcU
 x14EwyS3hDtbaARTL83dyqkV74TCj2jyPavFscsIUdPDLuZ+iNpXdWKNLyLvLjgvUE
 NkHp0GjBKMJgwxgR/e5QjOgs9nmERhpP0q6K4LACjNDJ2IsdMtKIT2wx6w+CjIXcC8
 z/0omx3IvEMjRtMKX5yEFWffds7XXlxwrY8JzeM8e6mKA6/A/WvVtvUNnA9BNrUtBY
 gak0ZS1Ks3FVA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:50 -0500
Subject: [PATCH v4 03/31] accel: ethosu: Fix probe error cleanup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-3-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Adjust for previous patch reworking runtime-PM suspend
---
 drivers/accel/ethosu/ethosu_drv.c | 13 ++++++++++++-
 drivers/accel/ethosu/ethosu_job.c |  6 +-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index ae7ebf29cb2f..9ee144c41550 100644
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
index d656b3ec670e..b7faa715b47e 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -353,14 +353,10 @@ int ethosu_job_init(struct ethosu_device *edev)
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

