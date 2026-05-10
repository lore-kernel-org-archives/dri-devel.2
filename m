Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF417CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B45B10E44C;
	Sun, 10 May 2026 22:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S9z1Tavp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6739B10E44D
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RPaIpTNOIv+W6lTsfSqLsYcvrEjpRqPqmc2rasPR8vw=; b=S9z1TavpQQQhcKGArO73sYtSwh
 qKrGF02NEfbeOpVnTUPhVm8k2yYikfDnTn7gK5WMLmvn6kJzRnhRKBBEtOJEQX5SJh2J+KEesYdJJ
 I0ZMfnZNuonkO2vAmmgTgZI+Gqa8VycORqUwjYBZe4QFyw+b0414pqn4kjx8fpoqTLR20Ba4SoUzr
 bW6QLUQyaWw5oZMQ4/QS6YCqhBGhmsOM3mA3UYnvYnCSi5ri6QpjI6evr07UFn9cnd0n4ITA8EHF+
 rAqiTGbG30uiEODpDoU5Mf7pdGuouVJU6yD/YftlJQwEby2AAFHto+7/HuzrROynjxElr+JXP3UqD
 bHCvnd8g==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCOX-008k1J-04; Mon, 11 May 2026 00:13:04 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:09 -0300
Subject: [PATCH v2 12/14] drm/v3d: Split BO fence attach from syncobj
 output handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-12-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4405; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=5meq0tMRCxA0SGZZfTg24R9RmqRNkoJosSDe8oWAEJI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK1NOP+Uky8QzApNXVTCBDAj/NSk/YsbhetF
 DeyO1ksDYGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtQAKCRA/8w6Kdoj6
 qg1DCACs9WDQdaqutaAE81zLXNzMQT8Q8GRxOyWxnCUYAdGcJw9lDGGD8GjPswhX17qn1pmVbYT
 JPYc3VNyL87VSHbKvxNZ4mrz4odY4S4W1lBzzwTDBDIugRcy/qbtFlZ11SjrVnmtCklLgJGepfh
 nFKBOmLaVEJdDNuFRfnKcq2oZ9OkL73FoXurd0Qg2fTBdWuAwsgoXyHGqAkinw3qbPpz9cLiatZ
 Vm5ITE8t3FdRZrRHODXcUbSaphEqM1Ie5UskO/xocGsx/FoH3zxOWnuUSfGYzJSyxkAYW2zMUtt
 /hzHykqUEPmtoF1/WdUXTIh9tfSl+k8PBRcXz8kGMAA1GAsJ
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

v3d_attach_fences_and_unlock_reservation() does three different things:
(1) attaches the submission's last fence to every BO, (2) releases
drm_exec, and (3) replaces the userspace out_sync syncobjs. Decouple
these three behaviors into different functions, so that each function
has a more self-contained behavior.

Also, move fence attachment and reservation unlocking to v3d_submit_jobs(),
so that callers no longer have to deal with this sequence. Now, after
submitting the jobs, callers are only responsible for calling
v3d_submit_process_post_deps().

No functional change; just code consolidation.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 57 ++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 6506acb6992e..08a7fa9bc366 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -273,6 +273,25 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
 	return 0;
 }
 
+static void
+v3d_submit_attach_object_fences(struct v3d_submit *submit)
+{
+	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
+
+	/* The submission's last fence covers the entire submission. Attach it
+	 * to every BO touched by any job in the submission.
+	 */
+	for (int i = 0; i < submit->job_count; i++) {
+		struct v3d_job *job = submit->jobs[i];
+
+		for (int j = 0; j < job->bo_count; j++) {
+			/* XXX: Use shared fences for read-only objects. */
+			dma_resv_add_fence(job->bo[j]->resv, last_job->done_fence,
+					   DMA_RESV_USAGE_WRITE);
+		}
+	}
+}
+
 static void
 v3d_push_job(struct v3d_job *job)
 {
@@ -307,6 +326,13 @@ v3d_submit_jobs(struct v3d_submit *submit)
 		}
 	}
 
+	mutex_unlock(&v3d->sched_lock);
+
+	v3d_submit_attach_object_fences(submit);
+	v3d_submit_unlock_reservations(submit);
+
+	return 0;
+
 err:
 	mutex_unlock(&v3d->sched_lock);
 	return ret;
@@ -327,28 +353,13 @@ v3d_submit_cleanup_jobs(struct v3d_submit *submit)
 }
 
 static void
-v3d_attach_fences_and_unlock_reservation(struct v3d_submit *submit,
-					 u32 out_sync, struct v3d_submit_ext *se)
+v3d_submit_process_post_deps(struct v3d_submit *submit, u32 out_sync,
+			     struct v3d_submit_ext *se)
 {
 	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
 	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
 	struct drm_syncobj *sync_out;
 
-	/* The submission's last fence covers the entire submission. Attach it
-	 * to every BO touched by any job in the submission.
-	 */
-	for (int i = 0; i < submit->job_count; i++) {
-		struct v3d_job *job = submit->jobs[i];
-
-		for (int j = 0; j < job->bo_count; j++) {
-			/* XXX: Use shared fences for read-only objects. */
-			dma_resv_add_fence(job->bo[j]->resv, last_job->done_fence,
-					   DMA_RESV_USAGE_WRITE);
-		}
-	}
-
-	v3d_submit_unlock_reservations(submit);
-
 	/* Update the return sync object for the job */
 	/* If it only supports a single signal semaphore*/
 	if (!has_multisync) {
@@ -1052,8 +1063,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
-
+	v3d_submit_process_post_deps(&submit, args->out_sync, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
@@ -1145,8 +1155,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
-
+	v3d_submit_process_post_deps(&submit, args->out_sync, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
@@ -1213,8 +1222,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_attach_fences_and_unlock_reservation(&submit, args->out_sync, &se);
-
+	v3d_submit_process_post_deps(&submit, args->out_sync, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
@@ -1322,8 +1330,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_attach_fences_and_unlock_reservation(&submit, 0, &se);
-
+	v3d_submit_process_post_deps(&submit, 0, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;

-- 
2.54.0

