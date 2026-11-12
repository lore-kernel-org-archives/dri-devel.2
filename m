Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EF606B59A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJldOmxu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A486810FD73;
	Thu, 12 Nov 2026 08:49:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38E910FDA1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:48:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D770D46B19;
 Thu, 12 Nov 2026 08:48:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794473318;
 b=rBfjRqBwAUzAHW2nC7uMyCT7HlZUR9hflN8+X2pq3ef1YFdONkjnriTccP3ZjUGi7zUh
 4cTXDT1vrXqdHAJSwjFFG1I3qvO173Sbm93xbFxjr8bDRR9S1TyjMqAeVMu3/YCMixGRt
 i9EzUdbYEp7JvGtr1kFejt//K09sd6UBeKaBVRWB7gMvR5LLZKgM/62Mk+vrnLYwVy5wQ
 PIz33SGe9eRvTAjGakbg+ZdzbQmtN97+RyJgpSCJDHrNQiaclyC4CxyIbNZ4HHmhsRMGm
 6eiCy0i2i4EP5I51toa5p8ImnGo2GcrYQH314XryEpS+pU68jb/UEZVps1hpQ+4bvhw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794473318;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ZhYWuY2I9f3k8MEPhJu0jy4jXtUTdjf/cX15Y4bmCrc=;
 b=yxuZgSSGZA2eTUH6VOTocDOgzytzTEGY2LGSMFs8MHDucErmeTTTqUXvNaHPoOc1Sgo4
 reKTGgDPIO3NM8mZwVDaYP9M4EZWKx9T9MoLQx8qENjcy6pWlag7kiIxUM3PF6O04ibF5
 5Qw9lrDYtyKt1rUQ0JnEuVR2uMEad7fDW5f6zaGN6MftFBBT5lomk3zN6qOEIS5lmpSQL
 9h1+EpecCmttx31dNncwR0jMFFblGeYowXQXCRVahAMSG4NeorRpxihDhP9du2ceTkjZC
 I0tlVR3cj4ygKiLinfwVChQeyrzL0QikCqo56sjRmQO+l/uH9iKgxjdtbo5M81j6jJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 237241F00A12;
 Thu, 12 Nov 2026 08:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473318;
 bh=ZhYWuY2I9f3k8MEPhJu0jy4jXtUTdjf/cX15Y4bmCrc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=AJldOmxuvKBYuBrXwnGLJM08ZX0y7gg/IHrrDln5GUoM1IRCR/wYCIF8uxAebkVAn
 RCGsgI3gEnS6Ir6iJDXu5IFBQ9+yfRLN9RnJgX80lnrMemryBp5AA4d+KpdnTcDusm
 r/hXxE2hKdGYWEpFSeqoB3lWJLYjtQPysodmoE+lv6nZonknV+taBw0J4kzRMMyIiD
 zXq9aVSU4Q1nwDKx1abZ65eeNlRIKa6pm34fojMaAJMSwMlF0eyAivqvYmP4qeF7oW
 4k9Bs6dMPbNtHZuOjPEDU4TpmmpbBAW1Af/HWg1phfOCjOt5hVHtts2dROQnJCasso
 V5dB1N1F4stgg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 90461493F5;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:48:40 +0000
Subject: [PATCH v2 07/11] drm/panfrost: Don't signal a job cancelled from
 _NEXT at a reset as done
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panfrost-long-jobs-v2-7-a06830da3d99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473314; l=3871;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=gJ9MHP9WJHKJVhxNHkpa2xRnP84nJEjxexYJc8IDTCc=;
 b=/0fxxlblZoUiR4o6g+r0j1xdsNquO7AyYG5+0CkKLlg9l6VkQLdYMgP9kX4WmfXMyGCnCqZYP
 ZfYIRi5gS0zAmUapDsC5dZi46wUH5kUTnBn2w2047wppqlOfRsNlECJ
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

panfrost_reset() cancels the job waiting in each slot's _NEXT registers
with JS_COMMAND_NOP and soft-stops the running one. If the running job
finishes instead of stopping, its DONE interrupt is handled by
panfrost_jm_handle_irqs() before the reset. panfrost_jm_handle_irq()
dequeues it, which moves the cancelled job to the head of the slot, then
finds both subslots inactive and takes that job for done as well: when
a job completes, the job manager starts the _NEXT one without waiting
for the interrupt, so a job left on an inactive slot is normally one
that has finished too. The cancelled job gets its jc cleared and its
done fence signalled without having run: drm_sched_resubmit_jobs() does
not run it again, and it completes with -ECANCELED although nothing was
wrong with it.

The Arm driver checks JS_HEAD_NEXT after writing the NOP: if it still
holds the job, the job has not started and is evicted; if it reads zero,
the job manager had already moved the job to the running subslot. Do the
same: take an evicted job off the slot while the remaining interrupts
are handled, and put it back afterwards, so that it is restarted with
the other jobs.

Found by code review (Sashiko) of the next patches, which make the
soft-stop wait longer and the window wider. Not reproduced.

Fixes: 030761e097b4 ("drm/panfrost: Queue jobs on the hardware")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206581@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 0c2fda80c..418a91a31 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -659,6 +659,7 @@ static void
 panfrost_reset(struct panfrost_device *pfdev,
 	       struct drm_sched_job *bad)
 {
+	struct panfrost_job *evicted[NUM_JOB_SLOTS] = {};
 	u32 js_state, js_state_mask = 0xffffffff;
 	unsigned int i, j;
 	bool cookie;
@@ -694,11 +695,28 @@ panfrost_reset(struct panfrost_device *pfdev,
 	job_write(pfdev, JOB_INT_MASK, 0);
 	synchronize_irq(pfdev->js->irq);
 
+	spin_lock(&pfdev->js->job_lock);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		/* Cancel the next job and soft-stop the running job. */
 		job_write(pfdev, JS_COMMAND_NEXT(i), JS_COMMAND_NOP);
+
+		/* A job still in the _NEXT registers after the NOP has not
+		 * started and will not. Take it off the slot until the
+		 * remaining interrupts are handled: if the running job
+		 * finishes instead of stopping, panfrost_jm_handle_irq() finds
+		 * both subslots inactive and takes the job left on the slot
+		 * for done too, and it would be signalled without having run.
+		 */
+		if (pfdev->jobs[i][1] &&
+		    (job_read(pfdev, JS_HEAD_NEXT_LO(i)) ||
+		     job_read(pfdev, JS_HEAD_NEXT_HI(i)))) {
+			evicted[i] = pfdev->jobs[i][1];
+			pfdev->jobs[i][1] = NULL;
+		}
+
 		job_write(pfdev, JS_COMMAND(i), JS_COMMAND_SOFT_STOP);
 	}
+	spin_unlock(&pfdev->js->job_lock);
 
 	/* Wait at most 10ms for soft-stops to complete */
 	ret = readl_poll_timeout(pfdev->iomem + JOB_INT_JS_STATE, js_state,
@@ -720,6 +738,12 @@ panfrost_reset(struct panfrost_device *pfdev,
 	 */
 	spin_lock(&pfdev->js->job_lock);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
+		/* Put the evicted jobs back, they are restarted like the
+		 * others.
+		 */
+		if (evicted[i])
+			pfdev->jobs[i][pfdev->jobs[i][0] ? 1 : 0] = evicted[i];
+
 		for (j = 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++) {
 			if (pfdev->jobs[i][j]->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
 			    pfdev->jobs[i][j]->is_profiled)

-- 
2.55.0


