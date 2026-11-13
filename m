Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1C606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLItxIcO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD20112094;
	Fri, 13 Nov 2026 09:03:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2279210FF8A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:03:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48D0446649;
 Fri, 13 Nov 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560577;
 b=CQIipPxKRZO5LUTZLi1tAtHrtQDE1YOEOcmq6noy2htiwz6KwX78CSDAA8c+JcWlVtdm
 m2lO+5Gaa1737pRCRLrx41GKl5dk5xeHUg2/ToN5K4olVmkMwliJaFTJf2i+VxyP9APqP
 U83PgX1fDcUK9YVkpHyqnTCDPgKo4Xp6e3sfneThgUG9Fdn+OlLZlUhurzbTVmduIqGDm
 EiQ98I6nryeuoICrzyfpd1uGSE4aEaP8nIOB3jbxI7JCob2AcbAHnfAnZI/bTzqcTCoWh
 I6n2JyV1mbFxKCPUPhCYHcjRE+L6E2qvLDY1nGN5tLgDBYUomszUt21QW59hd+UzCyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560577;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=BfN5mFFbqEYptv1VMcXQZ0FhODM/ZYIBIQGAQdpfllw=;
 b=nqtUSWqWgzuRGic9TOu3GyASHQ5xAMXyq/hCgWXRV4JGqL1Fu7ylA3U0xuqjqwmDoFut
 MHA6SkE6oDiB+IftHGkfpap1iiwGjxe/CgpixPzL/H3TOn19j3GtsveyxBk1l4aBYsuuA
 D8Yq8cQmpIg0SwNUQhWsqN7636CI9xUY1IR9uQYJjijidgL9yv8PCRYe2jzmPslalGTzh
 1bilsupaxyDKfiBXhWW5adojlNRwjOs16PFeRFGS/uotgHjbpEs7IroFToIRNkScfHYRu
 Jz03vR0qZ4/5Ft9IUOsiK560RVS/WrSJqVYdmdypWqn1SXYkCwtayqSYi4nTsbgTjSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3A23A1F000D4;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560577;
 bh=BfN5mFFbqEYptv1VMcXQZ0FhODM/ZYIBIQGAQdpfllw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NLItxIcOH+GtciPe75Cx2kSALwb+bDTM1+VmsalQXOUHZQATEOVFL+Pj5rY30X3QE
 E7sDZQ4EqPQTIdwsS8uQWk7uL3ggGSD6kMZ6ja9sg5G5n42/rcZhYaCyStFxBr4Vi3
 RV7sUy5aN5eO6rIiY6GU824CoYT6Gbrd+4cWE9eZPTUtHDuIpbDbfY8EdOH6ZoGutI
 1afdyLkPzs+wh+ZYHABnpryfHDQSWxp8Q3Rzg8bKjxjmgpDJeycp2kHWwlu+FSfrlW
 XHRnNG7PxrcV+wjfviGDbFWSUZtjp7zdm1onseOkKv3eGTjG51A6IKNw3fvkrsT26a
 llaZCPGHUFI+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7B474476F6;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:03:01 +0000
Subject: [PATCH v3 09/14] drm/panfrost: Don't cancel a job that completed
 during a reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-9-80ae78d38f6e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=2187;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=hhguDU6dUN4EClF9T/THCI2uXCXcschD/PT+h4s0NtU=;
 b=zHYfn9q8MOwjSlbANdJbWdAckGdgiktwBAROwiPPeAvamcaz7HyTmrQydaC3gnBKJ1YEsbZLl
 RmRtiAeGenDAC5ZqzLT2d03iTbkN70ahXlxK2pTAZUhCAH40m508svI
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

panfrost_reset() stops the schedulers, which detaches them from the done
fences of the jobs on the GPU, then soft-stops the slots and handles the
pending interrupts. A job that completes in that window gets its done
fence signalled and its jc cleared. drm_sched_resubmit_jobs() then calls
panfrost_job_run(), which returns NULL for a job with no jc, and since
commit 03877d621db0 ("drm/scheduler: mark jobs without fence as
canceled") drm_sched_start() completes it with -ECANCELED, although it
did complete.

Return the job's done fence instead: drm_sched_start() finds it
signalled and completes the job with its status, 0 or the error
panfrost_job_handle_err() set for a job that was hard-stopped or
faulted.

This depends on the previous patch: without it, a job cancelled from
_NEXT and taken for done would now be reported as completed.

Found by code review (Sashiko) of "Soft-stop and resume a job that
outlives the timeout", which widens the window. Not reproduced.

Fixes: 03877d621db0 ("drm/scheduler: mark jobs without fence as canceled")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206581@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 1bb70b07d..897743cb8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -409,11 +409,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
 
-	/* Nothing to execute: can happen if the job has finished while
-	 * we were resetting the GPU.
+	/* The job has finished while we were resetting the GPU. Return its
+	 * done fence: with no fence, drm_sched_start() cancels the job.
 	 */
 	if (!job->jc)
-		return NULL;
+		return dma_fence_get(job->done_fence);
 
 	fence = panfrost_fence_create(pfdev, slot);
 	if (IS_ERR(fence))

-- 
2.55.0


