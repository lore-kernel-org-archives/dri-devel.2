Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2A0C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BA110E4F9;
	Sat,  5 Sep 2026 00:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OmY6eeFf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A5810E518
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:43:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87D1E60A7A;
 Sat,  5 Sep 2026 00:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC241F00A3D;
 Sat,  5 Sep 2026 00:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569027;
 bh=VA5xoQf037drhq5+1N2WYwe4lAlKlXMyH8lLNPBodKI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OmY6eeFfcPNgJaDw9+5zPgNugZTjotgsy07v+XE697dX7lOnhglp4SRrsHmCf5T/i
 VBrMXknZhzAeET80kz3DMebBzc41xVA7JvIh6Cvq+uUXpbKgZrXcPdYaKmESVH8rCh
 nm+rjr2AxsmaMbXyiwkauIrnICSpEcTqFa/p2za68fygDHo8dtRgB895gTGyZ964FY
 dzGX+dTzShwLJXV464aGLrWMjAY7kS1Ivz5INGB+497iOf/CFlg9zNBzuA3faYF45r
 Ed7gm+3eCIEYrKZKffP9tP1N5jSNeVMg+BXZdgzn5fQR7/FqrKC7Fc3Jt8u7z6a2a7
 KMlq3Cssdf++g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 04 Sep 2026 19:43:23 -0500
Subject: [PATCH v2 04/19] accel: ethosu: Quiesce jobs before scheduler teardown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ethosu-fixes-v2-4-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
In-Reply-To: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
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

An NPU job can complete while driver removal tears down the scheduler. Its
IRQ handler could then access scheduler state after it has been
destroyed.

Stop scheduler submission and timeout work, reset the NPU, and
synchronize its IRQ before finalizing the scheduler. Add a cancel_job
callback so drm_sched_fini() signals queued jobs with -ECANCELED; their
runtime-PM references are then released during normal job cleanup.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_drv.c |  4 ++--
 drivers/accel/ethosu/ethosu_drv.h |  2 ++
 drivers/accel/ethosu/ethosu_job.c | 22 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 65b148e770e5..0918fd9b7041 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -216,7 +216,7 @@ static const struct drm_driver ethosu_drm_driver = {
 #define U85_MEM_ATTR0_CFG	0x00000000
 #define U85_MEM_ATTR2_CFG	0x000000b7
 
-static int ethosu_reset(struct ethosu_device *ethosudev)
+int ethosu_device_reset(struct ethosu_device *ethosudev)
 {
 	int ret;
 	u32 reg;
@@ -263,7 +263,7 @@ static int ethosu_device_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = ethosu_reset(ethosudev);
+	ret = ethosu_device_reset(ethosudev);
 	if (!ret)
 		return 0;
 
diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/ethosu_drv.h
index 2193bc51d425..f59c845c758b 100644
--- a/drivers/accel/ethosu/ethosu_drv.h
+++ b/drivers/accel/ethosu/ethosu_drv.h
@@ -11,6 +11,8 @@ struct ethosu_device;
 struct drm_device;
 struct drm_file;
 
+int ethosu_device_reset(struct ethosu_device *ethosudev);
+
 struct ethosu_file_priv {
 	struct ethosu_device *edev;
 	struct drm_sched_entity sched_entity;
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index ec65305e0cd7..74a1136635f8 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -189,6 +189,16 @@ static void ethosu_job_free(struct drm_sched_job *sched_job)
 	ethosu_job_put(job);
 }
 
+static void ethosu_job_cancel(struct drm_sched_job *sched_job)
+{
+	struct ethosu_job *job = to_ethosu_job(sched_job);
+
+	if (!dma_fence_is_signaled(job->done_fence)) {
+		dma_fence_set_error(job->done_fence, -ECANCELED);
+		dma_fence_signal(job->done_fence);
+	}
+}
+
 static void
 ethosu_switch_perfmon(struct ethosu_device *ethosu, struct ethosu_job *job)
 {
@@ -315,7 +325,8 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(struct drm_sched_job *bad)
 static const struct drm_sched_backend_ops ethosu_sched_ops = {
 	.run_job = ethosu_job_run,
 	.timedout_job = ethosu_job_timedout,
-	.free_job = ethosu_job_free
+	.free_job = ethosu_job_free,
+	.cancel_job = ethosu_job_cancel,
 };
 
 int ethosu_job_init(struct ethosu_device *edev)
@@ -363,6 +374,15 @@ int ethosu_job_init(struct ethosu_device *edev)
 
 void ethosu_job_fini(struct ethosu_device *dev)
 {
+	drm_sched_wqueue_stop(&dev->sched);
+	cancel_delayed_work_sync(&dev->sched.work_tdr);
+
+	if (READ_ONCE(dev->in_flight_job)) {
+		WRITE_ONCE(dev->in_flight_job, NULL);
+		ethosu_device_reset(dev);
+	}
+
+	synchronize_irq(dev->irq);
 	drm_sched_fini(&dev->sched);
 }
 

-- 
2.53.0

