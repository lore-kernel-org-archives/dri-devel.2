Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC44CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE5C10E447;
	Sun, 10 May 2026 22:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NeqDm3wc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6797510E447
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U0eJ7WvOjw9QEqlRjz1pIHE1YxWw5qh8XpXKSyy8Rgg=; b=NeqDm3wc1HemBpS7j8qPDVoMa1
 j6983vhtg3x5IqFmrxI03P7UlvqekuEbUyRM6J8ibTXeHiDfAypzwAu9CCeNUrwfj3NGsSZTQEKSW
 tzQOHWABjYXjITBOpsBXdltrdbzZx6F54b7mhMmXPCdhinTPBTYCeN7Qf/1BamDGCu1fEosxoYjpY
 1V5LTk3dtXyeCknR8BlpDoeWKfoj70ehU0gSGgNnadFWmexBtj0OITY3ViuxrXzoFRtnxxlfp/xj6
 Mk05Tinhsp37TYx5n35RBg10UUNNp2VKsD+JQCFIyJUHcRKoRV0IjgHZ+yzA+WFvnnTDHYR59XnkC
 OUPeiFPw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCOS-008k1J-JB; Mon, 11 May 2026 00:13:00 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:08 -0300
Subject: [PATCH v2 11/14] drm/v3d: Refactor CPU ioctl into unified
 submission chain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-11-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5552; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=f2KhOvowD+4zWV/5IPk/N+QouGS4vKaomU7whumtMWc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK16TgnQrQJjsWgWP8+qiknYfDwLtZNIiwz0
 f6zbpkQZ0qJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtQAKCRA/8w6Kdoj6
 qt42B/wJe2Z/Uvt7UpEEgZg97BkzZ0+S/Pqxc6Fry2y3f0hEXT8Kyj2uwU/0AgK6oBmnR2YRW2v
 oO0uBAlQ1OeVkgVWhIOS2AMHJeTtMafnHx1CgPcJg0LDjlIGjvSlnh24hhyCUZIFP24Xonf8UIH
 9p2+N4V4GVv4BfFJFCSSWxVr1rVud+09yRr1C9b+An7HCcnwVfjL5gx2PBHESN2B7Ju5Usa2eFn
 at8Sn+U0osK34Ix8ceACWpnhyPRWC+Ym7W7gMxtWGzGFUO8udNBFYJB9GryTx4ppNdKOUa24+0e
 uUWENHfT34SxiG/QOZRPmV0xRyCZ8S889/tqnQW10Ahj0r+G
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Restructure the CPU ioctl so that all job types, including indirect CSD,
use a single struct v3d_submit chain and a single DRM exec context.

