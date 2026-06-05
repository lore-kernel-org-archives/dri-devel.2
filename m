Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8073CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB13B10E689;
	Fri,  5 Jun 2026 16:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HpWAZYOg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3633A10E689
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=48hUO3H0lIyu/djiNSlnAMe/PBuY2lYH84NFqL5NC3I=; b=HpWAZYOgJKir5CT2fL5UIV4sCq
 0AVTb8eBf5Ae+Ep5h6/yTBsHGeKHB2UwVrn++wZouKIgVIntN3LaAHRGFeqyipQia79ADi1+Aw3zp
 5gXf2+ME0ycyhArxbGUZbWClv72eFlvRuGO0EG9P+DiNVAlVnReY2LgvYBkFup+GTBFO8NZ3dI22D
 fmN6x5lRaMzHaEwCPKXbd91WlBPCtH15S5jMk7wF+raQM33D/TW4ih9eDm3jHMZgG8Bs8UgMtLKbR
 ydqqAp5bwss9FcLUzCnquKFRZIueKc2wq4gRVWN4hadJ/x87DMafSTJsyzPlvxCCwNIT0nzUrmG+Z
 n+gnIyUA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVX4t-00DGUE-IE; Fri, 05 Jun 2026 18:07:23 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 05 Jun 2026 13:07:00 -0300
Subject: [PATCH 3/3] drm/rocket: Drop the dedicated reset workqueue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-rocket-per-task-jobs-v1-3-e3319adf3c49@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=orFY29gZE456WlfwJM50OSQ58HMnt5r8Nt4V5Q/+1MM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIvQqUuiniK6pzeyp0TxJI7t7iV8zE0TKuvxza
 plixHJglgWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiL0KgAKCRA/8w6Kdoj6
 qtHnB/0cH19OKcTCtJZboqauLpq9nDDoJ2IJF05s2TJJruJkxSYQLqXkBIYAWisPmwfEZqMvF9o
 gjqC7UoP9V/MaQO/og1YZx05PGxIUzIUgVwClyLpUmv1hh9g4gNfZF+u3IQLM6UrLrIDZ/pNaz8
 rMsjC+nrxG2R3Hg6DywDXTHHQfuEkJ4ufkSWy91lnt5256kYhpknrhtA4C8SbUDIKCVJvz0jXGV
 lnkPg9YQrKgi3grk+oCr/pPeRuOAWfV93BGxFc/MVjF9ED34GDfx6fXc49blGp+eK+HSrTCiMTc
 rUn3HjHgz0LzwPr6518OUG29ixcGTqNRRilqZmH70Vva38xn
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

Each core allocated an ordered workqueue ("rocket-reset-%d") and passed
it as the scheduler's timeout_wq. The only documented reason to provide a
custom timeout_wq is to serialize the timeout handlers of several
schedulers that share globally-reset hardware. That does not apply here:
each core has its own scheduler and is reset independently
(rocket_reset() only touches its own core). With the reset worker gone,
the workqueue served solely as the timeout_wq.

Drop it and let drm_sched fall back to the default timeout workqueue.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/accel/rocket/rocket_core.h |  4 ----
 drivers/accel/rocket/rocket_job.c  | 15 +--------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f74dc99d07bb..607e4270f59c 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -46,10 +46,6 @@ struct rocket_core {
 
 	spinlock_t fence_lock;
 
-	struct {
-		struct workqueue_struct *wq;
-	} reset;
-
 	struct drm_gpu_scheduler sched;
 	u64 fence_context;
 	u64 emit_seqno;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 871041eb7a1d..1a454559ecf4 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -467,33 +467,20 @@ int rocket_job_init(struct rocket_core *core)
 		return ret;
 	}
 
-	core->reset.wq = alloc_ordered_workqueue("rocket-reset-%d", 0, core->index);
-	if (!core->reset.wq)
-		return -ENOMEM;
-
 	core->fence_context = dma_fence_context_alloc(1);
 
-	args.timeout_wq = core->reset.wq;
 	ret = drm_sched_init(&core->sched, &args);
 	if (ret) {
 		dev_err(core->dev, "Failed to create scheduler: %d.", ret);
-		goto err_sched;
+		return ret;
 	}
 
 	return 0;
-
-err_sched:
-	drm_sched_fini(&core->sched);
-
-	destroy_workqueue(core->reset.wq);
-	return ret;
 }
 
 void rocket_job_fini(struct rocket_core *core)
 {
 	drm_sched_fini(&core->sched);
-
-	destroy_workqueue(core->reset.wq);
 }
 
 int rocket_job_open(struct rocket_file_priv *rocket_priv)

-- 
2.54.0

