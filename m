Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD659606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEVot/Bf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB97112350;
	Fri, 13 Nov 2026 09:03:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B467D112094
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:03:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26F6A462F9;
 Fri, 13 Nov 2026 09:02:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560579;
 b=Q1scbMW4NoRlONFXrXsSB4UEClhl0T2A4SZHS1GK8w/J29IZpaw6lsO6LpNNUKzJVDL2
 NqsDXJZ2pCmc4Lqz50MXkgLe0UGFFJm94DAl2Fz9Hz9epzD21u3oHnfgSJK08RCa36KF0
 nKYgua1kdIj+BV5dWboh7TZa4nUzEHBDFXuJMHQupzMl+My/cdsMA1KVk60zcXWXfAxY4
 Nw024GPhnPgP8ab7ZvNnXaoN7V4+LFJBrJ4l+hocolixy28QL2xp3/VKCaJTsL6a3zyi+
 po26v1cxEmp8NHRC5f6DHkANtp2JAMWydGQWEFU9XD0bpiDLYTKVLJYbiIM20wyHsoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560579;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=eNyvVSZMbYwDVl4yyIN25cKJ60P1bT9PIzKDIsmg/fU=;
 b=ttr8qmwRne4dgTTjWxVgZjnYnqNNDoj0DK1MBir05BGtj0MogY4TkevKlhNMewB7xoLL
 tGTOU0ykyoq90c51T9r8Ujd80gPWeNXzaRZ3QZkCfOVvGwlMrAHbLZaPukKOopV8jACJW
 mTKnS8c9FMz7oHWbsMS9pdiz+JXP9Jw+kblRJJXo5WGTAbwuNufNDhZ/SdTg/xlwCNEPX
 pP8vbZLFA7rrbtWXegSm/d2+ItrPepgfQSu8JZ9ltdX2Hw8+Ni7RjISiYHAWFQ5gDR2D8
 cqea320eVJkewu4Jvd3FXpPu60iB4jC4Py4vppV4pd64uu1P3iYdmXc2RLWhmvu2owA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5DA8D1F00926;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560579;
 bh=eNyvVSZMbYwDVl4yyIN25cKJ60P1bT9PIzKDIsmg/fU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=MEVot/BfcgDoNAIQEiSma7y9qpbTgl2xqsdP+mXBnA7fNi4eYoZeezktMgYB/e3Nf
 Ou4wYtNoG8EF87D800mKxPxS1lIy7qzE8o0aCZJ5jbUlBzEliWhUUq6jPDqz6WJi9q
 3rzUiW5mej353O4LkHhDco9xupMCXh+9I3VDw2ycIeGtGQ1eUNircYghgLIdAzYCJZ
 3i7qNlIbaDm/7Uu1D4Hf552T00jYyQYbZ9kkCJvM0hpg9LIVvGHAHPa7ZKuhSzDMDX
 5cvUfgtYlTd0/I61BJkZZLiFHuA94VQv3oyS5rh6o3U7xRRO6QbJdZ07T8dLunpNlB
 ki7rMW9SxbFyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B6A5447702;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:03:04 +0000
Subject: [PATCH v3 12/14] drm/panfrost: Wait for the soft-stopped slots
 with the live slot status
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-12-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
In-Reply-To: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=4065;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=+9Y9glDL3o1W7R1YfSBd4YRIE6jG/q1VAQhorQILig8=;
 b=mAPuGPrCU2/FyJsBSh27k9JRCHWRMiSlW+aMintLh4lWld9EWz4LAt/wYJiDQdrWpnmHRPuk8
 Dzn+3K0kg8kB/19nLLLlyehYB2Kk5rvvf1fwnvG9HtRHF4ZXdEqcA84
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
polling JOB_INT_JS_STATE. That register is a snapshot of the slot states
taken when JOB_INT_CLEAR was last written (Arm driver: "status==active
and _next == busy snapshot from last JOB_IRQ_CLEAR"). For a job started
into an idle slot, the usual case for an OpenCL queue that submits one
kernel at a time, it shows the slot idle and the wait ends at once.

The GPU reset that follows hides this by killing the job. With the job
resumed instead (next patch), it was removed from pfdev->jobs[] and
resubmitted while its first run was still stopping. When the first run
reported DONE, the handler signalled the resubmission's fence, the job
manager started the resubmission from _NEXT, and its completion found no
job on the slot (Mali-G31, OpenCL CTS Integer Ops):

  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000f8
  pc : panfrost_dequeue_job+0x2c/0xd8 [panfrost]
  lr : panfrost_jm_handle_irqs+0x268/0x570 [panfrost]

Wait until no JS_STATUS register reads ACTIVE instead, so that the
pending DONE or STOPPED interrupt is handled before the queues are
touched. Also make panfrost_dequeue_job() return NULL for a slot without
a job: every caller copes with it, so a stray event is a WARN, not an
Oops.

Fixes: 030761e097b4 ("drm/panfrost: Queue jobs on the hardware")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 41 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 1b7becf7b..8235d182d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -173,7 +173,8 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
 {
 	struct panfrost_job *job = pfdev->jobs[slot][0];
 
-	WARN_ON(!job);
+	if (WARN_ON(!job))
+		return NULL;
 
 	if (job->is_profiled && job->engine_usage) {
 		job->engine_usage->elapsed_ns[slot] +=
@@ -647,25 +648,20 @@ static void panfrost_jm_handle_irqs(struct panfrost_device *pfdev)
 	}
 }
 
-static u32 panfrost_active_slots(struct panfrost_device *pfdev,
-				 u32 *js_state_mask, u32 js_state)
+/* Reads the live JS_STATUS: JOB_INT_JS_STATE is a snapshot from the last
+ * JOB_INT_CLEAR write and can show a busy slot as idle.
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
@@ -673,9 +669,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	       struct drm_sched_job *bad)
 {
 	struct panfrost_job *evicted[NUM_JOB_SLOTS] = {};
-	u32 js_state, js_state_mask = 0xffffffff;
 	unsigned int i, j;
-	bool cookie;
+	bool cookie, idle;
 	int ret;
 
 	if (!atomic_read(&pfdev->reset.pending))
@@ -728,10 +723,12 @@ panfrost_reset(struct panfrost_device *pfdev,
 	}
 	spin_unlock(&pfdev->js->job_lock);
 
-	/* Wait at most 10ms for soft-stops to complete */
-	ret = readl_poll_timeout(pfdev->iomem + JOB_INT_JS_STATE, js_state,
-				 !panfrost_active_slots(pfdev, &js_state_mask, js_state),
-				 10, 10000);
+	/* Wait at most 10ms for soft-stops to complete. No slot may be active
+	 * when we touch the queues: a late interrupt would find the wrong job,
+	 * or none, in pfdev->jobs[].
+	 */
+	ret = read_poll_timeout(panfrost_slots_idle, idle, idle, 10, 10000,
+				false, pfdev);
 
 	if (ret)
 		dev_err(pfdev->base.dev, "Soft-stop failed\n");

-- 
2.55.0


