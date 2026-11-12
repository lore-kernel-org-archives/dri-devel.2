Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C6606B24C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNy0EA1q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A109410FD52;
	Thu, 12 Nov 2026 08:49:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B603D10FD82
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:48:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D69C663516;
 Thu, 12 Nov 2026 08:48:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794473316;
 b=zysBscoLatRr/+xoVTX6Rl4kCD5PKeMM4QrKo5M1Tl9tTLu+ttLxuWYf0EfpFTFZxIBJ
 9GrCaFz9D7Ghd6sOZX1QjY2s7hppcqsyYDC1gJkq2IclHRFMo9IIjiS3ueStpSjkP/P9q
 FldzpJ+VsfNJbvHLVkHeC3aOWTGueMJvptsIx0PO0adMIITrZpcDVylxUABBPUJ0sJeFI
 kDy5ydHrA3zAw4cAaYb1f3IKllfzIoWvrCQVNT4dIqscm/YVjt4hzDXiHqMziut+w6xli
 7Ag6avzNtNFcJjykRXoWuDVwS19Xq1IccyHZcTtw7ZovgBDDmjuxSeutP3i8UofuoHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794473316;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=vPoPaJYm1rVdkvIwz3bwEXUPzWyWy9GLWeLRkuftn2o=;
 b=Yn74STF+2G1F2jMeVHxgwmMjf857rcSeCHVMArVEeQQEUDyswuQQhuIr0yOYFuJ2nl2v
 7pfvf0NPUFfPKXxkO1pGvHVT3zexLnK8CnFeiiUiurXPWxWuX/V8iqgMpow1BJSnTZT+X
 CKE1y7sk86q44P2PopVA0qfmvuzuhZuXM8dQ/gplpGx8i3+N7/L6r1hBXSVEsA/I4wz/R
 thZjVWT8qFylhkFzr40S3In9nFsmeJXahchz7/xkE18Bs7pcv3YiW0OK+sQURujJlqJIY
 d55q573cGfyYDEM/w7zpJxXgwFDPT/XA6fTALdztfW9OmL8yQAu5NR7nz8llswImpZg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9D1AE1F00A06;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473316;
 bh=vPoPaJYm1rVdkvIwz3bwEXUPzWyWy9GLWeLRkuftn2o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=LNy0EA1qWiptCnzix/+IsiQnfU7t+llJX/1LKe1COFyLNYOgd+nIZM5Ziz3Z0Q4RG
 dMnDeidhSkzP6gBWhbrvvjW72tMWvMz/rw9j1567lMMa/RhjwG9EDvl2Q6B4394vPu
 Y8KMJo8CPFsY8edWjR3LaoJA8xQT6CrKBtrIHsOvS15YludjtcFq0qEQxRbH6pNVxN
 JxwN8jJ0D4PrNYMJfoKL3uRC53PiMwmjnLDnxmzDiXmXKk/qeb35O7eM7nwu6FwMP1
 xduF3BZ7bsoUwyZtuqqP3NR2GnjmHhLHT4RqU5xJPxTNHI+zMgxYajCTiBmTrvWq8h
 aMx1cb6TeYwag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 16E63493DD;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:48:34 +0000
Subject: [PATCH v2 01/11] drm/panfrost: Power the GPU up for a reset queued
 from the MMU code
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panfrost-long-jobs-v2-1-a06830da3d99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473314; l=2612;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=3Nwfj5PjtSEDNrdV40YewE7S010LHXjG4GEcXIttwyU=;
 b=0ryBwxlYAwCmZkVAh7K+YyhyJgkV5eo4lx5zT8nt16/VZPa84kdzHsOr1c/ufAt9CWA/boFco
 dNMp9BI+aEeDpLRe9IHtJnI1DlLh5dvyibxixzOEuNV0jLs5xz9Xlka
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

panfrost_reset_work() calls panfrost_reset() without a runtime PM
reference. The work is queued by panfrost_device_schedule_reset(), which
wait_ready() calls when the AS_ACTIVE bit is stuck, from MMU operations
whose callers drop their own runtime PM reference right after. The work
shares the ordered reset workqueue with the scheduler timeout handlers, so
it can run well after it was queued. If the GPU has gone idle and been
runtime suspended in between, panfrost_reset() writes JOB_INT_MASK and the
job slot registers of a powered-off GPU, which is a synchronous external
abort on arm64.

Take a runtime PM reference in the work, resuming the GPU if needed, and
drop it after the reset. If the GPU cannot be resumed (runtime PM is
disabled during system sleep), no job is running on it and
panfrost_device_runtime_resume() resets it on the way back up, so just
clear the pending flag. Resuming instead of skipping the reset when the
GPU is suspended keeps jobs that a concurrent resume queued behind the
pending flag from waiting for a reset that never comes.

Found by code review only (Sashiko); not reproduced.

Fixes: f9ab9c66f080 ("drm/panfrost: Reset the GPU when the AS_ACTIVE bit is stuck")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206548@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 3a46dd61c..0c2fda80c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -810,7 +810,21 @@ static void panfrost_reset_work(struct work_struct *work)
 	struct panfrost_device *pfdev;
 
 	pfdev = container_of(work, struct panfrost_device, reset.work);
+
+	/* The work can run long after it was queued, when the GPU has gone
+	 * idle and been runtime suspended. Power it up for the reset: its
+	 * registers are not accessible while it is suspended. If it cannot
+	 * be resumed (runtime PM is disabled during system sleep), there is
+	 * no job on it, and panfrost_device_runtime_resume() resets it when
+	 * it comes back up.
+	 */
+	if (pm_runtime_resume_and_get(pfdev->base.dev)) {
+		atomic_set(&pfdev->reset.pending, 0);
+		return;
+	}
+
 	panfrost_reset(pfdev, NULL);
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 
 static const struct drm_sched_backend_ops panfrost_sched_ops = {

-- 
2.55.0


