Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61785CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53D310E448;
	Sun, 10 May 2026 22:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ktv5AFTU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD17F10E448
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qZe8peYsCHWFcauJvBNQOhCm+HracWQ+Ep589Vust1s=; b=Ktv5AFTUGyAmjC4q0srmCcP4Lp
 FNjUNbV+9y/WvP6n0YxdeCI/5Potg4v79hG7/4m98T3Mn97drAzuFcznpceQg1Z5DNMd6QxglK0/n
 tSAme+LVgZBFqxNR82LwP40HkvnlfGUZBJ7NFBE52Mm8FOS72PEnH0tdjGAklcDkTWL58SenIqgmw
 ahPtRScc1dnKjiqgI9LYslx51lmQdaJC41g1meXZIv5aYG+7kVkEsqV6u+wwt3xI/5v+ecxVH6H2d
 DBhTEPjR8fXsYDEzhAVHMdUHgJAZnQJYE4FpLfMQOP5wRucEZAMkiJpn7VbXUG3NPJ0n7vVlnpJ+v
 btns47vw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCOb-008k1J-D3; Mon, 11 May 2026 00:13:08 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:10 -0300
Subject: [PATCH v2 13/14] drm/v3d: Reject invalid out_sync handles in
 submit ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-13-ca4aba343ef6@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7028; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=89R2yj/6D3Sjs0kKgk253Ox6gqpZZdnl/ydK6N988K8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK1hL0M9HLEdxAJL5QRGZRcvPWWzDm7GJ26t
 Texrtm2T1+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtQAKCRA/8w6Kdoj6
 qqHrB/4w8+8CqkCBkxXx9tkGM6w1EUWwiQisBxaXCYX5uLLlFjTDxTeZOxfDf8EX5cnBO3SYddV
 04lnvCtCl0gtTuMlFIKei3x6QD7HXT2num5bvC1Lw5JioI85ql6pB1Qul+lzRAVk3ol95SFRaw9
 OjAdqkzKejrVSOgX2ich2a6Pdzmc6g1eH8GohOxq9jZwEdahyG6GkG5JoFW1bMJDr07vnzl1m/j
 wxMFr5N/C6un4eg/wt3K0TLUxIVpsDVqHOl7/FuDo3ZwI+grUqmuHdqJ9Zxd+fhMDhtriDDztxN
 OvZ8dPDMucCHr1HWVGePlAY2o7wKAFJ/NPIgBxQDBBIT9kKX
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

v3d_submit_process_post_deps() looks up the out_sync syncobj via
drm_syncobj_find(), and if userspace passes a non-zero handle that doesn't
refer to a valid syncobj, the lookup silently returns NULL and the
post-deps step skips publishing the submission's last fence to it. The
ioctl still returns success, leaving userspace to wait on a invalid
syncobj.

Instead of silently ignoring an invalid non-zero out_sync, move the syncobj
lookup to the submission and make it fail with -ENOENT up front, mirroring
the syncobj validation already done for in_sync. Now,
v3d_submit_process_post_deps() only does the fence replacement.

Note that the lookup is skipped when the multi-sync extension is in use,
since args->out_sync is unused in that case.

To keep cleanup symmetric on error paths, convert the function
v3d_put_multisync_post_deps() into a single function that releases the
references that were acquired but never published for both single-sync
and multi-sync.

Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 46 +++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 08a7fa9bc366..afe54e73a461 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -353,17 +353,15 @@ v3d_submit_cleanup_jobs(struct v3d_submit *submit)
 }
 
 static void
-v3d_submit_process_post_deps(struct v3d_submit *submit, u32 out_sync,
+v3d_submit_process_post_deps(struct v3d_submit *submit, struct drm_syncobj *sync_out,
 			     struct v3d_submit_ext *se)
 {
 	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
 	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
-	struct drm_syncobj *sync_out;
 
 	/* Update the return sync object for the job */
 	/* If it only supports a single signal semaphore*/
 	if (!has_multisync) {
-		sync_out = drm_syncobj_find(submit->file_priv, out_sync);
 		if (sync_out) {
 			drm_syncobj_replace_fence(sync_out, last_job->done_fence);
 			drm_syncobj_put(sync_out);
@@ -416,10 +414,13 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit *submit,
 }
 
 static void
-v3d_put_multisync_post_deps(struct v3d_submit_ext *se)
+v3d_submit_put_post_deps(struct drm_syncobj *sync_out, struct v3d_submit_ext *se)
 {
 	unsigned int i;
 
+	if (sync_out)
+		drm_syncobj_put(sync_out);
+
 	if (!(se && se->out_sync_count))
 		return;
 
@@ -978,6 +979,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_cl *args = data;
+	struct drm_syncobj *sync_out = NULL;
 	struct v3d_submit_ext se = {0};
 	struct v3d_bin_job *bin = NULL;
 	struct v3d_render_job *render = NULL;
@@ -1004,6 +1006,12 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
+		sync_out = drm_syncobj_find(file_priv, args->out_sync);
+		if (!sync_out)
+			return -ENOENT;
+	}
+
 	if (args->bcl_start != args->bcl_end) {
 		ret = v3d_submit_add_job(&submit, (void **)&bin, sizeof(*bin),
 					 v3d_job_free, V3D_BIN);
@@ -1063,7 +1071,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_submit_process_post_deps(&submit, args->out_sync, &se);
+	v3d_submit_process_post_deps(&submit, sync_out, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
@@ -1072,7 +1080,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
 }
@@ -1092,6 +1100,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_tfu *args = data;
+	struct drm_syncobj *sync_out = NULL;
 	struct v3d_submit_ext se = {0};
 	struct v3d_tfu_job *job = NULL;
 	int ret = 0;
@@ -1111,6 +1120,12 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
+		sync_out = drm_syncobj_find(file_priv, args->out_sync);
+		if (!sync_out)
+			return -ENOENT;
+	}
+
 	ret = v3d_submit_add_job(&submit, (void **)&job, sizeof(*job),
 				 v3d_job_free, V3D_TFU);
 	if (ret)
@@ -1155,7 +1170,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_submit_process_post_deps(&submit, args->out_sync, &se);
+	v3d_submit_process_post_deps(&submit, sync_out, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
@@ -1164,7 +1179,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
 }
@@ -1184,6 +1199,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_csd *args = data;
+	struct drm_syncobj *sync_out = NULL;
 	struct v3d_submit_ext se = {0};
 	int ret;
 
@@ -1210,6 +1226,12 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
+		sync_out = drm_syncobj_find(file_priv, args->out_sync);
+		if (!sync_out)
+			return -ENOENT;
+	}
+
 	ret = v3d_setup_csd_jobs_and_bos(&submit, args, &se);
 	if (ret)
 		goto fail;
@@ -1222,7 +1244,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_submit_process_post_deps(&submit, args->out_sync, &se);
+	v3d_submit_process_post_deps(&submit, sync_out, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
@@ -1231,7 +1253,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
 }
@@ -1330,7 +1352,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	v3d_submit_process_post_deps(&submit, 0, &se);
+	v3d_submit_process_post_deps(&submit, NULL, &se);
 	v3d_submit_put_jobs(&submit);
 
 	return 0;
@@ -1339,7 +1361,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(NULL, &se);
 	kvfree(cpu_job->timestamp_query.queries);
 	kvfree(cpu_job->performance_query.queries);
 

-- 
2.54.0

