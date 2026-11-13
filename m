Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53E606A882
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vqrqsm4i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0174112355;
	Fri, 13 Nov 2026 09:03:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906F311224D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:03:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E2F4612C7;
 Fri, 13 Nov 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560579;
 b=Y8PRZkn/SzVFf+m67hqnXTpUmZjeWr/pGrcyCLFTiQUkvCG1QhNBNcOO+8NrExjEsWEE
 P+A/DFmkUNAg2yxkBil56oh1/l9vRFhUsyuEJehMDCYONK8/Xl1fbNteEzfiCLyRN0VSR
 hrGi7waAChvCDjmGNA8WnAL+c+dNGEv1Wz7bFlkBZ8OLDj22fvqjN6di4SDz76L9s4mZr
 6at3AKFZrIfYzwXcUUaeDS5aAZa+J5todc6ydTWvOB1DqVFZHIHpdXi1Smqzc4ABo0K/C
 DuqB84gH1OAxCkKtbDUWUdBvd+XvZt9yMKDQFJElz4FWfwzfbIapRVgco/x/dNxEJ3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560579;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=lw/eIi1DeYM948CTTWXBH4Tz5lAqICLMhRb/6nD6SWI=;
 b=dtiJCBRqOiGnZHTTws/xfzRKwt1l6aFez7hBnYoQvu38whDS3zKzX+K1+wAQRetQMkUG
 u2R+WbZDWsp9cyTFrJDtdbutVRKmVepzDonNWm2UUzOkE+MIDi+Jht1Dgfa3OTJWBWAMr
 qrsaqIaD4kddxX8X6ZuKVlOhcP4yIwe/GdloXcIrCI6EvHDKRxlYC9vbIccQ0GoKcx2ln
 HyXb72mMHQdTJ+TVYQSWJkEWHzJGJrc4d2oaOp4qoQHoG9cNaU7LhJtmmc5KP+KqM41ty
 MCi16FCRQLA1VCz+vUyZsuuotaI1DZVBxfM8ib0NHaNbywiOY2CBU7uyWqFkJsuFXvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 566EA1F000D2;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560579;
 bh=lw/eIi1DeYM948CTTWXBH4Tz5lAqICLMhRb/6nD6SWI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Vqrqsm4iZCYEsG7zQ5rLKkt55h5GtwV72QuJ9HJcgUpVQlcqXYBq+v+xRgsScYNm7
 012dKufAd6keglNKBU9fYiy9BHzFfU5+k95qdAouItIFLRT3xpczsoq0NrDovdaybk
 j1M3DjYGVz01kqZJtVlh0w4ByPuEoNQqTQkvzbN274VRLWyXG8wX4FNWp0DwrGs/Ym
 V1cJZ83Jfwnu6mlzGMZURr5sMgBtnOm7UIGTwp0h4jPYgY0vY2Dvs6MTjkaJKqYeWw
 mV8rBhzGUfjEtLdXUA7hEr2MPGMfZItEzR6rkZOQ/yVrTe+IOId/2twH07niSKe0Jd
 s+ezlDAzimccA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A2F1B476FE;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:03:03 +0000
Subject: [PATCH v3 11/14] drm/panfrost: Don't take a job that was never
 started for done
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-11-80ae78d38f6e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=3524;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=5pnkKY/+fhA341knvkY6+lqBVQeDd4XNYCdcDe+ATgU=;
 b=MXySwKJBuygCzSlOj9OcxD1/vAxiSPq5iQ13y5yehnA+vQqHvMclJMCha/Jfrokjdtbkx+mMr
 sHqYvybU/EBDbOv3LgVsYIZYYr2JN7iNwAkH4r0uK5idyeIGKs+kra0
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

While a reset is pending, panfrost_job_hw_submit() puts the job in
pfdev->jobs[] without starting it; the reset resubmits it. But
reset.pending is set, by a timeout or a job fault, before
panfrost_reset() masks the job interrupt. If such a job waits behind a
running one that completes in that window, panfrost_jm_handle_irq()
finds both subslots inactive and takes the waiting job for done as well.
Its fence is signalled and its jc cleared, so it is never run.

Mark a job as started when JS_COMMAND_START is written for it, and leave
a job that was not started to the reset.

Found by code review (Sashiko). Not reproduced.

Fixes: 030761e097b4 ("drm/panfrost: Queue jobs on the hardware")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-210891@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 8 ++++++--
 drivers/gpu/drm/panfrost/panfrost_job.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index df7fcc436..1b7becf7b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -261,6 +261,7 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	spin_lock(&pfdev->js->job_lock);
 	subslot = panfrost_enqueue_job(pfdev, js, job);
+	job->started = false;
 	/* Don't queue the job if a reset is in progress */
 	if (!atomic_read(&pfdev->reset.pending)) {
 		job->is_profiled = pfdev->profile_mode;
@@ -276,6 +277,7 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			job->start_cycles = panfrost_cycle_counter_read(pfdev);
 		}
 
+		job->started = true;
 		job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
 		dev_dbg(pfdev->base.dev,
 			"JS: Submitting atom %p to js[%d][%d] with head=0x%llx AS %d",
@@ -586,7 +588,8 @@ static void panfrost_jm_handle_irq(struct panfrost_device *pfdev, u32 status)
 
 		if (failed[j]) {
 			panfrost_job_handle_err(pfdev, failed[j], j);
-		} else if (pfdev->jobs[j][0] && !(js_state & MK_JS_MASK(j))) {
+		} else if (pfdev->jobs[j][0] && pfdev->jobs[j][0]->started &&
+			   !(js_state & MK_JS_MASK(j))) {
 			/* When the current job doesn't fail, the JM dequeues
 			 * the next job without waiting for an ACK, this means
 			 * we can have 2 jobs dequeued and only catch the
@@ -594,7 +597,8 @@ static void panfrost_jm_handle_irq(struct panfrost_device *pfdev, u32 status)
 			 * are inactive, but one job remains in pfdev->jobs[j],
 			 * consider it done. Of course that doesn't apply if a
 			 * failure happened since we cancelled execution of the
-			 * job in _NEXT (see above).
+			 * job in _NEXT (see above), or if the job was queued
+			 * while a reset was pending and never started.
 			 */
 			if (WARN_ON(!done[j][0]))
 				done[j][0] = panfrost_dequeue_job(pfdev, j);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index cd82d7930..4d1c54243 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -38,6 +38,8 @@ struct panfrost_job {
 	bool is_profiled;
 	/* Holds a reference on the cycle counter */
 	bool cycle_counter_ref;
+	/* JS_COMMAND_START was written for this submission */
+	bool started;
 	ktime_t start_time;
 	u64 start_cycles;
 };

-- 
2.55.0


