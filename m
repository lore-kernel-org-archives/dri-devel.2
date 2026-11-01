Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC20606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=H1WTYqxt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E18810E3E1;
	Sun,  1 Nov 2026 12:56:43 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A2010EA3E
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=rzCbi5EGPZLpXZbESgscRNIvuvALdr5g6z67Q5W8v3E=; b=H1WTYqxtt6M4UVYLFEvQVrmgcU
 90J83Ayh8GQhQuBEd7s+aNq1o3Idv67JHugGZCjNMIwcsYpzh5V1RgXQR1oxyHJc+PZ7b+pH9TweI
 2cLNLCoEjI6fKmnW72ovKlDXuIf3n3DIQWBTbmAjrg/XNKkWmzcQ/FHDMlLoJYypgaO/0ndcCubFp
 Ap2FhhzFVK88CPuzpgYlqHHSppsfHJcAvplYjLa296ebZOSWh/82Vcr29QR65xE+IJbWweZue7Cxw
 fF8O2RcCZajeRJ5YBedRihEoPgNByqGQPgLznBtCmw+H6man3x3n8j8fko8ucUguuxC6JpLpXswdD
 Kf62/F1g==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xNV6v-00Go36-Uz; Sun, 01 Nov 2026 13:56:34 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org, =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 1/2] drm/v3d: Initialize timedout_batches when running a CSD
 job
Date: Sun,  1 Nov 2026 09:53:57 -0300
Message-ID: <20261101125619.2465064-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>

v3d_csd_job_timedout() decides whether a compute job made progress by
comparing CSD_CURRENT_CFG4, the number of batches the dispatcher still
has to start, against the value saved at the previous timeout. That
saved value is never initialized, so it is zero on the first timeout.

On V3D 7.1.6 and later, CFG4 counts down to zero once the dispatcher has
started the last batch, but the dispatch keeps running until the batches
in flight complete. If the first timeout fires in that window, the
handler sees no change and resets the GPU while the job is about to
complete. For example, this happens with long dispatches that only keep a
single supergroup in flight.

Initialize timedout_batches to the value programmed in CFG4 when the job
is started. The register does not return to it once a batch has started:
it counts down to zero on V3D 7.1.6 and later (CFG4 holds the number of
batches), and to 0xffffffff on V3D 4.2 (CFG4 holds the number of batches
minus one).

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index e6283a75bcdf..002116efc874 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -360,6 +360,8 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->base.irq_fence);
 	job->base.irq_fence = dma_fence_get(fence);
 
+	job->timedout_batches = job->args.cfg[4];
+
 	trace_v3d_submit_csd(dev, to_v3d_fence(fence)->seqno);
 
 	v3d_job_start_stats(&job->base);
-- 
2.56.0

