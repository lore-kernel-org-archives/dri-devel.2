Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2D606C301
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6Iqieky
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD801122C4;
	Thu, 29 Oct 2026 13:36:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255F710E80F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BDFE605CA;
 Thu, 29 Oct 2026 13:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121511F01825;
 Thu, 29 Oct 2026 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280987;
 bh=2Xw95oa3umuyOD2TobV+GGOkefjbaeVN0ekeqjwNA+0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=H6Iqieky4uk15JfIuif4qe2e9JgBi3y1/qPt/vU7jGChIQ4oTa4DmdXD425cAP4EY
 KuCjPLE7kh3STJq5UDWaok8owQQw6/nZNzwZKBskkrRO9jR5F2Xrnk5NfuSpU4YLlb
 TbGHtaqvksU8JGgiaMuIxNps+hi+8BU1+eFyFRBjnY+Djqc3uyLb8KXYIs9xDHCPgJ
 qd+XFs4JhxlNcy3ASv6fBMpXq98k320ony9FP+pB3iZnljfoJeDKyEAqs+kKdQnUVQ
 QW+ZoQW5FFlnHVyty0rJAusAM0i+Fup7Vj+9JiV/bf3QnxYugdV7wwkkoadd6IPYBx
 ZBx3FQpZRAxbw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:55 -0500
Subject: [PATCH v4 08/31] accel: ethosu: Serialize job completion
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-8-4aa25e22578e@kernel.org>
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

The timeout worker and threaded IRQ handler can both clear
in_flight_job. If a new job is scheduled in between those,
in_flight_job could be overwritten when the IRQ thread resumes.
Serialize these updates so a late completion cannot clear the next job's
tracking pointer.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_device.h |  1 +
 drivers/accel/ethosu/ethosu_job.c    | 43 +++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 1eca8590e68d..51d5bc5d6137 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <drm/drm_device.h>
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index d418ae7961cf..f22cacb19e3d 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -42,6 +42,25 @@ static const struct dma_fence_ops ethosu_fence_ops = {
 	.get_timeline_name = ethosu_fence_get_timeline_name,
 };
 
+static void ethosu_job_set_in_flight(struct ethosu_device *dev,
+				     struct ethosu_job *job)
+{
+	guard(spinlock)(&dev->job_lock);
+	dev->in_flight_job = job;
+}
+
+static struct ethosu_job *
+ethosu_job_clear_in_flight(struct ethosu_device *dev)
+{
+	struct ethosu_job *job;
+
+	guard(spinlock)(&dev->job_lock);
+	job = dev->in_flight_job;
+	dev->in_flight_job = NULL;
+
+	return job;
+}
+
 static void ethosu_job_hw_submit(struct ethosu_device *dev, struct ethosu_job *job)
 {
 	struct drm_gem_dma_object *cmd_bo = to_drm_gem_dma_obj(job->cmd_bo);
@@ -235,7 +254,7 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
 
 	ethosu_switch_perfmon(dev, job);
 
-	WRITE_ONCE(dev->in_flight_job, job);
+	ethosu_job_set_in_flight(dev, job);
 	ethosu_job_hw_submit(dev, job);
 
 	return fence;
@@ -252,11 +271,9 @@ static void ethosu_job_handle_irq(struct ethosu_device *dev)
 		return;
 	}
 
-	job = READ_ONCE(dev->in_flight_job);
-	if (job) {
-		WRITE_ONCE(dev->in_flight_job, NULL);
+	job = ethosu_job_clear_in_flight(dev);
+	if (job)
 		dma_fence_signal(job->done_fence);
-	}
 }
 
 static irqreturn_t ethosu_job_irq_handler_thread(int irq, void *data)
@@ -285,6 +302,7 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(struct drm_sched_job *bad)
 	struct ethosu_job *job = to_ethosu_job(bad);
 	struct ethosu_device *dev = job->dev;
 	bool running;
+	int ret;
 	u32 *bocmds = to_drm_gem_dma_obj(job->cmd_bo)->vaddr;
 	u32 cmdaddr;
 
@@ -311,11 +329,19 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(struct drm_sched_job *bad)
 
 	drm_sched_stop(&dev->sched, bad);
 
-	WRITE_ONCE(dev->in_flight_job, NULL);
+	ethosu_job_clear_in_flight(dev);
 
 	/* Proceed with reset now. */
-	pm_runtime_force_suspend(dev->base.dev);
-	pm_runtime_force_resume(dev->base.dev);
+	ret = pm_runtime_force_suspend(dev->base.dev);
+	if (!ret)
+		ret = pm_runtime_force_resume(dev->base.dev);
+	if (ret) {
+		dev_err(dev->base.dev, "Failed to recover NPU: %d\n", ret);
+		return DRM_GPU_SCHED_STAT_ENODEV;
+	}
+
+	/* Drain a pending completion IRQ before a replacement job can run. */
+	synchronize_irq(dev->irq);
 
 	/* Restart the scheduler */
 	drm_sched_start(&dev->sched, 0);
@@ -344,6 +370,7 @@ int ethosu_job_init(struct ethosu_device *edev)
 	int ret;
 
 	spin_lock_init(&edev->fence_lock);
+	spin_lock_init(&edev->job_lock);
 	ret = devm_mutex_init(dev, &edev->sched_lock);
 	if (ret)
 		return ret;

-- 
2.53.0

