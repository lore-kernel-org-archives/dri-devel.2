Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B5606A337
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQcAKvCJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DC111224E;
	Thu, 26 Nov 2026 09:38:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B20E11224E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6450D42291;
 Thu, 26 Nov 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685867;
 b=knNkWwO5+li+jqXqRz/dXM7HuQ6oM8LqzBJ50SzT++qc7ABb/oervhA0PrqUqTBSzlXn
 gGyvMso9eDBJ66HtSBN+Ha2roAK78qGCeGoAE/ua1bSQDGxu+6TaoVm8d+G2RDhBhc9iq
 EKzsbAEYNGzshTD/qD3p34QZ5/rB87ZBW8MmmHfnAUy02+7v8ASNwF8lHWI1M03VVlVUH
 6poiHqGMD+uESbwgc6h2t/VE6hpNwKIWJWJY02/PvehlH3JDOMW5PKIeSX18zbCjWlCO/
 2k5vCDQMw5VF738Fvn97nF9kuSIeIT2wwUb/qJvQw4Iy33P2M44ERxiqEKf/meYPOkw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685867;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Vi65jhZmEorWcTmRFY2Go1/Dp9ZgmGzi6iEBf5pJZM4=;
 b=ZQDJ7esu2iansQbYyvLOGtJ/ikJsSGksPncCoydbmkgvjrEO9cXzWGDFATyLjPdGsjkO
 L+CLRV6r/L13l2tzSnD42OzRZJz07W/EcoNijmn63EFKFvNGOTDPquZLc8zqSb2pto2V2
 5ED7e8xnW0nkH87dm3MM90e96z0xaNsvSVox8nWeLyuIET2wdpV4biv77XylQ2F6/6WoX
 HhW9gMf3ho+IyGdOJYSPF9pNu5obxouf6ZNKb+Gc0TgM3xInxUBiZUrsSpHsyf95UIdOC
 Z0iIpaNPG3j9nKYuUfhGRvEmdI7RzsXnaBaxbG0bvZPA4iU/ngZf/aAc5GgqQ0wxwcg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A4B6F1F008B2;
 Thu, 26 Nov 2026 09:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685867;
 bh=Vi65jhZmEorWcTmRFY2Go1/Dp9ZgmGzi6iEBf5pJZM4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=oQcAKvCJrMwYoswPn09ZBBJbK/qp8x5WUN54xaK7+eoVVeT/hSemcTXVZRe1TaqTG
 CrnFHvKVMxTbBejPe4MZCylRfzz4zdYGZFCZGFQajNEzPK+mWTdSyXMIp27Emh3hkk
 7Zczm0qREBUwWiczisTTsEeJnFQmdjN7d3DrcvG6HWVFfIprHKD3zCpRFveOIrtkgp
 5y8qx08LQofOJpEHq1nMMoO73yrvC+AWDZH1JPyt1QoyEbRQZZwfbzKtYHb+9A66jn
 Zw9BkQM6c7pykoumg6y6fl5UCsH4pZV2R/UvQyLXBhhl+htyRtfmACB/BU75gag1o8
 gu5mxei7Snxjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B94524D39C;
 Thu, 26 Nov 2026 09:36:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:55 +0000
Subject: [PATCH v4 12/17] drm/panfrost: Don't take a job that was never
 started for done
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-12-23579629ceca@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=3202;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=KmxdBC9lkjEmZW2MQMtPWghJrhcIC8sdhTBhHqMQcUM=;
 b=ujTeMVHXVypiS3oxRaO4nmO/FfGxATVCgW4PBOGDmnObLTb+F/TbaMaVsfSX8vX4ihhG3c0hS
 BpQYFyaMyCKCodOENp72McIKMrG/mKdGp4TOh25fTb1GYRKkDPDt/a/
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

reset.pending is set before panfrost_reset() masks the job interrupt.
A job queued but not started in that window, behind a running job that
completes, is taken for done: its fence is signalled and it never runs.

Mark a job started when JS_COMMAND_START is written, and leave the
others to the reset. Found by Sashiko. Not reproduced.

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
index fcddc13bf..0946da3af 100644
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
@@ -584,7 +586,8 @@ static void panfrost_jm_handle_irq(struct panfrost_device *pfdev, u32 status)
 
 		if (failed[j]) {
 			panfrost_job_handle_err(pfdev, failed[j], j);
-		} else if (pfdev->jobs[j][0] && !(js_state & MK_JS_MASK(j))) {
+		} else if (pfdev->jobs[j][0] && pfdev->jobs[j][0]->started &&
+			   !(js_state & MK_JS_MASK(j))) {
 			/* When the current job doesn't fail, the JM dequeues
 			 * the next job without waiting for an ACK, this means
 			 * we can have 2 jobs dequeued and only catch the
@@ -592,7 +595,8 @@ static void panfrost_jm_handle_irq(struct panfrost_device *pfdev, u32 status)
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
index 7f71e4c38..0ed45e28b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -37,6 +37,8 @@ struct panfrost_job {
 	struct panfrost_engine_usage *engine_usage;
 	bool is_profiled;
 	bool cycle_counter_ref;
+	/* JS_COMMAND_START written */
+	bool started;
 	ktime_t start_time;
 	u64 start_cycles;
 };

-- 
2.55.0


