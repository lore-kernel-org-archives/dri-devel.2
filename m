Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847860A380A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9U5iw7k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA251122E5;
	Thu, 29 Oct 2026 13:37:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6043A1122CB
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 473A141263;
 Thu, 29 Oct 2026 13:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68701F01825;
 Thu, 29 Oct 2026 13:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280991;
 bh=JT7hU3QdLKJDaT47XHUJJB8XPz47k2dBS5FgLMn8MDE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=P9U5iw7kz/kTebaQI+xb0VPsQ+R4fPCYbLvBXgrQwC5PgOkxcHfsjx0CH7q7WW/Wy
 +F8wlzdIg7L+2rF/vZOaY3WTAcukmBfvMY13tJ0G4PONQvZn8WLwYtWMTW+0ij35jo
 W4+KVtTkZxdoBzbSWBju26HcAJ1FpV1lmeuNEahypcrEJ2KaNMbH3CUQC4VnTto+kQ
 P9M8FWmEMl6Ks7cMM9CLjfOZgch9ct7lU61Ec3a5Xj17SaCnQcsDoMJqmmLzAANDiL
 agsWXtXuyuQwp3SLuPIlRMRmugnR85CdEk3Y2b7berXztxoaJU/XtUNdy/0R16KNCF
 sQMC+UBvZgN3w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:58 -0500
Subject: [PATCH v4 11/31] accel: ethosu: Clear SRAM before submission
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-11-4aa25e22578e@kernel.org>
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

SRAM contents persist between jobs including different users. Clear the
SRAM before programming the SRAM region to prevent one client observing
another client's data.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_device.h |  2 ++
 drivers/accel/ethosu/ethosu_job.c    | 47 +++++++++++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 1a90d0ebe5d9..af1489fe08c4 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -205,6 +205,8 @@ struct ethosu_device {
 	spinlock_t fence_lock;
 
 	struct drm_gpu_scheduler sched;
+	/* Scheduler entity that last used SRAM. */
+	struct drm_sched_entity *sram_entity;
 	/* For ethosu_job_do_push() */
 	struct mutex sched_lock;
 	struct list_head sched_entities;
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index ef95a8abd61e..3976115902e8 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -45,11 +45,27 @@ static const struct dma_fence_ops ethosu_fence_ops = {
 	.get_timeline_name = ethosu_fence_get_timeline_name,
 };
 
-static void ethosu_job_set_in_flight(struct ethosu_device *dev,
-				     struct ethosu_job *job)
+static u32 ethosu_job_sram_size(struct ethosu_job *job)
 {
+	struct ethosu_validated_cmdstream_info *cmd_info =
+		to_ethosu_bo(job->cmd_bo)->info;
+
+	return cmd_info->region_size[ETHOSU_SRAM_REGION];
+}
+
+static bool ethosu_job_set_in_flight(struct ethosu_device *dev,
+				     struct ethosu_job *job, u32 sram_size)
+{
+	bool clear_sram = false;
+
 	guard(spinlock)(&dev->job_lock);
+	if (sram_size && dev->sram_entity != job->base.entity) {
+		dev->sram_entity = job->base.entity;
+		clear_sram = true;
+	}
 	dev->in_flight_job = job;
+
+	return clear_sram;
 }
 
 static struct ethosu_job *
@@ -64,7 +80,8 @@ ethosu_job_clear_in_flight(struct ethosu_device *dev)
 	return job;
 }
 
-static void ethosu_job_hw_submit(struct ethosu_device *dev, struct ethosu_job *job)
+static void ethosu_job_hw_submit(struct ethosu_device *dev, struct ethosu_job *job,
+				 u32 sram_size, bool clear_sram)
 {
 	struct drm_gem_dma_object *cmd_bo = to_drm_gem_dma_obj(job->cmd_bo);
 	struct ethosu_validated_cmdstream_info *cmd_info = to_ethosu_bo(job->cmd_bo)->info;
@@ -79,7 +96,12 @@ static void ethosu_job_hw_submit(struct ethosu_device *dev, struct ethosu_job *j
 		dev_dbg(dev->base.dev, "Region %d base addr = %pad\n", region, &bo->dma_addr);
 	}
 
-	if (job->sram_size) {
+	if (sram_size) {
+		if (clear_sram) {
+			memset_io(dev->sram, 0, dev->npu_info.sram_size);
+			/* Order the SRAM clear before starting the NPU. */
+			wmb();
+		}
 		writel_relaxed(lower_32_bits(dev->sramphys),
 			       dev->regs + NPU_REG_BASEP(ETHOSU_SRAM_REGION));
 		writel_relaxed(upper_32_bits(dev->sramphys),
@@ -263,6 +285,8 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
 	struct ethosu_job *job = to_ethosu_job(sched_job);
 	struct ethosu_device *dev = job->dev;
 	struct dma_fence *fence = job->done_fence;
+	u32 sram_size;
+	bool clear_sram;
 
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
@@ -273,8 +297,9 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
 
 	ethosu_switch_perfmon(dev, job);
 
-	ethosu_job_set_in_flight(dev, job);
-	ethosu_job_hw_submit(dev, job);
+	sram_size = ethosu_job_sram_size(job);
+	clear_sram = ethosu_job_set_in_flight(dev, job, sram_size);
+	ethosu_job_hw_submit(dev, job, sram_size, clear_sram);
 
 	return fence;
 }
@@ -482,12 +507,22 @@ int ethosu_job_open(struct ethosu_file_priv *ethosu_priv)
 	return ret;
 }
 
+static void ethosu_job_clear_sram_entity(struct ethosu_device *dev,
+					 struct drm_sched_entity *entity)
+{
+	guard(spinlock)(&dev->job_lock);
+	if (dev->sram_entity == entity) {
+		dev->sram_entity = NULL;
+	}
+}
+
 void ethosu_job_close(struct ethosu_file_priv *ethosu_priv)
 {
 	struct ethosu_device *dev = ethosu_priv->edev;
 	struct drm_sched_entity *entity = &ethosu_priv->sched_entity;
 
 	scoped_guard(mutex, &dev->sched_lock) {
+		ethosu_job_clear_sram_entity(dev, entity);
 		drm_sched_entity_kill(entity);
 		list_del(&ethosu_priv->sched_entity_list);
 	}

-- 
2.53.0