Now that v3d_get_cpu_indirect_csd_params() is a pure parser and the
submit helpers operate on struct v3d_submit, fold the indirect CSD path
into the standard flow by appending the CSD and CLEAN_CACHE jobs to the
same struct v3d_submit as the CPU job and locking the union of all jobs'
BOs under one drm_exec. This eliminates the second drm_exec, the nested
submission, and the conditional two-pass fence attachment that the CPU
ioctl previously required for the indirect CSD path.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  6 ---
 drivers/gpu/drm/v3d/v3d_submit.c | 80 ++++++++++------------------------------
 2 files changed, 20 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index ec01668bacb6..071d919fe860 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -422,9 +422,6 @@ struct v3d_indirect_csd_info {
 	/* Indirect CSD */
 	struct v3d_csd_job *job;
 
-	/* Clean cache job associated to the Indirect CSD job */
-	struct v3d_job *clean_job;
-
 	/* Indirect CSD args, stashed by the extension parser and later used
 	 * to create the CSD job from them.
 	 */
@@ -443,9 +440,6 @@ struct v3d_indirect_csd_info {
 
 	/* Indirect BO */
 	struct drm_gem_object *indirect;
-
-	/* Context of the Indirect CSD job */
-	struct drm_exec exec;
 };
 
 struct v3d_timestamp_query_info {
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 899128fc2bd5..6506acb6992e 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1250,15 +1250,10 @@ int
 v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *file_priv)
 {
-	struct v3d_dev *v3d = to_v3d_dev(dev);
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
-	struct v3d_submit indirect_submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_cpu *args = data;
 	struct v3d_submit_ext se = {0};
-	struct v3d_submit_ext *out_se = NULL;
 	struct v3d_cpu_job *cpu_job = NULL;
-	struct v3d_csd_job *csd_job = NULL;
-	struct v3d_job *clean_job = NULL;
 	int ret;
 
 	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
@@ -1292,86 +1287,51 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 	}
 
-	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
+	trace_v3d_submit_cpu_ioctl(dev, cpu_job->job_type);
 
 	ret = v3d_job_add_syncobjs(&cpu_job->base, file_priv, 0, &se, V3D_CPU);
 	if (ret)
 		goto fail;
 
-	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
-		ret = v3d_setup_csd_jobs_and_bos(&indirect_submit,
-						 &cpu_job->indirect_csd.args,
-						 NULL);
-		if (ret)
-			goto fail;
-
-		cpu_job->indirect_csd.job = container_of(indirect_submit.jobs[0],
-							 struct v3d_csd_job, base);
-		cpu_job->indirect_csd.clean_job = indirect_submit.jobs[1];
-	}
-
-	clean_job = cpu_job->indirect_csd.clean_job;
-	csd_job = cpu_job->indirect_csd.job;
-
+	/* Look up the CPU jobs' BOs first, so v3d_setup_csd_jobs_and_bos(), which
+	 * locks all jobs' BOs at its end, picks them up too in the case of indirect
+	 * CSD.
+	 */
 	if (args->bo_handle_count) {
 		ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
 		if (ret)
 			goto fail;
+	}
 
+	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
+		ret = v3d_setup_csd_jobs_and_bos(&submit, &cpu_job->indirect_csd.args,
+						 NULL);
+		if (ret)
+			goto fail;
+
+		/* The CSD job was appended at jobs[1] */
+		cpu_job->indirect_csd.job = container_of(submit.jobs[1], struct v3d_csd_job,
+							 base);
+	} else {
 		ret = v3d_submit_lock_reservations(&submit);
 		if (ret)
 			goto fail;
 	}
 
-	mutex_lock(&v3d->sched_lock);
-	v3d_push_job(&cpu_job->base);
+	ret = v3d_submit_jobs(&submit);
+	if (ret)
+		goto fail_unreserve;
 
-	switch (cpu_job->job_type) {
-	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
-		ret = drm_sched_job_add_dependency(&csd_job->base.base,
-						   dma_fence_get(cpu_job->base.done_fence));
-		if (ret)
-			goto fail_unreserve;
-
-		v3d_push_job(&csd_job->base);
-
-		ret = drm_sched_job_add_dependency(&clean_job->base,
-						   dma_fence_get(csd_job->base.done_fence));
-		if (ret)
-			goto fail_unreserve;
-
-		v3d_push_job(clean_job);
-
-		break;
-	default:
-		break;
-	}
-	mutex_unlock(&v3d->sched_lock);
-
-	out_se = (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) ? NULL : &se;
-
-	v3d_attach_fences_and_unlock_reservation(&submit, 0, out_se);
-
-	switch (cpu_job->job_type) {
-	case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
-		v3d_attach_fences_and_unlock_reservation(&indirect_submit, 0, &se);
-		break;
-	default:
-		break;
-	}
+	v3d_attach_fences_and_unlock_reservation(&submit, 0, &se);
 
 	v3d_submit_put_jobs(&submit);
-	v3d_submit_put_jobs(&indirect_submit);
 
 	return 0;
 
 fail_unreserve:
-	mutex_unlock(&v3d->sched_lock);
 	v3d_submit_unlock_reservations(&submit);
-	v3d_submit_unlock_reservations(&indirect_submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_submit_cleanup_jobs(&indirect_submit);
 	v3d_put_multisync_post_deps(&se);
 	kvfree(cpu_job->timestamp_query.queries);
 	kvfree(cpu_job->performance_query.queries);

-- 
2.54.0

