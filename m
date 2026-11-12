Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70C606B734
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewRVgpC8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8697010FB41;
	Thu, 12 Nov 2026 08:48:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD1C10FD84
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:48:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0DFC4798B;
 Thu, 12 Nov 2026 08:48:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794473318;
 b=S+ecziDaMmlJvRcawV7Gf+FJrKEdAwLW2Pf9pWSVpq6NCK03wMYtK2RMxzv6Tzk+nBkI
 dx9RjRtBK66Fru0zTFfI0Ccj54+os0cvB6MrtVPqe6kt92dw1zY9ENsTxwKkbD+pxBCBB
 D9Kbvxs7+SfQxXmcDvTO9UjyyuODGbgNGd07LZcFX1nRVmQ7fmZ/0GBc9twNK0cgp4UcB
 3RIe0+QJNRKonPL3wY/R6uFhmZnXlI3wGzKGO3CIDfCsO2vRVOqvs/peTSUPpVAwBc0hO
 B1Igrhm4sdJsKXMoLTiUwe3u2xuzIlvtuA0MJewGPkV4oHcmFUFP+GU53SxX8vkpOpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794473318;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=JAFY7CgxX/sTrEGFNpq7nnbRFjlP9hIGXuOjg5IezcM=;
 b=TeLAWxbgqvfID2WA8dwql5Of/JqaE+eH9XEzVKU6ACkkWKJFImNDLtnUazUFAxZ9iY1z
 ktaZLq7vb0Zm9bL29bIiCAh+ScrOOb8yvk6iUgCadMq2DzzHYUg2y8xQVuAgvqg2YS8v5
 jcyxSVQRHFIT+n/Ai+8U9rT8qsXN9tkWJKGdHQmkqxsIYebBOnAGBVQrVKKKmjFgIbUVd
 gF9WJ4Jb4p3564ndjw9rag/e3PbXSofyZsfbez0ZhNQ6ZByNX/TP139a7wg9KWoATsrw/
 bUmshioT11LgjMADeBzfEQN2XbUKms9ASfecl711uZZ9/l/EjCV8HVeFwHpLP3gSrqg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F2AC1F00A08;
 Thu, 12 Nov 2026 08:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473318;
 bh=JAFY7CgxX/sTrEGFNpq7nnbRFjlP9hIGXuOjg5IezcM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ewRVgpC8rPNym+HUTTeW/fs81UDzkgXL/KIzxQ/P0zUaty0AsvmIQX/nwnH36pRb1
 siIUO+S7kebPXHUnrLQL6PSijltea4d7WpHUuFsF/dUJMvrTfh61rEAt5RMc4jGsLL
 sHxOSdxRVOwVyprTu03ZIQJGNwp0Ai2uXekAP1LcAMenLsE1PakAsotpdOuWdnNtxA
 HRhY8e/f+1hEolKv1OP+46a3VJUY1zxEBc755xJC4G3r0S0gdxRvxrXO0nO4Fm6Dxh
 kRnlHK/G6mxbfMOieN+yZkoX8YbhXSFhXoly1oxXl/ZeHj1SIdYjAFm280GZSeuaL+
 rj6sJ350j4yOg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B8307493FD;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:48:42 +0000
Subject: [PATCH v2 09/11] drm/panfrost: Wait for the soft-stopped slots
 with the live slot status
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panfrost-long-jobs-v2-9-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
In-Reply-To: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473314; l=4728;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=OFCXcsyF7yKPjt78FDoIKVLEsOfJVzFl98ILpy4ZKvI=;
 b=d/eLQdsWXt2GqErMOBX33dtkWMziYMxCOqtGVHjrW3yFnPEoXjXxHzbaN7FRb3iVmDRVssQLx
 6gPBC4aZh2zBIGnbDhTJEGEW2FnwcFZWc7hF5apZUBjxhqbaVcuPgDk
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
index 7561de67c..28842c572 100644
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
@@ -637,25 +641,23 @@ static void panfrost_jm_handle_irqs(struct panfrost_device *pfdev)
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
@@ -663,9 +665,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	       struct drm_sched_job *bad)
 {
 	struct panfrost_job *evicted[NUM_JOB_SLOTS] = {};
-	u32 js_state, js_state_mask = 0xffffffff;
 	unsigned int i, j;
-	bool cookie;
+	bool cookie, idle;
 	int ret;
 
 	if (!atomic_read(&pfdev->reset.pending))
@@ -721,10 +722,13 @@ panfrost_reset(struct panfrost_device *pfdev,
 	}
 	spin_unlock(&pfdev->js->job_lock);
 
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


