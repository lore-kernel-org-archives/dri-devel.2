Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49530606A541
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiGWOtGM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F84110EE7B;
	Tue, 10 Nov 2026 07:45:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3433910E08B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:45:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06B5763787;
 Tue, 10 Nov 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794296699;
 b=UaPJGOjaTaVrZuY8yc8OvUHZQV2xGtBFIiVJOqUUqHgIX7PCwhO35TG6tpEnXhlkOmzz
 w1OpyBzpB1+u/yHd6lG74YT0Q0LW+DVC3W0DoqkjBagr+fQunH9TImXiVrnFiKpn9tmUp
 wAEw9J1FlcmaoqRVP9vjZY7gDUgU0grKPhDtitanHJhj/9QGmVCLsxAVUx/UoKMP6qkjN
 9OdT7qaxy6lm9E7edd4XJ9rGgLFKabUdK9HuFJEdGUTMVidnkAqaCvqwN+cYYlxB8kdoD
 2oZIJuRl7C59dPwSMjGpBE7hJdnMZ6YnW9Ez5qiqjLi0E6mNEWEtN+QC9Uxm+c2ugvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794296699;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=13+kxbRxrZAsYhPPfD0WvutetemaIB0HAlGBo8xujfI=;
 b=rqUtOJGZPexV7ZvloXGk8WeO64KJaX3M3lauM4bpOqohtt/4aE+GfRFE28lcL9LF6P2O
 bRkn7wb+ZYy2UHZoANwlfBZslEsmZOPadzswIqzWWvl62TSLymG47wnDkwU+38UzTI0ck
 MQEQn0UsTQiNKrNpFexEGz4ktwqI/eZkAq5D48+WXcjYOd07pnhmke1e0DoLH4uGms4Qe
 Atv8D43c/zGN/8jRjxCLK9pQA5jBfmPsNkC/VBfTYiClMnc9ecay5Lp8X1G3zurMY2B26
 4WXkgj331HGAb/NKQo0v0Clkkx7jl3OBDGamNAzUo+BqTL0sjUB0hlc81Uuvg41IjJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DBFB71F008A1;
 Tue, 10 Nov 2026 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794296699;
 bh=13+kxbRxrZAsYhPPfD0WvutetemaIB0HAlGBo8xujfI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=aiGWOtGM61SVgKwQ/MvNmaI7ZCIFv1VUKbK2NAKMdYSKRMVcULO2A9vrDwcxni2DF
 EXo6fTwYEEBUrD0Yn5PBtoZcdTXRCJfBdFljI0Ywd6B+IzQV+9syTVjFm7+KtYwyw9
 w82uDVxGtY3r6xpgcp4fp1dOTXfFvkWyreuawvYBGBaxtYUfjiZ/4DojO4RTLde2wD
 VSFYyMBbAcDdCPOsGvtcGDg4k3mP6b/65gzf5IrtzDfZ9OD/Txh+0PUFc7/F1LSHTf
 WZTY/2HurCpokPzRxc34FplosCFlDgzzkHiT7nviqcrrcfLAqmbB7qDKT7e+7kAuSR
 F3wVNP13ssciA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7F5FB48A1E;
 Tue, 10 Nov 2026 07:44:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:45:00 +0000
Subject: [PATCH 5/7] drm/panfrost: Wait for the soft-stopped slots with the
 live slot status
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-panfrost-long-jobs-v1-5-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
In-Reply-To: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
To: David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794296695; l=4677;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=OBz7dKLGmuvx7lzxnQgoll5OPmklbtN6lL5L81r2Qmc=;
 b=OxUagcW02OITSyn9pB5xxa26MlzkW+GJp5p4B2sKmDhb/QBSWwzhCEGsaXXzq8YQYc5LjMgb1
 m8G/lIOs/aGCwJmt+ZK8wzxsX5KiXx6Zv+TuT/9fRu2fcdDE4KPS6Ma
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

