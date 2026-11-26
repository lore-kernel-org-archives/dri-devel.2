Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF72606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoREpRje
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0936611225C;
	Thu, 26 Nov 2026 09:39:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20B0112245
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DB2762EC6;
 Thu, 26 Nov 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685866;
 b=pTHRKZhKxdxn3z3iObP6pnSs7LuyN0WMjoKdqp9JuehNiZsmMi2OCu6JdmXIlOeYO54Y
 NaJ/8Sb8++xCnJG5XvRBWFc2epV3kooxpFkHQN0lmSwb/K17Wbp3yUrAk71gArowrtlvG
 M5cjtRhFJsKDvqZ5BEUOUyxqvWmmHqFF+j9h6Kf3ch5NORde76ogDJtlsfqEbLEEpXJlf
 rKv1jb19khVkj4p1kwDvXnJBdQilnCue8Djl/9oY9Cth39HZPZ+gBQWIerE7ZdZMq37zc
 ZqLiiZ4El8NXrIKJfFvacpQLp5lgJLRmpNqB054jpOG4Bsyg3S22bhvggXB+eSg8qpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685866;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=b1Vnpjw6TkLbgzGL1wuTpBp+Omi7UldDv2w4ZaQiTe4=;
 b=aoJBjdq++z/g0Y0HQdC4Zm0oQZot7dmy5aQne7F6ziEHD3T49sTN+N7U4Wwh67W9++8+
 GIrI26c4iB6yrDuMUVYW2s5UlmbGU9mOX17z1F3BBKpLAKSohbgR/uAWf8ndS2+lgBguu
 dla5H1XYFU7ExV9P/xc7c83Gyv+t2abxZsOUawU4pNC//on6sLr8pOzH0AtSOr1WGGoYc
 gR8eJD4O+ZnGLPsUf7WUnRjlMDgh9SykR4zej2XlTKz0W2QgNdCa1u9uJoekWg05ZFGsQ
 rEzGlUfpSY5TjPFaRR/Csh5HJ38VIygx9c+TRJKUusFAy0/xWLYfY47Yc2nJtUyczCQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 275711F000F2;
 Thu, 26 Nov 2026 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685866;
 bh=b1Vnpjw6TkLbgzGL1wuTpBp+Omi7UldDv2w4ZaQiTe4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NoREpRjeOEYrnwCwwD5OjKdEtsEBVajT6fEm5eByPbDD65Gn3OfNtfpAms3lKEtWs
 Jtt31sMO98LD+znzgznUqJw8URmWOoKBkJGa3RuUBkk4f/q/zZNPfdSCKcfy0PvX3f
 09nVafC0iKD5IYJJBscuZYuwO0H0VfAosYz3GZklREVS1yRBNxuPA/zihn1Tz3tmyL
 p7Qniv+26u0qmyw4exMfj7ENbg0EvxBEvg3/j3Leg1WQHVYYZTHugL3EjRh7AUafh3
 9+zEJ1o2z88GU4ku6Fqv+81Jh2INskGgJuy9Ieaz+BI9rOfPn+psza1jNHHSM31LAp
 mZzrANcYwi1yA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D84BC4D3A0;
 Thu, 26 Nov 2026 09:36:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:56 +0000
Subject: [PATCH v4 13/17] drm/panfrost: Wait for the soft-stopped slots
 with the live slot status
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-13-23579629ceca@gmail.com>
References: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
In-Reply-To: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=3109;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=vru6jIS0f9TqDaLwqRrhySvhQChWFPA8qS25wfCvx6I=;
 b=PFVHGe7e5dXmP1KFAVuR0aZlfVK8fAMeh49R3CJT2QKHeM8y99C2jjYOrzBFr+Bcn6w6Xd229
 /s9bEL9JR/ZCOWRznNfIkE1qV5HlTErJc0iwxDqphL1i9S/Vs9ivMyw
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

panfrost_reset() waits for the soft-stopped slots by polling
JOB_INT_JS_STATE, a snapshot taken at the last JOB_INT_CLEAR write. A
job started into an idle slot shows as idle, and the wait ends at once.
The GPU reset hides this. With the job resumed instead (patch 16), its
resubmission ran while the first run was still stopping (Mali-G31,
OpenCL CTS Integer Ops):

  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000f8
  pc : panfrost_dequeue_job+0x2c/0xd8 [panfrost]

Wait until no JS_STATUS reads ACTIVE, and make panfrost_dequeue_job()
return NULL for an empty slot (a WARN, not an Oops).

Fixes: 030761e097b4 ("drm/panfrost: Queue jobs on the hardware")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 34 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 0946da3af..722f87ebe 100644
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
@@ -645,25 +646,18 @@ static void panfrost_jm_handle_irqs(struct panfrost_device *pfdev)
 	}
 }
 
-static u32 panfrost_active_slots(struct panfrost_device *pfdev,
-				 u32 *js_state_mask, u32 js_state)
+/* JOB_INT_JS_STATE is a snapshot: it can show a busy slot as idle. */
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
@@ -671,9 +665,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	       struct drm_sched_job *bad)
 {
 	struct panfrost_job *evicted[NUM_JOB_SLOTS] = {};
-	u32 js_state, js_state_mask = 0xffffffff;
 	unsigned int i, j;
-	bool cookie;
+	bool cookie, idle;
 	int ret;
 
 	if (!atomic_read(&pfdev->reset.pending))
@@ -724,9 +717,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	spin_unlock(&pfdev->js->job_lock);
 
 	/* Wait at most 10ms for soft-stops to complete */
-	ret = readl_poll_timeout(pfdev->iomem + JOB_INT_JS_STATE, js_state,
-				 !panfrost_active_slots(pfdev, &js_state_mask, js_state),
-				 10, 10000);
+	ret = read_poll_timeout(panfrost_slots_idle, idle, idle, 10, 10000,
+				false, pfdev);
 
 	if (ret)
 		dev_err(pfdev->base.dev, "Soft-stop failed\n");

-- 
2.55.0


