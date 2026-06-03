Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38CCCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65491112431;
	Wed,  3 Jun 2026 22:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Kn13Om78";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC16112431
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qmgz3hZSQROQLuYh3JXURATLKOVfHQGkVqVv62N0U78=; b=Kn13Om78kmTqj0bPMhdi1PvpFY
 mrZJOq211Yp7K2BKb3V2OCgvqZLa+I/HMtIo6/FYXx87bdJnM1V2fb60AQjS3wBxOEQEEjkrAA5by
 IKaGi4CmHCaQU8+hXFtLIeJsR8ll1Pr6DvLHS/bZRzNSOQV1UN8OrE1dpvNSJ90fY1n0S7G7lU7iq
 ZkvrBmaaVcg10hfrNXPiei6KjQnJ7b64i5ns52aU6egGB7X6c5B3/PADbidBXE5Cov7UajI0nJZD2
 4wUSQJA8TwbrwebZ0Ye3dhTTiCxyq+J2Qe8hKKuYkTUGaR5SgvaRJTVFRV8Rzp+f+HVP3wOLWIGrP
 0zItR3ug==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUu2L-00CNgx-El; Thu, 04 Jun 2026 00:26:09 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 03 Jun 2026 19:25:15 -0300
Subject: [PATCH v3 13/14] drm/v3d: Reject invalid out_sync handles in
 submit ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-v3d-sched-misc-fixes-v3-13-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7433; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=XbXdJOmkgpTntseyoZJjJqdpt+7Dj1/aK7J0eCucpAo=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIKnHs51VcMM+ok2Oj8H+EmKfNDbMjkym1jWft
 4ZOYWRzLUOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiCpxwAKCRA/8w6Kdoj6
 qit3B/4miBn3WPjCa+qVFyB5jBXPDMtpzB/GzRMcXuGP/4b3ykKGxTejH+yJVvOfM5FXc/yPVpr
 vMsKCakL3uYpq8d6UOyd3IeCeg+ddBvWwGYKnl2mt8MXIgRrudrqzNprO7Q+xap0E/Y93sgAKyO
 YusLLkxiN9VWyDUXxxkpFJw2Z6mSZFmcM9/4wiAXPkPNpgWufUZM3WPtBP/H4PArY3UIuyhoVPI
 Kj2fWaMEM+iNdepbXTezJP1vbESiAqN1wAR+Kld9BM9Qo2aRv7ZzLWZvJMaU7wPyzWydIbKvJuH
 pnbbgULiJtObiTND9f7L8172nR+nj/rXHJ8N+qUXrYMuT5BE
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
 drivers/gpu/drm/v3d/v3d_submit.c | 50 +++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 2beb99a25104..dc27770d85fd 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -338,17 +338,15 @@ v3d_submit_attach_object_fences(struct v3d_submit *submit)
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
@@ -381,7 +379,7 @@ v3d_push_job(struct v3d_job *job)
 }
 
 static int
-v3d_submit_jobs(struct v3d_submit *submit, u32 out_sync,
+v3d_submit_jobs(struct v3d_submit *submit, struct drm_syncobj *sync_out,
 		struct v3d_submit_ext *se)
 {
 	struct v3d_dev *v3d = submit->v3d;
@@ -406,7 +404,7 @@ v3d_submit_jobs(struct v3d_submit *submit, u32 out_sync,
 
 	v3d_submit_attach_object_fences(submit);
 	v3d_submit_unlock_reservations(submit);
-	v3d_submit_process_post_deps(submit, out_sync, se);
+	v3d_submit_process_post_deps(submit, sync_out, se);
 
 	v3d_submit_put_jobs(submit);
 
@@ -444,10 +442,13 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit *submit,
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
 
@@ -1006,6 +1007,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_cl *args = data;
+	struct drm_syncobj *sync_out = NULL;
 	struct v3d_submit_ext se = {0};
 	struct v3d_bin_job *bin = NULL;
 	struct v3d_render_job *render = NULL;
@@ -1032,6 +1034,12 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
+		sync_out = drm_syncobj_find(file_priv, args->out_sync);
+		if (!sync_out)
+			return -ENOENT;
+	}
+
 	if (args->bcl_start != args->bcl_end) {
 		bin = (struct v3d_bin_job *) v3d_submit_add_job(&submit, V3D_BIN);
 		if (IS_ERR(bin)) {
@@ -1088,7 +1096,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_submit_jobs(&submit, args->out_sync, &se);
+	ret = v3d_submit_jobs(&submit, sync_out, &se);
 	if (ret)
 		goto fail_unreserve;
 
@@ -1098,7 +1106,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
 }
@@ -1118,6 +1126,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_tfu *args = data;
+	struct drm_syncobj *sync_out = NULL;
 	struct v3d_submit_ext se = {0};
 	struct v3d_tfu_job *job = NULL;
 	int ret = 0;
@@ -1137,6 +1146,12 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (args->out_sync && !(se.flags & DRM_V3D_EXT_ID_MULTI_SYNC)) {
+		sync_out = drm_syncobj_find(file_priv, args->out_sync);
+		if (!sync_out)
+			return -ENOENT;
+	}
+
 	job = (struct v3d_tfu_job *) v3d_submit_add_job(&submit, V3D_TFU);
 	if (IS_ERR(job)) {
 		ret = PTR_ERR(job);
@@ -1178,7 +1193,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_submit_jobs(&submit, args->out_sync, &se);
+	ret = v3d_submit_jobs(&submit, sync_out, &se);
 	if (ret)
 		goto fail_unreserve;
 
@@ -1188,7 +1203,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
 }
@@ -1208,6 +1223,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_csd *args = data;
+	struct drm_syncobj *sync_out = NULL;
 	struct v3d_submit_ext se = {0};
 	int ret;
 
@@ -1234,6 +1250,12 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
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
@@ -1246,7 +1268,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_submit_jobs(&submit, args->out_sync, &se);
+	ret = v3d_submit_jobs(&submit, sync_out, &se);
 	if (ret)
 		goto fail_unreserve;
 
@@ -1256,7 +1278,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(sync_out, &se);
 
 	return ret;
 }
@@ -1354,7 +1376,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_submit_jobs(&submit, 0, &se);
+	ret = v3d_submit_jobs(&submit, NULL, &se);
 	if (ret)
 		goto fail_unreserve;
 
@@ -1364,7 +1386,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	v3d_submit_unlock_reservations(&submit);
 fail:
 	v3d_submit_cleanup_jobs(&submit);
-	v3d_put_multisync_post_deps(&se);
+	v3d_submit_put_post_deps(NULL, &se);
 
 	return ret;
 }

-- 
2.54.0