panfrost_reset() soft-stops the slots and waits for them to go idle by
polling JOB_INT_JS_STATE. That register is not live: it is a snapshot of
the slot states taken when JOB_INT_CLEAR was last written (the Arm
driver documents it as "status==active and _next == busy snapshot from
last JOB_IRQ_CLEAR"). For a job that was started into an idle slot, the
usual case for an OpenCL queue that submits one kernel at a time, it
still shows the slot idle, and the wait ends at once while the job is
still running.

The GPU reset that follows hides this, since it kills the job anyway.
Without a reset it does not: with the soft-stopped job resumed instead
(next patch) and this wait, the job was removed from pfdev->jobs[] and
resubmitted while its first run was still stopping. When that first run
reported DONE, the handler signalled the resubmission's fence, the job
manager started the resubmission from _NEXT, and its completion found
no job on the slot (Mali-G31, OpenCL CTS Integer Ops):

  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000f8
  pc : panfrost_dequeue_job+0x2c/0xd8 [panfrost]
  lr : panfrost_jm_handle_irqs+0x268/0x570 [panfrost]

Wait on the live JS_STATUS registers instead: a slot is busy while it
reads ACTIVE, and every slot has to be idle before the queues are
touched, so that the pending DONE or STOPPED interrupt is handled first.
And make panfrost_dequeue_job() return NULL for a slot without a job:
every caller copes with a NULL, so a stray event is a warning rather
than an Oops.

Fixes: 030761e097b4 ("drm/panfrost: Queue jobs on the hardware")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 48 ++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index e1f3e5d71..81efa8a86 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -165,7 +165,11 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
 {
 	struct panfrost_job *job = pfdev->jobs[slot][0];
 
-	WARN_ON(!job);
+	/* An event for a slot we have no job on. Not fatal, as every caller
+	 * copes with a NULL job; a WARN, not an Oops.
+	 */
+	if (WARN_ON(!job))
+		return NULL;
 
 	if (job->is_profiled && job->engine_usage) {
 		job->engine_usage->elapsed_ns[slot] +=
@@ -647,34 +651,31 @@ static void panfrost_jm_handle_irqs(struct panfrost_device *pfdev)
 	}
 }
 
-static u32 panfrost_active_slots(struct panfrost_device *pfdev,
-				 u32 *js_state_mask, u32 js_state)
+/* A slot is busy as long as its status register reads ACTIVE. This has to
+ * be the live JS_STATUS: JOB_INT_JS_STATE is a snapshot taken when
+ * JOB_INT_CLEAR was last written, so for a job that was started into an idle
+ * slot it still shows the slot idle, and a wait on it ends before the
+ * soft-stop has done anything.
+ */
+static bool panfrost_slots_idle(struct panfrost_device *pfdev)
 {
-	u32 rawstat;
-
-	if (!(js_state & *js_state_mask))
-		return 0;
-
-	rawstat = job_read(pfdev, JOB_INT_RAWSTAT);
-	if (rawstat) {
-		unsigned int i;
+	unsigned int i;
 
-		for (i = 0; i < NUM_JOB_SLOTS; i++) {
-			if (rawstat & MK_JS_MASK(i))
-				*js_state_mask &= ~MK_JS_MASK(i);
-		}
+	for (i = 0; i < NUM_JOB_SLOTS; i++) {
+		if (job_read(pfdev, JS_STATUS(i)) ==
+		    DRM_PANFROST_EXCEPTION_ACTIVE)
+			return false;
 	}
 
-	return js_state & *js_state_mask;
+	return true;
 }
 
 static void
 panfrost_reset(struct panfrost_device *pfdev,
 	       struct drm_sched_job *bad)
 {
-	u32 js_state, js_state_mask = 0xffffffff;
 	unsigned int i, j;
-	bool cookie;
+	bool cookie, idle;
 	int ret;
 
 	if (!atomic_read(&pfdev->reset.pending))
@@ -713,10 +714,13 @@ panfrost_reset(struct panfrost_device *pfdev,
 		job_write(pfdev, JS_COMMAND(i), JS_COMMAND_SOFT_STOP);
 	}
 
-	/* Wait at most 10ms for soft-stops to complete */
-	ret = readl_poll_timeout(pfdev->iomem + JOB_INT_JS_STATE, js_state,
-				 !panfrost_active_slots(pfdev, &js_state_mask, js_state),
-				 10, 10000);
+	/* Wait at most 10ms for soft-stops to complete. Every slot must have
+	 * gone idle before we touch the queues: a job that is still stopping
+	 * (or finishing) raises its interrupt later, when its entry in
+	 * pfdev->jobs[] is gone or belongs to its own resubmission.
+	 */
+	ret = read_poll_timeout(panfrost_slots_idle, idle, idle, 10, 10000,
+				false, pfdev);
 
 	if (ret)
 		dev_err(pfdev->base.dev, "Soft-stop failed\n");

-- 
2.55.0


