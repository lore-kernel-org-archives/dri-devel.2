Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11799D6AAFE
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DEC10F324;
	Thu,  2 Apr 2026 19:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="r/M51ggu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD8C10F324;
 Thu,  2 Apr 2026 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QA03b4iHy3Tt3lyqf7Fg9Ef2IU9dNO2WnNF9Cny/+3Y=; b=r/M51ggulFiHCLOzi+csoSoXO0
 DTpYFEJVgbqMtM9AKTSoYDpar0ZWB20EjbmaGOROUOdlqp6b5pVq6wj1lqPA2gPCwDRbfWkAdIeQc
 QzviHD7l1tYXA+/elSeE39gtJK2yphcChppN+kObF27IQsICmuZgsFyNqtVBbvPA8ibqTZBEB/pOG
 MI1UXBYpKyxwk8hAdgGbFkGClWvJhKnrBNZ3DwZicUqryhla4d2odKw5yauYLqOX7WdAtNKRWBmeT
 gTJw5HR2bvFL78sONVrOonAjcgZEis0Xfb8iB4bXj+gYdfgUjVIWxP+6mCtjY3jVF7v51lNgvaH8J
 ouEZ5zfA==;
Received: from [189.7.87.169] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w8NoH-00AbX8-HV; Thu, 02 Apr 2026 21:34:34 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 kernel-dev@igalia.com, =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] drm/etnaviv: Fix armed job not being pushed to the DRM
 scheduler
Date: Thu,  2 Apr 2026 16:32:35 -0300
Message-ID: <20260402193424.2023318-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

When xa_alloc_cyclic() failed in etnaviv_sched_push_job(), the error
path skipped drm_sched_entity_push_job(). This is a violation of the DRM
scheduler contract, as once a job has been armed with drm_sched_job_arm(),
it must be pushed with drm_sched_entity_push_job(). From the DRM
scheduler documentation,

"""
drm_sched_job_arm() is a point of no return since it initializes the
fences and their sequence number etc. Once that function has been called,
you *must* submit it with drm_sched_entity_push_job() and cannot simply
abort it by calling drm_sched_job_cleanup().
"""

Fix this by splitting the fence ID allocation into two phases: first,
alloc an xarray slot before arming the job (which can fail), then fill in
the actual fence with xa_store() after arming. This way, allocation
failures are handled before the job is armed, and once armed, the job is
always pushed to the scheduler.

This also fixes a double call to drm_sched_job_cleanup(), as both
etnaviv_sched_push_job() and its caller would call it on failure.

Fixes: 764be12345c3 ("drm/etnaviv: convert user fence tracking to XArray")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_sched.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index df4232d7e135..3cc50d697c89 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -116,16 +116,18 @@ int etnaviv_sched_push_job(struct etnaviv_gem_submit *submit)
 	 */
 	mutex_lock(&gpu->sched_lock);
 
+	ret = xa_alloc_cyclic(&gpu->user_fences, &submit->out_fence_id,
+			      NULL, xa_limit_32b, &gpu->next_user_fence,
+			      GFP_KERNEL);
+	if (ret < 0)
+		goto out_unlock;
+
 	drm_sched_job_arm(&submit->sched_job);
 
 	submit->out_fence = dma_fence_get(&submit->sched_job.s_fence->finished);
-	ret = xa_alloc_cyclic(&gpu->user_fences, &submit->out_fence_id,
-			      submit->out_fence, xa_limit_32b,
-			      &gpu->next_user_fence, GFP_KERNEL);
-	if (ret < 0) {
-		drm_sched_job_cleanup(&submit->sched_job);
-		goto out_unlock;
-	}
+
+	xa_store(&gpu->user_fences, submit->out_fence_id,
+		 submit->out_fence, GFP_KERNEL);
 
 	/* the scheduler holds on to the job now */
 	kref_get(&submit->refcount);
-- 
2.53.0

