Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D119CCD98C5
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 22:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BCD10E563;
	Wed, 10 Jun 2026 22:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BIW2+4sh";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E13610EC02
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cYll/zoNMB7QWhTzDT5o/NsSu7qQfd1pgl8LRbOf+ac=; b=BIW2+4shRzc8+cow7HPZR8hnM/
 UrP2/xTsZxtU31vXQeJKstfIcLFeYpDS9GcsUFgYkFk/w3IralqsGGkxj9CznGmyoa7kD9t5SULZY
 HvFr8xvgtusvPeU8/I76timopvF6eGpoQbs74slIgPA7i+vkR45x09sPG0tVpPHAstJYZUVGle3ZO
 WHHqRZI3McPNnubkWozxIfVQc3LbSVabDpTaremE1iZ/ii/IoX1lDsn/uJ/0qIEl4Eet2YF8mI+E9
 gPmP4db5IErUSxMru4ARLF2bLDIHjvNoMnRQT03vXWwbe3mpYE0vPgZugPHggd0AtKvIxF38y/BOG
 TGSMvrnA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXRlQ-00FrrZ-3n; Thu, 11 Jun 2026 00:51:12 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 10 Jun 2026 19:50:59 -0300
Subject: [PATCH 1/3] drm/v3d: Associate BOs with every job that accesses them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-v3d-cpu-job-fixes-v1-1-0d9c88989edc@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
In-Reply-To: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4592; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=olDYvk3wJK2VmQKFAc2OPRjtxUKxIVG9cZjekZTsSog=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqKepa5gEvydsenwZLJl1RVtZZScrlbdq9Ot/5j
 r+TNeU9vXeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCainqWgAKCRA/8w6Kdoj6
 qg1KCAC0VrDDqN4YhVKa99j/X4abe26i3mxpEJ33ylJ1AtBwVAMhUeLZB+1K3umI1lobmbJ6IlZ
 QxoDEdY/uQce66GQkU6YewwNyBujpKBgwHFcB6we30AtO0PALiPRXdLz8Ct0mGGMxmWPubJonjR
 arScY15ob2DppfquYSo9+STe/M2Gx62BJK/LVLIpA/nEEYCWyu5aOP0S8auaxnvd9uQ7XJkhbgO
 jUvUQcub1CRCm+v7R2isG16QxBXJtXMy7Dez2JUHaTYppt9dKScQAZetdRTbISf3r8ZIRww4H9U
 rmphWue1cRZimy5hVVkqIH1VPiBl8ZO2haSIRc5mNI2R5hlo
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
jobs don't have any BO attached to them. With that, the BIN job reads the
same buffers as the RENDER job, yet nothing made it wait for a prior
writer to finish. The BIN job could therefore be dispatched to the
hardware and read a BO while another context was still writing it,
leading to data corruption that was only avoided as the userspace adds
explicit syncobjs.

Fix this by calling v3d_lookup_bos() for each job that references the
submission's BOs, so every job carries its own bo[]/bo_count and picks
up the correct implicit dependencies during reservation locking.

Fixes: dffa9b7a78c4 ("drm/v3d: Add missing implicit synchronization.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 41 +++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed5..3d6582dfb1bf 100644
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
@@ -1066,6 +1062,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 					   &se);
 		if (ret)
 			goto fail;
+
+		ret = v3d_lookup_bos(submit.file_priv, &bin->base,
+				     args->bo_handles, args->bo_handle_count);
+		if (ret)
+			goto fail;
 	}
 
 	render = (struct v3d_render_job *)v3d_submit_add_job(&submit, V3D_RENDER);
@@ -1085,6 +1086,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
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
@@ -1097,10 +1103,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_count);
-	if (ret)
-		goto fail;
-
 	ret = v3d_submit_lock_reservations(&submit);
 	if (ret)
 		goto fail;
@@ -1359,7 +1361,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
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

