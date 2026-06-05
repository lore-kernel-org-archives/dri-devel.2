Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D596CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093A310E67C;
	Fri,  5 Jun 2026 16:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NbmHVKiA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC07510E677
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8jj4+J5yeQWjg5KY9DqEw4WJpS6VuRZIUVj2ZIu2Pzw=; b=NbmHVKiAIWCOBY8JcneuUIXqR4
 jaTtK3/Xmgnvjsh6NlM5wjIMLfn/q0J9dJYDWDXB0l++zSMqGtRNX9jBEszTJi4zilUisiRarSmwS
 Y3HsA0VfwiWlCj5oLQFD8daH49whg0R2W7FHTaT0iVCK3+2FkhnOZNKP+61CR/OEdqIpLjVlhI9O2
 JM2V254++jOEzRLXnadHg/kMFyZssj0Kqo8pv7ZOlJH17p7hS27surstY4EC4dT3HY+JvgwWIdkeM
 Kkfi8k2vcUiT+ylUmM41B0tChTRna42L1YNsDle6yN6i0TMfDna9fpO3HMeGjdpYZyd5p1Wrb5VyP
 +9xgNbmQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVX4k-00DGUE-MX; Fri, 05 Jun 2026 18:07:15 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 05 Jun 2026 13:06:58 -0300
Subject: [PATCH 1/3] drm/rocket: Remove unused reset worker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-rocket-per-task-jobs-v1-1-e3319adf3c49@igalia.com>
References: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
In-Reply-To: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Rob Herring <robh@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ogXWHPfdY2GzAhjXznCbxDrE7Laht8qpiB6WY27XL3s=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIvQpS57UFdrEPvFgOrnRH9Gs6d2vOpmHGiu9n
 9Cu9jZrDJWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiL0KQAKCRA/8w6Kdoj6
 ql1wCADUu/4N3xyjipRHV50KgWwVSLVH6wRuNtDaIb4MdTihwWe/Iqpr1l4vnpwb2wZcgMfZhzJ
 dyPKM5A07vH0in2d6sX9MCirInXWMtNQQWSKCKXxSdI1AtWvXR1JgcHlkl8tKDH3hpD2ulgTLBx
 38G++wVfWg45MIMJoDNUf9IJUzXbKLpAkDl+HjcsWjzm5bl53yzxiZ3mpj/t8pqk5eQ7xaOOtlh
 FN3K5Ap3Akd0Jr/o/cH8djaAfBSg7FmFu+deYBvuh7lP7HPeuNhxNka40l8cnvB52PeZscIknlA
 naTSU2b68+W8qShLOL7GT0xDz7dBr4hZYLyL4OuVQTKuYDIk
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The reset.work work_struct and its rocket_reset_work() handler were
initialized and cancelled, but never actually queued: no code path calls
queue_work()/schedule_work() on core->reset.work. The only reset entry
point is the scheduler's timedout_job callback, rocket_job_timedout(),
which invokes rocket_reset() directly on the timeout workqueue.

Drop the dead worker, its initialization and cancellation, and the
unused struct member.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/accel/rocket/rocket_core.h |  1 -
 drivers/accel/rocket/rocket_job.c  | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca..4d163a6ac653 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -48,7 +48,6 @@ struct rocket_core {
 
 	struct {
 		struct workqueue_struct *wq;
-		struct work_struct work;
 		atomic_t pending;
 	} reset;
 
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 2f1861f960cc..8a26139a44f4 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -393,14 +393,6 @@ static enum drm_gpu_sched_stat rocket_job_timedout(struct drm_sched_job *sched_j
 	return DRM_GPU_SCHED_STAT_RESET;
 }
 
-static void rocket_reset_work(struct work_struct *work)
-{
-	struct rocket_core *core;
-
-	core = container_of(work, struct rocket_core, reset.work);
-	rocket_reset(core, NULL);
-}
-
 static const struct drm_sched_backend_ops rocket_sched_ops = {
 	.run_job = rocket_job_run,
 	.timedout_job = rocket_job_timedout,
@@ -444,7 +436,6 @@ int rocket_job_init(struct rocket_core *core)
 	};
 	int ret;
 
-	INIT_WORK(&core->reset.work, rocket_reset_work);
 	spin_lock_init(&core->fence_lock);
 	mutex_init(&core->job_lock);
 
@@ -488,7 +479,6 @@ void rocket_job_fini(struct rocket_core *core)
 {
 	drm_sched_fini(&core->sched);
 
-	cancel_work_sync(&core->reset.work);
 	destroy_workqueue(core->reset.wq);
 }
 

-- 
2.54.0

