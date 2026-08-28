Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7F0C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101B310F466;
	Fri, 28 Aug 2026 20:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VvWP+zSi";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B6710F466
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950684; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B4sgNEU3pL3AzHx6TXNR5LPi2g4kbdAKF67WavKENCyDlO77I0jLqaYbfmc1nMo61fCOexw00xEweYY6D4y21sO90mAUxikB+bIM5Tf3zKqKoCVsAI8jMb8Nou+FC2/lMrXnk0ud0Iafe8eJf6d+8SO6+0ERUnygKjpfOzTFDjo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950684;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Bkr1BFA8JaqPgz+ZJjaJL66hXD/0MblU6CSIj4eBGyo=; 
 b=j7NdIFU+Pvijg9vqJfzkN8OLUhY0jKu4JkRPIoIYdU+RL4Kk/UkGytT8SyzlPuua2AevQ4rUN7CbxZNbY98kZGRsa2MAh0+N3BugQKuR9L9ugKy+9vX9WdynJ884dqfF6KcgG6EwOoBNE6H04taQX8BkCOmtiwAZVWZf73XLq2M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950684; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Bkr1BFA8JaqPgz+ZJjaJL66hXD/0MblU6CSIj4eBGyo=;
 b=VvWP+zSiWdF2No9eX8dlTXn2YgvytsytOel2i9SKpt4KnAeIxBZeArf5zFV7WAl3
 mHeJ0tarLMyLGrGuLUudl5Z0D6TAxpjgPSYsnz/BB8oIk2xyEFO9OwFLpDEkh+HRbF7
 BV4Rmx2c2tUweTeAK1qAwbEkwb1wqe0Q0OVOJgrs=
Received: by mx.zohomail.com with SMTPS id 1787950682002200.20126287790504;
 Fri, 28 Aug 2026 13:58:02 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:47 +0100
Subject: [PATCH v7 07/17] drm/panfrost: Stop all jobs before commencing
 device teardown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-7-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4381;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=OBbDOeQ+abKzN85Sr4YSgFexzzXD/M4vh+LXEOXQxtM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYtRPk8CtvzxnSHnHS5fzPViAl1laKmOlkKE
 Ngjcs2M9EmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LQAKCRAOJn5M7lND
 Pd68DACrP0g/jy9KLDK0ibr7mtK7xmNO6AvntzwnxTg+qSez+qDAzOmna1N/UbsJLGWXMg04lYl
 8Y6U/jDPy0WsejHAf51TQ+DhfkB7l2VPbaYMsZy5ffeK+6wRl4SqFQVUeqy/TYEBnumBAX53KTM
 dMXTdfNaBEQd4n6OP1hLTcyClRE2+mbbznZYOh5VNV/pRW+ekiI7/zwszO0uIHME3f9lsKVGvPi
 6weX13R1Tp3A2ZqiHJV4F8M47Ad6KmjDu2e6st2q50xxlxxfemd7rHJBjzgEXMuxHPUkO+1tYHb
 PAmZN4qFR9WT8vuQqOLoMDplQRSd3yXR2kObGicVZxmGNSS6pnvPBomkyZRQo0TFilw2N1ET5pe
 V7KFrp96cuiGLK255xWSvsVBdXBCnZ+Ho6VdLTkQERIwssSIl7rEFRjGaE7XsKTR34FEbB8tUbB
 UnqFwL2IZYZ2I82QiZx7jm+aA9sU7sJtEBY0ESGlw9QePqbxnD1tLgIf/rRgMp2iT54nM=
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

We should make sure there are no inflight jobs at the time we finish driver
structures and synchronise their IRQs, and even more so by the time clocks
and power domains are disabled.

To that end, stop submissions from existing scheduler entities and force HW
to stop all running jobs.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c |  2 +
 drivers/gpu/drm/panfrost/panfrost_job.c    | 71 ++++++++++++++++++------------
 drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 9549ddb7854a..9e02fb5f73c8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -341,6 +341,8 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
 	pm_runtime_get_sync(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 
+	panfrost_jm_stop_sched_jobs(pfdev);
+
 	panfrost_gem_fini(pfdev);
 	panfrost_perfcnt_fini(pfdev);
 	panfrost_jm_fini(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 5016d2d53da2..630298b7ea8a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -655,39 +655,12 @@ static u32 panfrost_active_slots(struct panfrost_device *pfdev,
 	return js_state & *js_state_mask;
 }
 
-static void
-panfrost_reset(struct panfrost_device *pfdev,
-	       struct drm_sched_job *bad)
+static void panfrost_stop_jobs(struct panfrost_device *pfdev)
 {
 	u32 js_state, js_state_mask = 0xffffffff;
 	unsigned int i, j;
-	bool cookie;
 	int ret;
 
-	if (!atomic_read(&pfdev->reset.pending))
-		return;
-
-	/* Stop the schedulers.
-	 *
-	 * FIXME: We temporarily get out of the dma_fence_signalling section
-	 * because the cleanup path generate lockdep splats when taking locks
-	 * to release job resources. We should rework the code to follow this
-	 * pattern:
-	 *
-	 *	try_lock
-	 *	if (locked)
-	 *		release
-	 *	else
-	 *		schedule_work_to_release_later
-	 */
-	for (i = 0; i < NUM_JOB_SLOTS; i++)
-		drm_sched_stop(&pfdev->js->queue[i].sched, bad);
-
-	cookie = dma_fence_begin_signalling();
-
-	if (bad)
-		drm_sched_increase_karma(bad);
-
 	/* Mask job interrupts and synchronize to make sure we won't be
 	 * interrupted during our reset.
 	 */
@@ -730,6 +703,48 @@ panfrost_reset(struct panfrost_device *pfdev,
 	}
 	memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
 	spin_unlock(&pfdev->js->job_lock);
+}
+
+void panfrost_jm_stop_sched_jobs(struct panfrost_device *pfdev)
+{
+	for (u32 i = 0; i < NUM_JOB_SLOTS; i++)
+		drm_sched_wqueue_stop(&pfdev->js->queue[i].sched);
+
+	panfrost_stop_jobs(pfdev);
+}
+
+static void
+panfrost_reset(struct panfrost_device *pfdev,
+	       struct drm_sched_job *bad)
+{
+	unsigned int i;
+	bool cookie;
+
+	if (!atomic_read(&pfdev->reset.pending))
+		return;
+
+	/* Stop the schedulers.
+	 *
+	 * FIXME: We temporarily get out of the dma_fence_signalling section
+	 * because the cleanup path generate lockdep splats when taking locks
+	 * to release job resources. We should rework the code to follow this
+	 * pattern:
+	 *
+	 *	try_lock
+	 *	if (locked)
+	 *		release
+	 *	else
+	 *		schedule_work_to_release_later
+	 */
+	for (i = 0; i < NUM_JOB_SLOTS; i++)
+		drm_sched_stop(&pfdev->js->queue[i].sched, bad);
+
+	cookie = dma_fence_begin_signalling();
+
+	if (bad)
+		drm_sched_increase_karma(bad);
+
+	panfrost_stop_jobs(pfdev);
 
 	/* Proceed with reset now. */
 	panfrost_device_reset(pfdev, false);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index 3e3b9717838f..dc9d3c9dc67b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -73,6 +73,7 @@ int panfrost_jm_is_idle(struct panfrost_device *pfdev);
 int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
+void panfrost_jm_stop_sched_jobs(struct panfrost_device *pfdev);
 
 #ifdef CONFIG_DEBUG_FS
 void panfrost_sched_debugfs_init(struct drm_minor *minor);

-- 
2.55.0

