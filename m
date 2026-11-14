Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002B606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+Zwyvz3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088A210F02F;
	Sat, 14 Nov 2026 16:25:08 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1073910E1B5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:26:52 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36dc4797082so201556eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794637611; x=1795242411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xUwUTar5g+YyZ0+0H60qrNboYluLL/4nAr406HnMeqA=;
 b=h+Zwyvz3PlKshJ4P+wGBMlp8PXRU1KF0TgxUpVjxrjn39rKZFbj13Bs5aCH8Iqc4gY
 ssGqWTfUomY5sqqkOeiUWnFpmzIUNlzvuSdAO7vngLxchPdYJKyqE1ldT2P6xJzPjp2d
 7eko96PBM60KSFnT10ljhiRRyUthU2ivCoUPfirlL/gV/y0TnqfB9lAFrvphD4xrGS34
 QyNtXVswCnldpDwGMt1ijD4itcA0+ehdf7qyos/7MF7pPVTxQanlhKfADypudf2Ut1jZ
 pKeEvk/YQRrEW9+NN8QYZk2y6s3KxFpmTmKzhr0crt3YsaJSBRNpdf/i4dr8sjv9IkVg
 9shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794637611; x=1795242411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xUwUTar5g+YyZ0+0H60qrNboYluLL/4nAr406HnMeqA=;
 b=cGx0baRIYiF3QlwYGKC5FLOJtCFBjycGmk43PeztXhGd04Bl0XYkEi67t7HKdKvhqz
 8VQQue9PQvtjJdJ8f7/608ESxU4rXiWtTF6Tu1mYxKy8/84kG+oCLKPTcd9NEWMcYsNY
 Gxn8jowkYlqeIoq1OM6KXi9vuqclaH62EuKmw8TQe7bh9yHzowu4cZ+W3Jd4+VXMf+ci
 113TRhQd8kYaFMSTRv0RDe0Z2w1nkAKsxFPeiIWQ6nEv6eJgimdDhfwHttP1Jzy75Ily
 IX0r5Lx0qZ8cZNYcELchZJG0h/4XmXHoC9HB5kigUwqfSKgvImOBFmbSCSk6XmAGPc5l
 wsVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGHvzuYb4lSUdaRlWFMpgdOQ2UcCETa0cNGgkZApqSaEbG8IymtEgQ9tsvnQ9agR2g5UodxAERvuVc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jrt+/xTqt5aKuwUA1CGVgiDjNbT9xnfiDllLpoAthZWoL9kNA
 ugZIX0GyVSYwZAVgXAU3Yue+k5pLt15m99qR+4WlyEDAs5e0arbOWiFB
X-Gm-Gg: AYBFou1V5nMATHjcftetFEZ4ZCUl5DqJ8bGbo0PiRMTnuhU/hcp8tN2qBwl18zQ2Mo1
 PoN/vAejUKgUMVCalesNu2lU8awLAd77ND2Yu/bHSLG+gvHVPAGuUQoYWAtRaQtinNxEOHikGef
 NPuwDwuYkxIRzvm17qKdHFtF6b60ZmOj4L0jX1sEWXJd4W9mG9/65Kd163FJDwXLNWdZE32Q12m
 xcH8EBbJ1ASe1xmF/2QX0hksACNVNqAqJJNQRe7SMrfD7/obKlixxC2I+sTC5RRLk8zNgIweMhc
 ZZaZv3x0SwFQ3ze16tPyZ8oqcCoOZuHmYcAtq7TU/JUBbecUM99w1rpUYp54b8AYNpNw1kB9tMn
 Up46Csg9eeYygGh++RUj/RH414zmd+kTTubE5lCwSK2DdfQrKsTqzO8zpML/fkOhWseWe8RGCeE
 i0KgI7s1XxrSzGl63gkf4q4U6dtP7XJfWjssUYTnmS5ZTx4HQJqNWEm7xo7H3DiTu8By6+KpKBJ
 JHqUmsoIut89wnU+8HV4OfSXpXC6QH7sohDbvfAAydFRr9TwOlAeN798WkKqbyfsQiX3mynMSmJ
 jnuFq/UkaGY1VjHPVSxmZBEmjH07UcAUl8HvoFuZB4hejGU4yr+4i4oBf1AeRTR54FnC5GVDorK
 1Y5Y=
X-Received: by 2002:a05:693c:3e0a:b0:377:d6e5:e642 with SMTP id
 5a478bee46e88-379652e5215mr5982030eec.1.1794637611213; 
 Fri, 13 Nov 2026 22:26:51 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955ffcbc9sm19762863eec.18.2026.11.13.22.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 22:26:50 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/2] drm/panfrost: Stop a job queued after its JM context was
 destroyed
Date: Sat, 14 Nov 2026 15:26:37 +0900
Message-ID: <20261114062637.2447-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114062637.2447-1-arpe1618@gmail.com>
References: <20261114062637.2447-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

panfrost_jm_ctx_destroy(), which runs on JM_CTX_DESTROY and when the
file is closed, sets jm_ctx->destroyed and then stops the jobs of the
context that it finds in pfdev->jobs[]. panfrost_job_run() checks the
flag once, without any lock, and panfrost_job_hw_submit() can then
sleep in pm_runtime_get_sync() before it queues the job in
pfdev->jobs[] under job_lock. A job that is between the check and the
queueing when its context is destroyed is therefore neither cancelled
nor stopped, and can then be started after its context, and possibly
its file, are gone. With profiling enabled, its engine_usage also still
points into the panfrost_file_priv that panfrost_postclose() frees, and
panfrost_dequeue_job() writes to it when the job completes.

