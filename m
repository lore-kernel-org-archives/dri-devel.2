Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC35CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E4E10E874;
	Thu, 18 Jun 2026 15:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JZBrilnC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93E010E874
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9OryqeiBNTyp/eCwWofmOxdc9q8XrCnt6tEOVNRS4qU=; b=JZBrilnC+DPHcQB5gCYuiSWqoh
 gMY5RPIzyWTnxCQm12X+DKJXA1xwPBhfYXBK6Jc/FlqaCtb51jHWS4Ql9GysMBH2xNkaLu4BZKdgA
 oS3zvIS2WbcCMRC0KhxKwH67rZ8bmDYHOiPl8NgTpL63EtOMC0llnKgrOVm8wuUJ1wPxB3+u3Oym+
 +vONL/tJz8MQHkyCfGE5dHtScbP51AehYmKbPb7VpEMpBWWPdcejmIrACwuqIEVN5aTXyJgoy6TGv
 tam7MwhZB6l4Kdk+aKSheMefBblek9m9DTxL6VTJhs3r7AFJvLdvM5ci8yOyUEboGJFeLy+NkBnzJ
 nnw55Pzw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1waEH5-001vhd-VM; Thu, 18 Jun 2026 17:03:24 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 18 Jun 2026 12:03:13 -0300
Subject: [PATCH v2 1/3] drm/v3d: Associate BOs with every job that accesses
 them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-v3d-cpu-job-fixes-v2-1-fec132484fc4@igalia.com>
References: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
In-Reply-To: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=DiOLg3XrwKwlxEEsz+Uo97KJu+Y098lfjHstJmEnAeI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqNAi2Xf2Skvarnnr7+gAmMf9hse/hRZ80DpWq8
 j5f+C1nb1eJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCajQItgAKCRA/8w6Kdoj6
 qsgFB/0ZCbRjSF6MywF7V1o56yFQgfbBFGkY/ItImzoNEmjpmhucouxtLuOjbvLWj1sunNCVjDX
 BsX6wrZl/Qs+ARZ3SSyB9RRwXwcyh1x/mzTj0J4bZzoZZ3hJRws5tTvx1b2bHY11AmL9iTOalVB
 iBJUbmJS3ABdTDKbMtTUXzOqtgtYMnBCu3ixWcaTaLhDrn+jqNtL1MYfEwZP+3aoE+Z6d27hJsl
 CcK/LquIpJQOg5qqCiEGRNbecGenqVBkuRdCsKFAgEvOF5EeAHl4IQzHeyedWFQWNvq7WOyJPXA
 TY0UlWdXpMZywg2emUaXQ9gRdTN0OPRu/8Jc39i65hRF8Hpt
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

A submission can expand into a chain of jobs (e.g. bin + render + cache
clean), but v3d_lookup_bos() only looked up the user's BO list onto the
*last* job of the submission. Every earlier job was left with
bo_count == 0 and an empty bo[] array.

As a consequence, when implicit synchronization happens in
v3d_submit_lock_reservations(), earlier jobs get no implicit
dependencies at all, as the loop is gated on job->bo_count and earlier
jobs don't have any BO attached to them. With that, the RENDER job could
therefore be dispatched to the hardware and read a BO while another context
was still writing it, leading to data corruption.

Fix this by calling v3d_lookup_bos() for each job that references the
submission's BOs, so every job carries its own bo[]/bo_count and picks
up the correct implicit dependencies during reservation locking.

Fixes: dffa9b7a78c4 ("drm/v3d: Add missing implicit synchronization.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed5..18467e448c91 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -68,7 +68,6 @@ v3d_submit_unlock_reservations(struct v3d_submit *submit)
 /**
  * v3d_lookup_bos() - Sets up job->bo[] with the GEM objects
  * referenced by the job.
- * @dev: DRM device
  * @file_priv: DRM file for this fd
  * @job: V3D job being set up
  * @bo_handles: GEM handles
@@ -82,23 +81,19 @@ v3d_submit_unlock_reservations(struct v3d_submit *submit)
  * failure, because that will happen at `v3d_job_free()`.
  */
 static int
-v3d_lookup_bos(struct v3d_submit *submit, u64 bo_handles, u32 bo_count)
+v3d_lookup_bos(struct drm_file *file_priv, struct v3d_job *job,
+	       u64 bo_handles, u32 bo_count)
 {
-	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
-
-	last_job->bo_count = bo_count;
-
-	if (!last_job->bo_count) {
-		/* See comment on bo_index for why we have to check
-		 * this.
-		 */
-		drm_warn(&submit->v3d->drm, "Rendering requires BOs\n");
+	if (!bo_count) {
+		drm_warn(&job->v3d->drm, "Rendering requires BOs\n");
 		return -EINVAL;
 	}
 
-	return drm_gem_objects_lookup(submit->file_priv,
+	job->bo_count = bo_count;
+
+	return drm_gem_objects_lookup(file_priv,
 				      (void __user *)(uintptr_t)bo_handles,
-				      last_job->bo_count, &last_job->bo);
+				      job->bo_count, &job->bo);
 }
 
 static void
@@ -446,7 +441,8 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit *submit,
 	if (IS_ERR(clean_job))
 		return PTR_ERR(clean_job);
 
-	return v3d_lookup_bos(submit, args->bo_handles, args->bo_handle_count);
+	return v3d_lookup_bos(submit->file_priv, &job->base,
+			      args->bo_handles, args->bo_handle_count);
 }
 
 static void
@@ -1085,6 +1081,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
+	ret = v3d_lookup_bos(submit.file_priv, &render->base,
+			     args->bo_handles, args->bo_handle_count);
+	if (ret)
+		goto fail;
+
 	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
 		clean_job = v3d_submit_add_job(&submit, V3D_CACHE_CLEAN);
 		if (IS_ERR(clean_job)) {
@@ -1097,10 +1098,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
-	if (ret)
-		goto fail;
-
 	ret = v3d_submit_lock_reservations(&submit);
 	if (ret)
 		goto fail;
@@ -1359,7 +1356,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	 * the CSD and clean jobs in the case of indirect CSD job.
 	 */
 	if (args->bo_handle_count) {
-		ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
+		ret = v3d_lookup_bos(submit.file_priv, &cpu_job->base,
+				     args->bo_handles, args->bo_handle_count);
 		if (ret)
 			goto fail;
 	}

-- 
2.54.0

