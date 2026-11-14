Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7496606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tTPYG1hS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3937D10F041;
	Sat, 14 Nov 2026 16:25:20 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F2610E22C
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:20:37 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-33c10faf6easo229996eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644437; x=1795249237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5+RlFqufX4xhL1zOaDcekPTcuiYRW3XbXJOszvYL5u4=;
 b=tTPYG1hSjl0unIoY7az4uitGR1noAjdA87UwPM0bUmX6Orhj3DjyPqOD9nzUXq4nq2
 jEKU/rRjfnMQb1yuVca8KCabpN2IJVSaICyjrV0BCBwyoqw2HrklCa7TljVifHDVh1Kl
 LYsLAgH6aoiJOsM1a+Va62cFEKzZbl6m9o7bDbSOxsWVMc0wROXQgymIyPHyN0oCV+ct
 eOvm9SXCw+CIg9fYpCz+7FGH+8hDMYavQ4U+xNumeFkOQIjKlxoNtEEzP4Lqee90rB1d
 7YyQeabuEIkMLxUYOVM18Xs29UOGy/BuOLThrTd03yQMi8tUFvMuTN5HL1Up2LaUtcvB
 Tz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644437; x=1795249237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5+RlFqufX4xhL1zOaDcekPTcuiYRW3XbXJOszvYL5u4=;
 b=z+j5t06GVVhN7BXdfQxDCa6q+fPf+k0Z+R7RU8Dg2xnWEA2I/xN6WWbMNmOu2i6j4U
 j+LAGdXXYSSLYuZ16dlEv9KrQSxhc6WpF2vKYo4MAwG+jPXxXnIPnyALHn2sR/QNqpRh
 CwONZhITDtnLnT35lMh02N024EUWSWEvTTwP7GGQhGuM49vH6RW58lvvc76Chjfh89bM
 ioKHr5mQEI24UEHOfMc2wlVD2KzzNZvVYzth9net/bLY7NNXTRX7US4hzONavVqVSB48
 +Ud/Dhe3cQ+GxNBJBWpZyblfhUojiS5EJhjlP8YQy3H5gR35qn4/PYduiT7jWfn7W70A
 jtBA==
X-Forwarded-Encrypted: i=1;
 AL+hErH0URfMMYfIi39+7ChskIkO5zu6/wlvLebr3Skgu1WBmMIWQhXYN6sGSicBry47DdG53Jg4BCkrLq4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/yWkghxCaOqsLSG9v8dhpIIVqhIUMCiRHmAMJDsnbAo4q/h2FP
 PVOQREgqXnLCiqs4pMDgMOPClWLf3Smd8LjYlonCZUbjaZxQnCUEX+nZ
X-Gm-Gg: AYBFou0pNa9kFk0CK/zy97n2yaZXQ8DAro0PNhjBoTHZ3R2QKCKQEGkvRuYWxmF9ayP
 UiQ/MUTvf0vqpotESgHpBor7l/K5ZDfqkaByfr1idVhkcqiLBQNdtLuZMhRYy4aXxSD36VP4eig
 vlCQOcWjU6fz22hdzwVawcRsOUDEQq7LT92AONBU1ohkcs1J9HJJkHXSFTXaWPyH3/Af9P5U0lR
 rAB7H3SHEnyWzz0ZCWUrw9nFuqYjj/R0pdeaYGvEL4wueVh5uz1CxlcSitm1pQMT7Uctpbz4709
 MdGHGLaXOTAG0D/k0mcyv8i2a30EbweTn75amV/IimbtZ37fUXNJ1DPUlZzii3FQ9PdDt4LsfyC
 2X0iCMxKThDS4wAeNwQTWcovij0ZE/TUii1XG1ZHS1lM00rPOzj3lWC3f9DV6jSOnvHjm62cBB8
 RF8WriaN24HHOgYr7egzJAA3zceOC92nZWzL5hpIDWP3QUzn3LAx61K8Dr0SNTx15oP0+gI/Xdh
 CMGBKkrO+8Psp0dBEhZVDfOUbHKnUGTBocXXFaGUWLUSWneUxDh4+VbeGOT27h1VrxoNdDP902C
 VMHiA/oZzFMJm0wNS0zBx77YNa38aOoPil4nHcxGBb43gVKX4oyBZ4uaXVXcrqgFaIHtyIdxiVv
 Y1Io=
X-Received: by 2002:a05:7300:7481:b0:36d:cd5d:d809 with SMTP id
 5a478bee46e88-37964ff2d6emr9742335eec.1.1794644436617; 
 Sat, 14 Nov 2026 00:20:36 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:20:35 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 3/4] drm/panfrost: Stop a job queued after its JM context
 was destroyed
Date: Sat, 14 Nov 2026 17:20:15 +0900
Message-ID: <20261114082016.2454-4-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114082016.2454-1-arpe1618@gmail.com>
References: <20261114082016.2454-1-arpe1618@gmail.com>
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
it takes the lock, so with the previous patch, such a job is either
found by panfrost_jm_ctx_destroy() or sees the flag, and it then goes
through the same stop and completion path in both cases. Cancelling the
job in panfrost_job_hw_submit() instead would leave a gap in the fence
seqnos of the slot, which the job chain flags rely on. Use READ_ONCE()
and WRITE_ONCE() for the flag, as it is written outside job_lock and
read without it in panfrost_job_run().

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for manging job resources")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
panfrost_stop_job() is the loop body of panfrost_jm_ctx_destroy() moved
into a helper unchanged, apart from the lockdep assertion.

When the job is in subslot 0, the hard stop is written right after
JS_COMMAND_NEXT=START, as panfrost_jm_ctx_destroy() can already do for
a job it finds just after it was started. Whether the job manager can
miss a stop that early could not be checked on hardware.

Arun Iyengar's "Resume long jobs instead of resetting" series also
changes panfrost_job_hw_submit(); this patch does not depend on it:
https://lore.kernel.org/r/20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com

 drivers/gpu/drm/panfrost/panfrost_job.c | 68 ++++++++++++++++---------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7a3137dacb9d..0dbed7a50910 100644
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
+	 * resume. job_lock orders this against panfrost_jm_ctx_destroy().
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
@@ -1100,14 +1141,13 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 	if (!jm_ctx)
 		return -EINVAL;
 
-	jm_ctx->destroyed = true;
+	WRITE_ONCE(jm_ctx->destroyed, true);
 
 	/* Kill in-flight jobs */
 	spin_lock(&pfdev->js->job_lock);
 	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity); i++) {
 		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
 			struct panfrost_job *job = pfdev->jobs[i][j];
-			u32 cmd;
 
 			/*
 			 * The scheduler clears job->base.entity when it pops the
@@ -1116,27 +1156,7 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 			if (!job || job->ctx != jm_ctx)
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

