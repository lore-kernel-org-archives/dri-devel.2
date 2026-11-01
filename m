Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B61606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=V7kdtGQo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC6910E374;
	Sun,  1 Nov 2026 12:56:49 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFF510E374
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=hbPLb4n4AfHgdvdWq7wNKLfZnjDMiftzs/eMZt0rWuE=; b=V7kdtGQo29RfNMtGzNaZ372eok
 x2iccNirQ5pXE1sPezYOwLRmbnHZIPeVoCYYzf32LHYcfRmS0+sN+6EnEQeletGerUThRueJW+Gsv
 fuHHDgZLcyZXiFLKnTnaBuqBDHsAZCQefNcc+tk/ozJLS7pLvUmmEDaLwBB/CmDKHLdVT6ME4RwaN
 Pw3xb5YsxuqGwDS5EdRDz1hrmozWZQWnJq2k3RRn8z270D4J8wte8ALtVP+BlvQS1Ti8CZOggxduA
 zQu/mWitF4lEkGYmjxjntMiYCE95SUvLJ5yI83SjF+4CF7QKuIgIFmS3J/8ab5FJAHr5BjafND2q3
 2zJXyIAQ==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xNV6y-00Go36-L7; Sun, 01 Nov 2026 13:56:37 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 2/2] drm/v3d: Count released supergroup IDs as CSD progress on
 V3D 7.x
Date: Sun,  1 Nov 2026 09:53:58 -0300
Message-ID: <20261101125619.2465064-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101125619.2465064-1-mcanal@igalia.com>
References: <20261101125619.2465064-1-mcanal@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>

v3d_csd_job_timedout() only treats a change in CSD_CURRENT_CFG4, the
number of batches still to be started, as progress. Once the last batch
has started, CFG4 no longer changes until the dispatch completes, so the
batches still in flight must complete within one timeout period.

Since V3D 7.1 the dispatcher can keep up to MAX_SG_ID + 1 supergroups in
flight. With supergroups of different lengths, the ones still running
after the last batch starts can take longer than that while they keep
completing, and the job is reset although it is making progress.

On V3D 7.x, CSD_EXT_STATUS reports how many supergroup IDs are allocated.
An ID is released when its supergroup completes, and none is allocated
after the last batch has started, so the count only decreases until the
dispatch completes.

Treat a change of that count as progress too, starting from zero IDs when
the job is started. V3D 4.2 has no register that reports supergroup
completion, so it keeps the current behaviour.

Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h   |  2 +-
 drivers/gpu/drm/v3d/v3d_regs.h  |  5 +++++
 drivers/gpu/drm/v3d/v3d_sched.c | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 29fa14be130b..deac9e6a2e42 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -426,7 +426,7 @@ struct v3d_tfu_job {
 struct v3d_csd_job {
 	struct v3d_job base;
 
-	u32 timedout_batches;
+	u32 timedout_batches, timedout_sg_ids;
 
 	struct drm_v3d_submit_csd args;
 };
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index c1870265eaee..8b8199ecb086 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -412,6 +412,11 @@
 # define V3D_CSD_STATUS_HAVE_CURRENT_DISPATCH          BIT(1)
 # define V3D_CSD_STATUS_HAVE_QUEUED_DISPATCH           BIT(0)
 
+/* V3D 7.x+ only */
+#define V3D_V7_CSD_EXT_STATUS                           0x00904
+# define V3D_V7_CSD_EXT_STATUS_NUM_ALLOCED_SG_IDS_MASK  V3D_MASK(9, 3)
+# define V3D_V7_CSD_EXT_STATUS_NUM_ALLOCED_SG_IDS_SHIFT 3
+
 #define V3D_CSD_QUEUED_CFG0(ver) ((ver >= 71) ? 0x00930 : 0x00904)
 # define V3D_CSD_QUEUED_CFG0_NUM_WGS_X_MASK            V3D_MASK(31, 16)
 # define V3D_CSD_QUEUED_CFG0_NUM_WGS_X_SHIFT           16
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 002116efc874..b9e0b7babaf9 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -361,6 +361,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	job->base.irq_fence = dma_fence_get(fence);
 
 	job->timedout_batches = job->args.cfg[4];
+	job->timedout_sg_ids = 0;
 
 	trace_v3d_submit_csd(dev, to_v3d_fence(fence)->seqno);
 
@@ -776,12 +777,23 @@ v3d_csd_job_timedout(struct drm_sched_job *sched_job)
 	struct v3d_csd_job *job = to_csd_job(sched_job);
 	struct v3d_dev *v3d = job->base.v3d;
 	u32 batches = V3D_CORE_READ(0, V3D_CSD_CURRENT_CFG4(v3d->ver));
+	u32 sg_ids = 0;
+
+	/* Once the last batch has started, CFG4 no longer changes until the
+	 * dispatch completes. On V3D 7.x, supergroups that complete in that
+	 * window release their ID, so count that as progress too.
+	 */
+	if (v3d->ver >= V3D_GEN_71) {
+		sg_ids = V3D_GET_FIELD(V3D_CORE_READ(0, V3D_V7_CSD_EXT_STATUS),
+				       V3D_V7_CSD_EXT_STATUS_NUM_ALLOCED_SG_IDS);
+	}
 
 	/* If we've made progress, skip reset, add the job to the pending
 	 * list, and let the timer get rearmed.
 	 */
-	if (job->timedout_batches != batches) {
+	if (job->timedout_batches != batches || job->timedout_sg_ids != sg_ids) {
 		job->timedout_batches = batches;
+		job->timedout_sg_ids = sg_ids;
 
 		return DRM_GPU_SCHED_STAT_NO_HANG;
 	}
-- 
2.56.0