Before commit 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for
manging job resources"), the close path called
drm_sched_entity_destroy(), which waits for a run_job() call in
progress on the entity, before it looked for the jobs to stop. The
entities are now only destroyed when the last reference to the context
is dropped.

Move the per-job part of panfrost_jm_ctx_destroy() into a helper, and
call it from panfrost_job_hw_submit() on the job it has just queued if
the context has been destroyed by then. The check in
panfrost_job_hw_submit() and the loop in panfrost_jm_ctx_destroy() both
run under job_lock, and panfrost_jm_ctx_destroy() sets the flag before
it takes the lock, so such a job is either found by
panfrost_jm_ctx_destroy() or sees the flag, and it then goes through
the same stop and completion path in both cases. Cancelling the job in
panfrost_job_hw_submit() instead would leave a gap in the fence seqnos
of the slot, which the job chain flags rely on. Use READ_ONCE() and
WRITE_ONCE() for the flag, as it is written outside job_lock and read
without it in panfrost_job_run().

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for manging job resources")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
panfrost_stop_job() is the loop body of panfrost_jm_ctx_destroy() moved
into a helper unchanged, apart from the lockdep assertion.

Arun Iyengar's "Resume long jobs instead of resetting" series also
changes panfrost_job_hw_submit(); this patch does not depend on it:
https://lore.kernel.org/r/20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com

 drivers/gpu/drm/panfrost/panfrost_job.c | 68 ++++++++++++++++---------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7022b1b2e020..fbfdee42a4ae 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -202,6 +202,37 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
 	return 1;
 }
 
+/* Stop a job of a destroyed JM context, found in pfdev->jobs[slot][subslot]. */
+static void panfrost_stop_job(struct panfrost_device *pfdev, int slot,
+			      unsigned int subslot, struct panfrost_job *job)
+{
+	u32 cmd;
+
+	lockdep_assert_held(&pfdev->js->job_lock);
+
+	if (subslot == 1) {
+		/* Try to cancel the job before it starts */
+		job_write(pfdev, JS_COMMAND_NEXT(slot), JS_COMMAND_NOP);
+		/* Reset the job head so it doesn't get restarted if
+		 * the job in the first slot failed.
+		 */
+		job->jc = 0;
+	}
+
+	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_JOBCHAIN_DISAMBIGUATION)) {
+		cmd = panfrost_get_job_chain_flag(job) ?
+		      JS_COMMAND_HARD_STOP_1 :
+		      JS_COMMAND_HARD_STOP_0;
+	} else {
+		cmd = JS_COMMAND_HARD_STOP;
+	}
+
+	job_write(pfdev, JS_COMMAND(slot), cmd);
+
+	/* Jobs can outlive their file context */
+	job->engine_usage = NULL;
+}
+
 static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
@@ -272,6 +303,16 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			"JS: Submitting atom %p to js[%d][%d] with head=0x%llx AS %d",
 			job, js, subslot, jc_head, cfg & 0xf);
 	}
+
+	/*
+	 * panfrost_jm_ctx_destroy() only stops the jobs it finds in
+	 * pfdev->jobs[], so stop this one here if its context was destroyed
+	 * while we were getting here, e.g. while waiting for the GPU to
+	 * resume. Pairs with the WRITE_ONCE() in panfrost_jm_ctx_destroy().
+	 */
+	if (READ_ONCE(job->ctx->destroyed))
+		panfrost_stop_job(pfdev, js, subslot, job);
+
 	spin_unlock(&pfdev->js->job_lock);
 
 	return 0;
@@ -404,7 +445,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence = NULL;
 	int ret;
 
-	if (job->ctx->destroyed)
+	if (READ_ONCE(job->ctx->destroyed))
 		return ERR_PTR(-ECANCELED);
 
 	if (unlikely(job->base.s_fence->finished.error))
@@ -1100,7 +1141,7 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 	if (!jm_ctx)
 		return -EINVAL;
 
-	jm_ctx->destroyed = true;
+	WRITE_ONCE(jm_ctx->destroyed, true);
 
 	/* Kill in-flight jobs */
 	spin_lock(&pfdev->js->job_lock);
@@ -1109,32 +1150,11 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 
 		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
 			struct panfrost_job *job = pfdev->jobs[i][j];
-			u32 cmd;
 
 			if (!job || job->base.entity != entity)
 				continue;
 
-			if (j == 1) {
-				/* Try to cancel the job before it starts */
-				job_write(pfdev, JS_COMMAND_NEXT(i), JS_COMMAND_NOP);
-				/* Reset the job head so it doesn't get restarted if
-				 * the job in the first slot failed.
-				 */
-				job->jc = 0;
-			}
-
-			if (panfrost_has_hw_feature(pfdev, HW_FEATURE_JOBCHAIN_DISAMBIGUATION)) {
-				cmd = panfrost_get_job_chain_flag(job) ?
-				      JS_COMMAND_HARD_STOP_1 :
-				      JS_COMMAND_HARD_STOP_0;
-			} else {
-				cmd = JS_COMMAND_HARD_STOP;
-			}
-
-			job_write(pfdev, JS_COMMAND(i), cmd);
-
-			/* Jobs can outlive their file context */
-			job->engine_usage = NULL;
+			panfrost_stop_job(pfdev, i, j, job);
 		}
 	}
 	spin_unlock(&pfdev->js->job_lock);
-- 
2.43.0

