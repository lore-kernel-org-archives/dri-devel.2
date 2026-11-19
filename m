Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228E606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZUI8I6O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1902D10E893;
	Thu, 19 Nov 2026 13:20:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5ED10E893
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:19:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 439DC413A4;
 Thu, 19 Nov 2026 13:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232CD1F000C4;
 Thu, 19 Nov 2026 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795094395;
 bh=Lttm65rr0Emb5GQAhMwCGlWva+mW8MFSIkZED0kELt0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XZUI8I6O2fW4O6fBLyZz0ma41X7iKCcL9Q2JLyPNJGWx3/V6dMDv0Qq920BCXDJ/H
 4RcHbec5BGa6zAHdd0EzqzeM4MTXE0xDRMscDUvcbE/foQ7598YSkG2khiwxYgWKil
 krJdmSznt3TrCC4cWdZE+hO5GmI1dDbGpj40JskooZr5rYrZVHJUZxy/Twu8fVthwI
 llBPUboCo//iXEImpVZTvFm+tKYVvo4c70yZOPRTqPojrgF8zdsaLo2RZf+MQI7lHQ
 KxPU4oaezp1Lbl3RJViTtOgrlG1Bis8xuldrnIWc1m2ErdUDHDBnK0GuQUUHIg4KBW
 FmJssBd1KXkbA==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Yunxiang Li <Yunxiang.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3/3] drm/sched: Fix memory ordering with
 dma_fence_overwrite_timestamp()
Date: Thu, 19 Nov 2026 14:18:31 +0100
Message-ID: <20261119131830.2535266-5-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119131830.2535266-2-phasta@kernel.org>
References: <20261119131830.2535266-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is a memory ordering bug in drm_sched_get_finished_job(). The
manual timestamp flag check with test_bit() is not ordered.

The dma_fence framework now provides dma_fence_overwrite_timestamp(), a
function to overwrite a timestamp in a safe manner with correct memory
ordering.

Solve the bug with dma_fence_overwrite_timestamp().

Cc: stable@vger.kernel.org
Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 28 +++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 99252674e266..a065a6d2eb1c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -66,6 +66,7 @@
  * This implies waiting for previously executed jobs.
  */
 
+#include <linux/dma-fence.h>
 #include <linux/export.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
@@ -898,6 +899,22 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 	return IS_ERR(entity) ? NULL : entity;
 }
 
+/**
+ * drm_sched_overwrite_scheduled_timestamp - make timestamp more accurate
+ *
+ * Overwrites the timestamp of the provided scheduled fence with the one from
+ * the finished fence, if the scheduled fence is already signaled. Does nothing
+ * otherwise.
+ */
+static void
+drm_sched_overwrite_scheduled_timestamp(struct dma_fence *finished,
+					struct dma_fence *scheduled)
+{
+	ktime_t timestamp = dma_fence_timestamp(finished);
+
+	dma_fence_overwrite_timestamp(scheduled, timestamp);
+}
+
 /**
  * drm_sched_get_finished_job - fetch the next finished job to be destroyed
  *
@@ -928,11 +945,12 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
-			/* make the scheduled timestamp more accurate */
-			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
-				     &next->s_fence->scheduled.flags))
-				next->s_fence->scheduled.timestamp =
-					dma_fence_timestamp(&job->s_fence->finished);
+			/* Try to make the scheduled timestamp more accurate. */
+			drm_sched_overwrite_scheduled_timestamp(
+					&job->s_fence->finished,
+					&next->s_fence->scheduled
+					);
+
 
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
-- 
2.56.0

